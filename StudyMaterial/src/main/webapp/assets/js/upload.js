/** JavaScript for Drag & Drop & Subject Selection **/

const dropZone = document.getElementById("drop-zone");
const fileInput = document.getElementById("fileInput");
const browseButton = document.getElementById("browseButton");
const uploadButton = document.getElementById("uploadButton");
const filePath = document.getElementById("filePath"); // You can use this to show selected file names
const subjectSelect = document.getElementById("subjectSelect");
const customSubjectDiv = document.getElementById("customSubjectDiv");
const customSubject = document.getElementById("customSubject");

// Update the filePath input to show all selected filenames
function updateFileListDisplay(files) {
    if (files.length > 0) {
        const names = Array.from(files).map(file => file.name).join(", ");
        filePath.value = names;
        uploadButton.disabled = false;
    } else {
        filePath.value = "";
        uploadButton.disabled = true;
    }
}

// Drag & Drop Events
dropZone.addEventListener("dragover", (e) => {
    e.preventDefault();
    dropZone.classList.add("active");
});

dropZone.addEventListener("dragleave", () => {
    dropZone.classList.remove("active");
});

dropZone.addEventListener("drop", (e) => {
    e.preventDefault();
    dropZone.classList.remove("active");

    const files = e.dataTransfer.files;
    if (files.length > 0) {
        fileInput.files = files;
        updateFileListDisplay(files);
    }
});

// File selection via button
browseButton.addEventListener("click", () => {
    fileInput.click();
});

fileInput.addEventListener("change", () => {
    updateFileListDisplay(fileInput.files);
});

// Subject selection logic
subjectSelect.addEventListener("change", () => {
    if (subjectSelect.value === "other") {
        customSubjectDiv.style.display = "block";
        customSubject.required = true;
    } else {
        customSubjectDiv.style.display = "none";
        customSubject.required = false;
    }
});
