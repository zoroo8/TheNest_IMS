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
    // Add other paths that require login but are not role-specific if needed
    // e.g., "/profile", "/inventory", etc. if all authenticated users can access them
    // but for now, we are focusing on role-specific prefixes.
})
public class RoleBasedAuthenticationFilter implements Filter {

    private static final String LOGIN_PATH = "/Login";
    private static final String ADMIN_DASHBOARD_PATH = "/admin/dashboard";
    private static final String STAFF_DASHBOARD_PATH = "/staff/dashboard";

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        // Filter initialization, if required.
    }

   @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;
        String contextPath = req.getContextPath();
        String uri = req.getRequestURI();

        Object currentUser = SessionUtil.getAttribute(req, "currentUser");
        String userRole = (String) SessionUtil.getAttribute(req, "role");
        boolean isLoggedIn = currentUser != null && userRole != null;

        if (!isLoggedIn) {
            if (uri.equals(contextPath + LOGIN_PATH) || uri.startsWith(contextPath + "/resources/") || uri.startsWith(contextPath + "/assets/")) {
                chain.doFilter(request, response);
            } else {
                res.sendRedirect(contextPath + LOGIN_PATH);
            }
        } else {
            // User is logged in, check role-based access
            if (uri.startsWith(contextPath + "/admin/")) {
                if ("ADMIN".equalsIgnoreCase(userRole)) {
                    chain.doFilter(request, response);
                } else {
                    // Admin trying to access staff page or staff trying to access admin page
                    res.sendRedirect(contextPath + STAFF_DASHBOARD_PATH + "?error=unauthorized");
                }
            } else if (uri.startsWith(contextPath + "/staff/")) {
                if ("STAFF".equalsIgnoreCase(userRole)) {
                    chain.doFilter(request, response);
                } else {
                     // Admin trying to access staff page or staff trying to access admin page
                    res.sendRedirect(contextPath + ADMIN_DASHBOARD_PATH + "?error=unauthorized");
                }
            } else {
                // For paths not starting with /admin/ or /staff/ but caught by filter (if urlPatterns expanded)
                // Or if a logged-in user accesses a non-protected common page (filter won't catch this unless pattern matches)
                chain.doFilter(request, response);
            }
        }
    }

    @Override
    public void destroy() {
        // Cleanup if needed
    }
}
