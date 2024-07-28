<%@page import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Delete Event</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body>
<%@ include file="navbar.jsp" %>
<div class="container mt-5">
<%
int id = Integer.parseInt(request.getParameter("id"));
Connection con = null;
PreparedStatement pstmt = null;

try {
    Class.forName("com.mysql.cj.jdbc.Driver");
    con = DriverManager.getConnection("jdbc:mysql://localhost:3306/project", "root", "password");
    String query = "DELETE FROM events WHERE id = ?";
    pstmt = con.prepareStatement(query);
    pstmt.setInt(1, id);
    int rowsAffected = pstmt.executeUpdate();
    
    if (rowsAffected > 0) {
        out.println("<div class='alert alert-success text-center'>Event deleted successfully!</div>");
    } else {
        out.println("<div class='alert alert-danger text-center'>Failed to delete event. Please try again.</div>");
    }
    
    response.setHeader("Refresh", "2; URL=index.jsp");  // Redirects after 2 seconds
} catch(Exception e) {
    e.printStackTrace();
} finally {
    try {
        if (pstmt != null) pstmt.close();
        if (con != null) con.close();
    } catch (SQLException e) {
        e.printStackTrace();
    }
}
%>
</div>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
