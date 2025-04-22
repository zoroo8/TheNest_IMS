package com.ims.controller;

import java.io.IOException;

import com.ims.util.SessionUtil;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

@WebServlet("/Logout")
public class LogoutController extends HttpServlet {
    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // Invalidate session
        SessionUtil.invalidateSession(request);
        
        // Clear remember me cookie
        Cookie logoutCookie = new Cookie("rememberedUser", "");
        logoutCookie.setMaxAge(0); // Delete cookie
        logoutCookie.setPath("/");
        response.addCookie(logoutCookie);
        
        // Redirect to login page
        response.sendRedirect(request.getContextPath() + "/Login");
    }
}