const stars = document.querySelectorAll(".star");
const ratingInput = document.getElementById("rating");
const feedbackText = document.getElementById("feedback-text");
const submitButton = document.getElementById("submit-feedback");

let selectedRating = 0;

// Handle star clicks
stars.forEach(star => {
    star.addEventListener("click", () => {
        selectedRating = parseInt(star.getAttribute("data-value"));
        ratingInput.value = selectedRating;

        // Highlight stars
        stars.forEach(s => {
            s.style.color = parseInt(s.getAttribute("data-value")) <= selectedRating ? "#f39c12" : "#ccc";
        });

        checkEnableSubmit();
    });
});

// Enable submit button only when rating and feedback are filled
feedbackText.addEventListener("input", checkEnableSubmit);

function checkEnableSubmit() {
    const feedback = feedbackText.value.trim();
    if (selectedRating > 0 && feedback.length > 0) {
        submitButton.disabled = false;
    } else {
        submitButton.disabled = true;
    }
}

// Validate on submit
document.getElementById("feedback-form").addEventListener("submit", function(e) {
    const userStatus = document.getElementById("user-status").value;
    const feedback = feedbackText.value.trim();
    const ratingValue = ratingInput.value;

    if (userStatus !== "loggedIn") {
        e.preventDefault();
        alert("Please log in or sign up to submit feedback.");
    } else if (!ratingValue || feedback === "") {
        e.preventDefault();
        alert("Please provide both rating and feedback.");
    }
});
