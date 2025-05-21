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
            List<CategoryModel> categories = new CategoryService().getAllCategories();
            List<SupplierModel> suppliers = new SupplierService().getAllSuppliers();
            List<ImportModel> imports = new ImportService().getAllImports();

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

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect(request.getContextPath() + "/Login");
            return;
        }

        int userId = (int) session.getAttribute("userId");

        try {
            String productName = request.getParameter("productName");
            String priceStr = request.getParameter("productPrice");
            String stockStr = request.getParameter("productQuantity");
            String categoryIdStr = request.getParameter("productCategory");
            String supplierIdStr = request.getParameter("productSupplier");
            String description = request.getParameter("productDescription");
            String importIdStr = request.getParameter("productImport");

            if (productName == null || productName.trim().isEmpty() ||
                priceStr == null || stockStr == null ||
                categoryIdStr == null || supplierIdStr == null ||
                description == null || importIdStr == null) {

                request.setAttribute("error", "One or more required fields are empty.");
                request.getRequestDispatcher("/WEB-INF/pages/Products.jsp").forward(request, response);
                return;
            }

            float price = Float.parseFloat(priceStr);
            int stock = Integer.parseInt(stockStr);
            int categoryId = Integer.parseInt(categoryIdStr);
            int supplierId = Integer.parseInt(supplierIdStr);
            int importId = Integer.parseInt(importIdStr);

            ProductService productService = new ProductService();
            productService.addProductWithImport(productName, price, stock, categoryId, supplierId, description, importId, userId);

            response.sendRedirect("products?success=1");

        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "Database error: " + e.getMessage());
            request.getRequestDispatcher("/WEB-INF/pages/Products.jsp").forward(request, response);
        } catch (NumberFormatException e) {
            e.printStackTrace();
            request.setAttribute("error", "Invalid numeric input: " + e.getMessage());
            request.getRequestDispatcher("/WEB-INF/pages/Products.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Unexpected error: " + e.getMessage());
            request.getRequestDispatcher("/WEB-INF/pages/Products.jsp").forward(request, response);
        }
    }
}
