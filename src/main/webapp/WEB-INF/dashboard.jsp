<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page session="true" %>
<%
    String userEmail = (String) session.getAttribute("user");
    if (userEmail == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Dashboard | StudyMate</title>
    <link rel="stylesheet" href="assets/css/styles.css">
</head>
<body>

    <!-- HEADER -->
    <div class="header">
        <div class="logo">StudyMate</div>
        <div class="nav-buttons">
            <a href="index.jsp">Home</a>
            <a href="upload.jsp">Upload</a>
            <a href="download.jsp">Download</a>
            <a href="profile.jsp">Profile</a>
            <a href="logout.jsp">Logout</a>
        </div>
    </div>

    <!-- DASHBOARD CONTENT -->
    <div class="dashboard-container">
        <h2>Welcome, <%= userEmail %>!</h2>
        <p>This is your study dashboard. Manage your materials, access downloads, and more.</p>
        <a href="upload.jsp" class="dashboard-btn">Upload Materials</a>
        <a href="download.jsp" class="dashboard-btn">Download Materials</a>
        <a href="profile.jsp" class="dashboard-btn">Go to Profile</a>
    </div>

    <!-- FOOTER -->
    <footer>
        <p>© 2024 StudyMate. All rights reserved.</p>
    </footer>

</body>
</html>
