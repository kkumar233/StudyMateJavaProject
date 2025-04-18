<link rel="stylesheet" href="assets/css/profile.css">
<script src="assets/js/profile.js"></script>

<!-- Profile Modal -->
<div id="profileModal" class="modal">
    <div class="modal-content">
        <span class="close" id="close-profile">&times;</span>
        <h2>User Profile</h2>

        <div class="profile-section">
            <img src="uploads/<%= session.getAttribute("profilePic") %>" alt="Profile Picture" class="profile-img">
            <h3><%= session.getAttribute("userName") %></h3>
            <p><%= session.getAttribute("email") %></p>
        </div>

        <hr>

        <h3>Edit Profile</h3>
        <form action="UpdateProfileServlet" method="post" enctype="multipart/form-data">
            <label for="userName">Full Name:</label>
            <input type="text" id="userName" name="userName" value="<%= session.getAttribute("userName") %>" required>

            <label for="email">Email:</label>
            <input type="email" id="email" name="email" value="<%= session.getAttribute("email") %>" required>

            <label for="profilePic">Profile Picture:</label>
            <input type="file" id="profilePic" name="profilePic" accept="image/*">

            <button type="submit" class="modal-button">Save Changes</button>
        </form>
    </div>
</div>
