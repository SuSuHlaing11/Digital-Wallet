package com.bank.controller;

import com.bank.model.CurrencyExchangeModel;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import com.bank.LanguageHelper;

@WebServlet("/currencyExchange")
public class CurrencyExchangeController extends HttpServlet {
	private CurrencyExchangeModel exchangeService = new CurrencyExchangeModel();
	
	 protected void doGet(HttpServletRequest request, HttpServletResponse response) 
	            throws ServletException, IOException {
	        request.getRequestDispatcher("/exchange_converter.jsp").forward(request, response);
	    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
    	
        HttpSession session = request.getSession();
        String lang = (session.getAttribute("lang") != null) ? session.getAttribute("lang").toString() : "en";
 
        try {
            String fromCurrency = request.getParameter("from");
            String toCurrency = request.getParameter("to");
            double amount = Double.parseDouble(request.getParameter("amount"));
            
            if (amount < 0) {
                request.setAttribute("error", LanguageHelper.getMessage("negative_amt_error", lang));
                request.getRequestDispatcher("/exchange_converter.jsp").forward(request, response);
                return;
            }
            
            double result = exchangeService.convertCurrency(fromCurrency, toCurrency, amount);
            
            request.setAttribute("originalAmount", amount);
            request.setAttribute("fromCurrency", fromCurrency);
            request.setAttribute("toCurrency", toCurrency);
            request.setAttribute("convertedAmount", result);
            
            request.getRequestDispatcher("/exchange_converter.jsp").forward(request, response);
        } catch (Exception e) {
        	request.setAttribute("error", LanguageHelper.getMessage("curr_error", lang) + ": " + e.getMessage());
            request.getRequestDispatcher("/exchange_converter.jsp").forward(request, response);
        }
    }
}
