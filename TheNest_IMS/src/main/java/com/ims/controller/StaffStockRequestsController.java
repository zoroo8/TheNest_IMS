package com.ims.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Map;
import java.util.List;

import com.ims.model.ProductModel;
import com.ims.model.RequestProductUserModel;
import com.ims.model.StaffRequestViewModel;
import com.ims.service.ProductService;
import com.ims.service.RequestService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/staff/my-requests")
public class StaffStockRequestsController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public StaffStockRequestsController() {
        super();
    }

    // Helper to escape strings for JSON
    private String escapeJson(String s) {
        if (s == null) {
            return "";
        }
        return s.replace("\\", "\\\\")
                .replace("\"", "\\\"")
                .replace("\b", "\\b")
                .replace("\f", "\\f")
                .replace("\n", "\\n")
                .replace("\r", "\\r")
                .replace("\t", "\\t");
    }


       @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        Integer userId = (session != null) ? (Integer) session.getAttribute("userId") : null;

        if (userId == null) {
            response.sendRedirect(request.getContextPath() + "/Login");
            return;
        }

        String action = request.getParameter("action");
        RequestService requestService = new RequestService();

        if ("getRequestItems".equals(action)) {
            handleGetRequestItems(request, response, requestService, userId);
            return; // Response handled, do not proceed to forward
        }

        // Default action: Load the main page
        try {
            ProductService productService = new ProductService();
            List<ProductModel> products = productService.getAllProducts();
            request.setAttribute("products", products);

            List<StaffRequestViewModel> stockRequests = requestService.getRequestsByUserId(userId);
            request.setAttribute("stockRequests", stockRequests);
            
            long pendingCount = stockRequests.stream().filter(r -> "Pending".equalsIgnoreCase(r.getStatus())).count();
            long approvedCount = stockRequests.stream().filter(r -> "Approved".equalsIgnoreCase(r.getStatus())).count();
            long dispatchedCount = stockRequests.stream().filter(r -> "Dispatched".equalsIgnoreCase(r.getStatus())).count();

            request.setAttribute("pendingRequestsCount", pendingCount);
            request.setAttribute("approvedRequestsCount", approvedCount);
            request.setAttribute("dispatchedRequestsCount", dispatchedCount);
            request.setAttribute("totalRequestsCount", stockRequests.size());

            request.getRequestDispatcher("/WEB-INF/pages/staff/StaffStockRequests.jsp").forward(request, response);
        } catch (SQLException e) {
            e.printStackTrace(); 
            if (!response.isCommitted()) {
                request.setAttribute("errorMessage", "Error loading your stock requests: " + e.getMessage());
                request.getRequestDispatcher("/WEB-INF/pages/staff/StaffStockRequests.jsp").forward(request, response);
            }
        } catch (Exception e) { 
            e.printStackTrace();
             if (!response.isCommitted()) {
                request.setAttribute("errorMessage", "An unexpected error occurred: " + e.getMessage());
                request.getRequestDispatcher("/WEB-INF/pages/staff/StaffStockRequests.jsp").forward(request, response);
            }
        }
    }

    private void handleGetRequestItems(HttpServletRequest request, HttpServletResponse response, RequestService requestService, Integer userId) throws IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();
        StringBuilder jsonBuilder = new StringBuilder();

        String requestIdParam = request.getParameter("requestId");
        if (requestIdParam == null || requestIdParam.isEmpty()) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            out.print("{\"error\":\"Request ID is required\"}");
            out.flush();
            return;
        }

        try {
            int requestId = Integer.parseInt(requestIdParam);
            // Optional: Add a check here to ensure the logged-in user is authorized to view this request's items.
            // For now, we assume if they can see the request on their page, they can see its items.
            List<Map<String, Object>> items = requestService.getRequestItemDetails(requestId);

            jsonBuilder.append("[");
            for (int i = 0; i < items.size(); i++) {
                Map<String, Object> item = items.get(i);
                jsonBuilder.append("{");
                jsonBuilder.append("\"productName\":\"").append(escapeJson((String) item.get("productName"))).append("\",");
                jsonBuilder.append("\"quantity\":").append(item.get("quantity"));
                jsonBuilder.append("}");
                if (i < items.size() - 1) {
                    jsonBuilder.append(",");
                }
            }
            jsonBuilder.append("]");
            out.print(jsonBuilder.toString());

        } catch (NumberFormatException e) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            out.print("{\"error\":\"Invalid Request ID format\"}");
        } catch (SQLException e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            out.print("{\"error\":\"Database error fetching items: " + escapeJson(e.getMessage()) + "\"}");
        } finally {
            out.flush();
        }
    }


    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        Integer userId = (session != null) ? (Integer) session.getAttribute("userId") : null;

        if (userId == null) {
            response.sendRedirect(request.getContextPath() + "/Login");
            return;
        }

        String action = request.getParameter("action");
        RequestService requestService = new RequestService();

        if ("cancelRequest".equals(action)) {
            handleCancelRequest(request, response, requestService, userId);
            return; // Response handled
        }

        // Default POST action: Add new request
        try {
            String[] productIdsParam = request.getParameterValues("productId[]");
            String[] quantitiesParam = request.getParameterValues("quantity[]");
            String notes = request.getParameter("notes");

            if (productIdsParam == null || quantitiesParam == null || productIdsParam.length != quantitiesParam.length) {
                response.sendRedirect(request.getContextPath() + "/staff/my-requests?error=" + java.net.URLEncoder.encode("Invalid item data. Please try again.", "UTF-8"));
                return;
            }
            
            List<Integer> productIds = new ArrayList<>();
            for (String pidStr : productIdsParam) {
                if (pidStr != null && !pidStr.isEmpty()) {
                    productIds.add(Integer.parseInt(pidStr));
                }
            }

            List<Integer> quantities = new ArrayList<>();
             for (String qtyStr : quantitiesParam) {
                if (qtyStr != null && !qtyStr.isEmpty()) {
                    quantities.add(Integer.parseInt(qtyStr));
                }
            }

            if (productIds.isEmpty() || productIds.size() != quantities.size()) {
                 response.sendRedirect(request.getContextPath() + "/staff/my-requests?error=" + java.net.URLEncoder.encode("No items selected or mismatch in item data.", "UTF-8"));
                return;
            }

            List<RequestProductUserModel> requestProducts = new ArrayList<>();
            int totalQty = 0;

            for (int i = 0; i < productIds.size(); i++) {
                int pid = productIds.get(i);
                int qty = quantities.get(i);
                if (pid > 0 && qty > 0) {
                    requestProducts.add(new RequestProductUserModel(pid, userId, qty)); 
                    totalQty += qty;
                }
            }

            if (requestProducts.isEmpty()) {
                response.sendRedirect(request.getContextPath() + "/staff/my-requests?error=" + java.net.URLEncoder.encode("No valid items to request.", "UTF-8"));
                return;
            }

            java.util.Date today = new java.util.Date();
            boolean success = requestService.addRequest(userId, today, notes, requestProducts, totalQty);

            if (success) {
                response.sendRedirect(request.getContextPath() + "/staff/my-requests?success=" + java.net.URLEncoder.encode("Request submitted successfully!", "UTF-8"));
            } else {
                response.sendRedirect(request.getContextPath() + "/staff/my-requests?error=" + java.net.URLEncoder.encode("Failed to submit request. Please try again.", "UTF-8"));
            }

        } catch (NumberFormatException e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/staff/my-requests?error=" + java.net.URLEncoder.encode("Invalid quantity for items. Please enter valid numbers.", "UTF-8"));
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/staff/my-requests?error=" + java.net.URLEncoder.encode("An error occurred: " + e.getMessage(), "UTF-8"));
        }
    }

    private void handleCancelRequest(HttpServletRequest request, HttpServletResponse response, RequestService requestService, Integer userId) throws IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();
        String jsonResponse;

        String requestIdParam = request.getParameter("requestId");
        if (requestIdParam == null || requestIdParam.isEmpty()) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            out.print("{\"success\":false, \"message\":\"Request ID is required.\"}");
            out.flush();
            return;
        }

        try {
            int requestId = Integer.parseInt(requestIdParam);
            boolean success = requestService.cancelRequest(requestId, userId);

            if (success) {
                jsonResponse = "{\"success\":true, \"message\":\"Request cancelled successfully.\"}";
            } else {
                jsonResponse = "{\"success\":false, \"message\":\"Failed to cancel request. It may not be pending, not belong to you, or an error occurred.\"}";
            }
            out.print(jsonResponse);

        } catch (NumberFormatException e) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            out.print("{\"success\":false, \"message\":\"Invalid Request ID format.\"}");
        } catch (SQLException e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            out.print("{\"success\":false, \"message\":\"Database error: " + escapeJson(e.getMessage()) + "\"}");
        } finally {
            out.flush();
        }
    }
}