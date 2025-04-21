<!-- DOWNLOAD SECTION -->
<section id="download">
    <div class="download-container">
        <h2>Download Your File</h2>

        <!-- File Selection -->
        <form action="ViewUploads.jsp" method="get">
            <div class="input-group">
                <label for="file-select">Choose Your File:</label>
                <select id="file-select" name="file" required onchange="enableButton()">
                    <option value="">-- Select File --</option>
                    <option value="file1.pdf">All Files</option>
                    <option value="file2.zip">Project File</option>
                    <option value="file3.jpg">Image File</option>
                </select>
            </div>

            <!-- Download Button -->
            <button type="submit" class="download-button" id="download-btn" disabled>Download</button>
        </form>
    </div>
</section>

<script>
    function enableButton() {
        const select = document.getElementById('file-select');
        const button = document.getElementById('download-btn');
        button.disabled = !select.value;
    }
</script>
