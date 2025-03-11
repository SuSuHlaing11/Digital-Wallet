package com.bank.dao;

import com.bank.database.DatabaseConnection;
import com.bank.model.User;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class UserDAO {
    private static final String GET_ALL_USERS = "SELECT * FROM user";

    public List<User> getAllUsers() throws SQLException {
        List<User> userList = new ArrayList<>();
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(GET_ALL_USERS);
             ResultSet rs = pstmt.executeQuery()) {
            
            while (rs.next()) {
                User user = new User();
                user.setId(rs.getInt("id"));
                user.setAccno(rs.getInt("accno"));
                user.setFullname(rs.getString("fullname"));
                user.setUsername(rs.getString("username"));
                user.setDob(rs.getDate("dob"));
                user.setGender(rs.getString("gender"));
                user.setNrc(rs.getString("nrc"));
                user.setAddress(rs.getString("address"));
                user.setEmail(rs.getString("email"));
                user.setPhone(rs.getLong("phone"));
                user.setAcctype(rs.getString("acctype"));
                user.setStatus(rs.getString("status"));
                user.setProfilePicture(rs.getString("profile_picture"));
                user.setFrozen(rs.getBoolean("is_frozen"));
                user.setDeleted(rs.getBoolean("is_deleted"));
                
                userList.add(user);
            }
        }
        return userList;
    }
    
    public boolean updateFreezeStatus(int id, boolean freeze) {
        String query = "UPDATE user SET is_frozen = ? WHERE id = ?";
        try (Connection conn = DatabaseConnection.getConnection();
        	PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setBoolean(1, freeze);
            stmt.setInt(2, id);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    public boolean deleteUser(int userId) {
        String query = "UPDATE user SET is_deleted = TRUE WHERE id = ?";
        try (Connection conn = DatabaseConnection.getConnection();
        	PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, userId);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    public User getUserById(int userId) {
        User user = null;
        String query = "SELECT fullname, email, accno FROM user WHERE id = ?";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, userId);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                user = new User();
                user.setFullname(rs.getString("fullname"));
                user.setEmail(rs.getString("email"));
                user.setAccno(rs.getInt("accno"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return user;
    }
    
    public String getUserEmailById(int userId) {
        String email = null;
        String query = "SELECT email FROM user WHERE id = ?";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setInt(1, userId);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                email = rs.getString("email");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return email;
    }

    public static int insertUser(User user) {
        int status = 0;
        Connection con = null;
        PreparedStatement checkStmt = null;
        PreparedStatement insertStmt = null;
        ResultSet rs = null;

        try {
            con = DatabaseConnection.getConnection();
            
            if (con == null) {
                System.out.println("[ERROR] Database connection is null.");
                return 0;
            }

            System.out.println("[INFO] Connected to database successfully!");

            String checkQuery = "SELECT COUNT(*) FROM user WHERE username = ?";
            checkStmt = con.prepareStatement(checkQuery);
            checkStmt.setString(1, user.getUsername());
            rs = checkStmt.executeQuery();

            if (rs.next() && rs.getInt(1) > 0) {
                System.out.println("[INFO] Username already exists: " + user.getUsername());
                return -1;
            }

            System.out.println("[INFO] Username is unique. Proceeding to insert user...");

            String insertQuery = "INSERT INTO user (id, accno, fullname, username, dob, gender, nrc, address, email, phone, acctype, password, code, status, profile_picture) "
                    + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, 'Pending', NULL)";
            insertStmt = con.prepareStatement(insertQuery);
            insertStmt.setInt(1, user.getId());
            insertStmt.setInt(2, user.getAccno());
            insertStmt.setString(3, user.getFullname());
            insertStmt.setString(4, user.getUsername());
            insertStmt.setDate(5, user.getDob());
            insertStmt.setString(6, user.getGender());
            insertStmt.setString(7, user.getNrc());
            insertStmt.setString(8, user.getAddress());
            insertStmt.setString(9, user.getEmail());
            insertStmt.setLong(10, user.getPhone());
            insertStmt.setString(11, user.getAcctype());
            insertStmt.setString(12, user.getPassword());
            insertStmt.setInt(13, user.getCode());

            status = insertStmt.executeUpdate();

            if (status > 0) {
                System.out.println("[SUCCESS] User inserted successfully with NULL profile picture!");
            } else {
                System.out.println("[ERROR] Failed to insert user.");
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

    public static boolean updateUser(User user) {
        try (Connection con = DatabaseConnection.getConnection();
             PreparedStatement ps = con.prepareStatement("UPDATE user SET username=?, phone=?, address=? WHERE accno=?")) {
            
            ps.setString(1, user.getUsername());
            ps.setLong(2, user.getPhone());
            ps.setString(3, user.getAddress());
            ps.setInt(4, user.getAccno());

            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public static boolean updateUserProfile(User user) {
        try (Connection con = DatabaseConnection.getConnection();
             PreparedStatement ps = con.prepareStatement("UPDATE user SET username=?, phone=?, address=?, profile_picture=? WHERE accno=?")) {
            
            ps.setString(1, user.getUsername());
            ps.setLong(2, user.getPhone());
            ps.setString(3, user.getAddress());
            ps.setString(4, user.getProfilePicture());
            ps.setInt(5, user.getAccno());

            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public static User getUserByAccno(int accno) {
        User user = null;
        try (Connection con = DatabaseConnection.getConnection();
             PreparedStatement ps = con.prepareStatement("SELECT * FROM user WHERE accno=?")) {
            
            ps.setInt(1, accno);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                user = new User(
                    rs.getInt("id"),
                    rs.getInt("accno"),
                    rs.getString("fullname"),
                    rs.getString("username"),
                    rs.getDate("dob"),
                    rs.getString("gender"),
                    rs.getString("nrc"),
                    rs.getString("address"),
                    rs.getString("email"),
                    rs.getLong("phone"),
                    rs.getString("acctype"),
                    rs.getString("password"),
                    rs.getInt("code"),
                    rs.getString("status"),
                    rs.getString("profile_picture"),
                    rs.getBoolean("is_frozen"),
                	rs.getBoolean("is_deleted")
                );
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return user;
    }

}