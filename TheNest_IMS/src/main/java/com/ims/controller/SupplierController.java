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
        // Forward to supplier form or list JSP as needed
        request.getRequestDispatcher("/WEB-INF/pages/admin/Suppliers.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        // Extract form fields
        String supplierName = request.getParameter("supplierName");
        String phoneNumber = request.getParameter("phoneNumber");
        String email = request.getParameter("email");
        String address = request.getParameter("address");

        // Handle file upload for logo
        Part logoPart = request.getPart("supplierLogo");
        String logoFileName = null;

        if (logoPart != null && logoPart.getSize() > 0) {
            // Construct upload directory path under webapp root
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

            // Write the file to disk
            logoPart.write(uploadDir + File.separator + logoFileName);
        }

        // Prepare supplier model
        SupplierModel supplier = new SupplierModel();
        supplier.setSupplierName(supplierName);
        supplier.setPhoneNumber(phoneNumber);
        supplier.setEmail(email);
        supplier.setAddress(address);
        supplier.setLogo(logoFileName);

        try {
            supplierService.addSupplier(supplier);

            // Redirect to a list page or success page - adjust URL accordingly
            response.sendRedirect(request.getContextPath() + "//WEB-INF/pages/admin/Suppliers.jsp?success=Supplier added successfully");

        } catch (Exception e) {
            e.printStackTrace();

            // Add error message and forward back to the form JSP
            request.setAttribute("errorMessage", "Error saving supplier: " + e.getMessage());

            request.setAttribute("supplier", supplier);

            request.getRequestDispatcher("/WEB-INF/pages/admin/Suppliers.jsp").forward(request, response);
        }
    }
}
