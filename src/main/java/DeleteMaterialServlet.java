import java.io.File;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/DeleteMaterialServlet")
public class DeleteMaterialServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private static final String UPLOAD_DIRECTORY = "C:/path/to/your/project/uploads"; // update this path

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String idStr = request.getParameter("id");
        String source = request.getParameter("source"); // Get source: 'admin' or 'user'

        if (idStr == null || idStr.isEmpty()) {
            response.sendRedirect("index.jsp");
            return;
        }

        int id = Integer.parseInt(idStr);
        String fileName = null;

        try {
            Connection conn = DBConnection.getConnection();

            // Fetch filename
            PreparedStatement selectPs = conn.prepareStatement("SELECT file_name FROM uploads WHERE id = ?");
            selectPs.setInt(1, id);
            ResultSet rs = selectPs.executeQuery();
            if (rs.next()) {
                fileName = rs.getString("file_name");
            }

            // Delete from DB
            PreparedStatement deletePs = conn.prepareStatement("DELETE FROM uploads WHERE id = ?");
            deletePs.setInt(1, id);
            deletePs.executeUpdate();

            // Delete physical file
            if (fileName != null) {
                File file = new File(UPLOAD_DIRECTORY + File.separator + fileName);
                if (file.exists()) {
                    file.delete();
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        // Redirect based on source
        if ("admin".equalsIgnoreCase(source)) {
            response.sendRedirect("adminDashboard.jsp");
        } else {
            response.sendRedirect("ViewUploads.jsp");
        }
    }
}
