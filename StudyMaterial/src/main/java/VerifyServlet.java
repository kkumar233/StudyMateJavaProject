import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/VerifyServlet")
public class VerifyServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private static final String DB_URL = "jdbc:mysql://localhost:3306/studymatedb";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "";

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String token = request.getParameter("token");
        response.setContentType("text/html");

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD)) {
                String sql = "SELECT email FROM users WHERE token=? AND verified=false";
                try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                    stmt.setString(1, token);
                    ResultSet rs = stmt.executeQuery();

                    if (rs.next()) {
                        String updateQuery = "UPDATE users SET verified=true WHERE token=?";
                        try (PreparedStatement updateStmt = conn.prepareStatement(updateQuery)) {
                            updateStmt.setString(1, token);
                            updateStmt.executeUpdate();
                            response.getWriter().println("<script>alert('Email verified! You can now log in.'); window.location='index.jsp';</script>");
                        }
                    } else {
                        response.getWriter().println("<script>alert('Invalid or already used token!'); window.location='index.jsp';</script>");
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
