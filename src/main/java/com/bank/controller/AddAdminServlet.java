package com.bank.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.bank.model.Admin;
import com.bank.dao.AdminDAO;

@WebServlet("/AddAdminServlet")
public class AddAdminServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String phoneStr = request.getParameter("phone");
        String password = request.getParameter("password");

        // Validate inputs
        if (username == null || username.trim().isEmpty()) {
            request.setAttribute("errorMessage", "Username is required.");
            request.getRequestDispatcher("add_admin.jsp").forward(request, response);
            return;
        }

        if (email == null || email.trim().isEmpty()) {
            request.setAttribute("errorMessage", "Email is required.");
            request.getRequestDispatcher("add_admin.jsp").forward(request, response);
            return;
        }

        if (password == null || password.trim().isEmpty()) {
            request.setAttribute("errorMessage", "Password is required.");
            request.getRequestDispatcher("add_admin.jsp").forward(request, response);
            return;
        }

        long phone = 0;
        if (phoneStr != null && !phoneStr.isEmpty()) {
            if (phoneStr.matches("\\d+")) {
                try {
                    phone = Long.parseLong(phoneStr);
                } catch (NumberFormatException e) {
                    request.setAttribute("errorMessage", "Invalid phone number format.");
                    request.getRequestDispatcher("add_admin.jsp").forward(request, response);
                    return;
                }
            } else {
                request.setAttribute("errorMessage", "Phone number should contain only digits.");
                request.getRequestDispatcher("add_admin.jsp").forward(request, response);
                return;
            }
        } else {
            request.setAttribute("errorMessage", "Phone number is required.");
            request.getRequestDispatcher("add_admin.jsp").forward(request, response);
            return;
        }

        Admin admin = new Admin(username, email, phone, password);
        int status = AdminDAO.insertAdmin(admin);

        if (status == -1) {
            request.setAttribute("errorMessage", "Username already exists. Please choose a different one.");
        } else if (status > 0) {
            request.setAttribute("successMessage", "Admin added successfully!");
        } else {
            request.setAttribute("errorMessage", "Failed to add admin. Please try again.");
        }

        request.getRequestDispatcher("add_admin.jsp").forward(request, response);
    }
}
