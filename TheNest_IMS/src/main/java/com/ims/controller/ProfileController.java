package com.ims.controller;

import com.ims.model.UserModel;
import com.ims.service.RegisterService;
import com.ims.util.PasswordUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/profile")
public class ProfileController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private RegisterService registerService;

    @Override
    public void init() {
        registerService = new RegisterService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect(request.getContextPath() + "/Login");
            return;
        }

        int userId = (int) session.getAttribute("userId");

        try {
            UserModel user = registerService.getUserById(userId);
            if (user != null) {
                request.setAttribute("user", user);
                request.getRequestDispatcher("/WEB-INF/pages/Profile.jsp").forward(request, response);
            } else {
                session.setAttribute("error", "User not found.");
                response.sendRedirect(request.getContextPath() + "/dashboard");
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            session.setAttribute("error", "Error loading profile.");
            response.sendRedirect(request.getContextPath() + "/dashboard");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect(request.getContextPath() + "/Login");
            return;
        }

        int userId = (int) session.getAttribute("userId");
        String action = request.getParameter("action");

        try {
            if ("updatePersonal".equals(action)) {
                UserModel user = new UserModel();
                user.setUserId(userId);
                user.setFirstName(request.getParameter("firstName"));
                user.setLastName(request.getParameter("lastName"));
                user.setEmail(request.getParameter("email"));
                user.setPhoneNumber(request.getParameter("phone"));
                user.setDepartment(request.getParameter("department"));
                user.setRole(request.getParameter("position"));

                boolean updated = registerService.updateUser(user);
                if (updated) {
                    session.setAttribute("successMessage", "Profile updated successfully.");
                } else {
                    session.setAttribute("errorMessage", "Failed to update profile.");
                }
                response.sendRedirect(request.getContextPath() + "/profile");
            }

            else if ("changePassword".equals(action)) {
                String currentPassword = request.getParameter("current_password");
                String newPassword = request.getParameter("new_password");
                String confirmPassword = request.getParameter("confirm_password");

                try {
                    UserModel user = registerService.getUserById(userId);
                    if (user == null) {
                        session.setAttribute("errorMessage", "User not found.");
                    } else {
                        String decryptedPassword = PasswordUtil.decrypt(user.getPassword(), user.getEmail());

                        if (decryptedPassword != null && decryptedPassword.equals(currentPassword)) {
                            if (!newPassword.equals(confirmPassword)) {
                                session.setAttribute("errorMessage", "New password and confirmation do not match.");
                            } else {
                                boolean updated = registerService.updateUserPassword(
                                    userId,
                                    newPassword,
                                    user.getEmail()
                                );

                                if (updated) {
                                    session.setAttribute("successMessage", "Password changed successfully.");
                                } else {
                                    session.setAttribute("errorMessage", "Failed to update password.");
                                }
                            }
                        } else {
                            session.setAttribute("errorMessage", "Current password is incorrect.");
                        }
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                    session.setAttribute("errorMessage", "Error changing password: " + e.getMessage());
                }

                response.sendRedirect(request.getContextPath() + "/profile");
            }

            else {
                response.sendRedirect(request.getContextPath() + "/profile");
            }
        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("errorMessage", "Error processing request.");
            response.sendRedirect(request.getContextPath() + "/profile");
        }
    }
}
