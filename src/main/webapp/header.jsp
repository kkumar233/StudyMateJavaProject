<div class="header">
    <div class="logo">StudyMate</div>
    <div class="nav-buttons">
        <a href="index.jsp#home">Home</a>
        <a href="index.jsp#upload">Upload</a>
        <a href="index.jsp#download">Download</a>
        <a href="index.jsp#about">About</a>
        <a href="index.jsp#feedback">Feedback</a>  

        <%
            // Check if user is logged in
            String userName = (String) session.getAttribute("userName"); 
            if (userName != null) {
        %>
            <a href="#" id="open-profile">Profile</a> /
            <a href="LogoutServlet">Logout</a>
        <%
            } else {
        %>
            <a href="#" id="open-login">Sign In</a> /
            <a href="#" id="open-signup">Sign Up</a>
        <%
            }
        %>
    </div>
</div>
