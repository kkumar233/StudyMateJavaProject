<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>StudyMate - Home</title>
    
    <link rel="stylesheet" href="assets/css/header-styles.css">
    <link rel="stylesheet" href="assets/css/style.css">
    <link rel="stylesheet" href="assets/css/admin-styles.css">
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    
</head>
<body>
<%
    Boolean feedbackSubmitted = (Boolean) session.getAttribute("feedbackSubmitted");
    if (feedbackSubmitted != null && feedbackSubmitted) {
%>
    <script>alert("Thank you! Your feedback has been submitted.");</script>
<%
        session.removeAttribute("feedbackSubmitted"); // Clear the flag after showing alert
    }
%>

<%@ include file="header.jsp" %>

<%@ include file="home.jsp" %>
<%@ include file="upload.jsp" %>
<%@ include file="download.jsp" %>
<%@ include file="about.jsp" %>
<%@ include file="feedback.jsp" %>

<%@ include file="footer.jsp" %>
<%@ include file="modals.jsp" %>
<%@ include file="profile.jsp" %>

<script src="assets/js/script.js"></script>
<script src="assets/js/modal.js"></script>
<script src="assets/js/upload.js"></script>
<script src="assets/js/download.js"></script>
<script src="assets/js/feedback.js"></script>

</body>
</html>
