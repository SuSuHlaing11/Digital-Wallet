package com.bank;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class ChangeLanguageServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    private void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String lang = request.getParameter("lang");
        if (lang != null) {
            HttpSession session = request.getSession();
            session.setAttribute("lang", lang);
        }

        // Redirect to the referring page
        String referer = request.getHeader("referer");
        if (referer == null || referer.isEmpty()) {
            referer = "index.jsp"; // Default fallback page
        }
        response.sendRedirect(referer);
    }
}
