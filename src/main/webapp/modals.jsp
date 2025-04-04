<!-- User Login Modal -->
<div id="loginModal" class="modal">
    <div class="modal-content">
        <span class="close" id="close-login">&times;</span>
        <h2>User Login</h2>
        <form action="LoginServlet" method="post">
            <input type="email" name="email" placeholder="Email" required>
            <input type="password" name="password" placeholder="Password" required>
            <button type="submit" class="modal-button">Login</button>
        </form>
        <p><a href="#" id="open-forgot-password">Forgot Password?</a></p>
        <p>Don't have an account? <a href="#" id="switch-to-signup">Sign Up</a></p>
    </div>
</div>

<!-- Sign-Up Modal -->
<div id="signupModal" class="modal">
    <div class="modal-content">
        <span class="close" id="close-signup">&times;</span>
        <h2>Sign Up</h2>
        <form action="SignupServlet" method="post">
            <input type="text" name="name" placeholder="Full Name" required>
            <input type="email" name="email" placeholder="Email" required>
            <input type="password" name="password" placeholder="Password" required>
            <input type="password" name="c-password" placeholder="Confirm Password" required>
            <button type="submit" class="modal-button">Sign Up</button>
        </form>
        <p>Already have an account? <a href="#" id="switch-to-login">Sign In</a></p>
    </div>
</div>

<!-- Admin Login Modal -->
<div id="adminLoginModal" class="modal">
    <div class="modal-content">
        <span class="close" id="close-admin">&times;</span>
        <h2>Admin Login</h2>
        <form action="AdminLoginServlet" method="post">
            <input type="text" name="adminUsername" placeholder="Admin Username" required>
            <input type="password" name="adminPassword" placeholder="Password" required>
            <button type="submit" class="modal-button">Login</button>
        </form>
    </div>
</div>

<!-- Choose User Type Modal -->
<div id="userTypeModal" class="modal">
    <div class="modal-content">
        <span class="close" id="close-user-type">&times;</span>
        <h2>Select Login Type</h2>
        <button class="modal-button" id="login-user">User Login</button>
        <button class="modal-button" id="login-admin">Admin Login</button>
    </div>
</div>

<!-- Forgot Password Modal -->
<div id="forgotPasswordModal" class="modal">
    <div class="modal-content">
        <span class="close" id="close-forgot-password">&times;</span>
        <h2>Forgot Password</h2>
        <form action="ForgotPasswordServlet" method="post">
            <input type="email" name="email" placeholder="Enter your registered email" required>
            <button type="submit" class="modal-button">Send Reset Link</button>
        </form>
    </div>
</div>

<!-- Reset Password Modal -->
<div id="resetPasswordModal" class="modal">
    <div class="modal-content">
        <span class="close" id="close-reset-password">&times;</span>
        <h2>Reset Password</h2>
        <form action="ResetPasswordServlet" method="post">
            <input type="password" name="newPassword" placeholder="Enter new password" required>
            <input type="password" name="confirmPassword" placeholder="Confirm new password" required>
            <button type="submit" class="modal-button">Reset Password</button>
        </form>
    </div>
</div>

<!-- Profile Modal -->
<div id="profileModal" class="modal">
    <div class="modal-content">
        <span class="close" id="close-profile">&times;</span>
        <h2>User Profile</h2>

        <div class="profile-section">
            <h3><%= request.getSession().getAttribute("name") %></h3>
            <p><%= request.getSession().getAttribute("email") %></p>
        </div>

        <hr>

        <h3>Edit Profile</h3>
        <form action="UpdateProfileServlet" method="post" enctype="multipart/form-data">
            <label for="name">Full Name:</label>
            <input type="text" id="name" name="name" value="<%= request.getSession().getAttribute("name") %>" required>

            <label for="email">Email:</label>
            <input type="email" id="email" name="email" value="<%= request.getSession().getAttribute("email") %>" required>

            <label for="profilePic">Profile Picture:</label>
            <input type="file" id="profilePic" name="profilePic" accept="image/*">

            <button type="submit" class="modal-button">Save Changes</button>
        </form>
    </div>
</div>
