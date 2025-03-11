package com.bank.controller;

import java.io.IOException;
import java.util.stream.Collectors;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONObject;

@WebServlet("/updateFreezeStatus")
public class FreezeStatusController extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws IOException {
        // Read JSON payload
        String json = request.getReader().lines().collect(Collectors.joining());
        JSONObject jsonObject = new JSONObject(json);
        String status = jsonObject.getString("status");

        // Update session
        HttpSession session = request.getSession();
        session.setAttribute("accountFrozen", "frozen".equals(status));

        response.setContentType("application/json");
        response.getWriter().write("{\"success\": true}");
    }
}