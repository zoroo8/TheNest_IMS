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

import java.io.IOException;
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

        try {
            List<SupplierModel> suppliers = supplierService.getAllSuppliers();
            request.setAttribute("suppliers", suppliers);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Failed to load suppliers.");
        }

        request.getRequestDispatcher("/WEB-INF/pages/Import.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {

        String importName = request.getParameter("importName");
        String importDateStr = request.getParameter("importDate");
        String supplierIdStr = request.getParameter("supplier");

        if (importName == null || importName.isBlank() ||
            importDateStr == null || importDateStr.isBlank() ||
            supplierIdStr == null || supplierIdStr.isBlank()) {
            response.sendRedirect("import?error=missingData");
            return;
        }

        LocalDate importDate;
        int supplierId;

        try {
            importDate = LocalDate.parse(importDateStr);
            supplierId = Integer.parseInt(supplierIdStr);
        } catch (DateTimeParseException | NumberFormatException e) {
            response.sendRedirect("import?error=invalidData");
            return;
        }

        ImportModel importModel = new ImportModel();
        importModel.setImportName(importName.trim());
        importModel.setImportDate(importDate);
        importModel.setSupplierId(supplierId);

        try {
            importService.saveImport(importModel);
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("import?error=serverError");
            return;
        }

        response.sendRedirect("import?success=importSaved");
    }
}
