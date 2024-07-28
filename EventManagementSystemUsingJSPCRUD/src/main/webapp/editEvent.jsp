<%@page import="java.sql.*"%>
<%@page import="com.example.model.Event" %>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Edit Event</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body>
    <div class="container">
        <h1 class="text-center mt-5">Edit Event</h1>
        <%
            int id = Integer.parseInt(request.getParameter("id"));
            Connection con = null;
            PreparedStatement pstmt = null;
            ResultSet rs = null;
            String name = "";
            Date date = null;
            String location = "";
            String description = "";
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                con = DriverManager.getConnection("jdbc:mysql://localhost:3306/project", "root", "password");
                String query = "SELECT * FROM events WHERE id = ?";
                pstmt = con.prepareStatement(query);
                pstmt.setInt(1, id);
                rs = pstmt.executeQuery();
                if (rs.next()) {
                    name = rs.getString("name");
                    date = rs.getDate("date");
                    location = rs.getString("location");
                    description = rs.getString("description");
                } else {
                    out.println("<div class='alert alert-danger'>No event found with ID: " + id + "</div>");
                }
            } catch (Exception e) {
                e.printStackTrace();
                out.println("<div class='alert alert-danger'>Error: " + e.getMessage() + "</div>");
            } finally {
                try {
                    if (rs != null) rs.close();
                    if (pstmt != null) pstmt.close();
                    if (con != null) con.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        %>
        <form action="editEvent.jsp" method="post">
            <input type="hidden" name="id" value="<%= id %>">
            <div class="form-group">
                <label for="name">Event Name:</label>
                <input type="text" class="form-control" id="name" name="name" value="<%= name %>" required>
            </div>
            <div class="form-group">
                <label for="date">Event Date:</label>
                <input type="date" class="form-control" id="date" name="date" value="<%= (date != null ? date.toLocalDate() : "") %>" required>
            </div>
            <div class="form-group">
                <label for="location">Event Location:</label>
                <input type="text" class="form-control" id="location" name="location" value="<%= location %>" required>
            </div>
            <div class="form-group">
                <label for="description">Event Description:</label>
                <textarea class="form-control" id="description" name="description"><%= description %></textarea>
            </div>
            <button type="submit" class="btn btn-dark">Update Event</button>
        </form>
        <%
            if ("POST".equalsIgnoreCase(request.getMethod())) {
                int eventId = Integer.parseInt(request.getParameter("id"));
                String eventName = request.getParameter("name");
                String eventDate = request.getParameter("date");
                String eventLocation = request.getParameter("location");
                String eventDescription = request.getParameter("description");

                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    con = DriverManager.getConnection("jdbc:mysql://localhost:3306/project", "root", "password");
                    String query = "UPDATE events SET name = ?, date = ?, location = ?, description = ? WHERE id = ?";
                    pstmt = con.prepareStatement(query);
                    pstmt.setString(1, eventName);
                    pstmt.setDate(2, Date.valueOf(eventDate));
                    pstmt.setString(3, eventLocation);
                    pstmt.setString(4, eventDescription);
                    pstmt.setInt(5, eventId);
                    int rowsAffected = pstmt.executeUpdate();

                    if (rowsAffected > 0) {
                        response.sendRedirect("index.jsp"); // Redirect after successful update
                    } else {
                        out.println("<div class='alert alert-warning'>No changes were made.</div>");
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                    out.println("<div class='alert alert-danger'>Error: " + e.getMessage() + "</div>");
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
