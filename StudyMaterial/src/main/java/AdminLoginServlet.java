import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/AdminLoginServlet")
public class AdminLoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    // Static Admin Credentials (No Database)
    private static final String ADMIN_USERNAME = "karan";
    private static final String ADMIN_PASSWORD = "karan123";

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String username = request.getParameter("adminUsername");
        String password = request.getParameter("adminPassword");

        // Authentication Logic
        if (ADMIN_USERNAME.equals(username) && ADMIN_PASSWORD.equals(password)) {
            HttpSession session = request.getSession();
            session.setAttribute("adminAuth", true);  // Setting Admin Authentication Session
            session.setAttribute("adminUsername", username);

            response.sendRedirect("adminDashboard.jsp"); // Redirect to Admin Dashboard
        } else {
            request.setAttribute("errorMessage", "Invalid Username or Password!");
            request.getRequestDispatcher("index.jsp").forward(request, response); // Show error on login page
        }
    }
}
