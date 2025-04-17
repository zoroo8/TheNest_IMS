package controller;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/stock-requests")
public class StockRequestsController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    public StockRequestsController() {
        super();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // Forward to the stock requests page
        request.getRequestDispatcher("/WEB-INF/pages/StockRequests.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // This will be implemented later for handling stock request submissions
        // For now, just redirect back to the stock requests page
        response.sendRedirect("stock-requests");
    }
}