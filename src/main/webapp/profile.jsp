<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page session="true" %>
<%@ page import="java.sql.*" %>
<%@ page import="jakarta.servlet.http.HttpSession" %>

<%
    // Fetch user details from session
    String userName = (String) session.getAttribute("userName");
    String userEmail = (String) session.getAttribute("userEmail");
    String profilePic = (String) session.getAttribute("profilePic");

    // Set default profile picture if not available
    if (profilePic == null || profilePic.isEmpty()) {
        profilePic = "assets/images/default-avatar.png";
    }

    if (userName == null || userEmail == null) {
        response.sendRedirect("index.jsp"); // Redirect to login if not logged in
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Profile - StudyMate</title>
    <link rel="stylesheet" href="assets/css/profile.css">
</head>
<body>

    <!-- Profile Modal -->
    <div id="profileModal" class="modal">
        <div class="modal-content">
            <span class="close" id="close-profile">&times;</span>
            <h2>User Profile</h2>

            <div class="profile-section">
                <img src="<%= profilePic %>" alt="Profile Picture" class="profile-pic">
                <h3><%= userName %></h3>
                <p><%= userEmail %></p>
            </div>

            <hr>

            <h3>Edit Profile</h3>
            <form action="UpdateProfileServlet" method="post" enctype="multipart/form-data">
                <label for="name">Full Name:</label>
                <input type="text" id="name" name="name" value="<%= userName %>" required>

                <label for="email">Email:</label>
                <input type="email" id="email" name="email" value="<%= userEmail %>" required>

                <label for="profilePic">Profile Picture:</label>
                <input type="file" id="profilePic" name="profilePic" accept="image/*">

                <button type="submit" class="save-btn">Save Changes</button>
            </form>
        </div>
    </div>

    <script>
        document.getElementById("close-profile").addEventListener("click", function() {
            document.getElementById("profileModal").style.display = "none";
        });

        function openProfileModal() {
            document.getElementById("profileModal").style.display = "block";
        }
    </script>

</body>
</html>
