<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Admin Panel - StudyMate</title>
    <link rel="stylesheet" href="assets/css/admin-styles.css">
    <script>
        function confirmDelete(userId) {
            if (confirm("Are you sure you want to remove this user?")) {
                window.location.href = "RemoveUserServlet?id=" + userId;
            }
        }

        function confirmDeleteMaterial(id) {
            if (confirm("Are you sure you want to delete this material?")) {
            	window.location.href = "DeleteMaterialServlet?id=" + id + "&source=admin";
            }
        }

        function confirmDeleteFeedback(id) {
            if (confirm("Are you sure you want to delete this feedback?")) {
                window.location.href = "DeleteFeedbackServlet?id=" + id;
            }
        }
    </script>
</head>
<body>

<%
    HttpSession adminSession = request.getSession(false);
    if (adminSession == null || adminSession.getAttribute("adminAuth") == null) {
        response.sendRedirect("index.jsp");
        return;
    }
%>

<div class="admin-header">
    <h2>Admin Panel - StudyMate</h2>
    <a href="LogoutServlet" class="logout-btn">Logout</a>
</div>

<div class="admin-container">

    <%
        String dbURL = "jdbc:mysql://localhost:3306/studymatedb";
        String dbUser = "root";
        String dbPassword = "";
        Connection conn = null;
        Statement stmt = null;
        ResultSet rs = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(dbURL, dbUser, dbPassword);
    %>

    <!-- Manage Study Materials -->
    <h3>Manage Study Materials</h3>
    <table>
        <tr>
            <th>ID</th>
            <th>User ID</th>
            <th>Title</th>
            <th>Subject</th>
            <th>File Name</th>
            <th>Upload Time</th>
            <th>Actions</th>
        </tr>
        <%
            stmt = conn.createStatement();
            rs = stmt.executeQuery("SELECT * FROM uploads");
            while (rs.next()) {
        %>
        <tr>
            <td><%= rs.getInt("id") %></td>
            <td><%= rs.getInt("user_id") %></td>
            <td><%= rs.getString("title") %></td>
            <td><%= rs.getString("subject") %></td>
            <td><%= rs.getString("file_name") %></td>
            <td><%= rs.getTimestamp("upload_time") %></td>
            <%
    		int uploadId = rs.getInt("id");
			%>
			<td>
    		<button class="delete-btn" onclick="confirmDeleteMaterial(<%= uploadId %>)">Delete</button>
			</td>	
        </tr>
        <% } %>
    </table>

    <!-- Manage Users -->
    <h3>Manage Users</h3>
    <table>
        <tr>
            <th>ID</th>
            <th>Name</th>
            <th>Email</th>
            <th>Actions</th>
        </tr>
        <%
            rs = stmt.executeQuery("SELECT * FROM users");
            while (rs.next()) {
        %>
        <tr>
            <td><%= rs.getInt("id") %></td>
            <td><%= rs.getString("name") %></td>
            <td><%= rs.getString("email") %></td>
            <td>
                <button class="delete-btn" onclick="confirmDelete(<%= rs.getInt("id") %>)">Remove</button>
            </td>
        </tr>
        <% } %>
    </table>

    <!-- Manage Feedback -->
    <h3>User Feedback</h3>
    <table>
        <tr>
            <th>ID</th>
            <th>User</th>
            <th>Feedback</th>
            <th>Rating</th>
            <th>Actions</th>
        </tr>
        <%
            rs = stmt.executeQuery("SELECT * FROM feedback");
            while (rs.next()) {
        %>
        <tr>
            <td><%= rs.getInt("id") %></td>
            <td><%= rs.getString("username") %></td>
            <td><%= rs.getString("feedback") %></td>
            <td><%= rs.getInt("rating") %> ⭐</td>
            <td>
                <button class="delete-btn" onclick="confirmDeleteFeedback(<%= rs.getInt("id") %>)">Delete</button>
            </td>
        </tr>
        <% } %>
    </table>

    <%
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (rs != null) rs.close();
            if (stmt != null) stmt.close();
            if (conn != null) conn.close();
        }
    %>
</div>
</body>
</html>
