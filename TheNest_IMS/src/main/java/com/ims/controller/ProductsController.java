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

    /* -------------------------------------------------------------
       GET  – load dropdown data and (optionally) success / error msg
       ------------------------------------------------------------- */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            List<CategoryModel> categories = new CategoryService().getAllCategories();
            List<SupplierModel> suppliers  = new SupplierService().getAllSuppliers();
            List<ImportModel>   imports    = new ImportService().getAllImports();

            request.setAttribute("categories", categories);
            request.setAttribute("suppliers",  suppliers);
            request.setAttribute("imports",    imports);

            /*  forward to JSP  */
            request.getRequestDispatcher("/WEB-INF/pages/Products.jsp")
                   .forward(request, response);

        } catch (Exception ex) {
            ex.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR,
                               "Error loading product form data.");
        }
    }

    /* -------------------------------------------------------------
       POST – create product + supplier_product + import_product_user
       ------------------------------------------------------------- */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        /* ------- 1. Auth check ------- */
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect(request.getContextPath() + "/Login");
            return;
        }
        int userId = (int) session.getAttribute("userId");

        /* ------- 2. Pull & validate form params ------- */
        String productName     = request.getParameter("productName");
        String priceStr        = request.getParameter("productPrice");
        String stockStr        = request.getParameter("productQuantity");
        String categoryIdStr   = request.getParameter("productCategory");
        String supplierIdStr   = request.getParameter("productSupplier");
        String description     = request.getParameter("productDescription");
        String importIdStr     = request.getParameter("productImport");
        
        if (productName == null || productName.trim().isEmpty() ||
            priceStr == null   || stockStr == null   ||
            categoryIdStr == null || supplierIdStr == null ||
            importIdStr == null) {

            request.setAttribute("error", "One or more required fields are empty.");
            doGet(request, response);   // reload dropdowns + error
            return;
        }

        try {
            float price      = Float.parseFloat(priceStr);
            int   stock      = Integer.parseInt(stockStr);
            int   categoryId = Integer.parseInt(categoryIdStr);
            int   supplierId = Integer.parseInt(supplierIdStr);
            int   importId   = Integer.parseInt(importIdStr);

            /* ------- 3. Delegate to service (handles all 3 tables) ------- */
            new ProductService().addProductWithImport(
                    productName, price, stock,
                    categoryId, supplierId,
                    description, importId, userId);

            /* ------- 4. Redirect with success flag ------- */
            response.sendRedirect(request.getContextPath() + "/products?success=1");

        } catch (NumberFormatException nfe) {
            nfe.printStackTrace();
            request.setAttribute("error", "Invalid numeric input: " + nfe.getMessage());
            doGet(request, response);     // reload dropdowns + error

        } catch (SQLException sqle) {
            sqle.printStackTrace();
            request.setAttribute("error", "Database error: " + sqle.getMessage());
            doGet(request, response);

        } catch (Exception ex) {
            ex.printStackTrace();
            request.setAttribute("error", "Unexpected error: " + ex.getMessage());
            doGet(request, response);
        }
    }
}