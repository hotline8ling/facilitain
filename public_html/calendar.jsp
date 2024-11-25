<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Maintenance Calendar</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <link href="https://cdn.jsdelivr.net/npm/fullcalendar@6.1.5/main.min.css" rel="stylesheet" />
    <script src="https://cdn.jsdelivr.net/npm/rrule@2.6.6/dist/es5/rrule.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/fullcalendar@6.1.5/main.min.js"></script>
    <script src='https://cdn.jsdelivr.net/npm/fullcalendar@6.1.15/index.global.min.js'></script>
    
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            var calendarEl = document.getElementById('calendar');
            // Get the current year
            var currentYear = new Date().getFullYear();

            // Generate recurring events for 10 years before and after
            var startYear = currentYear - 5; // 10 years before current year
            var endYear = currentYear + 10;   // 10 years after current year
            var recurringEvents = [];


            for (var year = startYear; year <= endYear; year++) {
                <c:forEach var="job" items="${calendarSched}">
                <c:if test="${fn:contains(job.repeatInterval, 'YEARLY')}">
                    <c:set var="jobNumber" value="${fn:substringBefore(fn:substringAfter(job.jobName, 'CAT'), '_')}" />
                    <c:set var="jobNumberInt" value="${jobNumber + 0}" />
                    <c:set var="monthNumber" value="${fn:substringBefore(fn:substringAfter(job.repeatInterval, 'BYMONTH='), ';')}" />
                    <c:choose>
                        <c:when test="${fn:length(monthNumber) == 1}">
                            <c:set var="monthNumber" value="0${monthNumber}" />
                        </c:when>
                        <c:otherwise>
                        </c:otherwise>
                    </c:choose>
                    <c:forEach var="cat" items="${FMO_CATEGORIES_LIST}">
                        <c:if test="${cat.itemCID == jobNumberInt}">
                            recurringEvents.push({
                                title: 'Annual Maintenance for '+'${cat.itemCat}',
                                start: year + '-${monthNumber}-01', 
                                allDay: true
                            });
                        </c:if>
                    </c:forEach>
                </c:if>
                </c:forEach>
                
                <c:forEach var="job" items="${calendarSched}">
                <c:if test="${fn:contains(job.repeatInterval, 'MONTHLY')}">
                <c:if test="${fn:contains(job.repeatInterval, 'BYMONTH=')}">
                    <c:set var="qjobNumber" value="${fn:substringBefore(fn:substringAfter(job.jobName, 'CAT'), '_')}" />
                    <c:set var="qjobNumberInt" value="${qjobNumber + 0}" />
                        <c:set var="monthNumbers" value="${fn:substringAfter(job.repeatInterval, 'BYMONTH=')}" />
                        <c:set var="monthNumbers" value="${fn:substringBefore(monthNumbers, ';')}" />
                        <c:set var="monthArray" value="${fn:split(monthNumbers, ',')}" />
                            <c:forEach var="month" items="${monthArray}">
                                <c:set var="monthInt" value="${month * 1}" /> 
                                <c:choose>
                                    <c:when test="${monthInt < 10}">
                                        <c:set var="monthStr" value="0${monthInt}" /> 
                                    </c:when>
                                    <c:otherwise>
                                        <c:set var="monthStr" value="${monthInt}" /> 
                                    </c:otherwise>
                                </c:choose>
                                <c:forEach var="cat" items="${FMO_CATEGORIES_LIST}">
                                <c:if test="${cat.itemCID == qjobNumberInt}">
                                    recurringEvents.push({
                                        title: 'Quarterly Maintenance for '+'${cat.itemCat}',
                                        start: year + '-${monthStr}-01', 
                                        allDay: true
                                    });
                                </c:if>
                                </c:forEach>
                            </c:forEach>
                </c:if>
                </c:if>
                </c:forEach>
                
                for (var month = 1; month <= 12; month++) {
                    var monthStr = month < 10 ? '0' + month : month; 
                    <c:forEach var="job" items="${calendarSched}">
                    <c:if test="${fn:contains(job.repeatInterval, 'MONTHLY') && !fn:contains(job.repeatInterval, 'BYMONTH=')}">                        
                        <c:set var="mjobNumber" value="${fn:substringBefore(fn:substringAfter(job.jobName, 'CAT'), '_')}" />
                        <c:set var="mjobNumberInt" value="${mjobNumber + 0}" />
                            <c:forEach var="cat" items="${FMO_CATEGORIES_LIST}">
                            <c:if test="${cat.itemCID == mjobNumberInt}">
                                recurringEvents.push({
                                    title: 'Monthly Maintenance for '+'${cat.itemCat}',
                                    start: year + '-' + monthStr + '-01', 
                                    allDay: true
                                });
                            </c:if>
                            </c:forEach>
                    </c:if>
                    </c:forEach>
                }
                
                var startOfYear = new Date(year, 0, 1); 
                var firstMonday = startOfYear.getDate() + (1 - startOfYear.getDay() + 7) % 7; 
                startOfYear.setDate(firstMonday);                
                var weekIncrement = 7 * 24 * 60 * 60 * 1000; 
                for (var week = 0; week < 52; week++) { // 52 weeks in a year
                    var weeklyDate = new Date(startOfYear.getTime() + week * weekIncrement);
                    var weekMonthStr = (weeklyDate.getMonth() + 1).toString().padStart(2, '0'); 
                    var weekDayStr = weeklyDate.getDate().toString().padStart(2, '0'); 
                    <c:forEach var="job" items="${calendarSched}">
                    <c:if test="${fn:contains(job.repeatInterval, 'WEEKLY')}">
                        <c:set var="jobNumber" value="${fn:substringBefore(fn:substringAfter(job.jobName, 'CAT'), '_')}" />
                        <c:set var="jobNumberInt" value="${jobNumber + 0}" />
                            <c:forEach var="cat" items="${FMO_CATEGORIES_LIST}">
                            <c:if test="${cat.itemCID == jobNumberInt}">
                            recurringEvents.push({
                                title: 'Weekly Maintenance for '+'${cat.itemCat}',
                                start: year + '-' + weekMonthStr + '-' + weekDayStr, 
                                allDay: true
                            });
                            </c:if>
                            </c:forEach>
                    </c:if>
                    </c:forEach>
                }
                
                
            }

            // Other static events
            var events = [
                ...recurringEvents,
            {
                title: 'Meeting with Team',
                start: '2024-11-24T10:00:00',
                end: '2024-11-24T12:00:00'
            }
            ];
            var calendar = new FullCalendar.Calendar(calendarEl, {
                initialView: 'dayGridMonth',
                events: events,
                headerToolbar: {
                    left: 'prev,next today',
                    center: 'title',
                    right: 'dayGridMonth,timeGridWeek,timeGridDay'
                },
                eventClick: function(info) {
                    alert(info.event.title);
                    // Additional actions like editing or deleting the event
                }
            });
            calendar.render();
        });
    </script>

    <style>
    /* Apply custom styles for smaller screens */
    @media (max-width: 768px) {
        .fc-toolbar {
            display: flex;
            flex-direction: column; /* Stack the toolbar items vertically */
            align-items: center;
        }

        .fc-toolbar-chunk {
            display: flex;
            flex-wrap: wrap; /* Allow wrapping if necessary */
            justify-content: center;
            margin-bottom: 0.5rem; /* Add spacing between rows */
        }

        .fc-toolbar-title {
            margin-bottom: 0.5rem;
            font-size: 1.2rem; /* Adjust title size for better readability */
        }

        .fc-button {
            margin: 0.2rem; /* Add spacing around buttons */
        }
    }
    </style>

</head>
<body>
<div class="container-fluid">
<div class="row min-vh-100">
    <jsp:include page="sidebar.jsp"/>
    
    <div class="col-md-10">
        <div class="mt-4">
            <h1>Maintenance Calendar</h1>
        </div>
        <div class="mb-4">
        <div id='calendar'></div>
        
        </div>
    </div>
    
</div>
</div>
    
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"></script> 
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>  
</body>
</html>
