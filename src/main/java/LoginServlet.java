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
import jakarta.servlet.http.HttpSession;
import org.mindrot.jbcrypt.BCrypt;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
    private static final String DB_URL = "jdbc:mysql://localhost:3306/studymatedb";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "";

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        // Validate input
        if (email == null || email.trim().isEmpty() || password == null || password.trim().isEmpty()) {
            request.getSession().setAttribute("loginError", "Email and password cannot be empty.");
            response.sendRedirect("index.jsp");
            return;
        }

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD)) {
                String sql = "SELECT id, name, password FROM users WHERE email=?";
                try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                    stmt.setString(1, email);
                    ResultSet rs = stmt.executeQuery();

                    if (rs.next()) {
                        int userId = rs.getInt("id");
                        String userName = rs.getString("name");
                        String hashedPassword = rs.getString("password");

                        if (BCrypt.checkpw(password, hashedPassword)) {
                            // Create session and store user details
                            HttpSession session = request.getSession();
                            session.setAttribute("userId", userId);
                            session.setAttribute("userName", userName);
                            session.setAttribute("email", email);
                            session.setMaxInactiveInterval(30 * 60); // 30-minute session timeout

                            response.sendRedirect("profile.jsp"); // Redirect to profile page
                        } else {
                            request.getSession().setAttribute("loginError", "Invalid password.");
                            response.sendRedirect("index.jsp");
                        }
                    } else {
                        request.getSession().setAttribute("loginError", "User not found.");
                        response.sendRedirect("index.jsp");
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.getSession().setAttribute("loginError", "Server error. Please try again.");
            response.sendRedirect("index.jsp");
        }
    }
}
