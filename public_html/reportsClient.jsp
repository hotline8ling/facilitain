<!DOCTYPE html>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=windows-1252"%>
<html lang="en">
    <head>
        <!-- Meta Tags -->
        <meta http-equiv="Content-Type" content="text/html; charset=windows-1252"/>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">

        <!-- Bootstrap CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">

        <title>Reports</title>
        <style>
            .error-message {
                color: red;
                font-size: 0.875rem;
            }
        </style>
      
    </head>
    <body>
        <jsp:include page="headerClient.jsp"/>
        <div class="w-100 h-100 bg-white d-flex flex-column justify-content-center align-items-center p-3">
            <div class="mw-50 h-75 bg-facilGray text-white p-5">
                <img src="resources/images/FACILITAIN.png" alt="FACILITAIN" style="height: 4rem;"/>
                <h3 class="text-center">Report a Problem</h3>

                <!-- Form Starts Here -->
                <form action="reportsClient" method="post" enctype="multipart/form-data" onsubmit="return validateForm();">
                    <!-- Equipment -->
                    <label for="equipment">Type of Equipment</label>
                    <div class="mt-1">
                        <input type="text" name="equipment" id="equipment" class="form-control w-100" placeholder="Enter equipment type">
                        <div id="equipmentError" class="error-message"></div>
                    </div>

                    <!-- Location -->
                    <label for="location">Location</label>
                    <div class="mt-1">
                        <select name="location" id="location" class="form-control w-100">
                            <option value="">Select a location</option>
                            <c:forEach var="location" items="${locationList}">
                                <option value="${location.key}">${location.value}</option>
                            </c:forEach>
                        </select>
                        <div id="locationError" class="error-message"></div>
                    </div>

                    <!-- Floor -->
                    <label for="floor">Floor</label>
                    <div class="mt-1">
                        <input type="text" name="floor" id="floor" class="form-control w-100" placeholder="Enter floor">
                        <div id="floorError" class="error-message"></div>
                    </div>

             
                    <label for="room">Room</label>
                    <div class="mt-1">
                        <input type="text" name="room" id="room" class="form-control w-100" placeholder="Enter room">
                        <div id="roomError" class="error-message"></div>
                    </div>
                    
<!-- Optional Email for Notification -->
<label for="email" class="mt-3">Email Address (Optional: to be notified when resolved)</label>
<div class="mt-1">
    <input type="email" name="email" id="email" class="form-control w-100" placeholder="Enter your email address if you wish to be notified">
    <div id="emailError" class="error-message"></div>
</div>

                    <label for="issue" class="text-center d-block mt-3 mb-3">Describe the Issue</label>
                    <textarea id="issue" name="issue" rows="4" cols="50" class="form-control"></textarea>
                    <div id="issueError" class="error-message"></div>

                
                    <label for="imageUpload" class="text-center d-block mt-3 mb-3">Upload an Image (optional)</label>
                    <input type="file" name="imageUpload" id="imageUpload" class="form-control" accept="image/*">

                    <!-- Submit Button -->
                    <div class="container mt-3 d-flex justify-content-center">
                        <button type="submit" class="btn btn-primary">Submit</button>
                    </div>
                </form>

            
                <div>
                    <button class="btn text-white p-2" style="background-color: transparent;" onclick="window.history.back();">
                        <i class="bi bi-arrow-left-short"></i>Back
                    </button>
                </div>
            </div>
        </div>
            <script>
            function validateForm() {
                let valid = true;

                // Clear previous error messages
                document.querySelectorAll('.text-danger').forEach(el => el.textContent = '');

                // Validate Equipment
                const equipment = document.getElementById('equipment').value.trim();
                if (!equipment) {
                    document.getElementById('equipmentError').textContent = 'Please enter the type of equipment.';
                    valid = false;
                }

                // Validate Location
                const location = document.getElementById('location').value;
                if (!location) {
                    document.getElementById('locationError').textContent = 'Please select a location.';
                    valid = false;
                }

                // Validate Floor
                const floor = document.getElementById('floor').value.trim();
                if (!floor) {
                    document.getElementById('floorError').textContent = 'Please enter the floor.';
                    valid = false;
                }

                // Validate Room
                const room = document.getElementById('room').value.trim();
                if (!room) {
                    document.getElementById('roomError').textContent = 'Please enter the room.';
                    valid = false;
                }

                // Validate Issue
                const issue = document.getElementById('issue').value.trim();
                if (!issue) {
                    document.getElementById('issueError').textContent = 'Please describe the issue.';
                    valid = false;
                }

                return valid;
            }
           // Validate Email (optional)
const email = document.getElementById('email').value.trim();
if (email && !/\S+@\S+\.\S+/.test(email)) {
    document.getElementById('emailError').textContent = 'Please enter a valid email address.';
    valid = false;
}


        </script>
        <!-- Bootstrap JS -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
        <jsp:include page="footerClient.jsp"/>
    </body>
</html>
