import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.*;

@WebServlet("/DownloadServlet")
public class DownloadServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

    private static final String UPLOAD_DIR = "uploads";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String filename = request.getParameter("filename");

        if (filename == null || filename.trim().isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Filename is required.");
            return;
        }

        String appPath = request.getServletContext().getRealPath("");
        File file = new File(appPath + File.separator + UPLOAD_DIR, filename);

        if (!file.exists()) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "File not found.");
            return;
        }

        response.setContentType(getServletContext().getMimeType(file.getName()));
        response.setHeader("Content-Disposition", "attachment;filename=\"" + file.getName() + "\"");
        response.setContentLength((int) file.length());

        try (FileInputStream in = new FileInputStream(file);
             OutputStream out = response.getOutputStream()) {

            byte[] buffer = new byte[4096];
            int bytesRead;

            while ((bytesRead = in.read(buffer)) != -1) {
                out.write(buffer, 0, bytesRead);
            }
        }
    }
}
