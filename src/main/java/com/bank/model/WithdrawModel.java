package com.bank.model;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.*;
import com.bank.database.DatabaseConnection;

public class WithdrawModel {

	private static final double MAX_WITHDRAWAL_AMOUNT = 5000000.0;

	public boolean verifyPassword(int accno, String password) {
		try (Connection conn = DatabaseConnection.getConnection();
				PreparedStatement ps = conn.prepareStatement("SELECT password FROM user WHERE accno = ?")) {

			ps.setInt(1, accno);
			ResultSet rs = ps.executeQuery();

			if (rs.next()) {
				return rs.getString("password").equals(hashPassword(password));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return false;
	}

	// Withdraw Amount & Insert into History Table
	public boolean withdrawAmount(int accno, double amount, String accountType) {
		try (Connection conn = DatabaseConnection.getConnection();
				PreparedStatement psBalanceCheck = conn.prepareStatement("SELECT balance FROM balance WHERE accno = ?");
				PreparedStatement psWithdraw = conn
						.prepareStatement("UPDATE balance SET balance = balance - ? WHERE accno = ?");
				PreparedStatement psHistory = conn.prepareStatement(
						"INSERT INTO history (sender_id, receiver_id, amount, transfer_type, transfer_time, account_type, note) VALUES (?, ?, ?, ?, CURRENT_TIMESTAMP, ?, ?)",
						Statement.RETURN_GENERATED_KEYS)) {

			psBalanceCheck.setInt(1, accno);
			ResultSet rs = psBalanceCheck.executeQuery();

			if (!rs.next() || rs.getDouble("balance") < amount) {
				return false; // Insufficient balance
			}

			psWithdraw.setDouble(1, amount);
			psWithdraw.setInt(2, accno);

			if (psWithdraw.executeUpdate() > 0) {
				psHistory.setInt(1, accno);
				psHistory.setString(2, "WITHDRAW");
				psHistory.setDouble(3, amount);
				psHistory.setString(4, "withdraw");
				psHistory.setString(5, accountType);
				psHistory.setString(6, null);
				psHistory.executeUpdate();
				return true;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return false;
	}

	// Retrieve Latest Transfer ID from History Table
	public Integer getTransferId(int accno) {
		Integer transferId = null;
		try (Connection conn = DatabaseConnection.getConnection();
				PreparedStatement ps = conn.prepareStatement(
						"SELECT transfer_id FROM history WHERE sender_id = ? ORDER BY transfer_time DESC LIMIT 1")) {
			ps.setInt(1, accno);
			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				transferId = rs.getInt("transfer_id");
			}
			System.out.println("DEBUG: Retrieved transferId: " + transferId); // Debugging line
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return transferId;
	}

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
