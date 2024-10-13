<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no"/>
    <title>Homepage</title>

    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css" rel="stylesheet"/>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        .trash-btn {
            position: absolute;
            top: 10px;
            right: 10px;
            z-index: 10;
        }
    </style>
</head>
<body>
<div class="d-flex vh-100">
    <!-- Sidebar Component -->
    <jsp:include page="sidebar.jsp"/>

    <!-- Main Content -->
    <div class="flex-grow-1 p-4">
        <div class="container">
            <div class="d-flex justify-content-between align-items-center mb-4">
                <h1>Homepage</h1>
                <!-- Trigger Modal Button -->
                <button class="btn btn-warning" data-toggle="modal" data-target="#addBuildingModal">
                    <i class="bi bi-plus-lg"></i> Add
                </button>
            </div>

            <!-- Buildings Listing -->
            <div class="row">
                <c:forEach var="location" items="${locations}">
                    <div class="col-md-4">
                        <div class="card mb-4 position-relative">
                            <a href="buildingDashboard?buildingID=${location.itemLocId}" class="text-decoration-none">
                                <div class="card-body">
                                    <h5 class="card-title">${location.locName}</h5>
                                    <p class="card-text">${location.locDescription}</p>
                                </div>
                            </a>
                            <button class="btn btn-sm btn-danger trash-btn">
                                <i class="bi bi-trash"></i>
                            </button>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </div>
    </div>
</div>

<!-- Modal for Adding Building -->
<div class="modal fade" id="addBuildingModal" tabindex="-1" role="dialog" aria-labelledby="addBuildingModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="addBuildingModalLabel">Add Building</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <div class="form-group">
                    <label for="buildingName">Name</label>
                    <input type="text" class="form-control" id="buildingName" placeholder="Enter building name">
                </div>
                <div class="form-group">
                    <label for="buildingImage">Upload Image</label>
                    <input type="file" class="form-control-file" id="buildingImage">
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-warning">Add</button>
                <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
            </div>
        </div>
    </div>
</div>

<!-- Bootstrap JS and dependencies -->
<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.bundle.min.js"></script>

</body>
</html>
