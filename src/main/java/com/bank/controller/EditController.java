package com.bank.controller;

import java.io.IOException;
import java.io.File;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.bank.dao.UserDAO;
import com.bank.model.User;
import com.bank.database.DatabaseConnection;

@WebServlet("/EditController")
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2MB
        maxFileSize = 1024 * 1024 * 10, // 10MB
        maxRequestSize = 1024 * 1024 * 50) // 50MB
public class EditController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private static final String UPLOAD_DIR = "img"; // Directory to store uploaded profile pictures
    private static final String DEFAULT_PROFILE_PIC = "img/No_Img.jpg"; // Default profile picture

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Integer accno = (Integer) session.getAttribute("accno");

        if (accno == null) {
            response.sendRedirect("editprofile.jsp?message=Account number not found in session");
            return;
        }

        User user = UserDAO.getUserByAccno(accno);
        if (user != null) {
            request.setAttribute("user", user);
            request.setAttribute("fullname", user.getFullname());

            // Ensure profile picture is not null
            String tempProfilePic = user.getProfilePicture();
            request.setAttribute("profilePicture",
                    (tempProfilePic == null || tempProfilePic.isEmpty()) ? DEFAULT_PROFILE_PIC : tempProfilePic);

            request.setAttribute("phone", user.getPhone());
            request.setAttribute("username", user.getUsername());
        }

        double balance = fetchUserBalance(accno);
        request.setAttribute("balance", balance);
        request.getRequestDispatcher("editprofile.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Integer accno = (Integer) session.getAttribute("accno");

        if (accno == null) {
            response.sendRedirect("editprofile.jsp?message=Account number not found in session");
            return;
        }

        User user = UserDAO.getUserByAccno(accno);
        if (user == null) {
            response.sendRedirect("editprofile.jsp?message=User not found");
            return;
        }

        // Debugging Logs
        String username = request.getParameter("username");
        System.out.println("[DEBUG] Received username: " + username);
        System.out.println("[DEBUG] Received phone: " + request.getParameter("phone"));
        System.out.println("[DEBUG] Checking form enctype...");

        String phoneStr = request.getParameter("phone");
        Part filePart = request.getPart("profile_picture");

        if (filePart != null) {
            String fileName = filePart.getSubmittedFileName();
            long fileSize = filePart.getSize();

            System.out.println("[DEBUG] Profile picture part received: " + (filePart != null));
            System.out.println("[DEBUG] File name: " + fileName);
            System.out.println("[DEBUG] File size: " + fileSize);

            if (fileName == null || fileName.trim().isEmpty()) {
                System.out.println("[ERROR] File name is null or empty. File upload failed.");
            } else if (fileSize < 1000) { // Less than 1KB
                System.out.println("[WARNING] Uploaded file is too small, possibly invalid.");
            } else {
                String uploadPath = getServletContext().getRealPath("") + File.separator + UPLOAD_DIR;
                File uploadDir = new File(uploadPath);
                if (!uploadDir.exists()) {
                    uploadDir.mkdir();
                }

                String filePath = uploadPath + File.separator + "user_" + accno + ".jpg";
                filePart.write(filePath);
                System.out.println("[INFO] Profile picture updated successfully. Stored at: " + filePath);
            }
        } else {
            System.out.println("[DEBUG] No file selected.");
        }

        String profilePicture = user.getProfilePicture();

        if (phoneStr == null || phoneStr.isEmpty()) {
            System.out.println("[ERROR] Phone number is missing from request.");
            response.sendRedirect("editprofile.jsp?message=Phone number is required");
            return;
        }

        long phone;
        try {
            phone = Long.parseLong(phoneStr);
            System.out.println("[INFO] Parsed phone number: " + phone);
        } catch (NumberFormatException e) {
            response.sendRedirect("editprofile.jsp?message=Invalid phone number");
            return;
        }

        profilePicture = handleProfilePictureUpload(filePart, accno, profilePicture);

        user.setUsername(username);
        user.setPhone(phone);
        user.setProfilePicture(profilePicture);

        boolean updateStatus = UserDAO.updateUserProfile(user);
        if (updateStatus) {
            System.out.println("[SUCCESS] User profile updated successfully");
            session.setAttribute("profileUpdateSuccess", true); // Set success flag
            response.sendRedirect("profile.jsp");
        } else {
            System.out.println("[ERROR] Failed to update user profile");
            response.sendRedirect("editprofile.jsp?message=Failed to update user");
        }
    }

    private double fetchUserBalance(int accno) {
        double balance = 0.00;
        try (Connection con = DatabaseConnection.getConnection();
             PreparedStatement psBalance = con.prepareStatement("SELECT balance FROM balance WHERE accno = ?")) {
            psBalance.setInt(1, accno);
            try (ResultSet rsBalance = psBalance.executeQuery()) {
                if (rsBalance.next()) {
                    balance = rsBalance.getDouble("balance");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return balance;
    }

    private String handleProfilePictureUpload(Part filePart, int accno, String existingProfilePicture) {
        String profilePicture = existingProfilePicture;

        if (filePart != null && filePart.getSize() > 0) {
            String uploadPath = getServletContext().getRealPath("") + File.separator + UPLOAD_DIR;
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) {
                uploadDir.mkdir();
            }

            profilePicture = "img/user_" + accno + ".jpg";
            String filePath = uploadPath + File.separator + "user_" + accno + ".jpg";
            try {
                filePart.write(filePath);
                System.out.println("[INFO] Profile picture updated successfully. Stored at: " + filePath);
            } catch (Exception e) {
                System.out.println("[ERROR] Failed to save profile picture: " + e.getMessage());
            }
        } else {
            System.out.println("[DEBUG] No new profile picture uploaded. Retaining existing profile picture.");
        }

        return (profilePicture == null || profilePicture.isEmpty()) ? DEFAULT_PROFILE_PIC : profilePicture;
    }
}