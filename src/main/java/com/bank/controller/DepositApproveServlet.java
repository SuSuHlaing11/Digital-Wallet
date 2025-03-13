package com.bank.controller;

import java.io.IOException;
import java.net.Authenticator;
import java.net.PasswordAuthentication;
import java.sql.*;
import java.util.Properties;
import javax.mail.*;
import javax.mail.internet.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.bank.dao.AdminDAO;
import com.bank.dao.DepositDAO;
import com.bank.database.DatabaseConnection;

@WebServlet("/DepositApproveServlet")
public class DepositApproveServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String idParam = request.getParameter("id");
        if (idParam == null || idParam.isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Deposit ID is missing");
            return;
        }

        int depositId;
        try {
            depositId = Integer.parseInt(idParam);
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid Deposit ID");
            return;
        }

        String action = request.getParameter("action");
        if ("approve".equals(request.getParameter("action"))) {
            System.out.println("DEBUG: Approving deposit with ID " + depositId);
            boolean success = approveDeposit(depositId); // Already updates balance before deleting

            if (success) {
                response.setContentType("text/plain");
                response.getWriter().write("success");
            } else {
                response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Approval failed.");
            }
        }

        else if ("reject".equals(request.getParameter("action"))) {
            System.out.println("DEBUG: Rejecting deposit with ID " + depositId);
            boolean success = rejectDeposit(depositId);

            if (success) {
                response.setContentType("text/plain");
                response.getWriter().write("rejected"); // ✅ Send response to AJAX
            } else {
                response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Rejection failed.");
            }
        }

        else if ("undo".equals(action)) {
            System.out.println("DEBUG: Undoing rejection for deposit ID " + depositId);
            boolean success = undoRejectDeposit(depositId);
            if (success) {
                response.setContentType("text/plain");
                response.getWriter().write("undone");
            } else {
                response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Undo failed.");
            }
        }
    }

    public boolean approveDeposit(int depositId) {
        try (Connection conn = DatabaseConnection.getConnection()) {
            conn.setAutoCommit(false); // ✅ Start transaction

            // ✅ Step 1: Fetch approved deposit details
            String selectQuery = "SELECT d.receiver_id, d.amount, d.transfer_type, d.transfer_time, u.email " +
                    "FROM deposit_approve d " +
                    "JOIN user u ON CAST(u.accno AS CHAR) = CAST(d.receiver_id AS CHAR) " +
                    "WHERE d.deposit_id = ?";
            int accno = 0;
            double amount = 0.0;
            String transferType = "";
            String transferTime = "";
            String email = null;

            try (PreparedStatement selectStmt = conn.prepareStatement(selectQuery)) {
                selectStmt.setInt(1, depositId);
                try (ResultSet rs = selectStmt.executeQuery()) {
                    if (rs.next()) {
                        accno = rs.getInt("receiver_id");
                        amount = rs.getDouble("amount");
                        transferType = rs.getString("transfer_type");
                        transferTime = rs.getString("transfer_time");
                        email = rs.getString("email");
                    } else {
                        System.out.println("ERROR: No matching record found for deposit ID: " + depositId);
                        return false;
                    }
                }
            }

            // ✅ Step 2: Update balance
            String updateQuery = "UPDATE balance SET balance = balance + ? WHERE accno = ?";
            try (PreparedStatement updateStmt = conn.prepareStatement(updateQuery)) {
                updateStmt.setDouble(1, amount);
                updateStmt.setInt(2, accno);
                int rowsUpdated = updateStmt.executeUpdate();

                if (rowsUpdated == 0) {
                    String insertBalanceQuery = "INSERT INTO balance (accno, balance) VALUES (?, ?)";
                    try (PreparedStatement insertStmt = conn.prepareStatement(insertBalanceQuery)) {
                        insertStmt.setInt(1, accno);
                        insertStmt.setDouble(2, amount);
                        insertStmt.executeUpdate();
                    }
                }
            }

            // ✅ Step 3: Move to history table and retrieve transfer_id
            String insertHistorySql = "INSERT INTO history (sender_id, receiver_id, amount, transfer_type, transfer_time, account_type) "
                    +
                    "SELECT sender_id, receiver_id, amount, transfer_type, transfer_time, account_type " +
                    "FROM deposit_approve WHERE deposit_id = ?";

            int transferId = -1; // Default in case of failure

            try (PreparedStatement insertStmt = conn.prepareStatement(insertHistorySql,
                    Statement.RETURN_GENERATED_KEYS)) {
                insertStmt.setInt(1, depositId);
                int historyRows = insertStmt.executeUpdate();

                if (historyRows == 0) {
                    System.out.println("ERROR: Failed to insert deposit into history.");
                    conn.rollback();
                    return false;
                }

                // ✅ Get the generated transfer_id
                try (ResultSet generatedKeys = insertStmt.getGeneratedKeys()) {
                    if (generatedKeys.next()) {
                        transferId = generatedKeys.getInt(1); // Retrieve the auto-generated transfer_id
                        System.out.println("DEBUG: Generated transfer_id = " + transferId);
                    } else {
                        System.out.println("ERROR: Failed to retrieve transfer_id.");
                    }
                }
            }

            // ✅ Step 4: Delete from deposit_approve
            String deleteQuery = "DELETE FROM deposit_approve WHERE deposit_id = ?";
            try (PreparedStatement deleteStmt = conn.prepareStatement(deleteQuery)) {
                deleteStmt.setInt(1, depositId);
                int deletedRows = deleteStmt.executeUpdate();

                if (deletedRows > 0) {
                    conn.commit(); // ✅ Commit transaction
                    System.out.println("DEBUG: Deposit approved, moved to history, and balance updated.");

                    // ✅ Send approval email with approved deposit details
                    if (email != null && transferId != -1) {
                        sendApprovalEmail(email, accno, amount, transferType, transferTime, transferId);
                    } else {
                        System.out.println("WARNING: No valid email or transfer_id for deposit ID " + depositId);
                    }

                    return true;
                } else {
                    System.out.println("ERROR: Failed to delete from deposit_approve.");
                    conn.rollback();
                    return false;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    private void sendApprovalEmail(String email, int accno, double amount, String transferType, String transferTime,
            int transferId) {
        final String from = "sender@gmail.com";
        final String smtpUser = "smtpAuthentication@gmail.com";
        final String smtpPass = "app password";
        final String host = "smtp.gmail.com";

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

        mailSession.setDebug(true);

        try {
            Message message = new MimeMessage(mailSession);
            message.setFrom(new InternetAddress(from));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(email));
            message.setSubject("Deposit Approved - Digital Wallet");

            // ✅ Updated Email with transferId
            String emailContent = "<html>" +
                    "<head>" +
                    "<style>" +
                    "body { font-family: Arial, sans-serif; background-color: #f4f4f5; color: #333; padding: 20px; text-align: center; }"
                    +
                    ".container { max-width: 600px; margin: auto; background-color: #f4f4f5; padding: 20px; border-radius: 8px; }"
                    +
                    ".header { margin-bottom: 20px; }" +
                    ".header i { font-size: 48px; }" +
                    ".header h3 { color: #333; margin-top: 10px; }" +
                    ".amount { color: #333; font-weight: bold; font-size: 20px; margin-top: 10px; }" +
                    ".hr { border: 0; border-top: 1px solid #fff; margin: 20px 0; }" +
                    ".list-group { list-style-type: none; padding: 0; margin: 0; text-align: left; }" +
                    ".list-group-item { padding: 10px; text-align: left; display: flex; justify-content: space-between; border-bottom: 1px solid #333; }"
                    +
                    "</style>" +
                    "</head>" +
                    "<body>" +
                    "<div class='container'>" +
                    "<div class='header'>" +
                    "<i class='fa-solid fa-check-circle' style=' font-size: 48px;'></i>" +
                    "<h3 style='text-align: center; color: #333; margin-top: 10px;'>Deposit Successful</h3>" +
                    "<h3 class='fw-bold' style='text-align: center; font-size: 20px;'>+ " + amount + " Ks</h3>" +
                    "</div>" +
                    "<hr class='hr'>" +
                    "<h4 style='text-align: center; color: #333;'>Receipt</h4>" +

                    "<div class='row'>" +
                    "<div class='col-md-12'>" +
                    "<ul class='list-group mb-3'>" +
                    "<li class='list-group-item' style='text-align: left; color: #333;'><strong>Receipt ID:</strong> <span style='text-align: right; flex-grow: 1;'> "
                    + transferId + "</span></li>" +
                    "<li class='list-group-item' style='text-align: left; color: #333; '><strong>Transaction Type:</strong> <span style='text-align: right; flex-grow: 1;'> "
                    + transferType + "</span></li>" +
                    "<li class='list-group-item' style='text-align: left; color: #333; '><strong>My Account:</strong> <span style='text-align: right; flex-grow: 1;'> "
                    + accno + "</span></li>" +

                    "<li class='list-group-item' style='text-align: left; color: #333; '><strong>Amount:</strong> <span style='text-align: right; flex-grow: 1;'> "
                    + amount + " Ks</span></li>" +
                    "<li class='list-group-item' style='text-align: left; color: #333; '><strong>Date & Time:</strong> <span style='text-align: right; flex-grow: 1;'> "
                    + transferTime + "</span></li>" +
                    "</ul>" +
                    "</div>" +
                    "</div>" +

                    "<h5 style='text-align: center; color: #333;'>Thank you for using our service!</h5>" +

                    "</div>" +
                    "</body>" +
                    "</html>";

            message.setContent(emailContent, "text/html");

            Transport.send(message);
            System.out.println("DEBUG: Approval email sent successfully!");
        } catch (MessagingException e) {
            System.out.println("ERROR: Approval email sending failed!");
            e.printStackTrace();
        }
    }

    public boolean undoRejectDeposit(int depositId) {
        try (Connection conn = DatabaseConnection.getConnection()) {
            String updateQuery = "UPDATE deposit_approve SET status = 'Pending' WHERE deposit_id = ?";
            try (PreparedStatement stmt = conn.prepareStatement(updateQuery)) {
                stmt.setInt(1, depositId);
                int rowsUpdated = stmt.executeUpdate();

                if (rowsUpdated > 0) {
                    System.out.println("DEBUG: Deposit status restored to Pending. ID: " + depositId);
                    return true;
                } else {
                    System.out.println("ERROR: No rows updated for undo action. ID: " + depositId);
                    return false;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean rejectDeposit(int depositId) {
        try (Connection conn = DatabaseConnection.getConnection()) {
            // ✅ Step 1: Fetch email & validate deposit ID
            String email = null;
            String fetchQuery = "SELECT u.email " +
                    "FROM deposit_approve d " +
                    "JOIN user u ON CAST(u.accno AS CHAR) = CAST(d.receiver_id AS CHAR) " +
                    "WHERE d.deposit_id = ?";

            try (PreparedStatement fetchStmt = conn.prepareStatement(fetchQuery)) {
                fetchStmt.setInt(1, depositId);
                try (ResultSet rs = fetchStmt.executeQuery()) {
                    if (rs.next()) {
                        email = rs.getString("email");
                    }
                }
            }

            if (email == null || email.isEmpty()) {
                System.out.println("ERROR: Email not found for deposit ID: " + depositId);
                return false;
            }

            // ✅ Step 2: Update status in `deposit_approve`
            String updateQuery = "UPDATE deposit_approve SET status = 'Rejected' WHERE deposit_id = ?";
            try (PreparedStatement stmt = conn.prepareStatement(updateQuery)) {
                stmt.setInt(1, depositId);
                int rowsUpdated = stmt.executeUpdate();

                if (rowsUpdated > 0) {
                    System.out.println("DEBUG: Deposit rejected successfully. ID: " + depositId);
                    sendRejectionEmail(email); // ✅ Send rejection email
                    return true;
                } else {
                    System.out.println("ERROR: No rows updated for deposit rejection. ID: " + depositId);
                    return false;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

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

        Session mailSession = Session.getInstance(properties, new Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(smtpUser, smtpPass);
            }
        });
        try {
            Message message = new MimeMessage(mailSession);
            message.setFrom(new InternetAddress(from));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(email));
            message.setSubject("Deposit Rejected - Digital Wallet");

            String emailContent = "<html><body>" +
                    "<h2>Your Deposit Request Was Rejected</h2>" +
                    "<p>Unfortunately, your deposit request has been rejected.</p>" +
                    "<p>If you have any questions, please contact support.</p>" +
                    "<p>Best Regards,<br>Digital Wallet Team</p>" +
                    "</body></html>";

            message.setContent(emailContent, "text/html");
            Transport.send(message);
            System.out.println("DEBUG: Rejection email sent successfully!");
        } catch (MessagingException e) {
            System.out.println("ERROR: Rejection email sending failed!");
            e.printStackTrace();
        }
    }

}
