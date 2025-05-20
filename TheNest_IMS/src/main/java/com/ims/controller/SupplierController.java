package com.ims.controller;

import com.ims.model.SupplierModel;
import com.ims.service.SupplierService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

import java.io.File;
import java.io.IOException;
import java.util.UUID;

@WebServlet("/suppliers")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024,   // 1MB
    maxFileSize = 5 * 1024 * 1024,     // 5MB
    maxRequestSize = 10 * 1024 * 1024  // 10MB
)
public class SupplierController extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private final SupplierService supplierService = new SupplierService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            request.setAttribute("suppliers", supplierService.getAllSuppliers());
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Failed to load suppliers.");
        }

        request.getRequestDispatcher("/WEB-INF/pages/admin/Suppliers.jsp").forward(request, response);
    }


    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String supplierName = request.getParameter("supplierName");
        String phoneNumber = request.getParameter("phoneNumber");
        String email = request.getParameter("email");
        String address = request.getParameter("address");

        Part logoPart = request.getPart("supplierLogo");
        String logoFileName = null;

        if (logoPart != null && logoPart.getSize() > 0) {
            String uploadDir = getServletContext().getRealPath("/uploads/logos");

            File uploadDirFile = new File(uploadDir);
            if (!uploadDirFile.exists() && !uploadDirFile.mkdirs()) {
                throw new ServletException("Failed to create upload directory: " + uploadDir);
            }

            String submittedFileName = logoPart.getSubmittedFileName();
            String extension = "";

            int i = submittedFileName.lastIndexOf('.');
            if (i >= 0) {
                extension = submittedFileName.substring(i);
            }

            logoFileName = UUID.randomUUID().toString() + extension;

            logoPart.write(uploadDir + File.separator + logoFileName);
        }

        SupplierModel supplier = new SupplierModel();
        supplier.setSupplierName(supplierName);
        supplier.setPhoneNumber(phoneNumber);
        supplier.setEmail(email);
        supplier.setAddress(address);
        supplier.setLogo(logoFileName);

        request.setAttribute("supplier", supplier); // so values remain in form

        try {
            supplierService.addSupplier(supplier);
            request.setAttribute("successMessage", "Supplier added successfully.");
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Error saving supplier: " + e.getMessage());
        }

        request.getRequestDispatcher("/WEB-INF/pages/admin/Suppliers.jsp").forward(request, response);
    }
}
