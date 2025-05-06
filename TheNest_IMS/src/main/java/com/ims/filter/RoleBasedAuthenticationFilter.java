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

        // Get the requested URI and context path
        String uri = req.getRequestURI();
        String contextPath = req.getContextPath(); // Get context path for accurate checks

        Object currentUser = SessionUtil.getAttribute(req, "currentUser");
        String userRole = (String) SessionUtil.getAttribute(req, "role");
        boolean isLoggedIn = currentUser != null && userRole != null;

 if (!isLoggedIn) {
            
            if (uri.endsWith(LOGIN)) { 
                chain.doFilter(request, response);
            } else {
                res.sendRedirect(contextPath + LOGIN);
            }
        } else {
        
            if (uri.startsWith(contextPath + "/admin/")) { 
               
                if ("admin".equalsIgnoreCase(userRole)) { 
              
                    chain.doFilter(request, response);
                } else {
                  
                    res.sendRedirect(contextPath + HOME); 
                }
            } else if (uri.startsWith(contextPath + "/staff/")) { 
                 
                if ("staff".equalsIgnoreCase(userRole)) {
                   
                    chain.doFilter(request, response);
                } else {
                     
                    res.sendRedirect(contextPath + HOME);
                }
            } else {
                
                chain.doFilter(request, response);
            }
        }
    }

    @Override
    public void destroy() {
        // Cleanup if needed
    }
}
