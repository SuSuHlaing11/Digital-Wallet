package com.bank.controller;

import com.bank.model.AlertModel;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
@WebServlet("/AlertController")
public class AlertController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
        throws ServletException, IOException {

        String transferId = request.getParameter("transfer_id"); // Expecting transfer ID

        if (transferId != null && !transferId.isEmpty()) {
            boolean emailSent = AlertModel.sendEmailAlert(transferId);

            if (emailSent) {
                response.getWriter().write("Transfer ID: " + transferId);
            } else {
                response.getWriter().write("Transfer ID: " + transferId);
            }
        } else {
            response.getWriter().write("Transfer ID is required.");
        }
    }
}