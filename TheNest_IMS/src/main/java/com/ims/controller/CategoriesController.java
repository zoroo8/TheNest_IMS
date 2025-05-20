package com.ims.controller;

import java.io.IOException;
import java.sql.SQLException;
import java.sql.SQLIntegrityConstraintViolationException;
import java.util.List;
import java.util.Map;

import com.ims.model.CategoryModel;
import com.ims.service.CategoryService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/categories")
public class CategoriesController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private CategoryService categoryService;

    @Override
    public void init() throws ServletException {
        categoryService = new CategoryService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || !"admin".equals(session.getAttribute("role"))) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

       try {

            List<CategoryModel> categories = categoryService.getAllCategoriesWithProductCounts();
            request.setAttribute("categories", categories);

            Map<String, Object> stats = categoryService.getCategoryStatistics(); // Return type is now Map<String, Object>
            request.setAttribute("stats", stats);

        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Error fetching categories: " + e.getMessage());
        }

        request.getRequestDispatcher("WEB-INF/pages/admin/Categories.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(); 

        if (session == null || !"admin".equals(session.getAttribute("role"))) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String action = request.getParameter("action");

        try {
            if ("delete".equals(action)) {
                handleDelete(request, session);
            } else { 
                handleSaveOrUpdate(request, session);
            }
        } catch (NumberFormatException e) {
            e.printStackTrace();
            session.setAttribute("errorMessage", "Invalid ID format: " + e.getMessage());
        } 
         catch (SQLIntegrityConstraintViolationException e) {
            e.printStackTrace();
            // Check if the error message indicates a foreign key constraint failure
            if (e.getMessage().toLowerCase().contains("foreign key constraint fails")) {
                session.setAttribute("errorMessage", "Cannot delete category: It is currently associated with existing products. Please reassign or delete these products first.");
            } else {
                // For other integrity constraint violations
                session.setAttribute("errorMessage", "Database integrity error: " + e.getMessage());
            }
        }
        catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            session.setAttribute("errorMessage", "Database operation failed: " + e.getMessage());
        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("errorMessage", "An unexpected error occurred: " + e.getMessage());
        }

        response.sendRedirect(request.getContextPath() + "/categories");
    }

    private void handleSaveOrUpdate(HttpServletRequest request, HttpSession session)
            throws SQLException, ClassNotFoundException {

        String idParam = request.getParameter("categoryId");
        String name = request.getParameter("categoryName");
        String icon = request.getParameter("categoryIcon"); 
        String description = request.getParameter("categoryDescription");

        if (name == null || name.trim().isEmpty()) {
            session.setAttribute("errorMessage", "Category name cannot be empty.");
            return; 
        }
         if (icon == null || icon.trim().isEmpty()) {
            session.setAttribute("errorMessage", "Category icon cannot be empty.");
            return;
        }

        int id = (idParam != null && !idParam.isEmpty()) ? Integer.parseInt(idParam) : 0;

        CategoryModel category = new CategoryModel(id, name.trim(), icon.trim(), description.trim());
        categoryService.saveOrUpdateCategory(category);

        session.setAttribute("successMessage", "Category '" + category.getName() + "' " + (id > 0 ? "updated" : "saved") + " successfully!");
    }

    private void handleDelete(HttpServletRequest request, HttpSession session)
            throws SQLException, ClassNotFoundException, NumberFormatException {

        String idParam = request.getParameter("categoryIdToDelete");
        if (idParam == null || idParam.isEmpty()) {
            session.setAttribute("errorMessage", "Category ID for deletion is missing.");
            return; 
        }

        int id = Integer.parseInt(idParam);

        categoryService.deleteCategory(id);
        session.setAttribute("successMessage", "Category (ID: " + id + ") deleted successfully!");
    }
}