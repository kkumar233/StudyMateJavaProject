import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.List;

public class UploadDAO {

    @SuppressWarnings("unused")
	public static boolean saveFiles(int userId, String title, String subject, List<String> fileNames) {
        boolean status = false;
        String sql = "INSERT INTO uploads (user_id, title, subject, file_name) VALUES (?, ?, ?, ?)";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            if (conn == null) {
                throw new SQLException("Failed to establish database connection.");
            }

            // Add each file to the batch
            for (String fileName : fileNames) {
                ps.setInt(1, userId);
                ps.setString(2, title);
                ps.setString(3, subject);
                ps.setString(4, fileName);
                ps.addBatch(); // Queue the insert
            }

            // Execute the batch and check the result
            int[] rows = ps.executeBatch();  // Executes the batch insert
            status = rows.length == fileNames.size(); // Check if all files were inserted

        } catch (SQLException e) {
            e.printStackTrace(); // Print the exception for debugging
            // You can optionally rather this as a custom exception
            // throw new RuntimeException("Error saving files to database", e);
        }

        return status;
    }
}
