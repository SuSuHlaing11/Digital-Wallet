package com.bank.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import com.bank.model.Admin;
import com.bank.database.DatabaseConnection;
import java.sql.ResultSet;

public class AdminDAO {

    public static int insertAdmin(Admin admin) {
        int status = 0;
        Connection con = null;
        PreparedStatement checkStmt = null;
        PreparedStatement insertStmt = null;
        ResultSet rs = null;

        try {
            con = DatabaseConnection.getConnection();
            
            if (con == null) {
                System.out.println("[ERROR] Database connection is null.");
                return 0; // Connection failed
            }

            System.out.println("[INFO] Connected to database successfully!");

            // Check if username already exists
            String checkQuery = "SELECT COUNT(*) FROM admin WHERE username = ?";
            checkStmt = con.prepareStatement(checkQuery);
            checkStmt.setString(1, admin.getUsername());
            rs = checkStmt.executeQuery();

            if (rs.next() && rs.getInt(1) > 0) {
                System.out.println("[INFO] Username already exists: " + admin.getUsername());
                return -1; // Username already exists
            }

            System.out.println("[INFO] Username is unique. Proceeding to insert admin...");

            // Insert new admin with NULL profile picture
            String insertQuery = "INSERT INTO admin (username, email, phone, password, profile_picture) VALUES (?, ?, ?, ?, NULL)";
            insertStmt = con.prepareStatement(insertQuery);
            insertStmt.setString(1, admin.getUsername());
            insertStmt.setString(2, admin.getEmail());
            insertStmt.setLong(3, admin.getPhone());
            insertStmt.setString(4, admin.getPassword());

            status = insertStmt.executeUpdate();

            if (status > 0) {
                System.out.println("[SUCCESS] Admin inserted successfully with NULL profile picture!");
            } else {
                System.out.println("[ERROR] Failed to insert admin.");
            }

        } catch (SQLException e) {
            e.printStackTrace();
            System.out.println("[ERROR] SQL Exception: " + e.getMessage());
            status = 0;
        } finally {
            try {
                if (rs != null) rs.close();
                if (checkStmt != null) checkStmt.close();
                if (insertStmt != null) insertStmt.close();
                if (con != null) con.close();
                System.out.println("[INFO] Database connections closed.");
            } catch (SQLException e) {
                e.printStackTrace();
                System.out.println("[ERROR] Error closing database connections.");
                status = 0;
            }
        }
        return status;
    }
    public static boolean updateAdminProfile(int id, String email, long phone, String profilePicPath) {
        try (Connection con = DatabaseConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(
                     "UPDATE admin SET email=?, phone=?, profile_picture=? WHERE a_id=?"
             )) {
            
            ps.setString(1, email);
            ps.setLong(2, phone);
            ps.setString(3, profilePicPath);
            ps.setInt(4, id);

            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
    public static boolean updateAdmin(Admin admin) {
        try (Connection con = DatabaseConnection.getConnection();
             PreparedStatement ps = con.prepareStatement("UPDATE admin SET email=?, phone=?, profile_picture=? WHERE a_id=?")) {
            
            ps.setString(1, admin.getEmail());
            ps.setLong(2, admin.getPhone());
            ps.setString(3, admin.getProfilePicture());
            ps.setInt(4, admin.getA_id());

            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
}
