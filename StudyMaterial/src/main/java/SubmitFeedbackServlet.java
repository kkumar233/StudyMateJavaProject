import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/SubmitFeedbackServlet")
public class SubmitFeedbackServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        HttpSession session = request.getSession(false);
        String username = (session != null) ? (String) session.getAttribute("userName") : null;

        String feedback = request.getParameter("feedback");
        String ratingStr = request.getParameter("rating");

        if (username == null || feedback == null || ratingStr == null) {
            response.sendRedirect("index.jsp?error=missing");
            return;
        }

        try {
            int rating = Integer.parseInt(ratingStr);

            Class.forName("com.mysql.cj.jdbc.Driver");
            try (Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/studymatedb", "root", "");
                 PreparedStatement ps = conn.prepareStatement("INSERT INTO feedback (username, feedback, rating) VALUES (?, ?, ?)")) {

                ps.setString(1, username);
                ps.setString(2, feedback);
                ps.setInt(3, rating);
                ps.executeUpdate();
                session.setAttribute("feedbackSubmitted", true); // ✅ Set flag
                response.sendRedirect("index.jsp"); // ✅ Redirect

            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("index.jsp?error=server");
        }
    }
}
