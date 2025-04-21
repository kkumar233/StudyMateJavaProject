document.addEventListener("DOMContentLoaded", function () {
    const body = document.body;

    function openModal(modal) {
        modal.style.display = "flex";
        body.classList.add("modal-open");
    }

    function closeModal(modal) {
        modal.style.display = "none";
        body.classList.remove("modal-open");
    }

    document.getElementById("open-profile").addEventListener("click", () => {
        openModal(document.getElementById("profileModal"));
    });

    document.getElementById("close-profile").addEventListener("click", () => {
        closeModal(document.getElementById("profileModal"));
    });

    window.addEventListener("click", function (event) {
        document.querySelectorAll(".modal").forEach(modal => {
            if (event.target === modal) closeModal(modal);
        });
    });
});
