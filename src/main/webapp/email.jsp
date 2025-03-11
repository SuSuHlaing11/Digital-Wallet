<%@ page import="java.util.*, javax.mail.*, javax.mail.internet.*, javax.mail.Authenticator, javax.mail.PasswordAuthentication" %>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<html>
<head>
    <title>Email Receipt</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            padding: 20px;
            text-align: center;
        }
        .container {
            width: 80%;
            max-width: 600px;
            background: #fff;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            margin: auto;
        }
        .header {
            text-align: center;
            margin-bottom: 20px;
        }
        .header i {
            color: green;
            font-size: 36px;
        }
        .header h3 {
            color: #333;
        }
        .amount {
            color: #ff6257;
            font-weight: bold;
            font-size: 20px;
        }
        hr {
            border: 0;
            border-top: 2px solid #eee;
            margin: 20px 0;
        }
        .details-list {
            list-style-type: none;
            padding: 0;
            text-align: left;
        }
        .details-list li {
            display: flex;
            justify-content: space-between;
            padding: 8px 0;
            border-bottom: 1px solid #ddd;
        }
        .details-list .label {
            font-weight: bold;
            color: #333;
        }
        .details-list .value {
            text-align: right;
            color: #555;
        }
        .footer {
            text-align: center;
            margin-top: 20px;
            font-size: 14px;
            color: #777;
        }
        .btn {
            background-color: #4CAF50; /* Green */
            border: none;
            color: white;
            padding: 15px 32px;
            text-align: center;
            font-size: 16px;
            cursor: pointer;
            margin-top: 20px;
        }
        .btn:hover {
            background-color: #45a049;
        }
        .email-input {
            padding: 10px;
            margin-top: 10px;
            font-size: 16px;
            width: 100%;
            border: 1px solid #ccc;
            border-radius: 5px;
        }
    </style>
</head>
<body>
    <div class="container">

        <!-- Form to receive email and send the receipt -->
        <form method="post">
            <!-- Email input field -->
            <input type="email" name="email" class="email-input" placeholder="Enter your email to receive the receipt" required />

            <!-- Hidden fields for transaction details -->
            <input type="hidden" name="amount" value="<%= request.getParameter("amount") %>" />
            <button type="submit" class="btn">Send Receipt via Email</button>
        </form>

    </div>
    
<%@ page import="java.io.*, java.util.*, java.nio.charset.StandardCharsets" %>

    <%
        String email = request.getParameter("email");
        String amount = request.getParameter("amount");

        if (email != null && amount != null && request.getMethod().equalsIgnoreCase("POST")) {
            String transactionId = UUID.randomUUID().toString();
            String date = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date());

            String from = "digitalwallet2025@gmail.com";
            String host = "smtp.gmail.com";
            
            Properties properties = new Properties();
            properties.put("mail.smtp.auth", "true");
            properties.put("mail.smtp.starttls.enable", "true");
            properties.put("mail.smtp.host", host);
            properties.put("mail.smtp.port", "587");

            final String smtpUser = "hninshweyiwint2022@gmail.com";
            final String smtpPass = "givw ovku mvla yjqe";

            Session mailSession = Session.getInstance(properties, new Authenticator() {
                protected PasswordAuthentication getPasswordAuthentication() {
                    return new PasswordAuthentication(smtpUser, smtpPass);
                }
            });

            try {
                Message message = new MimeMessage(mailSession);
                message.setFrom(new InternetAddress(from));
                message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(email));
                message.setSubject("Payment Receipt - Digital Wallet");

                String emailContent = "<html>" +
                	    "<head>" +
                	    "<style>" +
                	    "body { font-family: Arial, sans-serif; background-color: #f4f4f5; color: #333; padding: 20px; text-align: center; }" +
                	    ".container { max-width: 600px; margin: auto; background-color: #f4f4f5; padding: 20px; border-radius: 8px; }" +
                	    ".header { margin-bottom: 20px; }" +
                	    ".header i { font-size: 48px; }" +
                	    ".header h3 { color: #333; margin-top: 10px; }" +
                	    ".amount { color: #333; font-weight: bold; font-size: 20px; margin-top: 10px; }" +
                	    ".hr { border: 0; border-top: 1px solid #fff; margin: 20px 0; }" +
                	    ".list-group { list-style-type: none; padding: 0; margin: 0; text-align: left; }" +
                	    ".list-group-item { padding: 10px; text-align: left; display: flex; justify-content: space-between; border-bottom: 1px solid #333; }" +
                	    
                	    "</style>" +
                	    "</head>" +
                	    "<body>" +
                	    "<div class='container'>" +
                	    "<div class='header'>" +
                	    "<i class='fa-solid fa-check-circle' style=' font-size: 48px;'></i>" +
                	    "<h3 style='text-align: center; color: #333; margin-top: 10px;'>Transaction Successful</h3>" +
                	    "<h3 class='fw-bold' style='text-align: center; font-size: 20px;'>-${Tamount} Ks</h3>" +
                	    "</div>" +
                	    "<hr class='hr'>" +
                	    "<h4 style='text-align: center; color: #333;'>Receipt</h4>" +
                	    
                	    "<div class='row'>" +
                	    "<div class='col-md-12'>" +
                	    "<ul class='list-group mb-3'>" +
                	    "<li class='list-group-item' style='text-align: left; color: #333;'><strong>Receipt ID:</strong> <span style='text-align: right; flex-grow: 1;'> ${transferId}</span></li>" +
                	    "<li class='list-group-item' style='text-align: left; color: #333; '><strong>Transaction Type:</strong> <span style='text-align: right; flex-grow: 1;'> ${transactionType}</span></li>" +
                	    "<li class='list-group-item' style='text-align: left; color: #333; '><strong>My Account:</strong> <span style='text-align: right; flex-grow: 1;'> ${accno}</span></li>" +
                	    
                	    "<li class='list-group-item' style='text-align: left; color: #333; '><strong>Amount:</strong> <span style='text-align: right; flex-grow: 1;'> -${Tamount} Ks</span></li>" +
                	    "<li class='list-group-item' style='text-align: left; color: #333; '><strong>Date & Time:</strong> <span style='text-align: right; flex-grow: 1;'> ${transactionDate}</span></li>" +
                	    "</ul>" +
                	    "</div>" +
                	    "</div>" +
                	    
                	    "<h5 style='text-align: center; color: #333;'>Thank you for using our service!</h5>" +
                	    
                	    "</div>" +
                	    "</body>" +
                	    "</html>";


                message.setContent(emailContent, "text/html");
                Transport.send(message);
                out.println("<p style='color: green;'>Email receipt sent to " + email + " successfully.</p>");

            } catch (MessagingException e) {
                e.printStackTrace();
                out.println("<p style='color: red;'>Error sending email: " + e.getMessage() + "</p>");
            }
        }
    %>
</body>
</html>
