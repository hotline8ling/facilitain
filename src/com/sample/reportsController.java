package com.sample;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet(name = "reportsController", urlPatterns = { "/reportsClient" })
public class reportsController extends HttpServlet {
    private static final String CONTENT_TYPE = "text/html; charset=windows-1252";

    public void init(ServletConfig config) throws ServletException {
        super.init(config);
    }

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType(CONTENT_TYPE);
        PrintWriter out = response.getWriter();
        out.println("<html>");
        out.println("<head><title>reportsController</title></head>");
        out.println("<body>");
        out.println("<p>The servlet has received a GET. This is the reply.</p>");
        out.println("</body></html>");
        out.close();
    
        String path = request.getServletPath();
    
        switch (path) {
            case "/reportsClient":
                request.getRequestDispatcher("/reportsClient.jsp").forward(request, response);
                break;
            case "/reportsThanksClient":
                  request.getRequestDispatcher("/reportsThanksClient.jsp").forward(request, response);
                  break;
            default:
                response.sendError(HttpServletResponse.SC_NOT_FOUND);
                break;
        }
    
    
    
    }
    
    
}
