package com.ims.filter;

import java.io.IOException;
import java.util.Arrays;
import java.util.List;

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

@WebFilter("/*")
public class RoleBasedAuthenticationFilter implements Filter {

    private static final String LOGIN = "/Login";
    private static final String HOME = "/";
    private static final String ERROR = "/Error";

    // Publicly accessible URIs
    private static final List<String> PUBLIC_URIS = Arrays.asList(
        LOGIN, HOME, ERROR, "/css", "/js", "/images", "/assets"
    );

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
    	
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        
        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;
        String uri = req.getRequestURI();
        String contextPath = req.getContextPath();

        Object currentUser = SessionUtil.getAttribute(req, "currentUser");
        String userRole = (String) SessionUtil.getAttribute(req, "role");
        boolean isLoggedIn = currentUser != null && userRole != null;

        // Allow access to public URIs
        if (isPublic(uri)) {
            chain.doFilter(request, response);
            return;
        }

        // Redirect to login if not logged in
        if (!isLoggedIn) {
            res.sendRedirect(contextPath + LOGIN);
            return;
        }

        // Redirect to error if URL doesn't match role
        if (uri.equals("/dashboard") && !"admin".equalsIgnoreCase(userRole)) {
            res.sendRedirect(contextPath + ERROR);
            return;
        }

        if (uri.equals("/staffdashboard") && !"staff".equalsIgnoreCase(userRole)) {
            res.sendRedirect(contextPath + ERROR);
            return;
        }

        if (uri.equals("/users") && !"admin".equalsIgnoreCase(userRole)) {
            res.sendRedirect(contextPath + ERROR);
            return;
        }

         if (uri.equals("/categories") && !"admin".equalsIgnoreCase(userRole)) {
            res.sendRedirect(contextPath + ERROR);
            return;
        }

        if (uri.equals("/stock-requests") && !"admin".equalsIgnoreCase(userRole)) {
            res.sendRedirect(contextPath + ERROR);
            return;
        }

        if (uri.equals("/staff/my-requests") && !"staff".equalsIgnoreCase(userRole)) {
            res.sendRedirect(contextPath + ERROR);
            return;
        }

        // Pages accessible by both roles
        List<String> commonPages = Arrays.asList("/products");

        if (commonPages.contains(uri)) {
            chain.doFilter(request, response);
            return;
        }

        // Unknown route fallback
        res.sendRedirect(contextPath + ERROR);
    }

    private boolean isPublic(String uri) {
        return PUBLIC_URIS.stream().anyMatch(uri::startsWith);
    }

    @Override
    public void destroy() {
        // Optional cleanup
    }
}
