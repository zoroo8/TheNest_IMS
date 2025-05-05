package com.ims.filter;

import java.io.IOException;
import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.FilterConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import com.ims.util.SessionUtil;

@WebFilter(asyncSupported = true, urlPatterns = { 
    "/admin/*", 
    "/staff/*"
})
public class RoleBasedAuthenticationFilter implements Filter {

    private static final String LOGIN = "/Login";
    private static final String HOME = "/home";
    private static final String ADMIN_DASHBOARD = "/admin/dashboard";
    private static final String STAFF_DASHBOARD = "/staff/dashboard";

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        // Filter initialization, if required.
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        // Cast the request and response to HttpServletRequest and HttpServletResponse
        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;

        // Get the requested URI
        String uri = req.getRequestURI();

        Object currentUser = SessionUtil.getAttribute(req, "currentUser");
        String userRole = (String) SessionUtil.getAttribute(req, "role");
        boolean isLoggedIn = currentUser != null && userRole != null;


        // If the user is not logged in, redirect to the login page
        if (!isLoggedIn) {
            if (uri.endsWith(LOGIN)) {
                chain.doFilter(request, response);
            } else {
                res.sendRedirect(req.getContextPath() + LOGIN);
            }
        } else {
            // If the user is logged in, check the role for accessing the page
            if (uri.contains("/admin/")) {
                if ("admin".equals(userRole)) {
                    // Allow access to admin pages
                    chain.doFilter(request, response);
                } else {
                    res.sendRedirect(req.getContextPath() + HOME);
                }
            } else if (uri.contains("/staff/")) {
                if ("staff".equals(userRole)) {
                    // Allow access to staff pages
                    chain.doFilter(request, response);
                } else {
                    res.sendRedirect(req.getContextPath() + HOME);
                }
            } else {
                // For other URLs, pass the request along the filter chain
                chain.doFilter(request, response);
            }
        }
    }

    @Override
    public void destroy() {
        // Cleanup if needed
    }
}
