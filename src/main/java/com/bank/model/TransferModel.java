package com.bank.model;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import com.bank.LanguageHelper;
import com.bank.database.DatabaseConnection;

public class TransferModel {

    public boolean verifyPassword(int accno, String password) {
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            conn = DatabaseConnection.getConnection();
            String query = "SELECT password FROM user WHERE accno = ?";
            ps = conn.prepareStatement(query);
            ps.setInt(1, accno);
            rs = ps.executeQuery();

            if (rs.next()) {
                String storedPassword = rs.getString("password");

                // Hash the entered password before comparison
                String hashedPassword = hashPassword(password);

                // Debugging output
                System.out.println("DEBUG: Stored Password (from DB) = " + storedPassword);
                System.out.println("DEBUG: Hashed Entered Password = " + hashedPassword);

                // Compare the hashed entered password with stored hashed password
                return storedPassword.equals(hashedPassword);
            } else {
                System.out.println("DEBUG: No user found with accno: " + accno);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close();
                if (ps != null) ps.close();
                if (conn != null) conn.close();
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
        }
        return false;
    }

    public String transferAmount(int fromAccount, int toAccount, double amount, HttpSession session) {
        Connection conn = null;
        PreparedStatement psBalanceCheck = null;
        PreparedStatement psCheckDeleted = null;
        PreparedStatement psWithdraw = null;
        PreparedStatement psDeposit = null;
        PreparedStatement psHistory = null;
        ResultSet rs = null;

        String lang = (session.getAttribute("lang") != null) ? session.getAttribute("lang").toString() : "en";
        
        try {
            conn = DatabaseConnection.getConnection();

            // Check current balance of sender
            String balanceQuery = "SELECT balance FROM balance WHERE accno = ?";
            psBalanceCheck = conn.prepareStatement(balanceQuery);
            psBalanceCheck.setInt(1, fromAccount);
            rs = psBalanceCheck.executeQuery();

            if (!rs.next()) {
                return "Sender account not found.";
            }

            double currentBalance = rs.getDouble("balance");

            // Check if transfer amount is greater than balance
            if (amount > currentBalance) {
                return LanguageHelper.getMessage("no_balance", lang);
            }
            
            String checkDeletedQuery = "SELECT is_deleted FROM user WHERE accno = ?";
            psCheckDeleted = conn.prepareStatement(checkDeletedQuery);
            psCheckDeleted.setInt(1, toAccount);
            ResultSet rsDeleted = psCheckDeleted.executeQuery();

            if (rsDeleted.next()) {
                Boolean isDeleted = rsDeleted.getBoolean("is_deleted");
                if (isDeleted) {
                    return LanguageHelper.getMessage("receiver_deactivated", lang);
                }
            } else {
                return LanguageHelper.getMessage("receiver_not_found", lang);
            }

            // Perform withdrawal from sender's account
            String updateWithdrawQuery = "UPDATE balance SET balance = balance - ? WHERE accno = ?";
            psWithdraw = conn.prepareStatement(updateWithdrawQuery);
            psWithdraw.setDouble(1, amount);
            psWithdraw.setInt(2, fromAccount);

            // Perform deposit to receiver's account
            String updateDepositQuery = "UPDATE balance SET balance = balance + ? WHERE accno = ?";
            psDeposit = conn.prepareStatement(updateDepositQuery);
            psDeposit.setDouble(1, amount);
            psDeposit.setInt(2, toAccount);

            int rowsWithdrawn = psWithdraw.executeUpdate();
            int rowsDeposited = psDeposit.executeUpdate();

            if (rowsWithdrawn > 0 && rowsDeposited > 0) {
                // Now, check for large transaction and insert into history with appropriate note
                int transferId = processTransfer(fromAccount, toAccount, amount, conn);

                if (transferId != -1) {
                    return String.valueOf(transferId); // Return the transfer_id as a string
                } else {
                    return LanguageHelper.getMessage("no_transID", lang);
                }
            } else {
                return LanguageHelper.getMessage("trans_fail", lang);
            }

        } catch (SQLException e) {
            e.printStackTrace();
            return "Database error: " + e.getMessage();
        } finally {
            try {
                if (rs != null) rs.close();
                if (psBalanceCheck != null) psBalanceCheck.close();
                if (psWithdraw != null) psWithdraw.close();
                if (psDeposit != null) psDeposit.close();
                if (psHistory != null) psHistory.close();
                if (conn != null) conn.close();
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
        }
    }


    public int processTransfer(int fromAccount, int toAccount, double amount, Connection conn) throws SQLException {
        // Define the threshold amount and time window (e.g., 1 hour)
        double thresholdAmount = 100000; // Example: alert for transfers greater than 100,000
        long timeWindowInMillis = 60 * 60 * 1000; // 1 hour in milliseconds

        // Get the current time
        long currentTimeMillis = System.currentTimeMillis();

        // Get the last transaction time for the sender (you can fetch it from the database)
        String lastTransactionTimeQuery = "SELECT MAX(transfer_time) FROM history WHERE sender_id = ?";
        PreparedStatement psLastTransaction = conn.prepareStatement(lastTransactionTimeQuery);
        psLastTransaction.setInt(1, fromAccount);
        ResultSet rsLastTransaction = psLastTransaction.executeQuery();

        long lastTransactionTime = 0;
        if (rsLastTransaction.next()) {
            lastTransactionTime = rsLastTransaction.getTimestamp(1).getTime(); // Get the last transaction time in milliseconds
        }

        // Check if the amount exceeds the threshold and the time window condition
        String note = null;
        if (amount > thresholdAmount && (currentTimeMillis - lastTransactionTime) <= timeWindowInMillis) {
            note = "alert"; // Insert "alert" if the conditions are met
        }

        // Insert the transaction into the history table
        String insertHistoryQuery = "INSERT INTO history (sender_id, receiver_id, amount, transfer_type, transfer_time, note, account_type) VALUES (?, ?, ?, ?, CURRENT_TIMESTAMP, ?, ?)";
        PreparedStatement psHistory = conn.prepareStatement(insertHistoryQuery, PreparedStatement.RETURN_GENERATED_KEYS);

        // Set parameters for the history insert query
        psHistory.setInt(1, fromAccount); // Sender account
        psHistory.setInt(2, toAccount);   // Receiver account
        psHistory.setDouble(3, amount);    // Transfer amount
        psHistory.setString(4, "transfer"); // Transfer type
        psHistory.setString(5, note);      // Set the note (either null or "alert")
        psHistory.setString(6, "Checking account"); // Account type (set to "Checking account")

        // Execute the query to insert the transaction into history
        int rowsAffected = psHistory.executeUpdate();

        if (rowsAffected > 0) {
            // Retrieve the generated transfer_id (if any)
            ResultSet generatedKeys = psHistory.getGeneratedKeys();
            if (generatedKeys.next()) {
                int transferId = generatedKeys.getInt(1);
                System.out.println("Generated Transfer ID: " + transferId);  // Debugging line to log transferId
                return transferId;  // Return the transfer_id
            }
        }
        return -1; // Return -1 if transfer_id could not be retrieved
    }


    // Password Hashing Function
    private String hashPassword(String password) {
        try {
            MessageDigest md = MessageDigest.getInstance("SHA-256");
            md.update(password.getBytes());
            byte[] digest = md.digest();
            StringBuilder hexString = new StringBuilder();
            for (byte b : digest) {
                hexString.append(String.format("%02x", b));
            }
            return hexString.toString();
        } catch (NoSuchAlgorithmException e) {
            throw new RuntimeException("Error hashing password", e);
        }
    }
}