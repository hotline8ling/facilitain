package com.sample;

import sample.model.Feedback;
import sample.model.PooledConnection;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

@WebServlet(name = "feedbackController", urlPatterns = {"/feedback"})
public class FeedbackController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Feedback> feedbackList = new ArrayList<>();
        List<Object[]> satisfactionRates = new ArrayList<>();
        double generalAverage = 0.0;

        String feedbackQuery = 
            "SELECT F.FEEDBACK_ID, L.NAME AS LOCATION, F.ROOM, F.RATING, F.SUGGESTIONS, F.REC_INS_DT " +
            "FROM C##FMO_ADM.FMO_ITEM_FEEDBACK F " +
            "JOIN C##FMO_ADM.FMO_ITEM_LOCATIONS L ON F.ITEM_LOC_ID = L.ITEM_LOC_ID " +
            "ORDER BY F.REC_INS_DT DESC";

        String satisfactionQuery =
            "SELECT TO_CHAR(REC_INS_DT, 'Mon') AS MONTH, AVG(RATING) AS AVERAGE_RATING " +
            "FROM C##FMO_ADM.FMO_ITEM_FEEDBACK " +
            "GROUP BY TO_CHAR(REC_INS_DT, 'Mon') " +
            "ORDER BY TO_DATE(MONTH, 'Mon')";

        try (Connection conn = PooledConnection.getConnection();
             PreparedStatement feedbackStmt = conn.prepareStatement(feedbackQuery);
             PreparedStatement satisfactionStmt = conn.prepareStatement(satisfactionQuery);
             ResultSet feedbackRs = feedbackStmt.executeQuery();
             ResultSet satisfactionRs = satisfactionStmt.executeQuery()) {

            // Retrieve feedback list
            while (feedbackRs.next()) {
                Feedback feedback = new Feedback(
                    feedbackRs.getInt("FEEDBACK_ID"),
                    feedbackRs.getString("LOCATION"),
                    feedbackRs.getString("ROOM"),
                    feedbackRs.getInt("RATING"),
                    feedbackRs.getString("SUGGESTIONS"),
                    feedbackRs.getDate("REC_INS_DT")
                );
                feedbackList.add(feedback);
            }

            // Retrieve satisfaction rates
            while (satisfactionRs.next()) {
                String month = satisfactionRs.getString("MONTH");
                double avgRating = satisfactionRs.getDouble("AVERAGE_RATING");
                satisfactionRates.add(new Object[]{month, avgRating});
                generalAverage += avgRating;
            }
            generalAverage = satisfactionRates.isEmpty() ? 0.0 : generalAverage / satisfactionRates.size();
        } catch (Exception e) {
            e.printStackTrace();
        }

        // Set attributes for JSP
        request.setAttribute("feedbackList", feedbackList);
        request.setAttribute("satisfactionRates", satisfactionRates);
        request.setAttribute("generalAverage", generalAverage);
        request.getRequestDispatcher("feedback.jsp").forward(request, response);
    }
}
