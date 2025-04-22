package com.ims.controller;

import com.ims.model.UserModel;
import com.ims.service.LoginService;
import com.ims.util.CookiesUtil;
import com.ims.util.SessionUtil;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;

@WebServlet("/Login")
public class LoginController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private LoginService loginService = new LoginService();
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String rememberMe = request.getParameter("rememberMe");
        
        try {
            UserModel user = loginService.authenticate(email, password);
            
            if (user != null) {
                SessionUtil.setAttribute(request, "currentUser", user);
                
                if (rememberMe != null && rememberMe.equals("on")) {
                    CookiesUtil.addCookie(response, "rememberedUser", 
                        String.valueOf(user.getId()), 30 * 24 * 60 * 60);
                }
                
                String redirectPage = request.getContextPath() + "/" + determineRedirectPage(user.getRole());
                response.sendRedirect(redirectPage);
            } else {
                request.setAttribute("error", "Invalid email or password");
                request.getRequestDispatcher("/WEB-INF/pages/Login.jsp").forward(request, response);
            }
        } catch (Exception e) {
            request.setAttribute("error", "Login failed. Please try again.");
            request.getRequestDispatcher("/WEB-INF/pages/Login.jsp").forward(request, response);
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/pages/Login.jsp").forward(request, response);
    }
    
    private String determineRedirectPage(String role) {
        switch(role.toUpperCase()) {
            case "ADMIN":
                return "Dashboard";
            default: // STAFF
                return "staff-dashboard";
        }
    }
}