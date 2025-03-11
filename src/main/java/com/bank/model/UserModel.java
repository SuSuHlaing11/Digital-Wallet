package com.bank.model;

import java.sql.*;
import com.bank.LanguageHelper;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.security.SecureRandom;
import java.util.Properties;
import javax.mail.*;
import javax.mail.internet.*;
import javax.servlet.http.HttpSession;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.bank.controller.RegisterController;
import com.bank.database.DatabaseConnection;

public class UserModel {
	
	public String registerUser(String fullname, String username, String dob, String gender, String nrc, String address,
			String email, String phone, String acctype, String password1, String rePassword, String lang) {
		
		if (!password1.equals(rePassword)) {
			return LanguageHelper.getMessage("not_match", lang);
		}

		try (Connection conn = DatabaseConnection.getConnection()) {
			System.out.println("DEBUG: Database connection established");

// Check if the user already has the allowed number of accounts
			String checkUserQuery = "SELECT COUNT(*) AS count, GROUP_CONCAT(acctype) AS accts FROM user WHERE email = ?";

			try (PreparedStatement stmt = conn.prepareStatement(checkUserQuery)) {
				stmt.setString(1, email);
				try (ResultSet rs = stmt.executeQuery()) {
					if (rs.next()) {
						int count = rs.getInt("count");
						String existingAccounts = rs.getString("accts");

						if (count >= 2) {
							System.out.println("ERROR: Email already has both accounts: " + email);
							return LanguageHelper.getMessage("both", lang);
						}

						if (existingAccounts != null && existingAccounts.contains(acctype)) {
							System.out.println("ERROR: Duplicate account type for email: " + email);
							String translatedAccType = acctype.equalsIgnoreCase("Current Account") 
								    ? LanguageHelper.getMessage("current_account", lang) 
								    : LanguageHelper.getMessage("savings_account", lang);

								return LanguageHelper.getMessage("duplicate_account_type", lang).replace("{acctype}", translatedAccType);
						}
					}
				}
			}

// Generate unique account number
			int accountNo;
			boolean isUnique;
			SecureRandom rand = new SecureRandom();

			do {
				accountNo = 100000 + rand.nextInt(900000);
				String checkAccountQuery = "SELECT accno FROM user WHERE accno = ?";
				try (PreparedStatement stmt = conn.prepareStatement(checkAccountQuery)) {
					stmt.setInt(1, accountNo);
					try (ResultSet rs = stmt.executeQuery()) {
						isUnique = !rs.next();
					}
				}
			} while (!isUnique);

			System.out.println("DEBUG: Generated Account No: " + accountNo);

// Hash password
			String hashedPassword = hashPassword(password1);

// Insert user into database with 'Pending' status
			String insertQuery = "INSERT INTO user (accno, fullname, username, dob, gender, nrc, address, email, phone, password, acctype, status, code) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, 'Pending', ?)";
			try (PreparedStatement stmt = conn.prepareStatement(insertQuery)) {
				stmt.setInt(1, accountNo);
				stmt.setString(2, fullname);
				stmt.setString(3, username);
				stmt.setString(4, dob);
				stmt.setString(5, gender);
				stmt.setString(6, nrc);
				stmt.setString(7, address);
				stmt.setString(8, email);
				stmt.setString(9, phone);
				stmt.setString(10, hashedPassword);
				stmt.setString(11, acctype);
				stmt.setInt(12, new SecureRandom().nextInt(999999));

				int result = stmt.executeUpdate();
				if (result > 0) {
					System.out.println("DEBUG: User registered successfully with status Pending");
					return null; // Registration successful
				} else {
					return "Error while creating account.";
				}
			}

		} catch (SQLException e) {
			e.printStackTrace();
			return "Database error: " + e.getMessage();
		}
	}

	public boolean approveUser(String email) {
		try (Connection conn = DatabaseConnection.getConnection()) {
			String updateQuery = "UPDATE user SET status = 'Approved' WHERE email = ?";
			try (PreparedStatement stmt = conn.prepareStatement(updateQuery)) {
				stmt.setString(1, email);
				int rowsUpdated = stmt.executeUpdate();

				if (rowsUpdated > 0) {
					System.out.println("DEBUG: User approved successfully: " + email);
					System.out.println("DEBUG: Calling sendApprovalEmail() for " + email);
					sendApprovalEmail(email); // Call email method
					return true;
				} else {
					System.out.println("ERROR: User approval failed for email: " + email);
					return false;
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		}
	}

	public boolean rejectUser(String email) {
		try (Connection conn = DatabaseConnection.getConnection()) {
			String deleteQuery = "DELETE FROM user WHERE email = ?";
			try (PreparedStatement stmt = conn.prepareStatement(deleteQuery)) {
				stmt.setString(1, email);
				int rowsDeleted = stmt.executeUpdate();

				if (rowsDeleted > 0) {
					System.out.println("DEBUG: User successfully deleted from DB: " + email);
					sendRejectionEmail(email); // Send rejection email
					return true;
				} else {
					System.out.println("ERROR: No rows deleted for email: " + email);
					return false;
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		}
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

	private void sendApprovalEmail(String email) {
		final String from = "digitalwallet2025@gmail.com";
		final String smtpUser = "hninshweyiwint2022@gmail.com";
		final String smtpPass = "givw ovku mvla yjqe";
		final String host = "smtp.gmail.com";

		Properties properties = new Properties();
		properties.put("mail.smtp.auth", "true");
		properties.put("mail.smtp.starttls.enable", "true");
		properties.put("mail.smtp.host", host);
		properties.put("mail.smtp.port", "587");

		System.out.println("DEBUG: Setting up email session for approval email...");

		Session mailSession = Session.getInstance(properties, new Authenticator() {
			protected PasswordAuthentication getPasswordAuthentication() {
				return new PasswordAuthentication(smtpUser, smtpPass);
			}
		});

		mailSession.setDebug(true); // Enable debugging

		// Fetch account number from database
		String accountNo = null;

		try (Connection conn = DatabaseConnection.getConnection()) {
			String query = "SELECT accno FROM user WHERE email = ?";
			try (PreparedStatement stmt = conn.prepareStatement(query)) {
				stmt.setString(1, email);
				try (ResultSet rs = stmt.executeQuery()) {
					if (rs.next()) {
						accountNo = rs.getString("accno");
						System.out.println("DEBUG: Retrieved accno for " + email + " -> " + accountNo);
					} else {
						System.out.println("ERROR: No accno found for email: " + email);
						return; // Stop execution if account number is not found
					}
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
			return;
		}

		try {
			Message message = new MimeMessage(mailSession);
			message.setFrom(new InternetAddress(from));
			message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(email));
			message.setSubject("Account Approved - Digital Wallet");

			System.out.println("DEBUG: Preparing approval email content for " + email);

			// HTML-styled email content
			String emailContent = "<html>" + "<head><style>" + "body { font-family: Arial, sans-serif; color: #333; }"
					+ "h2 { color: #007BFF; }" + "p { font-size: 14px; }" + "</style></head>" + "<body>"
					+ "<h2>Welcome to Digital Wallet!</h2>" + "<p>Thank you for joining the Digital Wallet website.</p>"
					+ "<p>Your Digital Wallet account number is provided below:</p><br><br>" + "<h3><b>" + accountNo
					+ "</b></h3><br><br>"
					+ "<p>This account number will be required when you log into your account.</p>"
					+ "<p>If you didn’t request an account registration, no worries! You can safely ignore this email.</p><br>"
					+ "<p>Best regards,<br>The Digital Wallet Team</p>" + "</body></html>";

			message.setContent(emailContent, "text/html");

			System.out.println("DEBUG: Sending approval email to " + email);

			Transport.send(message);
			System.out.println("DEBUG: Approval email sent successfully!");

		} catch (MessagingException e) {
			System.out.println("ERROR: Approval email sending failed!");
			e.printStackTrace();
		}
	}

	// Email notification for account rejection
	private void sendRejectionEmail(String email) {
		final String from = "digitalwallet2025@gmail.com";
		final String smtpUser = "hninshweyiwint2022@gmail.com";
		final String smtpPass = "givw ovku mvla yjqe";
		final String host = "smtp.gmail.com";

		Properties properties = new Properties();
		properties.put("mail.smtp.auth", "true");
		properties.put("mail.smtp.starttls.enable", "true");
		properties.put("mail.smtp.host", host);
		properties.put("mail.smtp.port", "587");

		System.out.println("DEBUG: Setting up email session for rejection email...");

		Session mailSession = Session.getInstance(properties, new Authenticator() {
			protected PasswordAuthentication getPasswordAuthentication() {
				return new PasswordAuthentication(smtpUser, smtpPass);
			}
		});

		try {
			Message message = new MimeMessage(mailSession);
			message.setFrom(new InternetAddress(from));
			message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(email));
			message.setSubject("Account Registration Rejected - Digital Wallet");

			// HTML-styled rejection email content
			String emailContent = "<html>" + "<head>" + "<style>"
					+ "body { font-family: Arial, sans-serif; color: #333; }" + "h2 { color: #FF0000; }"
					+ "p { font-size: 14px; }" + "</style>" + "</head>" + "<body>" + "<h2>We're Sorry!</h2>"
					+ "<p>Unfortunately, your account registration for Digital Wallet has been rejected.</p>"
					+ "<p>There might be missing or incorrect information in your application.</p>"
					+ "<p>We kindly request you to <a href='http://yourwebsite.com/sign_up.jsp'>refill the registration form</a> and try again.</p><br>"
					+ "<p>If you believe this was a mistake, please contact our support team.</p><br>"
					+ "<p>Best regards,<br>The Digital Wallet Team</p>" + "</body>" + "</html>";

			message.setContent(emailContent, "text/html");

			System.out.println("DEBUG: Sending rejection email to " + email + "...");
			Transport.send(message);
			System.out.println("DEBUG: Rejection email sent successfully!");
		} catch (MessagingException e) {
			System.out.println("ERROR: Rejection email sending failed!");
			e.printStackTrace();
		}
	}

	}