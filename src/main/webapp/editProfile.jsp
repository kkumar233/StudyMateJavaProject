<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="jakarta.servlet.http.*, java.sql.*, java.io.*" %>
<%
    HttpSession userSession = request.getSession(false);
    if (userSession == null || userSession.getAttribute("userEmail") == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    String email = (String) userSession.getAttribute("userEmail");
    String userName = "";

    // Fetch user details
    String dbURL = "jdbc:mysql://localhost:3306/studymatedb";
    String dbUser = "root";
    String dbPassword = "";

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection conn = DriverManager.getConnection(dbURL, dbUser, dbPassword);
        String sql = "SELECT name FROM users WHERE email = ?";
        PreparedStatement stmt = conn.prepareStatement(sql);
        stmt.setString(1, email);
        ResultSet rs = stmt.executeQuery();

        if (rs.next()) {
            userName = rs.getString("name");
        }

        conn.close();
    } catch (Exception e) {
        e.printStackTrace();
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Profile</title>
    <link rel="stylesheet" href="assets/css/dashboard.css">
</head>
<body>

    <div class="profile-edit-container">
        <h2>Edit Profile</h2>
        <form action="UpdateProfileServlet" method="post" enctype="multipart/form-data">
            <label>Full Name:</label>
            <input type="text" name="name" value="<%= userName %>" required>

            <label>Profile Picture:</label>
            <input type="file" name="profilePic">

            <button type="submit" class="save-btn">Save Changes</button>
        </form>
    </div>

</body>
</html>
