<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>${errorCode} - The Nest Inventory System</title>
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
      href="${pageContext.request.contextPath}/resources/css/Dashboard.css"
    />
    <link
      rel="stylesheet"
      href="${pageContext.request.contextPath}/resources/css/Error.css"
    />
  </head>
  <body>
    <div class="error-container">
      <div class="error-content">
        <div class="error-icon">
          <i
            class="bi ${errorCode == '404' ? 'bi-question-circle' : 'bi-shield-lock'}"
          ></i>
        </div>
        <h1 class="error-code">${errorCode}</h1>
        <h2 class="error-title">
          ${errorCode == '404' ? 'Page Not Found' : 'Access Denied'}
        </h2>
        <p class="error-message">
          ${errorCode == '404' ? 'The page you are looking for might have been
          removed, had its name changed, or is temporarily unavailable.' : 'You
          do not have permission to access this page. Please contact your
          administrator if you believe this is a mistake.'}
        </p>
        <div class="error-actions">
          <a
            href="${pageContext.request.contextPath}/dashboard"
            class="btn btn-primary"
          >
            <i class="bi bi-house"></i> Back to Dashboard
          </a>
          <button onclick="window.history.back()" class="btn btn-outline">
            <i class="bi bi-arrow-left"></i> Go Back
          </button>
        </div>
        <div class="error-help">
          <p>Need assistance? Contact our support team</p>
          <a href="mailto:support@thenest.com" class="support-link">
            <i class="bi bi-envelope"></i> support@thenest.com
          </a>
        </div>
      </div>
    </div>

    <script>
      // Add a simple animation when the page loads
      document.addEventListener("DOMContentLoaded", function () {
        document.querySelector(".error-content").classList.add("animate");
      });
    </script>
  </body>
</html>
