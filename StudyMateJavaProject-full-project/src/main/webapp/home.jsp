<%
    boolean isLoggedIn = (session.getAttribute("userId") != null);
%>
 
 <!-- HOME SECTION -->
    <section id="home">
        <div class="overlay"></div>
        <div class="home-content">
            <h2>Unlock Your Potential with StudyMate</h2> <!-- Title in white -->
            <p>Organize your study materials and make learning stress-free.  
               Upload, download, and access your notes any time, anywhere!</p>
            <a href="#" id="getStartedBtn" class="signup-button">Get Started</a>

        </div>
    </section>
    
<script>
    const isLoggedIn = <%= isLoggedIn %>;

    document.getElementById("getStartedBtn").addEventListener("click", function(event) {
        event.preventDefault();

        if (isLoggedIn) {
            // Scroll to the upload section if logged in
            document.getElementById("upload").scrollIntoView({
                behavior: "smooth"
            });
        } else {
            // Alert and show signup modal
            alert("Please log in or sign up to get started.");
            document.getElementById("signupModal").style.display = "flex"; // Show the modal
        }
    });
</script>