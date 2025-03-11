package com.bank.controller;

import java.awt.Graphics2D;
import java.awt.Image;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import javax.imageio.ImageIO;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import com.bank.dao.AdminDAO;
import com.bank.database.DatabaseConnection;

@WebServlet("/AdminProfileServlet")
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2MB
                 maxFileSize = 1024 * 1024 * 10, // 10MB
                 maxRequestSize = 1024 * 1024 * 50) // 50MB
public class AdminProfileServlet extends HttpServlet {
    private static final String UPLOAD_DIR = "img"; // Store images in img folder

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        String email = request.getParameter("email");
        if (!isValidEmail(email)) {
            request.setAttribute("errorMessage", "Invalid email format! Must be a valid email like 'example@gmail.com'.");
            request.getRequestDispatcher("admin_profile.jsp").forward(request, response);
            return;
        }
        long phone = Long.parseLong(request.getParameter("phone"));

        // Retrieve the current profile picture from DB
        String existingProfilePic = getExistingProfilePicture(id);

        // Handle profile picture upload
        Part filePart = request.getPart("profilePic");
        String fileName = existingProfilePic; // Default to existing image

        if (filePart != null && filePart.getSize() > 0) { // Only update if a new file is uploaded
            String uploadPath = getServletContext().getRealPath("") + File.separator + UPLOAD_DIR;
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) {
                uploadDir.mkdir();
            }

            // Save profile picture with a consistent filename
            fileName = "img/admin_" + id + ".jpg"; // Keep it relative for DB
            String filePath = uploadPath + File.separator + "admin_" + id + ".jpg";
            filePart.write(filePath); // Save the file

            // Crop the image to a square aspect ratio
            cropToSquare(new File(filePath));
        }

        boolean isUpdated = AdminDAO.updateAdminProfile(id, email, phone, fileName);

        if (isUpdated) {
            request.setAttribute("successMessage", "Profile updated successfully!");
        } else {
            request.setAttribute("errorMessage", "Profile update failed!");
        }

        request.getRequestDispatcher("admin_profile.jsp").forward(request, response);
    }
    private boolean isValidEmail(String email) {
        String emailRegex = "^[A-Za-z0-9+_.-]+@(.+)$"; // Allows various email formats
        return email.matches(emailRegex);
    }

    /**
     * Retrieves the current profile picture from the database.
     */
    private String getExistingProfilePicture(int id) {
        String profilePic = "img/No_Img.jpg"; // Default if no image is found
        try (Connection con = DatabaseConnection.getConnection();
             PreparedStatement ps = con.prepareStatement("SELECT profile_picture FROM admin WHERE a_id=?")) {
            
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    String dbPic = rs.getString("profile_picture");
                    if (dbPic != null && !dbPic.isEmpty()) {
                        profilePic = dbPic; // Use existing image from DB
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return profilePic;
    }

    /**
     * Crops an image file to a 1x1 square aspect ratio.
     */
    private void cropToSquare(File imageFile) throws IOException {
        BufferedImage originalImage = ImageIO.read(imageFile);

        if (originalImage == null) {
            throw new IOException("Invalid image file.");
        }

        int width = originalImage.getWidth();
        int height = originalImage.getHeight();
        int squareSize = Math.min(width, height);

        // Crop the image to the center square
        BufferedImage croppedImage = originalImage.getSubimage(
                (width - squareSize) / 2,
                (height - squareSize) / 2,
                squareSize,
                squareSize
        );

        // Resize the cropped image if needed
        BufferedImage resizedImage = new BufferedImage(300, 300, BufferedImage.TYPE_INT_RGB);
        Graphics2D g2d = resizedImage.createGraphics();
        g2d.drawImage(croppedImage.getScaledInstance(300, 300, Image.SCALE_SMOOTH), 0, 0, 300, 300, null);
        g2d.dispose();

        // Save the cropped and resized image
        ImageIO.write(resizedImage, "jpg", imageFile);
    }
}
