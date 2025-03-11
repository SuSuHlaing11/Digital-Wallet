package com.bank.controller;

import java.io.IOException;
import com.bank.LanguageHelper;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.bank.LanguageHelper;
import com.bank.model.UserModel;

@WebServlet("/RegisterController")
public class RegisterController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	System.out.println("DEBUG: RegisterController doPost() called");
    	// Get parameters from the request
        String fullname = request.getParameter("fullname").trim();
        String username = request.getParameter("username").trim();
        String dob = request.getParameter("dob").trim();
        String gender = request.getParameter("gender").trim();
        String nrc = request.getParameter("nrc").trim();
        String address = request.getParameter("address").trim();
        String email = request.getParameter("email").trim();
        String phone = request.getParameter("phone").trim();
        String acctype = request.getParameter("acctype").trim();
        String password1 = request.getParameter("password").trim();
        String rePassword = request.getParameter("re_password").trim();
        HttpSession session = request.getSession();
        String lang = (session.getAttribute("lang") != null) ? session.getAttribute("lang").toString() : "en";

        


        UserModel userModel = new UserModel();
        String errorMessage = userModel.registerUser(fullname, username, dob, gender, nrc, address, email, phone, acctype, password1, rePassword, lang);
        
        if (errorMessage == null) {
        	// Registration successful → Store success message in session
        	request.setAttribute("successMessage", LanguageHelper.getMessage("reg_success",lang));

        	 request.getRequestDispatcher("sign_up.jsp").forward(request, response);
             
        } else {
            // Registration failed → Forward error message back to sign-up page
            request.setAttribute("errorMessage", errorMessage);
            request.getRequestDispatcher("sign_up.jsp").forward(request, response);
        }
    }
}
