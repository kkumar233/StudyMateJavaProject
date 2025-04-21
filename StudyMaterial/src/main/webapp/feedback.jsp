<%
    String loggedInUser = (String) session.getAttribute("userName");
%>

<section id="feedback">
    <div class="feedback-container">
        <h2>Give Us Your Feedback</h2>

        <form id="feedback-form" method="post" action="SubmitFeedbackServlet">
            <!-- Star Rating -->
            <div class="star-rating" id="star-rating">
                <span class="star" data-value="1">&#9733;</span>
                <span class="star" data-value="2">&#9733;</span>
                <span class="star" data-value="3">&#9733;</span>
                <span class="star" data-value="4">&#9733;</span>
                <span class="star" data-value="5">&#9733;</span>
            </div>

            <!-- Hidden input to store selected rating -->
            <input type="hidden" id="rating" name="rating">

            <!-- Comment Box -->
            <textarea id="feedback-text" name="feedback" placeholder="Write your feedback here..."></textarea>

            <!-- Submit Button -->
            <button type="submit" class="submit-button" id="submit-feedback" disabled>Submit</button>
        </form>

        <!-- Hidden input to check login on client -->
        <input type="hidden" id="user-status" value="<%= loggedInUser != null ? "loggedIn" : "guest" %>">
    </div>
</section>


