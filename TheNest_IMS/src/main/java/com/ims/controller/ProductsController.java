package com.ims.controller;

import java.io.IOException;
import java.util.List;

import com.ims.model.CategoryModel;
import com.ims.model.ProductModel;
import com.ims.model.SupplierModel;
import com.ims.service.CategoryService;
import com.ims.service.ProductService;
import com.ims.service.SupplierService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/products")
public class ProductsController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public ProductsController() {
        super();
    }

    // Load product form with category and supplier lists
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            List<CategoryModel> categories = new CategoryService().getAllCategories();
            List<SupplierModel> suppliers = new SupplierService().getAllSuppliers();

            request.setAttribute("categories", categories);
            request.setAttribute("suppliers", suppliers);
            request.getRequestDispatcher("/WEB-INF/pages/Products.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error loading categories or suppliers.");
        }
    }

    // Handle product form submission
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String name = request.getParameter("productName");
            int quantity = Integer.parseInt(request.getParameter("productQuantity"));
            int categoryId = Integer.parseInt(request.getParameter("productCategory"));
            int supplierId = Integer.parseInt(request.getParameter("productSupplier"));
            float price = Float.parseFloat(request.getParameter("productPrice"));

            ProductModel product = new ProductModel();
            product.setName(name);
            product.setPrice(price);
            product.setStock(quantity);
            product.setCategoryId(categoryId);
            product.setSupplierId(supplierId);

            new ProductService().saveProduct(product);
            response.sendRedirect("products?success=1");

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("products?error=1");
        }
    }
}
