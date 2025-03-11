package com.bank.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.mail.*;
import javax.mail.internet.*;
import java.util.Properties;
import com.bank.database.DatabaseConnection;

public class AlertModel {

	public static String getEmailForTransaction(String transferId) {
	    String email = null;
	    try (Connection conn = DatabaseConnection.getConnection()) {
	        String query = "SELECT sender_id, receiver_id, transfer_type FROM history WHERE transfer_id = ?";
	        try (PreparedStatement ps = conn.prepareStatement(query)) {
	            ps.setString(1, transferId);
	            try (ResultSet rs = ps.executeQuery()) {
	                if (rs.next()) {
	                    String senderId = rs.getString("sender_id");
	                    String receiverId = rs.getString("receiver_id");
	                    String transferType = rs.getString("transfer_type"); // Transfer, Deposit, Withdraw, Interest

	                    String accountToNotify = null;

	                    if ("transfer".equalsIgnoreCase(transferType)) {
	                        accountToNotify = senderId; // Notify sender
	                    } else if ("Deposit".equalsIgnoreCase(transferType) || "Interest".equalsIgnoreCase(transferType)) {
	                        accountToNotify = receiverId; // Notify receiver
	                    } else if ("withdraw".equalsIgnoreCase(transferType)) {
	                        accountToNotify = senderId; // Notify sender
	                    }

	                    if (accountToNotify != null) {
	                        // Fetch email from user table
	                        String emailQuery = "SELECT email FROM user WHERE accno = ?";
	                        try (PreparedStatement ps2 = conn.prepareStatement(emailQuery)) {
	                            ps2.setString(1, accountToNotify);
	                            try (ResultSet rs2 = ps2.executeQuery()) {
	                                if (rs2.next()) {
	                                    email = rs2.getString("email");
	                                }
	                            }
	                        }
	                    }
	                }
	            }
	        }
	    } catch (SQLException e) {
	        e.printStackTrace();
	    }
	    return email;
	}

	public static boolean sendEmailAlert(String transferId) {
	    final String from = "digitalwallet2025@gmail.com";
	    final String smtpUser = "hninshweyiwint2022@gmail.com";
	    final String smtpPass = "givw ovku mvla yjqe";
	    final String host = "smtp.gmail.com";

	    Properties properties = new Properties();
	    properties.put("mail.smtp.auth", "true");
	    properties.put("mail.smtp.starttls.enable", "true");
	    properties.put("mail.smtp.host", host);
	    properties.put("mail.smtp.port", "587");

	    System.out.println("DEBUG: Setting up email session for alert email...");

	    Session mailSession = Session.getInstance(properties, new Authenticator() {
	        protected PasswordAuthentication getPasswordAuthentication() {
	            return new PasswordAuthentication(smtpUser, smtpPass);
	        }
	    });

	    mailSession.setDebug(true);

	    // Get the correct email based on transfer type
	    String emailToNotify = getEmailForTransaction(transferId);
	    if (emailToNotify == null) {
	        System.out.println("ERROR: No email found for transfer ID: " + transferId);
	        return false;
	    }

	    try {
	        Message message = new MimeMessage(mailSession);
	        message.setFrom(new InternetAddress(from));
	        message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(emailToNotify));
	        message.setSubject("Urgent Alert - Digital Wallet");

	        String emailContent = "<html><head><style>" +
	                "body { font-family: Arial, sans-serif; color: #333; }" +
	                "h2 { color: #FF0000; }" +
	                "</style></head><body>" +
	                "<h2>Important Alert</h2>" +
	                "<p>A transaction has occurred on your account.</p>" +
	                "<p>If this was not you, please contact our support team immediately.</p>" +
	                "<p>Best regards,<br>The Digital Wallet Team</p>" +
	                "</body></html>";

	        message.setContent(emailContent, "text/html");

	        Transport.send(message);
	        System.out.println("DEBUG: Alert email sent successfully!");
	        return true;
	    } catch (MessagingException e) {
	        System.out.println("ERROR: Alert email sending failed!");
	        e.printStackTrace();
	        return false;
	    }
	}
}
