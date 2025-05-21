package com.ims.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import com.ims.model.ProductModel;
import com.ims.model.RequestProductUserModel;
import com.ims.service.ProductService;
import com.ims.service.RequestService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/staff/my-requests")
public class StaffStockRequestsController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public StaffStockRequestsController() {
        super();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            List<ProductModel> products = new ProductService().getAllProducts();
            request.setAttribute("products", products);
            request.getRequestDispatcher("/WEB-INF/pages/staff/StaffStockRequests.jsp").forward(request, response);
        } catch (Exception e) {
            if (!response.isCommitted()) {
                response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error loading product list.");
            }
            e.printStackTrace();
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Get userId from session
        Integer userId = (Integer) request.getSession().getAttribute("userId");
        if (userId == null) {
            response.sendRedirect(request.getContextPath() + "/Login");
            return;
        }

        try {
            // Receive product IDs and quantities
            String[] productIds = request.getParameterValues("productId[]");
            String[] quantities = request.getParameterValues("quantity[]");
            String notes = request.getParameter("notes");

            if (productIds == null || quantities == null || productIds.length != quantities.length) {
                throw new Exception("Invalid product or quantity data.");
            }

            List<RequestProductUserModel> requestProducts = new ArrayList<>();
            int totalQty = 0;

            for (int i = 0; i < productIds.length; i++) {
                int pid = Integer.parseInt(productIds[i]);
                int qty = Integer.parseInt(quantities[i]);
                requestProducts.add(new RequestProductUserModel(pid, qty));
                totalQty += qty;
            }

            if (requestProducts.isEmpty() || totalQty <= 0) {
                throw new Exception("No valid products or quantities provided.");
            }

            java.util.Date today = new java.util.Date();
            RequestService service = new RequestService();
            boolean success = service.addRequest(userId, today, notes, requestProducts, totalQty);

            if (success) {
                response.sendRedirect(request.getContextPath() + "/staff/my-requests?success=true");
            } else {
                response.sendRedirect(request.getContextPath() + "/staff/my-requests?error=true");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/staff/my-requests?error=true");
        }
    }
}
