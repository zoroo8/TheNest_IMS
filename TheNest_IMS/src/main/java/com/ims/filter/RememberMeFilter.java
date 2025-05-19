package com.ims.filter;

import java.io.IOException;
import java.sql.SQLException;

import com.ims.model.UserModel;
import com.ims.service.LoginService;

import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebFilter("/*")
public class RememberMeFilter implements Filter {
    private LoginService loginService = new LoginService();

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        
        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;
        HttpSession session = req.getSession(false);
        
        UserModel currentUser = (session != null) ? (UserModel) session.getAttribute("currentUser") : null;

        if (currentUser == null) {
            // Check for rememberedUser cookie
            Cookie[] cookies = req.getCookies();
            if (cookies != null) {
                for (Cookie cookie : cookies) {
                    if ("rememberedUser".equals(cookie.getName())) {
                        try {
                            int userId = Integer.parseInt(cookie.getValue());
                            UserModel user = loginService.getUserById(userId);
                            if (user != null) {
                                HttpSession newSession = req.getSession(true);
                                newSession.setAttribute("currentUser", user);
                                newSession.setAttribute("role", user.getRole());
                            }
                        } catch (NumberFormatException e) {
                            // Ignore malformed cookie
                        } catch (ClassNotFoundException | SQLException e) {
                            // Log or handle DB error gracefully
                            e.printStackTrace();
                        }
                        break;
                    }
                }
            }
        }

        chain.doFilter(request, response);
    }

}
