<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Dashboard - The Nest Inventory System</title>
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
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <link
      rel="stylesheet"
      href="${pageContext.request.contextPath}/resources/css/Dashboard.css"
    />
  </head>
  <body>
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
          Welcome, <strong>Admin User</strong>
          <div class="user-role">Administrator</div>
        </div>
      </div>
      <div class="sidebar-menu">
        <a
          href="${pageContext.request.contextPath}/dashboard"
          class="menu-item active"
        >
          <i class="bi bi-speedometer2"></i>
          <span>Dashboard</span>
        </a>
        <a
          href="${pageContext.request.contextPath}/inventory"
          class="menu-item"
        >
          <i class="bi bi-box-seam"></i>
          <span>Inventory</span>
        </a>
        <a
          href="${pageContext.request.contextPath}/manual-stock-adjustment"
          class="menu-item"
        >
          <i class="bi bi-sliders"></i>
          <span>Stock Adjustment</span>
        </a>
        <a
          href="${pageContext.request.contextPath}/stock-requests"
          class="menu-item"
        >
          <i class="bi bi-list-check"></i>
          <span>Stock Requests</span>
        </a>
        <a
          href="${pageContext.request.contextPath}/suppliers"
          class="menu-item"
        >
          <i class="bi bi-truck"></i>
          <span>Suppliers</span>
        </a>
        <a href="${pageContext.request.contextPath}/users" class="menu-item">
          <i class="bi bi-people"></i>
          <span>Users</span>
        </a>
        <a href="${pageContext.request.contextPath}/reports" class="menu-item">
          <i class="bi bi-graph-up"></i>
          <span>Reports</span>
        </a>
        <div class="menu-divider"></div>
        <a href="${pageContext.request.contextPath}/settings" class="menu-item">
          <i class="bi bi-gear"></i>
          <span>Settings</span>
        </a>
        <a href="${pageContext.request.contextPath}/Logout" class="menu-item">
          <i class="bi bi-box-arrow-right"></i>
          <span>Logout</span>
        </a>
      </div>
    </div>

    <!-- Main Content -->
    <div class="main-content">
      <div class="page-header">
        <h1 class="page-title">Dashboard</h1>
        <div class="header-actions">
          <div class="date-filter">
            <button class="btn btn-outline date-range-btn">
              <i class="bi bi-calendar3"></i> This Week
              <i class="bi bi-chevron-down"></i>
            </button>
            <div class="date-dropdown">
              <a href="#" class="date-option active">This Week</a>
              <a href="#" class="date-option">Last Week</a>
              <a href="#" class="date-option">This Month</a>
              <a href="#" class="date-option">Custom Range</a>
            </div>
          </div>
          <button class="btn btn-outline me-2">
            <i class="bi bi-share"></i> Share
          </button>
          <button class="btn btn-primary">
            <i class="bi bi-download"></i> Export
          </button>
        </div>
      </div>

      <!-- Stats Cards -->
      <div class="stats-row">
        <div class="stat-card">
          <div class="stat-icon total-products-icon">
            <i class="bi bi-box"></i>
          </div>
          <div class="stat-value">250</div>
          <div class="stat-label">Total Products</div>
        </div>
        <div class="stat-card">
          <div class="stat-icon stock-level-icon">
            <i class="bi bi-boxes"></i>
          </div>
          <div class="stat-value">1500</div>
          <div class="stat-label">Stock Level</div>
        </div>
        <div class="stat-card">
          <div class="stat-icon low-stock-icon">
            <i class="bi bi-exclamation-triangle"></i>
          </div>
          <div class="stat-value">20</div>
          <div class="stat-label">Low Stock Items</div>
        </div>
        <div class="stat-card">
          <div class="stat-icon recent-requests-icon">
            <i class="bi bi-envelope"></i>
          </div>
          <div class="stat-value">8</div>
          <div class="stat-label">Recent Requests</div>
        </div>
      </div>

      <!-- Charts Section -->
      <div class="charts-row">
        <div class="chart-card">
          <div class="chart-header">
            <h3 class="chart-title">Product Trends</h3>
            <div class="chart-controls">
              <button
                class="btn btn-sm btn-outline active"
                data-chart-view="daily"
              >
                Daily
              </button>
              <button class="btn btn-sm btn-outline" data-chart-view="weekly">
                Weekly
              </button>
              <button class="btn btn-sm btn-outline" data-chart-view="monthly">
                Monthly
              </button>
            </div>
          </div>
          <div class="chart-body">
            <div class="chart-container">
              <canvas id="productTrendsChart"></canvas>
            </div>
          </div>
        </div>
        <div class="chart-card">
          <div class="chart-header">
            <h3 class="chart-title">Product Distribution</h3>
            <div class="chart-controls">
              <button
                class="btn btn-sm btn-outline active"
                data-chart-view="category"
              >
                By Category
              </button>
              <button class="btn btn-sm btn-outline" data-chart-view="status">
                By Status
              </button>
            </div>
          </div>
          <div class="chart-body">
            <div class="chart-container">
              <canvas id="productDistributionChart"></canvas>
            </div>
          </div>
        </div>
      </div>

      <!-- Tables Section -->
      <div class="tables-row">
        <div class="table-card">
          <div class="table-header">
            <h3 class="table-title">My Recent Requests</h3>
            <a
              href="${pageContext.request.contextPath}/stock-requests"
              class="btn btn-sm btn-outline"
            >
              View All
            </a>
          </div>
          <div class="table-responsive">
            <table class="data-table">
              <thead>
                <tr>
                  <th>Product</th>
                  <th>Quantity</th>
                  <th>Date</th>
                  <th>Status</th>
                </tr>
              </thead>
              <tbody>
                <tr>
                  <td>Wireless Mouse</td>
                  <td>50</td>
                  <td>2023-05-18</td>
                  <td><span class="badge badge-pending">Pending</span></td>
                </tr>
                <tr>
                  <td>Office Chair</td>
                  <td>30</td>
                  <td>2023-05-19</td>
                  <td><span class="badge badge-approved">Approved</span></td>
                </tr>
                <tr>
                  <td>HDMI Cable</td>
                  <td>100</td>
                  <td>2023-05-20</td>
                  <td><span class="badge badge-completed">Completed</span></td>
                </tr>
              </tbody>
            </table>
          </div>
        </div>
        <div class="table-card">
          <div class="table-header">
            <h3 class="table-title">Stock Availability</h3>
            <a
              href="${pageContext.request.contextPath}/inventory"
              class="btn btn-sm btn-outline"
            >
              View All
            </a>
          </div>
          <div class="table-responsive">
            <table class="data-table">
              <thead>
                <tr>
                  <th>Product</th>
                  <th>Category</th>
                  <th>Stock</th>
                  <th>Actions</th>
                </tr>
              </thead>
              <tbody>
                <tr>
                  <td>Wireless Mouse</td>
                  <td>Electronics</td>
                  <td>500</td>
                  <td class="action-buttons">
                    <a href="#" class="view-item" data-id="1">
                      <i class="bi bi-eye"></i>
                    </a>
                    <a href="#" class="edit-item" data-id="1">
                      <i class="bi bi-pencil"></i>
                    </a>
                    <a href="#" class="delete-item" data-id="1">
                      <i class="bi bi-trash"></i>
                    </a>
                  </td>
                </tr>
                <tr>
                  <td>Office Chair</td>
                  <td>Furniture</td>
                  <td>300</td>
                  <td class="action-buttons">
                    <a href="#" class="view-item" data-id="2">
                      <i class="bi bi-eye"></i>
                    </a>
                    <a href="#" class="edit-item" data-id="2">
                      <i class="bi bi-pencil"></i>
                    </a>
                    <a href="#" class="delete-item" data-id="2">
                      <i class="bi bi-trash"></i>
                    </a>
                  </td>
                </tr>
                <tr>
                  <td>HDMI Cable</td>
                  <td>Electronics</td>
                  <td>200</td>
                  <td class="action-buttons">
                    <a href="#" class="view-item" data-id="3">
                      <i class="bi bi-eye"></i>
                    </a>
                    <a href="#" class="edit-item" data-id="3">
                      <i class="bi bi-pencil"></i>
                    </a>
                    <a href="#" class="delete-item" data-id="3">
                      <i class="bi bi-trash"></i>
                    </a>
                  </td>
                </tr>
              </tbody>
            </table>
          </div>
        </div>
      </div>
    </div>

    <script>
      document.addEventListener("DOMContentLoaded", function () {
        // Product Trends Chart
        const trendsCtx = document
          .getElementById("productTrendsChart")
          .getContext("2d");
        const trendsChart = new Chart(trendsCtx, {
          type: "line",
          data: {
            labels: ["January", "February", "March", "April", "May", "June"],
            datasets: [
              {
                label: "Products Sold",
                data: [50, 75, 100, 120, 150, 200],
                borderColor: "#2e7d32",
                backgroundColor: "rgba(46, 125, 50, 0.1)",
                borderWidth: 2,
                tension: 0.3,
                fill: true,
              },
            ],
          },
          options: {
            responsive: true,
            maintainAspectRatio: false,
            plugins: {
              legend: {
                display: false,
              },
            },
            scales: {
              y: {
                beginAtZero: true,
                grid: {
                  color: "rgba(0, 0, 0, 0.05)",
                },
              },
              x: {
                grid: {
                  display: false,
                },
              },
            },
          },
        });

        // Product Distribution Chart
        const distributionCtx = document
          .getElementById("productDistributionChart")
          .getContext("2d");
        const distributionChart = new Chart(distributionCtx, {
          type: "doughnut",
          data: {
            labels: ["Electronics", "Furniture", "Office Supplies"],
            datasets: [
              {
                data: [50, 30, 20],
                backgroundColor: ["#2e7d32", "#4caf50", "#8bc34a"],
                borderWidth: 0,
              },
            ],
          },
          options: {
            responsive: true,
            maintainAspectRatio: false,
            plugins: {
              legend: {
                position: "bottom",
              },
            },
            cutout: "70%",
          },
        });
      });
    </script>
  </body>
</html>
