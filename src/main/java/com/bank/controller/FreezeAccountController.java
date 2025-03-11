package com.bank.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.Connection;

import com.bank.dao.UserDAO;
import com.bank.database.DatabaseConnection;
import com.bank.websocket.FreezeWebSocket;

@WebServlet("/admin/freezeAccount")
public class FreezeAccountController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    	int id = Integer.parseInt(request.getParameter("id"));
        boolean freeze = "freeze".equals(request.getParameter("action")); // Check if freezing or unfreezing

        try (Connection conn = DatabaseConnection.getConnection()) {
            UserDAO userDAO = new UserDAO();
            boolean success = userDAO.updateFreezeStatus(id, freeze);
            
            FreezeWebSocket.notifyUser(String.valueOf(id), freeze ? "frozen" : "unfrozen");

            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");

            response.getWriter().write("{\"success\": " + success + ", \"freeze\": " + freeze + "}");
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().write("{\"success\": false, \"freeze\": false}");
        }
    }
}