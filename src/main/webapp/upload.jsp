 <!-- UPLOAD SECTION -->
<section id="upload">
    <div class="upload-container">
        <h2>Upload Your Study Material</h2>

        <!-- Title & Subject Fields -->
        <form action="UploadServlet" method="post" enctype="multipart/form-data">
        <!-- Drag and Drop Box -->
        <div id="drop-zone">
            <p>Drag & Drop Your File Here</p>
            <input type="file" id="fileInput" name="file" multiple accept=".pdf,.docx,.pptx,.jpg" hidden>
			<input type="text" id="filePath" readonly placeholder="No file selected">
            <button type="button" id="browseButton">Browse Files</button>
        </div>
        
            <input type="hidden" name="filePath" id="filePath">

            <div class="input-group">
                <input type="text" name="title" placeholder="Enter Title" required>
            </div>

            <div class="input-group">
                <select id="subjectSelect" name="subject">
                    <option value="">Select Subject</option>
                    <option value="Math">Math</option>
                    <option value="Science">Science</option>
                    <option value="History">History</option>
                    <option value="English">English</option>
                    <option value="other">Other (Enter Below)</option>
                </select>
            </div>

            <div class="input-group" id="customSubjectDiv" style="display: none;">
                <input type="text" id="customSubject" name="customSubject" placeholder="Enter Custom Subject">
            </div>

            <button class="upload-button" id="uploadButton" disabled>Upload -></button>
        </form>
    </div>
</section>
<script>
    const isLoggedIn = <%= session.getAttribute("userId") != null %>;

    document.getElementById("uploadButton").addEventListener("click", function (e) {
        if (!isLoggedIn) {
            e.preventDefault();
            alert("Please login or signup to upload files.");
            window.location.href = "index.jsp";
        }
    });
</script>
