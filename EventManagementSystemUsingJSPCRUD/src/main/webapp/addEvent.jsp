<%@page import="java.sql.*" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Add Event</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body>
<%@ include file="navbar.jsp" %>
    <div class="container">
        <h1 class="text-center mt-5">Add New Event</h1>
        <form action="addEvent.jsp" method="post">
            <div class="form-group">
                <label for="name">Event Name:</label>
                <input type="text" class="form-control" id="name" name="name" required>
            </div>
            <div class="form-group">
                <label for="date">Event Date:</label>
                <input type="date" class="form-control" id="date" name="date" required>
            </div>
            <div class="form-group">
                <label for="location">Event Location:</label>
                <input type="text" class="form-control" id="location" name="location" required>
            </div>
            <div class="form-group">
                <label for="description">Event Description:</label>
                <textarea class="form-control" id="description" name="description"></textarea>
            </div>
            <button type="submit" class="btn btn-dark">Add Event</button>
        </form>
        <%
            if ("POST".equalsIgnoreCase(request.getMethod())) {
                String name = request.getParameter("name");
                String date = request.getParameter("date");
                String location = request.getParameter("location");
                String description = request.getParameter("description");
                
                Connection con = null;
                PreparedStatement pstmt = null;
                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    con = DriverManager.getConnection("jdbc:mysql://localhost:3306/project", "root", "password");
                    String query = "insert into events (name, date, location, description) values (?, ?, ?, ?)";
                    pstmt = con.prepareStatement(query);
                    pstmt.setString(1, name);
                    pstmt.setDate(2, Date.valueOf(date));
                    pstmt.setString(3, location);
                    pstmt.setString(4, description);
                    int rowsAffected = pstmt.executeUpdate();
                    
                    if (rowsAffected > 0) {
                        out.println("<p class='alert alert-success'>Event added successfully!</p>");
                    } else {
                        out.println("<p class='alert alert-danger'>Failed to add event. Please try again.</p>");
                    }
                    
                    // Redirect to index.jsp after adding the event
                    response.sendRedirect("index.jsp");
                } catch (Exception e) {
                    e.printStackTrace();
                } finally {
                    try {
                        if (pstmt != null) pstmt.close();
                        if (con != null) con.close();
                    } catch (SQLException e) {
                        e.printStackTrace();
                    }
                }
            }
        %>
    </div>
</body>
</html>
