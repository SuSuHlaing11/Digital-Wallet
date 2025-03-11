package com.bank.controller;

import java.io.IOException;
import java.util.Properties;
import javax.mail.*;
import javax.mail.internet.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.bank.dao.UserDAO;
import com.bank.model.User;

@WebServlet("/admin/deleteAccount")
public class DeleteAccountController extends HttpServlet{
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String userIdStr = request.getParameter("id");
        
        if (userIdStr != null) {
            int userId = Integer.parseInt(userIdStr);  
            
            UserDAO userDAO = new UserDAO();
            User deletedUser = userDAO.getUserById(userId); 
            if (deletedUser == null) {
                response.getWriter().write("{\"success\": false, \"error\": \"User not found\"}");
                return;
            }
            boolean success = userDAO.deleteUser(userId);

            if (success) {
            	if (deletedUser != null && deletedUser.getEmail() != null) {
                    sendEmail(deletedUser.getEmail(), deletedUser.getFullname(), deletedUser.getAccno());
                }
                response.getWriter().write("{\"success\": true}");
            } else {
                response.getWriter().write("{\"success\": false}");
            }
        } else {
            response.getWriter().write("{\"success\": false, \"error\": \"ID not provided\"}");
        }
    }
	
	private void sendEmail(String recipientEmail, String fullName, int accNo) {
		final String from = "hninshweyiwint2022@gmail.com";
        final String smtpUser = "hninshweyiwint2022@gmail.com";
        final String smtpPass = "givw ovku mvla yjqe";
        final String host = "smtp.gmail.com";
        
        System.out.println("Preparing to send email to " + recipientEmail);

        Properties properties = new Properties();
        properties.put("mail.smtp.auth", "true");
        properties.put("mail.smtp.starttls.enable", "true");
        properties.put("mail.smtp.host", host);
        properties.put("mail.smtp.port", "587");

        Session mailSession = Session.getInstance(properties, new Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(smtpUser, smtpPass);
            }
        });

        try {
            Message message = new MimeMessage(mailSession);
            message.setFrom(new InternetAddress(from));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(recipientEmail));
            message.setSubject("Account Deleted");
            message.setText("Dear " + fullName + ",\n\n"
                + "Your account (Account No: " + accNo + ") has been deleted. "
                + "If you have any questions, please contact support.\n\n"
                + "Best regards,\nThe Digital Wallet Team");
            
            System.out.println("Sending email...");

            Transport.send(message);
            System.out.println("Email sent successfully to " + recipientEmail);
        } catch (MessagingException e) {
            System.err.println("Email sending failed: " + e.getMessage());
            e.printStackTrace();
        }
    }
}
