<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%> <%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core" %> <%@ taglib prefix="fn"
uri="http://java.sun.com/jsp/jstl/functions" %>

<!-- Sidebar Styles -->
<style>
  :root {
    --primary-color: #2e7d32; /* Green */
    --secondary-color: #4caf50; /* Lighter green */
    --dark-color: #1b5e20; /* Dark green */
    --light-color: #e8f5e9; /* Very light green */
    --gray-light: #f5f5f5; /* Light grey */
    --gray-medium: #e0e0e0; /* Medium grey */
    --gray-dark: #757575; /* Dark grey */
    --text-color: #212121; /* Near black */
    --white: #ffffff; /* White */
    --shadow-sm: 0 2px 5px rgba(0, 0, 0, 0.05);
    --shadow-md: 0 4px 15px rgba(0, 0, 0, 0.08);
    --shadow-lg: 0 8px 25px rgba(0, 0, 0, 0.1);
    --border-radius: 8px;
    --border-radius-sm: 4px;
    --border-radius-lg: 12px;
  }

  body {
    font-family: "Poppins", sans-serif;
    background-color: #fafafa; /* Very light grey */
    color: var(--text-color);
    min-height: 100vh;
    display: flex;
    margin: 0;
  }

  /* Main Content Styles */
  .main-content {
    flex: 1;
    margin-left: 250px;
    padding: 30px;
    transition: all 0.3s;
  }

  .page-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 25px;
    padding-bottom: 15px;
    border-bottom: 1px solid var(--gray-light);
  }

  .page-title {
    font-size: 1.8rem;
    font-weight: 600;
    color: var(--dark-color);
    margin: 0;
  }

  /* Button Styles */
  .btn {
    display: inline-flex;
    align-items: center;
    justify-content: center;
    gap: 8px;
    font-weight: 500;
    text-align: center;
    white-space: nowrap;
    border: 1px solid transparent;
    padding: 8px 16px;
    font-size: 0.9rem;
    line-height: 1.5;
    border-radius: 4px;
    transition: all 0.3s;
    cursor: pointer;
    font-family: inherit;
  }

  .btn-sm {
    padding: 4px 10px;
    font-size: 0.8rem;
  }

  .btn-primary {
    background-color: var(--primary-color);
    border-color: var(--primary-color);
    color: var(--white);
    box-shadow: 0 2px 5px rgba(46, 125, 50, 0.2);
  }

  .btn-primary:hover {
    background-color: var(--dark-color);
    border-color: var(--dark-color);
    box-shadow: 0 4px 8px rgba(46, 125, 50, 0.3);
  }

  .btn-outline {
    background-color: transparent;
    border-color: var(--gray-medium);
    color: var(--text-color);
  }

  .btn-outline:hover {
    background-color: var(--gray-light);
    color: var(--dark-color);
  }

  .btn-outline.active {
    background-color: var(--light-color);
    color: var(--primary-color);
    border-color: var(--primary-color);
  }

  .me-2 {
    margin-right: 0.5rem;
  }

  /* Form Controls */
  .form-control {
    display: block;
    width: 100%;
    padding: 8px 12px;
    font-size: 0.9rem;
    line-height: 1.5;
    color: var(--text-color);
    background-color: var(--white);
    background-clip: padding-box;
    border: 1px solid var(--gray-medium);
    border-radius: 4px;
    transition: border-color 0.15s ease-in-out, box-shadow 0.15s ease-in-out;
  }

  .form-control:focus {
    border-color: var(--primary-color);
    outline: 0;
    box-shadow: 0 0 0 0.2rem rgba(46, 125, 50, 0.25);
  }

  /* Responsive Adjustments */
  @media (max-width: 768px) {
    .main-content {
      margin-left: 0;
    }

    .page-header {
      flex-direction: column;
      align-items: flex-start;
      gap: 15px;
    }
  }
  /* Sidebar Styles */
  .sidebar {
    width: 250px;
    background-color: var(--white);
    color: var(--text-color);
    height: 100vh;
    position: fixed;
    left: 0;
    top: 0;
    overflow-y: auto;
    transition: all 0.3s;
    z-index: 1000;
    box-shadow: var(--shadow-md);
    scrollbar-width: none;
    -ms-overflow-style: none;
  }

  .sidebar::-webkit-scrollbar {
    display: none;
  }

  .sidebar-header {
    padding: 20px;
    text-align: center;
    border-bottom: 1px solid var(--gray-light);
    background-color: var(--white);
    color: var(--text-color);
  }

  .sidebar-logo {
    display: flex;
    align-items: center;
    justify-content: center;
    gap: 10px;
    margin-bottom: 10px;
  }

  .sidebar-logo img {
    width: 40px;
    height: 40px;
  }

  .sidebar-logo-text {
    font-size: 1.5rem;
    font-weight: 600;
    color: var(--primary-color);
  }

  .user-info {
    font-size: 0.9rem;
    margin-top: 10px;
    padding-top: 10px;
    border-top: 1px solid var(--gray-light);
  }

  .user-role {
    display: inline-block;
    background-color: var(--light-color);
    color: var (--primary-color);
    padding: 4px 10px;
    border-radius: 4px;
    font-size: 0.75rem;
    font-weight: 500;
    margin-top: 5px;
  }

  .sidebar-menu {
    padding: 20px 0;
  }

  .menu-item {
    padding: 12px 20px;
    display: flex;
    align-items: center;
    gap: 12px;
    color: var(--text-color);
    text-decoration: none;
    transition: all 0.3s;
    border-radius: 0;
  }

  .menu-item:hover {
    background-color: var(--light-color);
    color: var (--primary-color);
  }

  .menu-item.active {
    background-color: var(--light-color);
    color: var(--primary-color);
    font-weight: 500;
    border-left: 4px solid var(--primary-color);
  }

  .menu-item i {
    font-size: 1.2rem;
  }

  .menu-divider {
    height: 1px;
    background-color: var(--gray-light);
    margin: 10px 20px;
  }

  /* Responsive Sidebar */
  @media (max-width: 768px) {
    .sidebar {
      width: 0;
      transform: translateX(-100%);
    }

    .sidebar.active {
      width: 250px;
      transform: translateX(0);
    }

    .sidebar-toggle {
      display: block;
    }
  }
</style>

<!-- Sidebar -->
<div class="sidebar">
  <div class="sidebar-header">
    <div class="sidebar-logo">
      <img
        src="${pageContext.request.contextPath}/assets/images/nest-logo.png"
        alt="The Nest Logo"
      />
      <span class="sidebar-logo-text">The Nest</span>
    </div>
    <div class="user-info">
      Welcome,
      <strong>${sessionScope.currentUser.firstName}</strong>
      <div class="user-role">${sessionScope.currentUser.role}</div>
    </div>
  </div>
  <!-- Updated Sidebar Menu -->
  <div class="sidebar-menu">
    <%-- Dashboard Link --%>
    <c:choose>
      <c:when test="${sessionScope.currentUser.role eq 'admin'}">
        <a
          href="${pageContext.request.contextPath}/admin/dashboard"
          class="menu-item ${fn:contains(pageContext.request.servletPath, '/admin/dashboard') ? 'active' : ''}"
        >
          <i class="bi bi-speedometer2"></i>
          <span>Dashboard</span>
        </a>
      </c:when>
      <c:otherwise>
        <a
          href="${pageContext.request.contextPath}/staff/dashboard"
          class="menu-item ${fn:contains(pageContext.request.servletPath, '/staff/dashboard') ? 'active' : ''}"
        >
          <i class="bi bi-speedometer2"></i>
          <span>Dashboard</span>
        </a>
      </c:otherwise>
    </c:choose>

    <!-- Inventory Management Section -->
    <div class="menu-divider"></div>
    <a
      href="${pageContext.request.contextPath}/import"
      class="menu-item ${fn:contains(pageContext.request.servletPath, '/import') ? 'active' : ''}"
    >
      <i class="bi bi-box"></i>
      <span>Import</span>
    </a>
    <a
      href="${pageContext.request.contextPath}/low-stock"
      class="menu-item ${fn:contains(pageContext.request.servletPath, '/low-stock') ? 'active' : ''}"
    >
      <i class="bi bi-exclamation-triangle"></i>
      <span>Low Stock</span>
    </a>

    <c:if test="${sessionScope.currentUser.role eq 'admin'}">
      <a
        href="${pageContext.request.contextPath}/stock-movement"
        class="menu-item ${fn:contains(pageContext.request.servletPath, '/stock-movement') ? 'active' : ''}"
      >
        <i class="bi bi-arrow-left-right"></i>
        <span>Stock Movement</span>
      </a>
      <a
        href="${pageContext.request.contextPath}/admin/stock-history"
        class="menu-item ${fn:contains(pageContext.request.servletPath, '/admin/stock-history') ? 'active' : ''}"
      >
        <i class="bi bi-clock-history"></i>
        <span>Stock History</span>
      </a>
    </c:if>

    <!-- Product Management Section -->
    <div class="menu-divider"></div>
    <a
      href="${pageContext.request.contextPath}/products"
      class="menu-item ${fn:contains(pageContext.request.servletPath, '/products') ? 'active' : ''}"
    >
      <i class="bi bi-boxes"></i>
      <span>Products</span>
    </a>
    <c:if test="${sessionScope.currentUser.role eq 'admin'}"
      ><a
        href="${pageContext.request.contextPath}/categories"
        class="menu-item ${fn:contains(pageContext.request.servletPath, '/categories') ? 'active' : ''}"
      >
        <i class="bi bi-tags"></i>
        <span>Categories</span>
      </a></c:if
    >

    <!-- Requests Section -->
    <div class="menu-divider"></div>
    <c:choose>
      <c:when test="${sessionScope.currentUser.role eq 'admin'}">
        <a
          href="${pageContext.request.contextPath}/admin/stock-requests"
          class="menu-item ${fn:contains(pageContext.request.servletPath, '/admin/stock-requests') ? 'active' : ''}"
        >
          <i class="bi bi-megaphone"></i>
          <span>Stock Requests</span>
        </a>
      </c:when>
      <c:otherwise>
        <%-- Staff --%>
        <a
          href="${pageContext.request.contextPath}/staff/my-requests"
          class="menu-item ${fn:contains(pageContext.request.servletPath, '/staff/my-requests') ? 'active' : ''}"
        >
          <i class="bi bi-list-check"></i>
          <span>My Requests</span>
        </a>
      </c:otherwise>
    </c:choose>

    <a
      href="${pageContext.request.contextPath}/request-history"
      class="menu-item ${fn:contains(pageContext.request.servletPath, '/request-history') ? 'active' : ''}"
    >
      <i class="bi bi-archive"></i>
      <span>Request History</span>
    </a>

    <c:if test="${sessionScope.currentUser.role eq 'admin'}">
      <a
        href="${pageContext.request.contextPath}/admin/dispatch-request"
        class="menu-item ${fn:contains(pageContext.request.servletPath, '/admin/dispatch-request') ? 'active' : ''}"
      >
        <i class="bi bi-truck"></i>
        <span>Dispatch Request</span>
      </a>

      <!-- System Management Section -->
      <div class="menu-divider"></div>
      <a
        href="${pageContext.request.contextPath}/users"
        class="menu-item ${fn:contains(pageContext.request.servletPath, '/users') ? 'active' : ''}"
      >
        <i class="bi bi-people"></i>
        <span>Users</span>
      </a>
      <a
        href="${pageContext.request.contextPath}/suppliers"
        class="menu-item ${fn:contains(pageContext.request.servletPath, '/suppliers') ? 'active' : ''}"
      >
        <i class="bi bi-truck"></i>
        <span>Suppliers</span>
      </a>
      <a
        href="${pageContext.request.contextPath}/admin/manual-stock-adjustment"
        class="menu-item ${fn:contains(pageContext.request.servletPath, '/admin/manual-stock-adjustment') ? 'active' : ''}"
      >
        <i class="bi bi-sliders"></i>
        <span>Manual Adjustments</span>
      </a>
    </c:if>

    <!-- User Section -->
    <div class="menu-divider"></div>
    <a
      href="${pageContext.request.contextPath}/profile"
      class="menu-item ${fn:contains(pageContext.request.servletPath, '/profile') ? 'active' : ''}"
    >
      <i class="bi bi-person"></i>
      <span>Profile</span>
    </a>
    <a
      href="${pageContext.request.contextPath}/Logout"
      class="menu-item"
      id="logoutLink"
    >
      <i class="bi bi-box-arrow-right"></i>
      <span>Logout</span>
    </a>
  </div>

  <!-- Include Logout Modal if you have one, ensure its script uses contextPath for logout URL -->
  <jsp:include page="LogoutModal.jsp" />

  <!-- Sidebar Toggle Button -->
  <button class="sidebar-toggle" id="sidebarToggle">
    <i class="bi bi-list"></i>
  </button>

  <!-- Sidebar Toggle Script -->
  <script>
    document.addEventListener("DOMContentLoaded", function () {
      // Add sidebar toggle button for mobile
      const mainContent = document.querySelector(".main-content");
      if (mainContent) {
        const toggleButton = document.createElement("button");
        toggleButton.className = "sidebar-toggle btn";
        toggleButton.innerHTML = '<i class="bi bi-list"></i>';
        toggleButton.style.display = "none";
        toggleButton.style.position = "fixed";
        toggleButton.style.top = "10px";
        toggleButton.style.left = "10px";
        toggleButton.style.zIndex = "1001";

        document.body.appendChild(toggleButton);

        // Toggle sidebar on button click
        toggleButton.addEventListener("click", function () {
          const sidebar = document.querySelector(".sidebar");
          sidebar.classList.toggle("active");
        });

        // Show/hide toggle button based on screen size
        function handleResize() {
          if (window.innerWidth <= 768) {
            toggleButton.style.display = "flex";
          } else {
            toggleButton.style.display = "none";
            // Ensure sidebar is visible on larger screens
            const sidebar = document.querySelector(".sidebar");
            sidebar.classList.remove("active");
          }
        }

        // Initial check
        handleResize();

        // Listen for window resize
        window.addEventListener("resize", handleResize);
      }
    });
  </script>

  <!-- Include Chart.js -->
  <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
</div>