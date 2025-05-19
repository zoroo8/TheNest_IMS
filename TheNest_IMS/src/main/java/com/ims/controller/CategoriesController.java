package com.ims.controller;

import java.io.IOException;
import java.util.List;

import com.ims.model.CategoryModel;
import com.ims.service.CategoryService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/categories")
public class CategoriesController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private CategoryService categoryService;

    @Override
    public void init() throws ServletException {
        categoryService = new CategoryService();
    }

    // Handle GET request
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            List<CategoryModel> categories = categoryService.getAllCategories();
            request.setAttribute("categories", categories);
            request.getRequestDispatcher("WEB-INF/pages/admin/Categories.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Unable to fetch categories.");
        }
    }

    // Handle POST request
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String idParam = request.getParameter("categoryId");
        String name = request.getParameter("categoryName");
        String icon = request.getParameter("categoryIcon");
        String description = request.getParameter("categoryDescription");

        int id = (idParam != null && !idParam.isEmpty()) ? Integer.parseInt(idParam) : 0;

        CategoryModel category = new CategoryModel(id, name, icon, description);
        try {
            categoryService.saveOrUpdateCategory(category);
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Unable to save category.");
            return;
        }

        response.sendRedirect("categories");
    }
}
