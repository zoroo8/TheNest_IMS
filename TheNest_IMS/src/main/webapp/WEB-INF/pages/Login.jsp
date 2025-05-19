<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Login - The Nest Inventory System</title>
    <link rel="preconnect" href="https://fonts.googleapis.com" />
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
    <link
      href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap"
      rel="stylesheet"
    />
    <link
      href="https://fonts.googleapis.com/icon?family=Material+Icons"
      rel="stylesheet"
    />
    <link
      rel="stylesheet"
      href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css"
    />
    <link
      rel="stylesheet"
      href="${pageContext.request.contextPath}/resources/css/Login.css"
    />
  </head>
  <body>
    <a href="home" class="back-to-home">
      <i class="bi bi-arrow-left"></i> Back to Home
    </a>

    <div class="container">
      <div class="login-container">
        <div class="logo-area">
          <div class="logo-icon">
            <img
              src="${pageContext.request.contextPath}/assets/images/nest-logo.png"
              alt="The Nest Logo"
            />
          </div>
          <h2>The Nest</h2>
          <p class="subtitle">Inventory Management System</p>
        </div>
		<c:if test="${not empty error}">
		  <div class="alert alert-danger" style="color: red; margin-bottom: 1rem;">
		    ${error}
		  </div>
		</c:if>
				
        <form action="${pageContext.request.contextPath}/Login" method="post">
          <div class="form-group">
            <label for="email" class="form-label">Email address</label>
            <div class="input-group">
              <i class="bi bi-envelope input-icon"></i>
              <input
                type="email"
                class="form-control"
                id="email"
                name="email"
                placeholder="Enter your email"
                value="${param.email}"
                required
              />
            </div>
          </div>

          <div class="form-group">
            <label for="password" class="form-label">Password</label>
            <div class="input-group">
              <i class="bi bi-lock input-icon"></i>
              <input
                type="password"
                class="form-control"
                id="password"
                name="password"
                placeholder="Enter your password"
                required
              />
              <i
                class="bi bi-eye-slash toggle-password"
                id="togglePassword"
              ></i>
            </div>
          </div>

          <div class="form-check">
            <input
              type="checkbox"
              class="form-check-input"
              id="rememberMe"
              name="rememberMe"
            />
            <label class="form-check-label" for="rememberMe">Remember me</label>
          </div>

          <button type="submit" class="btn-primary">
            <i class="bi bi-box-arrow-in-right me-2"></i>Login
          </button>

          <a href="#" class="forgot-password">Forgot password?</a>

          <div class="divider">
            <span>New to The Nest?</span>
          </div>

          <div class="text-center">
            <a href="#" class="btn-outline">
              Contact administrator for access
            </a>
          </div>
        </form>
      </div>
    </div>

    <script>
      // Toggle password visibility
      document
        .getElementById("togglePassword")
        .addEventListener("click", function () {
          const passwordInput = document.getElementById("password");
          const icon = this;

          if (passwordInput.type === "password") {
            passwordInput.type = "text";
            icon.classList.replace("bi-eye-slash", "bi-eye");
          } else {
            passwordInput.type = "password";
            icon.classList.replace("bi-eye", "bi-eye-slash");
          }
        });
    </script>
  </body>
</html>
