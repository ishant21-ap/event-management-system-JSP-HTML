<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Confirm Delete</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body>
    <div class="container">
        <h1 class="text-center mt-5">Confirm Delete</h1>
        <div class="alert alert-warning text-center">
            <h4>Are you sure you want to delete this event?</h4>
        </div>
        <div class="text-center mt-4">
            <form action="deleteEvent.jsp" method="post" class="d-inline">
                <input type="hidden" name="id" value="<%= request.getParameter("id") %>">
                <button type="submit" class="btn btn-danger">Yes, Delete</button>
            </form>
            <a href="index.jsp" class="btn btn-secondary ml-2">Cancel</a>
        </div>
    </div>
</body>
</html>
