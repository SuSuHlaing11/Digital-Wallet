package com.bank.controller;

import com.bank.dao.UserDAO;
import com.bank.model.User;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import javax.servlet.annotation.WebServlet;

@WebServlet("/manage-accounts")
public class ManageAccountsController extends HttpServlet {
    private UserDAO userDao;

    @Override
    public void init() {
        userDao = new UserDAO();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        try {
            List<User> userList = userDao.getAllUsers();
            request.setAttribute("userList", userList);
            request.getRequestDispatcher("/manage_acc.jsp").forward(request, response);
        } catch (SQLException e) {
            throw new ServletException("Error retrieving users", e);
        }
    }
}