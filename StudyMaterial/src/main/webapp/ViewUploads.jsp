<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="jakarta.servlet.http.HttpSession" %>
<%
    HttpSession sessionUser = request.getSession(false);
    if (sessionUser == null || sessionUser.getAttribute("userId") == null) {
        response.sendRedirect("index.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Uploaded Files - StudyMate</title>
    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
            background-color: #f2f4f8;
            margin: 0;
            padding: 0;
        }
        .container {
            max-width: 1000px;
            margin: 50px auto;
            background-color: white;
            padding: 30px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            border-radius: 10px;
        }
        h2 {
            text-align: center;
            color: #1f4e79;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 25px;
        }
        th, td {
            padding: 14px;
            border-bottom: 1px solid #ccc;
            text-align: left;
        }
        th {
            background-color: #1f4e79;
            color: white;
        }
        tr:hover {
            background-color: #f1f1f1;
        }
        .btn {
            padding: 6px 12px;
            margin-right: 5px;
            border: none;
            border-radius: 4px;
            text-decoration: none;
            color: white;
            cursor: pointer;
        }
        .download-btn {
            background-color: #007bff;
        }
        .download-btn:hover {
            background-color: #0056b3;
        }
        .view-btn {
            background-color: #28a745;
        }
        .view-btn:hover {
            background-color: #1e7e34;
        }
        .delete-btn {
            background-color: #dc3545;
        }
        .delete-btn:hover {
            background-color: #c82333;
        }
        .btn-container {
            text-align: center;
            margin-top: 30px;
        }
        .back-btn {
            background-color: #6c757d;
            color: white;
            padding: 8px 15px;
            border-radius: 5px;
            text-decoration: none;
        }
        .back-btn:hover {
            background-color: #5a6268;
        }
        .edit-btn {
    		background-color: #ffc107;
    		color: black;
		}
		.edit-btn:hover {
    		background-color: #e0a800;
		}   
    </style>
    <script>
    function confirmDelete(id, fileName) {
        if (confirm("Are you sure you want to delete this file?")) {
            window.location.href = "DeleteMaterialServlet?id=" + id + 
                                   "&file=" + encodeURIComponent(fileName) + 
                                   "&source=user";
        }
    }
    </script>
</head>
<body>
<div class="container">
    <h2>All Uploaded Study Materials</h2>

<!-- 🔽 Filter Dropdown -->
<form method="get" style="text-align: center; margin-bottom: 20px;">
    <label for="subjectFilter">Filter by Subject:</label>
    <select name="subjectFilter" id="subjectFilter" onchange="this.form.submit()">
        <option value="">-- All Subjects --</option>
        <%
            Connection filterConn = DriverManager.getConnection("jdbc:mysql://localhost:3306/studymatedb", "root", "");
            Statement filterStmt = filterConn.createStatement();
            ResultSet subjectRs = filterStmt.executeQuery("SELECT DISTINCT subject FROM uploads ORDER BY subject ASC");
            String selectedSubject = request.getParameter("subjectFilter");

            while (subjectRs.next()) {
                String subjectOption = subjectRs.getString("subject");
        %>
        <option value="<%= subjectOption %>" <%= subjectOption.equals(selectedSubject) ? "selected" : "" %>>
            <%= subjectOption %>
        </option>
        <%
            }
            subjectRs.close();
            filterStmt.close();
            filterConn.close();
        %>
    </select>
</form>

<table>

        <tr>
            <th>ID</th>
            <th>Title</th>
            <th>Subject</th>
            <th>File Name</th>
            <th>Upload Time</th>
            <th>Actions</th>
        </tr>

        <%
            Connection conn = null;
            Statement stmt = null;
            ResultSet rs = null;

            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/studymatedb", "root", "");
                stmt = conn.createStatement();

                String subjectFilter = request.getParameter("subjectFilter");
                String query = "SELECT * FROM uploads";

                if (subjectFilter != null && !subjectFilter.isEmpty()) {
                    query += " WHERE subject = '" + subjectFilter + "'";
                }

                query += " ORDER BY upload_time DESC";
                rs = stmt.executeQuery(query);

                while (rs.next()) {
                    int id = rs.getInt("id");
                    String title = rs.getString("title");
                    String subject = rs.getString("subject");
                    String fileName = rs.getString("file_name");
                    Timestamp uploadTime = rs.getTimestamp("upload_time");
        %>
        <tr>
            <td><%= id %></td>
            <td><%= title %></td>
            <td><%= subject %></td>
            <td><%= fileName %></td>
            <td><%= uploadTime %></td>
            <td>
                <a class="btn view-btn" href="uploads/<%= fileName %>" target="_blank">View</a>
                <a class="btn download-btn" href="uploads/<%= fileName %>" download>Download</a>
                <button class="btn edit-btn" onclick="openEditModal(<%= id %>, '<%= title %>', '<%= subject %>')">Edit</button>
                <button class="btn delete-btn" onclick="confirmDelete(<%= id %>, '<%= fileName %>')">Delete</button>
            </td>
        </tr>
        <%
                }
            } catch (Exception e) {
                out.println("<tr><td colspan='6'>Error: " + e.getMessage() + "</td></tr>");
            } finally {
                if (rs != null) rs.close();
                if (stmt != null) stmt.close();
                if (conn != null) conn.close();
            }
        %>
    </table>

    <div class="btn-container">
        <a href="index.jsp" class="back-btn">⬅ Back</a>
    </div>
</div>

<!-- Edit Modal -->
<div id="editModal" style="display: none; position:fixed; top:0; left:0; width:100%; height:100%;
     background:rgba(0,0,0,0.5); align-items:center; justify-content:center;">
    <div style="background:white; padding:20px; border-radius:10px; width:300px;">
        <h3>Edit Details</h3>
        <form action="EditMaterialServlet" method="post">
            <input type="hidden" name="id" id="editId">
            <label>Title:</label><br>
            <input type="text" name="title" id="editTitle" required><br><br>
            <label>Subject:</label><br>
            <input type="text" name="subject" id="editSubject" required><br><br>
            <button type="submit" class="btn edit-btn">Save</button>
            <button type="button" class="btn back-btn" onclick="closeEditModal()">Cancel</button>
        </form>
    </div>
</div>
<script>
function openEditModal(id, title, subject) {
    document.getElementById("editId").value = id;
    document.getElementById("editTitle").value = title;
    document.getElementById("editSubject").value = subject;
    document.getElementById("editModal").style.display = "flex";  // show modal
}

function closeEditModal() {
    document.getElementById("editModal").style.display = "none";  // hide modal
}

</script>
</body>
</html>
