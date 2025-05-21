package com.ims.controller;

import com.ims.model.ImportModel;
import com.ims.model.SupplierModel;
import com.ims.service.ImportService;
import com.ims.service.SupplierService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.io.PrintWriter;
import java.time.LocalDate;
import java.time.format.DateTimeParseException;
import java.util.List;

@WebServlet("/import")
public class ImportController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private final ImportService importService = new ImportService();
    private final SupplierService supplierService = new SupplierService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
            
        String action = request.getParameter("action");
        
        if (action != null && action.equals("getImportDetails")) {
            getImportDetails(request, response);
            return;
        }

        try {
            // Get all imports
            List<ImportModel> imports = importService.getAllImports();
            request.setAttribute("imports", imports);
            
            // Get all suppliers for the dropdown
            List<SupplierModel> suppliers = supplierService.getAllSuppliers();
            request.setAttribute("suppliers", suppliers);
            
            // Get stats for the cards
            int totalImports = importService.getTotalImportCount();
            int currentMonthImports = importService.getCurrentMonthImportCount();
            int activeSuppliers = importService.getActiveSupplierCount();
            
            request.setAttribute("totalImports", totalImports);
            request.setAttribute("currentMonthImports", currentMonthImports);
            request.setAttribute("activeSuppliers", activeSuppliers);
            
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Failed to load data: " + e.getMessage());
        }

        request.getRequestDispatcher("/WEB-INF/pages/Import.jsp").forward(request, response);
    }

   private void getImportDetails(HttpServletRequest request, HttpServletResponse response) 
        throws ServletException, IOException {
    try {
        int importId = Integer.parseInt(request.getParameter("id"));
        ImportModel importDetail = importService.getImportById(importId);
        
        if (importDetail != null) {
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            
            // Manually construct JSON response
            StringBuilder json = new StringBuilder();
            json.append("{");
            json.append("\"importId\":").append(importDetail.getImportId()).append(",");
            json.append("\"importName\":\"").append(escapeJsonString(importDetail.getImportName())).append("\",");
            json.append("\"importDate\":\"").append(importDetail.getImportDate()).append("\",");
            json.append("\"supplierId\":").append(importDetail.getSupplierId()).append(",");
            json.append("\"supplierName\":\"").append(escapeJsonString(importDetail.getSupplierName())).append("\"");
            
            // Add optional fields
            if (importDetail.getSupplierPhone() != null) {
                json.append(",\"supplierPhone\":\"").append(escapeJsonString(importDetail.getSupplierPhone())).append("\"");
            }
            
            if (importDetail.getSupplierEmail() != null) {
                json.append(",\"supplierEmail\":\"").append(escapeJsonString(importDetail.getSupplierEmail())).append("\"");
            }
            
            json.append("}");
            
            PrintWriter out = response.getWriter();
            out.print(json.toString());
            out.flush();
        } else {
            response.setStatus(HttpServletResponse.SC_NOT_FOUND);
            response.getWriter().write("{\"error\":\"Import not found\"}");
        }
    } catch (NumberFormatException e) {
        response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
        response.getWriter().write("{\"error\":\"Invalid import ID\"}");
    } catch (Exception e) {
        e.printStackTrace();
        response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        response.getWriter().write("{\"error\":\"Server error: " + escapeJsonString(e.getMessage()) + "\"}");
    }
}

// Helper method to escape special characters in JSON
private String escapeJsonString(String input) {
    if (input == null) {
        return "";
    }
    
    StringBuilder sb = new StringBuilder();
    for (int i = 0; i < input.length(); i++) {
        char ch = input.charAt(i);
        switch (ch) {
            case '\"':
                sb.append("\\\"");
                break;
            case '\\':
                sb.append("\\\\");
                break;
            case '/':
                sb.append("\\/");
                break;
            case '\b':
                sb.append("\\b");
                break;
            case '\f':
                sb.append("\\f");
                break;
            case '\n':
                sb.append("\\n");
                break;
            case '\r':
                sb.append("\\r");
                break;
            case '\t':
                sb.append("\\t");
                break;
            default:
                sb.append(ch);
        }
    }
    return sb.toString();
}

    @Override
protected void doPost(HttpServletRequest request, HttpServletResponse response) 
        throws ServletException, IOException {
    HttpSession session = request.getSession();
    
    String importId = request.getParameter("importId");
    String importName = request.getParameter("importName");
    String importDateStr = request.getParameter("importDate");
    String supplierIdStr = request.getParameter("supplier");

    if (importName == null || importName.isBlank() ||
        importDateStr == null || importDateStr.isBlank() ||
        supplierIdStr == null || supplierIdStr.isBlank()) {
        
        session.setAttribute("errorMessage", "Missing required data");
        response.sendRedirect(request.getContextPath() + "/import");
        return;
    }

    LocalDate importDate;
    int supplierId;

    try {
        importDate = LocalDate.parse(importDateStr);
        supplierId = Integer.parseInt(supplierIdStr);
    } catch (Exception e) {
        session.setAttribute("errorMessage", "Invalid data format: " + e.getMessage());
        response.sendRedirect(request.getContextPath() + "/import");
        return;
    }

    ImportModel importModel = new ImportModel();
    importModel.setImportName(importName.trim());
    importModel.setImportDate(importDate);
    importModel.setSupplierId(supplierId);
    
    try {
        boolean success;
        
        // Check if we're updating an existing import or creating a new one
        if (importId != null && !importId.isEmpty()) {
            // Update existing import
            try {
                int id = Integer.parseInt(importId);
                importModel.setImportId(id);
                success = importService.updateImport(importModel);
                
                if (success) {
                    session.setAttribute("successMessage", "Import updated successfully");
                } else {
                    session.setAttribute("errorMessage", "Failed to update import");
                }
            } catch (NumberFormatException e) {
                session.setAttribute("errorMessage", "Invalid import ID: " + e.getMessage());
                response.sendRedirect(request.getContextPath() + "/import");
                return;
            }
        } else {
            // Create new import
            success = importService.saveImport(importModel);
            
            if (success) {
                session.setAttribute("successMessage", "Import saved successfully");
            } else {
                session.setAttribute("errorMessage", "Failed to save import");
            }
        }
    } catch (Exception e) {
        e.printStackTrace();
        session.setAttribute("errorMessage", "Error: " + e.getMessage());
    }

    response.sendRedirect(request.getContextPath() + "/import");
}
}