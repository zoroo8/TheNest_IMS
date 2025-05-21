package com.ims.controller;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import com.ims.model.CategoryModel;
import com.ims.model.ImportModel;
import com.ims.model.SupplierModel;
import com.ims.service.CategoryService;
import com.ims.service.ImportService;
import com.ims.service.ProductService;
import com.ims.service.SupplierService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/products")
public class ProductsController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public ProductsController() {
        super();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            ProductService productService = new ProductService();
            List<com.ims.model.ProductModel> products = productService.getAllProducts();
            request.setAttribute("products", products);

            // Calculate stats
            int totalProducts = products.size();
            int lowStockCount = 0;
            int outOfStockCount = 0;
            final int LOW_STOCK_THRESHOLD = 10; // Define your low stock threshold

            for (com.ims.model.ProductModel product : products) {
                if (product.getStock() == 0) {
                    outOfStockCount++;
                } else if (product.getStock() < LOW_STOCK_THRESHOLD) {
                    lowStockCount++;
                }
            }

            request.setAttribute("totalProducts", totalProducts);
            request.setAttribute("lowStockCount", lowStockCount);
            request.setAttribute("outOfStockCount", outOfStockCount);

            List<com.ims.model.CategoryModel> categories = new com.ims.service.CategoryService().getAllCategories();
            List<com.ims.model.SupplierModel> suppliers = new com.ims.service.SupplierService().getAllSuppliers();
            List<com.ims.model.ImportModel> imports = new com.ims.service.ImportService().getAllImports();

            request.setAttribute("categories", categories);
            request.setAttribute("suppliers", suppliers);
            request.setAttribute("imports", imports);

            request.getRequestDispatcher("/WEB-INF/pages/Products.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error loading product form data.");
        }
    }

 @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(); // Use getSession() to ensure it's created
        if (session.getAttribute("userId") == null) {
            response.sendRedirect(request.getContextPath() + "/Login");
            return;
        }

        int userId = (int) session.getAttribute("userId");
        String action = request.getParameter("action");

        if ("delete".equals(action)) {
            handleDeleteAction(request, response, session); // Pass session
            return;
        }

        try {
            String productIdStr = request.getParameter("productId");
            String productName = request.getParameter("productName");
            String priceStr = request.getParameter("productPrice");
            String stockStr = request.getParameter("productQuantity");
            String categoryIdStr = request.getParameter("productCategory");
            String supplierIdStr = request.getParameter("productSupplier");
            String description = request.getParameter("productDescription");
            String importIdStr = request.getParameter("productImport");

            if (productName == null || productName.trim().isEmpty() ||
                priceStr == null || priceStr.trim().isEmpty() || 
                stockStr == null || stockStr.trim().isEmpty() ||
                categoryIdStr == null || categoryIdStr.trim().isEmpty() || 
                supplierIdStr == null || supplierIdStr.trim().isEmpty() ||
                /* description can be empty */
                importIdStr == null || importIdStr.trim().isEmpty()) {

                try {
                    loadFormAttributes(request);
                } catch (Exception loadEx) {
                    System.err.println("Error loading form attributes after validation failure: " + loadEx.getMessage());
                    loadEx.printStackTrace();
                }
                session.setAttribute("errorMessage", "One or more required fields are empty.");
                // Forward back to the products page, which will then display the modal if needed by JS
                // Or, if you want to show the modal directly, you might need to set an attribute
                // request.setAttribute("showAddEditModal", true); 
                // request.setAttribute("formData", /* current form data to repopulate */);
                request.getRequestDispatcher("/WEB-INF/pages/Products.jsp").forward(request, response);
                return;
            }

            float price = Float.parseFloat(priceStr);
            int stock = Integer.parseInt(stockStr);
            int categoryId = Integer.parseInt(categoryIdStr);
            int supplierId = Integer.parseInt(supplierIdStr);
            int importId = Integer.parseInt(importIdStr);

            ProductService productService = new ProductService();

            if (productIdStr != null && !productIdStr.trim().isEmpty()) {
                int productId = Integer.parseInt(productIdStr);
                productService.updateProductWithImport(productId, productName, price, stock, categoryId, supplierId, description, importId, userId);
                session.setAttribute("successMessage", "Product updated successfully!");
            } else {
                productService.addProductWithImport(productName, price, stock, categoryId, supplierId, description, importId, userId);
                session.setAttribute("successMessage", "Product added successfully!");
            }
            response.sendRedirect(request.getContextPath() + "/products");

        } catch (SQLException e) {
            e.printStackTrace();
            handleFormError(request, session, "Database error: " + e.getMessage());
            request.getRequestDispatcher("/WEB-INF/pages/Products.jsp").forward(request, response);
        } catch (NumberFormatException e) {
            e.printStackTrace();
            handleFormError(request, session, "Invalid numeric input: " + e.getMessage());
            request.getRequestDispatcher("/WEB-INF/pages/Products.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            handleFormError(request, session, "An unexpected error occurred: " + e.getMessage());
            request.getRequestDispatcher("/WEB-INF/pages/Products.jsp").forward(request, response);
        }
    }

    private void handleFormError(HttpServletRequest request, HttpSession session, String errorMessage) {
        try {
            loadFormAttributes(request); // Reload dropdowns etc.
        } catch (Exception loadEx) {
            System.err.println("Error loading form attributes after primary error: " + loadEx.getMessage());
            loadEx.printStackTrace();
        }
        session.setAttribute("errorMessage", errorMessage);
        // To repopulate the form and show the modal, you might set attributes here
        // request.setAttribute("showAddEditModalOnError", true);
        // request.setAttribute("productNameOnError", request.getParameter("productName")); // and so on for other fields
    }


    private void handleDeleteAction(HttpServletRequest request, HttpServletResponse response, HttpSession session) throws IOException {
        try {
            String productIdStr = request.getParameter("productId");
            if (productIdStr == null || productIdStr.trim().isEmpty()) {
                session.setAttribute("errorMessage", "Delete failed: Product ID was missing.");
                response.sendRedirect(request.getContextPath() + "/products");
                return;
            }
            int productId = Integer.parseInt(productIdStr);
            ProductService productService = new ProductService();
            productService.deleteProduct(productId);
            session.setAttribute("successMessage", "Product deleted successfully!");
        } catch (SQLException e) {
            e.printStackTrace();
            session.setAttribute("errorMessage", "Delete failed: Database error.");
        } catch (NumberFormatException e) {
            e.printStackTrace();
            session.setAttribute("errorMessage", "Delete failed: Invalid Product ID.");
        }
        response.sendRedirect(request.getContextPath() + "/products");
    }
    

    // Changed to throws Exception to cover all possible checked exceptions from service calls
    private void loadFormAttributes(HttpServletRequest request) throws Exception {
        List<com.ims.model.CategoryModel> categories = new com.ims.service.CategoryService().getAllCategories();
        List<com.ims.model.SupplierModel> suppliers = new com.ims.service.SupplierService().getAllSuppliers();
        List<com.ims.model.ImportModel> imports = new com.ims.service.ImportService().getAllImports();
        List<com.ims.model.ProductModel> products = new ProductService().getAllProducts();


        request.setAttribute("categories", categories);
        request.setAttribute("suppliers", suppliers);
        request.setAttribute("imports", imports);
        request.setAttribute("products", products);
    }
}
