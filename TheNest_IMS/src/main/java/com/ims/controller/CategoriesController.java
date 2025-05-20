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

    private void handleGetCategory(HttpServletRequest request, HttpServletResponse response) 
        throws ServletException, IOException, SQLException, ClassNotFoundException {
    
    String idParam = request.getParameter("id");
    if (idParam == null || idParam.isEmpty()) {
        response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
        response.getWriter().write("{\"error\": \"Category ID is required\"}");
        return;
    }
    
    try {
        int id = Integer.parseInt(idParam);
        CategoryModel category = categoryService.getCategoryById(id);
        
        if (category == null) {
            response.setStatus(HttpServletResponse.SC_NOT_FOUND);
            response.getWriter().write("{\"error\": \"Category not found\"}");
            return;
        }
        
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        
        String json = String.format(
            "{\"id\": %d, \"name\": \"%s\", \"icon\": \"%s\", \"description\": \"%s\", \"productCount\": %d}",
            category.getId(),
            escapeJson(category.getName()),
            escapeJson(category.getIcon()),
            escapeJson(category.getDescription()),
            category.getProductCount()
        );
        
        response.getWriter().write(json);
    } catch (NumberFormatException e) {
        response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
        response.getWriter().write("{\"error\": \"Invalid category ID format\"}");
    }
}

private String escapeJson(String input) {
    if (input == null) {
        return "";
    }
    return input.replace("\\", "\\\\")
                .replace("\"", "\\\"")
                .replace("\n", "\\n")
                .replace("\r", "\\r")
                .replace("\t", "\\t");
}

   @Override
protected void doGet(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
    
    HttpSession session = request.getSession();
    
    if (session == null || !"admin".equals(session.getAttribute("role"))) {
        response.sendRedirect(request.getContextPath() + "/login");
        return;
    }
    
    try {
        String action = request.getParameter("action");
        
        if ("getCategory".equals(action)) {
            handleGetCategory(request, response);
            return;
        }
        
        int pageSize = 6;
        int currentPage = 1;
        
        try {
            String pageParam = request.getParameter("page");
            if (pageParam != null && !pageParam.isEmpty()) {
                currentPage = Integer.parseInt(pageParam);
                if (currentPage < 1) {
                    currentPage = 1;
                }
            }
        } catch (NumberFormatException e) {
            currentPage = 1;
        }

        CategoryService categoryService = new CategoryService();
        Map<String, Object> stats = categoryService.getCategoryStats();
        
        int totalCategories = (Integer) stats.get("totalCategories");
        int totalPages = (int) Math.ceil((double) totalCategories / pageSize);

        if (totalPages > 0 && currentPage > totalPages) {
            currentPage = totalPages;
        }
        
        int offset = (currentPage - 1) * pageSize;
        
        List<CategoryModel> categories = categoryService.getCategoriesWithPagination(offset, pageSize);
        
        request.setAttribute("categories", categories);
        request.setAttribute("stats", stats);
        request.setAttribute("currentPage", currentPage);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("pageSize", pageSize);
        
        request.getRequestDispatcher("/WEB-INF/pages/admin/Categories.jsp").forward(request, response);
        
    } catch (SQLException | ClassNotFoundException e) {
        e.printStackTrace();
        session.setAttribute("errorMessage", "Database error: " + e.getMessage());
        response.sendRedirect(request.getContextPath() + "/categories");
    }
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
           
            if (e.getMessage().toLowerCase().contains("foreign key constraint fails")) {
                session.setAttribute("errorMessage", "Cannot delete category: It is currently associated with existing products. Please reassign or delete these products first.");
            } else {

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