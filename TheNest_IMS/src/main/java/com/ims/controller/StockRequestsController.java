package com.ims.controller;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/admin/stock-requests") // Updated mapping for Admin
public class StockRequestsController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    public StockRequestsController() {
        super();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // This JSP path might need to be admin-specific if not already
        // e.g., /WEB-INF/pages/admin/StockRequests.jsp
        request.getRequestDispatcher("/WEB-INF/pages/StockRequests.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        response.sendRedirect(request.getContextPath() + "/admin/stock-requests"); // Updated redirect
    }
}