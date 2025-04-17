package controller;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/staff-stock-requests")
public class StaffStockRequestsController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    public StaffStockRequestsController() {
        super();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // Forward to the staff stock requests page
        request.getRequestDispatcher("/WEB-INF/pages/StaffStockRequests.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // This will be implemented later for handling staff stock request submissions
        // For now, just redirect back to the staff stock requests page
        response.sendRedirect("staff-stock-requests");
    }
}