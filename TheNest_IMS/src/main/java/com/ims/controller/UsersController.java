package com.ims.controller;

import com.ims.model.UserModel;
import com.ims.service.RegisterService; // Assuming RegisterService acts as UserService
import com.ims.util.RedirectionUtil; // Assuming you have this utility

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.File;
import java.io.IOException;
import java.sql.SQLException;
import java.sql.SQLIntegrityConstraintViolationException;
import java.time.LocalDate;
import java.time.format.DateTimeParseException;
import java.util.List;
import java.util.Map;

@WebServlet("/users")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 * 1, // 1 MB
    maxFileSize = 1024 * 1024 * 5,      // 5 MB
    maxRequestSize = 1024 * 1024 * 10   // 10 MB
)
public class UsersController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private RegisterService userService; // Renamed for clarity, still uses RegisterService
    private RedirectionUtil redirectionUtil;
    private static final String UPLOAD_DIRECTORY = "uploads" + File.separator + "profiles";


    @Override
    public void init() throws ServletException {
        userService = new RegisterService();
        redirectionUtil = new RedirectionUtil();
    }

   @Override
protected void doGet(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
    request.getServletContext().log("UsersController doGet: Entered."); // TEMP LOG
    HttpSession session = request.getSession(false);

    if (session == null || session.getAttribute("role") == null) {
        request.getServletContext().log("UsersController doGet: Session or role is null. Redirecting to login."); // TEMP LOG
        response.sendRedirect(request.getContextPath() + "/login");
        return;
    }
    request.getServletContext().log("UsersController doGet: User role is: " + session.getAttribute("role")); // TEMP LOG


    if (!"admin".equals(session.getAttribute("role"))) {
        request.getServletContext().log("UsersController doGet: User is not admin. Redirecting to login."); // TEMP LOG
        // Consider redirecting to an error page or home page if already logged in but wrong role
        response.sendRedirect(request.getContextPath() + "/login"); 
        return;
    }

    String action = request.getParameter("action");
    request.getServletContext().log("UsersController doGet: Action is: " + action); // TEMP LOG

    try {
        request.getServletContext().log("UsersController doGet: Entering try block."); // TEMP LOG
        if ("getUserDetails".equals(action)) {
            // handleGetUserDetails(request, response); // Comment out temporarily if suspect
            request.getServletContext().log("UsersController doGet: Action is getUserDetails."); // TEMP LOG
             handleGetUserDetails(request, response);
        } else {
            request.getServletContext().log("UsersController doGet: Calling listUsers."); // TEMP LOG
            listUsers(request, response);
        }
        request.getServletContext().log("UsersController doGet: Exiting try block successfully."); // TEMP LOG
    } catch (SQLException | ClassNotFoundException e) {
        request.getServletContext().log("UsersController doGet: CAUGHT SQLException or ClassNotFoundException: " + e.getMessage()); // TEMP LOG
        e.printStackTrace(); // This still goes to standard error, check server logs
        if (session != null) { // Ensure session is not null before setting attribute
            session.setAttribute("errorMessage", "Database error: " + e.getMessage());
        }
        response.sendRedirect(request.getContextPath() + "/users"); 
        return; 
    } catch (Exception e) { // Catch any other unexpected exceptions
        request.getServletContext().log("UsersController doGet: CAUGHT UNEXPECTED Exception: " + e.getMessage(), e); // Log with stack trace
         if (session != null) {
            session.setAttribute("errorMessage", "An unexpected error occurred: " + e.getMessage());
        }
        // Redirect to a generic error page instead of potentially looping
        response.sendRedirect(request.getContextPath() + "/Error"); // Assuming /Error is a safe error page
        return;
    }
}

    private void listUsers(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException, ClassNotFoundException {
        request.getServletContext().log("UsersController listUsers: Entered.");
        int pageSize = 6; // Records per page
        int currentPage = 1;

        String pageParam = request.getParameter("page");
        if (pageParam != null && !pageParam.isEmpty()) {
            try {
                currentPage = Integer.parseInt(pageParam);
                if (currentPage < 1) currentPage = 1;
            } catch (NumberFormatException e) {
                currentPage = 1;
            }
        }

        Map<String, Object> stats = userService.getUserStats();
        int totalUsers = (Integer) stats.get("totalUsers");
        int totalPages = (int) Math.ceil((double) totalUsers / pageSize);

        if (totalPages > 0 && currentPage > totalPages) {
            currentPage = totalPages;
        }
        if (currentPage < 1 && totalPages > 0) { // Ensure currentPage is at least 1 if there are pages
             currentPage = 1;
        }


        int offset = (currentPage - 1) * pageSize;
        if (offset < 0) offset = 0; // Should not happen if currentPage is validated

        List<UserModel> users = userService.getUsersWithPagination(offset, pageSize);

        request.setAttribute("users", users);
        request.setAttribute("stats", stats);
        request.setAttribute("currentPage", currentPage);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("pageSize", pageSize);

        redirectionUtil.redirectToPage(request, response, "/WEB-INF/pages/admin/Users.jsp");
    }

    private void handleGetUserDetails(HttpServletRequest request, HttpServletResponse response)
    throws IOException, SQLException, ClassNotFoundException {
    response.setContentType("application/json");
    response.setCharacterEncoding("UTF-8");
    String idParam = request.getParameter("id");
    if (idParam == null || idParam.isEmpty()) {
        response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
        response.getWriter().write("{\"error\": \"User ID is required\"}");
        return;
    }
    try {
        int userId = Integer.parseInt(idParam);
        UserModel user = userService.getUserById(userId);
        if (user == null) {
            response.setStatus(HttpServletResponse.SC_NOT_FOUND);
            response.getWriter().write("{\"error\": \"User not found\"}");
            return;
        }
        
        // Fixed JSON formatting - removed status field and fixing comma issues
        String json = String.format(
            "{\"userId\": %d, \"firstName\": \"%s\", \"lastName\": \"%s\", \"email\": \"%s\", " +
            "\"phoneNumber\": \"%s\", \"dob\": \"%s\", \"gender\": \"%s\", \"address\": \"%s\", " +
            "\"role\": \"%s\", \"department\": \"%s\", \"profilePicture\": \"%s\"}",
            user.getUserId(), 
            escapeJson(user.getFirstName()), 
            escapeJson(user.getLastName()), 
            escapeJson(user.getEmail()),
            escapeJson(user.getPhoneNumber()), 
            user.getDob() != null ? user.getDob().toString() : "", 
            escapeJson(user.getGender()), 
            escapeJson(user.getAddress()),
            escapeJson(user.getRole()), 
            escapeJson(user.getDepartment()),
            escapeJson(user.getProfilePicture())
        );
        
        response.getWriter().write(json);
    } catch (NumberFormatException e) {
        response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
        response.getWriter().write("{\"error\": \"Invalid User ID format\"}");
    }
}
    
    private String escapeJson(String input) {
        if (input == null) return "";
        return input.replace("\\", "\\\\").replace("\"", "\\\"").replace("\n", "\\n").replace("\r", "\\r").replace("\t", "\\t");
    }


    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || !"admin".equals(session.getAttribute("role"))) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String action = request.getParameter("action");
        if (action == null) action = "add"; // Default action if not specified

        try {
            switch (action) {
                case "add":
                    handleAddUser(request, response, session);
                    break;
                case "update":
                    handleUpdateUser(request, response, session);
                    break;
                case "delete":
                    handleDeleteUser(request, response, session);
                    break;
                default:
                    session.setAttribute("errorMessage", "Invalid action specified.");
                    response.sendRedirect(request.getContextPath() + "/users");
                    return; // Added return
            }
        } catch (DateTimeParseException e) {
            session.setAttribute("errorMessage", "Invalid date format: " + e.getMessage());
            response.sendRedirect(request.getContextPath() + "/users" + (request.getParameter("userId") != null ? "?action=edit&id="+request.getParameter("userId") : ""));
            return; // Added return
        } catch (SQLIntegrityConstraintViolationException e) {
             session.setAttribute("errorMessage", "Operation failed due to a data conflict (e.g., duplicate email or user associated with other records).");
             e.printStackTrace(); // Log full error
             response.sendRedirect(request.getContextPath() + "/users");
             return; // Added return
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            session.setAttribute("errorMessage", "Database operation failed: " + e.getMessage());
            response.sendRedirect(request.getContextPath() + "/users");
            return; // Added return
        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("errorMessage", "An unexpected error occurred: " + e.getMessage());
            response.sendRedirect(request.getContextPath() + "/users");
            return; // Added return
        }
    }

    private void handleAddUser(HttpServletRequest request, HttpServletResponse response, HttpSession session)
            throws ServletException, IOException, SQLException, ClassNotFoundException, DateTimeParseException {
        
        String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");
        String phoneNumber = request.getParameter("phoneNumber");
        String dobStr = request.getParameter("dob"); // Assuming YYYY-MM-DD
        String gender = request.getParameter("gender");
        String email = request.getParameter("email");
        String address = request.getParameter("address");
        String role = request.getParameter("role");
        String department = request.getParameter("department");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");
        


        if (firstName == null || lastName == null || dobStr == null || email == null || password == null || confirmPassword == null ||
            firstName.trim().isEmpty() || lastName.trim().isEmpty() || dobStr.trim().isEmpty() || email.trim().isEmpty() || password.isEmpty() || confirmPassword.isEmpty() ||
            role == null || role.trim().isEmpty() || department == null || department.trim().isEmpty()) {
            session.setAttribute("errorMessage", "Please fill all required fields.");
            response.sendRedirect(request.getContextPath() + "/users"); // Or back to form with error
            return;
        }

        if (!password.equals(confirmPassword)) {
            session.setAttribute("errorMessage", "Passwords do not match.");
            response.sendRedirect(request.getContextPath() + "/users");
            return;
        }

        LocalDate dob = LocalDate.parse(dobStr); // Can throw DateTimeParseException

        String profilePictureFileName = uploadProfilePicture(request);

        UserModel user = new UserModel(firstName, lastName, phoneNumber, dob, gender, email, address, role, department, profilePictureFileName, password);
        
        boolean registered = userService.registerUser(user);
        if (registered) {
            session.setAttribute("successMessage", "User '" + user.getFirstName() + " " + user.getLastName() + "' registered successfully!");
        } else {
            session.setAttribute("errorMessage", "User registration failed. Email might already exist or other database error.");
        }
        response.sendRedirect(request.getContextPath() + "/users");
        // No return needed here as it's the end of the method after a redirect.
    }

    private void handleUpdateUser(HttpServletRequest request, HttpServletResponse response, HttpSession session)
        throws ServletException, IOException, SQLException, ClassNotFoundException, DateTimeParseException {
        String userIdParam = request.getParameter("userId");
        if (userIdParam == null || userIdParam.isEmpty()) {
            session.setAttribute("errorMessage", "User ID is missing for update.");
            response.sendRedirect(request.getContextPath() + "/users");
            return;
        }
        int userId = Integer.parseInt(userIdParam);

        UserModel user = userService.getUserById(userId); // Fetch existing user to get current email for password salt if needed
        if (user == null) {
            session.setAttribute("errorMessage", "User not found for update.");
            response.sendRedirect(request.getContextPath() + "/users");
            return;
        }
        
        user.setFirstName(request.getParameter("firstName"));
        user.setLastName(request.getParameter("lastName"));
        user.setPhoneNumber(request.getParameter("phoneNumber"));
        user.setDob(LocalDate.parse(request.getParameter("dob")));
        user.setGender(request.getParameter("gender"));
        user.setEmail(request.getParameter("email"));
        user.setAddress(request.getParameter("address"));
        user.setRole(request.getParameter("role"));
        user.setDepartment(request.getParameter("department"));


        String newProfilePictureFileName = uploadProfilePicture(request);
        if (newProfilePictureFileName != null && !newProfilePictureFileName.isEmpty()) {
            // Optionally, delete old profile picture if it exists and is different
            user.setProfilePicture(newProfilePictureFileName);
        }

        boolean updated = userService.updateUser(user);

        // Handle password update separately if new password is provided
        String newPassword = request.getParameter("password");
        String confirmNewPassword = request.getParameter("confirmPassword");
        if (newPassword != null && !newPassword.isEmpty()) {
            if (!newPassword.equals(confirmNewPassword)) {
                session.setAttribute("errorMessage", "New passwords do not match. Other details might have been updated.");
                response.sendRedirect(request.getContextPath() + "/users"); // Or redirect to edit page
                return;
            }
            // Use the user's current email for encryption salt, as PasswordUtil might depend on it.
            // If email can be changed, ensure PasswordUtil handles this or use a fixed salt strategy.
            userService.updateUserPassword(userId, newPassword, user.getEmail()); 
            session.setAttribute("successMessage", "User '" + user.getFirstName() + "' updated successfully (including password)!");
        } else if (updated) {
            session.setAttribute("successMessage", "User '" + user.getFirstName() + "' updated successfully!");
        } else {
            session.setAttribute("errorMessage", "User update failed.");
        }
        response.sendRedirect(request.getContextPath() + "/users");
         // No return needed here as it's the end of the method after a redirect.
    }

    private void handleDeleteUser(HttpServletRequest request, HttpServletResponse response, HttpSession session)
            throws SQLException, ClassNotFoundException, IOException {
        String userIdParam = request.getParameter("userIdToDelete");
         if (userIdParam == null || userIdParam.isEmpty()) {
            session.setAttribute("errorMessage", "User ID for deletion is missing.");
            response.sendRedirect(request.getContextPath() + "/users");
            return;
        }
        int userId = Integer.parseInt(userIdParam);
        
        // Optional: Check if the admin is trying to delete their own account
        UserModel currentUser = (UserModel) session.getAttribute("currentUser"); // Assuming logged-in user is in session
        if (currentUser != null && currentUser.getUserId() == userId) {
            session.setAttribute("errorMessage", "You cannot delete your own account.");
            response.sendRedirect(request.getContextPath() + "/users");
            return;
        }

        boolean deleted = userService.deleteUser(userId);
        if (deleted) {
            session.setAttribute("successMessage", "User (ID: " + userId + ") deleted successfully!");
        } else {
            session.setAttribute("errorMessage", "Failed to delete user (ID: " + userId + ").");
        }
        response.sendRedirect(request.getContextPath() + "/users");
         // No return needed here as it's the end of the method after a redirect.
    }

    private String uploadProfilePicture(HttpServletRequest request) throws IOException, ServletException {
        Part filePart = request.getPart("profilePicture"); // Matches <input type="file" name="profilePicture">
        String fileName = null;

        if (filePart != null && filePart.getSize() > 0 && filePart.getSubmittedFileName() != null && !filePart.getSubmittedFileName().isEmpty()) {
            fileName = System.currentTimeMillis() + "_" + Paths.get(filePart.getSubmittedFileName()).getFileName().toString(); // MSIE fix.
            
            // Get the application's real path for the upload directory
            String appPath = request.getServletContext().getRealPath("");
            String uploadFilePath = appPath + File.separator + UPLOAD_DIRECTORY;
            
            File uploadDir = new File(uploadFilePath);
            if (!uploadDir.exists()) {
                uploadDir.mkdirs();
            }
            filePart.write(uploadFilePath + File.separator + fileName);
            return UPLOAD_DIRECTORY + File.separator + fileName; // Return relative path for storage in DB
        }
        return null; // No file uploaded or empty file
    }
     private static class Paths { // Inner utility class to avoid external dependency for simple path operation
        public static java.nio.file.Path get(String first, String... more) {
            return java.nio.file.Paths.get(first, more);
        }
    }
}