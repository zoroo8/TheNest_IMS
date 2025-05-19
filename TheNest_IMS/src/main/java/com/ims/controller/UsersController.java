package com.ims.controller;

import com.ims.model.UserModel;
import com.ims.service.RegisterService;
import com.ims.util.RedirectionUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.SQLException;
import java.time.LocalDate;
import java.time.format.DateTimeParseException;

@WebServlet("/users")
@MultipartConfig(maxFileSize = 1024 * 1024 * 5) // max 5MB file upload
public class UsersController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private RegisterService regService = new RegisterService();
    private RedirectionUtil redirectionUtil = new RedirectionUtil();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        redirectionUtil.redirectToPage(req, res, "/WEB-INF/pages/Users.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Extract form params
        String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");
        String phoneNumber = request.getParameter("phoneNumber");
        String dobStr = request.getParameter("dob");
        String gender = request.getParameter("gender");
        String email = request.getParameter("email");
        String address = request.getParameter("address");
        String role = request.getParameter("role");
        String department = request.getParameter("department");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");

        // Validate required fields
        if (firstName == null || lastName == null || dobStr == null || email == null || password == null || confirmPassword == null ||
                firstName.isEmpty() || lastName.isEmpty() || dobStr.isEmpty() || email.isEmpty() || password.isEmpty() || confirmPassword.isEmpty()) {
            redirectionUtil.setMsgAndRedirect(request, response, "errorMessage", "Please fill all required fields.", "/WEB-INF/pages/Users.jsp");
            return;
        }

        if (!password.equals(confirmPassword)) {
            redirectionUtil.setMsgAndRedirect(request, response, "errorMessage", "Passwords do not match.", "/WEB-INF/pages/Users.jsp");
            return;
        }

        LocalDate dob;
        try {
            dob = LocalDate.parse(dobStr);
        } catch (DateTimeParseException e) {
            redirectionUtil.setMsgAndRedirect(request, response, "errorMessage", "Invalid date of birth format.", "/WEB-INF/pages/Users.jsp");
            return;
        }

        // Handle profile picture upload (optional)
        Part filePart = request.getPart("profilePicture"); // form field name="profilePicture"
        String profilePictureFileName = null;
        if (filePart != null && filePart.getSize() > 0) {
            // You can generate a unique file name or just get submitted file name:
            profilePictureFileName = System.currentTimeMillis() + "_" + filePart.getSubmittedFileName();

            // Define where to save the uploaded file, e.g. webapp/images/profiles/
            String uploadPath = "C:\\Users\\Acer\\OneDrive - islingtoncollege.edu.np\\Documents\\Y2\\Y2 Coursework\\Y2 S2\\Advanced Programming and Technology\\TheNest_IMS\\TheNest_IMS\\src\\main\\webapp\\uploads\\profiles\\";


            java.io.File uploadDir = new java.io.File(uploadPath);
            if (!uploadDir.exists()) {
                uploadDir.mkdirs();
            }

            // Save the file on server
            filePart.write(uploadPath + profilePictureFileName);
        }

        UserModel user = new UserModel(firstName, lastName, phoneNumber, dob, gender, email, address, role, department, profilePictureFileName, password);
        
        try {
            boolean registered = regService.registerUser(user);
            if (registered) {
                redirectionUtil.setMsgAndRedirect(request, response, "successMessage", "User registered successfully!", "/WEB-INF/pages/Users.jsp");
            } else {
                redirectionUtil.setMsgAndRedirect(request, response, "errorMessage", "User registration failed.", "/WEB-INF/pages/Users.jsp");
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            redirectionUtil.setMsgAndRedirect(request, response, "errorMessage", "Internal server error.", "/WEB-INF/pages/Users.jsp");
        }
    }
}
