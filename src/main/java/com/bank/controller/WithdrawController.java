package com.bank.controller;


import java.io.IOException;
import java.sql.Timestamp;
import java.util.Date;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.bank.LanguageHelper;
import com.bank.model.WithdrawModel;

@WebServlet("/WithdrawController")
public class WithdrawController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private static final double MAX_WITHDRAWAL_AMOUNT = 5000000.0;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        Integer accno = (Integer) session.getAttribute("accno");
        String accountType = request.getParameter("acctype");
        String lang = (session.getAttribute("lang") != null) ? session.getAttribute("lang").toString() : "en";
        
        if (accno == null) {
            response.sendRedirect("sign_in.jsp");
            return;
        }

        String amountStr = request.getParameter("amount");
        String password = request.getParameter("password");

        if (amountStr == null || amountStr.isEmpty() || !amountStr.matches("\\d+(\\.\\d{1,2})?")) {
            
            request.setAttribute("error", LanguageHelper.getMessage("withdraw_above", lang));
            request.getRequestDispatcher("withdraw.jsp").forward(request, response);
            return;
        }

        double amount = Double.parseDouble(amountStr);
        if (amount <= 0 || amount > MAX_WITHDRAWAL_AMOUNT) {
        	request.setAttribute("error", LanguageHelper.getMessage("withdraw_above", lang));
        	request.getRequestDispatcher("withdraw.jsp").forward(request, response);
            return;
        }

        WithdrawModel withdrawModel = new WithdrawModel();
        boolean isPasswordValid = withdrawModel.verifyPassword(accno, password);

        if (!isPasswordValid) {
            System.out.println("DEBUG: Invalid password detected! Setting error message.");
            request.setAttribute("error", LanguageHelper.getMessage("withdraw_pswincorrect", lang));
            request.getRequestDispatcher("withdraw.jsp").forward(request, response);
            return;
        }


        // Perform withdrawal
        boolean withdrawalSuccess = withdrawModel.withdrawAmount(accno, amount, accountType);

        if (withdrawalSuccess) {
            // Fetch latest transfer_id
            Integer transferId = withdrawModel.getTransferId(accno);

            System.out.println("DEBUG: Transfer ID before setting request attribute: " + transferId); // Debugging line

            if (transferId != null) {
                request.setAttribute("transferId", transferId);
            } else {
                request.setAttribute("transferId", "N/A"); // Fallback if not found
            }

            request.setAttribute("Tamount", amount);
            request.setAttribute("transactionType", "Withdraw");
            request.setAttribute("accno", accno);
            request.setAttribute("transactionDate", new Timestamp(new Date().getTime()));

            request.getRequestDispatcher("receipt.jsp").forward(request, response);
        } else {
            response.sendRedirect("withdraw.jsp?error=Withdrawal failed.");
        }
    }
}
