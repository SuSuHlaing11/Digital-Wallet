package com.bank.controller;

import java.io.IOException;
import java.util.stream.Collectors;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

@WebServlet("/updateSessionState")
public class SessionStateServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
        throws IOException {
        
        // Parse JSON input
        String json = request.getReader().lines().collect(Collectors.joining());
        JsonObject data = JsonParser.parseString(json).getAsJsonObject();
        
        // Update session state
        boolean isFrozen = data.get("frozen").getAsBoolean();
        request.getSession().setAttribute("accountFrozen", isFrozen);
        
        response.setStatus(HttpServletResponse.SC_OK);
    }
}