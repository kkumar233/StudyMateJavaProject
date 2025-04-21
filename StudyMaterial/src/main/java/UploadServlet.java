import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.List;

@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 * 1, // 1MB
    maxFileSize = 10 * 1024 * 1024,      // 10MB
    maxRequestSize = 100 * 1024 * 1024   // Increased total request size for multiple files
)
@WebServlet("/UploadServlet")
public class UploadServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private static final String UPLOAD_DIR = "uploads";

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            out.println("<script>alert('Please login or signup to upload files.'); window.location='index.jsp';</script>");
            return;
        }

        int userId = (int) session.getAttribute("userId");

        String appPath = request.getServletContext().getRealPath("");
        String uploadPath = appPath + File.separator + UPLOAD_DIR;

        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) uploadDir.mkdir();

        // Get common form fields
        String title = request.getParameter("title");
        String subject = request.getParameter("subject");
        String customSubject = request.getParameter("customSubject");
        String finalSubject = "other".equals(subject) ? customSubject : subject;

        boolean allSuccess = true;
        List<String> fileNames = new ArrayList<>(); // List to store file names

        // Iterate through the parts and process the files
        for (Part part : request.getParts()) {
            if (part.getName().equals("file") && part.getSize() > 0) {
                String fileName = Paths.get(part.getSubmittedFileName()).getFileName().toString();
                String filePath = uploadPath + File.separator + fileName;

                try {
                    part.write(filePath); // Save the file to disk
                    fileNames.add(fileName); // Add the file name to the list
                } catch (Exception e) {
                    e.printStackTrace();
                    allSuccess = false;
                }
            }
        }

        // If all files were uploaded successfully, save them to the database
        if (allSuccess && !fileNames.isEmpty()) {
            boolean isSaved = UploadDAO.saveFiles(userId, title, finalSubject, fileNames);
            if (isSaved) {
                out.println("<script>alert('Files uploaded successfully!'); window.location='index.jsp';</script>");
            } else {
                out.println("<script>alert('Failed to save some files to the database.'); window.location='index.jsp';</script>");
            }
        } else {
            out.println("<script>alert('Some files failed to upload.'); window.location='index.jsp';</script>");
        }

        out.close();
    }
}
