package com.bank.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.bank.model.UserModel;

@WebServlet("/AdminApproval")
public class AdminApproval extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");
        String action = request.getParameter("action");

        if (email == null || action == null) {
            response.sendRedirect("acc_requests.jsp?error=Invalid Request");
            return;
        }

        UserModel userModel = new UserModel();
        boolean success = false;
        String redirectParam = "error=Failed to process the request."; // Default error message

        if (action.equals("approve")) {
            success = userModel.approveUser(email);
            if (success) {
                redirectParam = "success=Account approved successfully.";
            }
        } else if (action.equals("reject")) {
            success = userModel.rejectUser(email);
            if (success) {
                redirectParam = "rejectsuccess=Account rejected successfully."; // Different message
            }
        }

        response.sendRedirect("acc_requests.jsp?" + redirectParam);
    }
}
