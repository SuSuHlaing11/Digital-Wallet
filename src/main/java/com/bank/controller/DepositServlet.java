package com.bank.controller;

import com.bank.dao.DepositDAO;
import com.bank.model.Deposit;
import com.bank.model.User;
import com.bank.LanguageHelper;

import java.io.IOException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

@WebServlet("/DepositServlet")
public class DepositServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        System.out.println("DepositServlet: Request received");

        HttpSession session = request.getSession();
        Integer accno = (Integer) session.getAttribute("accno");
        String lang = (session.getAttribute("lang") != null) ? session.getAttribute("lang").toString() : "en";
        if (accno == null) {
            response.sendRedirect("sign_in.jsp");
            return;
        }

        try {
            String amountStr = request.getParameter("amount");
            String password = request.getParameter("password");

            if (amountStr == null || amountStr.trim().isEmpty()) {
            	request.setAttribute("error", LanguageHelper.getMessage("amt_req", lang));
                request.getRequestDispatcher("deposit.jsp").forward(request, response);
                return;
            }

            double amount = Double.parseDouble(amountStr);

            System.out.println("Received amount: " + amount);

            // Validation: amount must be greater than 0 and less than or equal to 5,000,000
            if (amount <= 0 || amount > 5000000) {
            	request.setAttribute("error", LanguageHelper.getMessage("withdraw_above", lang));
                request.getRequestDispatcher("deposit.jsp").forward(request, response);
                return;
            }

            // Hash the user-input password before validation
            String hashedPassword = hashPassword(password);

            // Retrieve account type from database
            String accountType = DepositDAO.getAccountType(accno);

         // If account type is null, return an error
         if (accountType == null || accountType.trim().isEmpty()) {
             System.out.println("ERROR: Failed to retrieve account type for accno = " + accno);
             request.setAttribute("error", LanguageHelper.getMessage("retre_accT", lang));
             request.getRequestDispatcher("deposit.jsp").forward(request, response);
             return;
         }
         System.out.println("DEBUG: Account Type Used = " + accountType);
            Deposit deposit = new Deposit(accno, amount, hashedPassword);

            // Validate deposit (check password)
            if (!DepositDAO.validateDeposit(deposit)) {
            	request.setAttribute("error", LanguageHelper.getMessage("inv_psw", lang));
                request.getRequestDispatcher("deposit.jsp").forward(request, response);
                return;
            }

            // Insert deposit for approval (sender_id = "DEPOSIT")
            // Insert deposit for approval (sender_id = "DEPOSIT")
            if (DepositDAO.insertDepositApproval(deposit, accountType)) {
            	request.setAttribute("success", LanguageHelper.getMessage("deposit_submit1", lang));
            } 
            else {
            	request.setAttribute("error", LanguageHelper.getMessage("f_deposit", lang));
            }

            request.getRequestDispatcher("deposit.jsp").forward(request, response);


        } catch (NumberFormatException e) {
        	request.setAttribute("error", LanguageHelper.getMessage("inv_amt_format", lang));
            request.getRequestDispatcher("deposit.jsp").forward(request, response);
        } catch (Exception e) {
        	request.setAttribute("error", LanguageHelper.getMessage("error", lang));
            request.getRequestDispatcher("deposit.jsp").forward(request, response);
        }
    }

    // Method to hash password using SHA-256
    private static String hashPassword(String password) {
        try {
            MessageDigest md = MessageDigest.getInstance("SHA-256");
            byte[] hashedBytes = md.digest(password.getBytes());

            // Convert bytes to hex
            StringBuilder hexString = new StringBuilder();
            for (byte b : hashedBytes) {
                String hex = Integer.toHexString(0xff & b);
                if (hex.length() == 1) hexString.append('0');
                hexString.append(hex);
            }
            return hexString.toString();
        } catch (NoSuchAlgorithmException e) {
            throw new RuntimeException("Error hashing password", e);
        }
    }
    
}
