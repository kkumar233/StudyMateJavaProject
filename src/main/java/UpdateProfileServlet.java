import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;

@WebServlet("/UpdateProfileServlet")
@MultipartConfig(fileSizeThreshold = 1024 * 1024, // 1MB
                 maxFileSize = 5 * 1024 * 1024,    // 5MB
                 maxRequestSize = 10 * 1024 * 1024) // 10MB
public class UpdateProfileServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private static final String DB_URL = "jdbc:mysql://localhost:3306/studymatedb";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "";

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        int userId = (int) session.getAttribute("userId");

        String userName = request.getParameter("userName");
        String email = request.getParameter("email");

        Part filePart = request.getPart("profilePic");
        String fileName = null;

        if (filePart != null && filePart.getSize() > 0) {
            fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();

            String uploadPath = getServletContext().getRealPath("") + File.separator + "uploads";
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) uploadDir.mkdir();

            filePart.write(uploadPath + File.separator + fileName);
        } else {
            fileName = (String) session.getAttribute("profilePic");
        }

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD)) {
                String sql = "UPDATE users SET name = ?, email = ?, profile_pic = ? WHERE id = ?";
                try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                    stmt.setString(1, userName);
                    stmt.setString(2, email);
                    stmt.setString(3, fileName);
                    stmt.setInt(4, userId);

                    int rowsUpdated = stmt.executeUpdate();

                    if (rowsUpdated > 0) {
                        session.setAttribute("userName", userName);
                        session.setAttribute("email", email);
                        session.setAttribute("profilePic", fileName);

                        response.sendRedirect("index.jsp?success=profile_updated");
                    } else {
                        response.sendRedirect("index.jsp?error=update_failed");
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("index.jsp?error=server_error");
        }
    }
}
