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
        	<!-- Profile Link with Icon -->
            <a href="#" id="open-profile" title="View Profile">
            <i class="fas fa-user-circle"></i> <strong><%= userName %></strong></a>
            
            <!-- Logout Icon -->
            <a href="LogoutServlet" title="Logout">
                <i class="fas fa-sign-out-alt"></i>
            </a>
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
