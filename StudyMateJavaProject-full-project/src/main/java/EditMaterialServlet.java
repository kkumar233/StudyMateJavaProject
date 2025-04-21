import java.io.IOException;
import java.sql.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/EditMaterialServlet")
public class EditMaterialServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        String title = request.getParameter("title");
        String subject = request.getParameter("subject");

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            try (Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/studymatedb", "root", "");
                 PreparedStatement ps = conn.prepareStatement("UPDATE uploads SET title = ?, subject = ? WHERE id = ?")) {

                ps.setString(1, title);
                ps.setString(2, subject);
                ps.setInt(3, id);
                ps.executeUpdate();
            }
            response.sendRedirect("ViewUploads.jsp");
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().write("Error: " + e.getMessage());
        }
    }
}
