package com.bank.dao;

import com.bank.database.DatabaseConnection;
import com.bank.model.Deposit;
import java.sql.*;

public class DepositDAO {
    
    public static boolean validateDeposit(Deposit deposit) {
        try (Connection conn = DatabaseConnection.getConnection()) {
            
            // Validate password
            PreparedStatement psPassword = conn.prepareStatement("SELECT password FROM user WHERE accno = ?");
            psPassword.setInt(1, deposit.getAccno());
            ResultSet rsPassword = psPassword.executeQuery();

            if (rsPassword.next()) {
                String storedHashedPassword = rsPassword.getString("password"); // Hashed password from DB
                String userHashedPassword = deposit.getPassword(); // Hashed input password

                if (!storedHashedPassword.equals(userHashedPassword)) {
                    return false; // Incorrect password
                }
            } else {
                return false; // User not found
            }

            return true; // Validation successful
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public static boolean insertDepositApproval(Deposit deposit, String accountType) {
        try (Connection conn = DatabaseConnection.getConnection()) {
            PreparedStatement ps = conn.prepareStatement(
                "INSERT INTO deposit_approve (sender_id, receiver_id, amount, transfer_type, account_type, note, status) " +
                "VALUES (?, ?, ?, ?, ?, ?, ?)"
            );
            ps.setString(1, "DEPOSIT"); // Sender ID is always "DEPOSIT"
            ps.setString(2, String.valueOf(deposit.getAccno())); // Receiver ID (self-deposit)
            ps.setDouble(3, deposit.getAmount()); // Deposit Amount
            ps.setString(4, "Deposit"); // Transfer Type
            ps.setString(5, accountType); // Account Type from DB
            ps.setString(6, ""); // Note
            ps.setString(7, "Pending"); // Status

            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public static String getAccountType(int accno) {
        String accountType = null;
        try (Connection conn = DatabaseConnection.getConnection()) {
            PreparedStatement ps = conn.prepareStatement("SELECT acctype FROM user WHERE accno = ?");
            ps.setInt(1, accno);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                accountType = rs.getString("acctype");
                System.out.println("DEBUG: Account Type Retrieved = " + accountType);
            } else {
                System.out.println("DEBUG: No account type found for accno = " + accno);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return accountType;
    }
}
