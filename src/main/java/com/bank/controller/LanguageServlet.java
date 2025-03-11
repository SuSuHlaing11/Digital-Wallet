package com.bank.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class LanguageServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
        throws ServletException, IOException {
        
        String lang = request.getParameter("lang");
        HttpSession session = request.getSession();
        session.setAttribute("lang", lang);
        
        // Redirect back to the referring page
        String referer = request.getHeader("Referer");
        response.sendRedirect(referer != null ? referer : "index.jsp");
    }
}

