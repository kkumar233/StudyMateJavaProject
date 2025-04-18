import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.*;

@WebServlet("/DeleteFeedbackServlet")
public class DeleteFeedbackServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String feedbackId = request.getParameter("id");

        if (feedbackId != null && !feedbackId.isEmpty()) {
            Connection conn = null;
            PreparedStatement pstmt = null;

            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/studymatedb", "root", "");

                String sql = "DELETE FROM feedback WHERE id = ?";
                pstmt = conn.prepareStatement(sql);
                pstmt.setInt(1, Integer.parseInt(feedbackId));

                int rowsAffected = pstmt.executeUpdate();

                if (rowsAffected > 0) {
                    response.sendRedirect("adminDashboard.jsp?msg=deleted");
                } else {
                    response.sendRedirect("adminDashboard.jsp?msg=notfound");
                }

            } catch (Exception e) {
                e.printStackTrace();
                response.sendRedirect("adminDashboard.jsp?msg=error");
            } finally {
                try {
                    if (pstmt != null) pstmt.close();
                    if (conn != null) conn.close();
                } catch (SQLException ex) {
                    ex.printStackTrace();
                }
            }
        } else {
            response.sendRedirect("adminDashboard.jsp?msg=invalid");
        }
    }
}
