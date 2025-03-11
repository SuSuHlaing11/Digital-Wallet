package com.bank.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.bank.LanguageHelper;
import com.bank.model.TransferModel;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
@WebServlet("/TransferController")
public class TransferController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        System.out.println("DEBUG: TransferController doPost() called");

        HttpSession session = request.getSession();
        Integer accno = (Integer) session.getAttribute("accno");
        String lang = (session.getAttribute("lang") != null) ? session.getAttribute("lang").toString() : "en";
        
        if (accno == null) {
            System.out.println("DEBUG: User not logged in, redirecting to sign_in.jsp");
            response.sendRedirect("sign_in.jsp");
            return;
        }

        System.out.println("DEBUG: Logged-in user account number: " + accno);

        // Print received parameters for debugging
        request.getParameterMap().forEach((key, value) -> 
            System.out.println("DEBUG: Parameter - " + key + ": " + String.join(", ", value))
        );

        String amountStr = request.getParameter("amount");
        String password = request.getParameter("password");
        String toAccountStr = request.getParameter("toAccount");

        System.out.println("DEBUG: Amount received: " + amountStr);
        System.out.println("DEBUG: Password received (before hashing): " + password);
        System.out.println("DEBUG: To Account received: " + toAccountStr);

        // Validate user inputs
        if (amountStr == null || amountStr.isEmpty()) {
        	request.setAttribute("error", LanguageHelper.getMessage("amt_req", lang));
            request.getRequestDispatcher("transfer.jsp").forward(request, response);
            return;
        }

        if (!amountStr.matches("\\d+(\\.\\d{1,2})?")) {  // Ensure input is a valid number
        	request.setAttribute("error", LanguageHelper.getMessage("withdraw_above", lang));
            request.getRequestDispatcher("transfer.jsp").forward(request, response);
            return;
        }

        if (password == null || password.isEmpty()) {
        	request.setAttribute("error", LanguageHelper.getMessage("enter_psw", lang));
            request.getRequestDispatcher("transfer.jsp").forward(request, response);
            return;
        }

        if (toAccountStr == null || toAccountStr.isEmpty()) {
        	request.setAttribute("error", LanguageHelper.getMessage("enter_rece", lang));
            request.getRequestDispatcher("transfer.jsp").forward(request, response);
            return;
        }

        double amount = Double.parseDouble(amountStr);
        int toAccount = Integer.parseInt(toAccountStr);

        if (amount <= 0 || amount>5000000) {
        	request.setAttribute("error", LanguageHelper.getMessage("inv_amt_format", lang));
            request.getRequestDispatcher("transfer.jsp").forward(request, response);
            return;
        }
        if (accno == toAccount) {
        	request.setAttribute("error", LanguageHelper.getMessage("not_own", lang));
            request.getRequestDispatcher("transfer.jsp").forward(request, response);
            return;
        }
        // Verify password before proceeding with transfer
        TransferModel transferModel = new TransferModel();
        boolean isPasswordValid = transferModel.verifyPassword(accno, password);

        if (!isPasswordValid) {
        	request.setAttribute("error", LanguageHelper.getMessage("withdraw_pswincorrect", lang));
            request.getRequestDispatcher("transfer.jsp").forward(request, response);
            return;
        }

        // Process transfer
        String result = transferModel.transferAmount(accno, toAccount, amount, session);

        if (result != null && result.matches("\\d+")) { // Ensure result is a valid transfer_id
            String receiptId = String.valueOf(toAccount); // Keep existing logic for receiptId
            String transactionType = "Transfer"; // This could be dynamic based on the transaction type
            LocalDateTime currentDateTime = LocalDateTime.now();
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"); 
            String transactionDate = currentDateTime.format(formatter); 
            double Tamount = Double.parseDouble(amountStr); 
            int receiverAcc = (int) Tamount; // Keep existing logic

            // New field for TransferId
            int transferId = Integer.parseInt(result); // Use the generated transfer_id
            System.out.println("Parsed Transfer ID: " + transferId);
            // Set attributes for the receipt page
            request.setAttribute("receiptId", receiptId);  
            request.setAttribute("transactionType", transactionType);
            request.setAttribute("Tamount", Tamount); 
            request.setAttribute("accno", accno);
            request.setAttribute("transactionDate", transactionDate); 
            request.setAttribute("receiverAcc", receiverAcc);
            request.setAttribute("transferId", transferId);

            // Forward the request to the receipt page
            request.getRequestDispatcher("receipt.jsp").forward(request, response);
        } else {
        	request.setAttribute("error", LanguageHelper.getMessage(result, lang));
            request.getRequestDispatcher("transfer.jsp").forward(request, response);
        }
    }

    }