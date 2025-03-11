package com.bank.controller;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.bank.database.DatabaseConnection;

import java.io.*;
import java.sql.*;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import com.bank.LanguageHelper;

@WebServlet("/login")
public class LoginController extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Getting parameters from the form
        String accnoStr = request.getParameter("accno");
        String pwd = request.getParameter("password");
        String errorMessage = null;
        String successMessage = null;
        boolean accountFrozen = false;
        
        HttpSession session = request.getSession();
        String lang = (session.getAttribute("lang") != null) ? session.getAttribute("lang").toString() : "en";
        
        if (accnoStr != null && pwd != null) {
            try {
                // Convert accno from String to Integer
                int accno = Integer.parseInt(accnoStr);

                // Hash the password using SHA-256
                MessageDigest md = MessageDigest.getInstance("SHA-256");
                md.update(pwd.getBytes());
                byte[] hashedBytes = md.digest();
                StringBuilder sb = new StringBuilder();
                for (byte b : hashedBytes) {
                    sb.append(String.format("%02x", b));
                }
                String hashedPwd = sb.toString(); // The hashed password

                // Load MySQL JDBC Driver
                Class.forName("com.mysql.cj.jdbc.Driver");

                // Establish database connection
                Connection conn = DatabaseConnection.getConnection();
                
                // Prepare and execute the SQL statement
                PreparedStatement ps = conn.prepareStatement("SELECT * FROM user WHERE accno = ? AND password = ? AND is_deleted = 0");
                ps.setInt(1, accno);  // Use setInt for Integer accno
                ps.setString(2, hashedPwd);  // Compare hashed password
                ResultSet rs = ps.executeQuery();

                // Check if user exists
                if (rs.next()) {
                	int userId = rs.getInt("id");
                    String uname = rs.getString("username");
                    accountFrozen = rs.getBoolean("is_frozen");

                    // Store accno, uname, and accountFrozen in session
                    session.setAttribute("userId", userId); 
                    session.setAttribute("accno", accno);
                    session.setAttribute("uname", uname);
                    session.setAttribute("accountFrozen", accountFrozen);

                    request.setAttribute("successMessage", LanguageHelper.getMessage("login_redir", lang));
                    request.getRequestDispatcher("homepage.jsp").forward(request, response);
                    return; // Stop further execution
                } else {
                    errorMessage = LanguageHelper.getMessage("accno_psw", lang);
                }
            } catch (NumberFormatException e) {
            	errorMessage = LanguageHelper.getMessage("inv_accNo", lang);
            } catch (NoSuchAlgorithmException e) {
            	errorMessage = LanguageHelper.getMessage("sha", lang) + ": " + e.getMessage();
            } catch (Exception e) {
            	errorMessage = LanguageHelper.getMessage("login_err", lang) + ": " + e.getMessage();
            } finally {
                // Close resources (if needed)
            }
        }

        // Set error message and forward to login page if login fails
        if (errorMessage != null) {
            request.setAttribute("errorMessage", errorMessage);
        }
        request.getRequestDispatcher("sign_in.jsp").forward(request, response);
    }
}
