<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%> <%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Stock Movement Report - The Nest Inventory System</title>
    <link rel="preconnect" href="https://fonts.googleapis.com" />
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
    <link
      href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap"
      rel="stylesheet"
    />
    <link
      rel="stylesheet"
      href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css"
    />
    <link rel="stylesheet" href="<c:url value='/resources/css/main.css' />" />
    <link
      rel="stylesheet"
      href="<c:url value='/resources/css/StockMovement.css' />"
    />
  </head>
  <body>
    <!-- Include the sidebar -->
    <jsp:include page="components/Sidebar.jsp" />

    <!-- Main Content -->
    <div class="main-content">
      <div class="page-header">
        <h1 class="page-title">Stock Movement Report</h1>
        <div>
          <button class="btn btn-outline me-2" id="printReportBtn">
            <i class="bi bi-printer"></i> Print Report
          </button>
          <button class="btn btn-primary" id="exportReportBtn">
            <i class="bi bi-download"></i> Export Report
          </button>
        </div>
      </div>

      <!-- Stats Row -->
      <div class="stats-row">
        <div class="stat-card">
          <div class="stat-icon total-icon">
            <i class="bi bi-arrow-left-right"></i>
          </div>
          <div>
            <div class="stat-value">1,245</div>
            <div class="stat-label">Total Movements</div>
          </div>
        </div>
        <div class="stat-card">
          <div class="stat-icon in-icon">
            <i class="bi bi-box-arrow-in-down"></i>
          </div>
          <div>
            <div class="stat-value">782</div>
            <div class="stat-label">Stock In</div>
          </div>
        </div>
        <div class="stat-card">
          <div class="stat-icon out-icon">
            <i class="bi bi-box-arrow-up-right"></i>
          </div>
          <div>
            <div class="stat-value">463</div>
            <div class="stat-label">Stock Out</div>
          </div>
        </div>
        <div class="stat-card">
          <div class="stat-icon value-icon">
            <i class="bi bi-cash-stack"></i>
          </div>
          <div>
            <div class="stat-value">$45,320</div>
            <div class="stat-label">Total Value</div>
          </div>
        </div>
      </div>

      <!-- Filter Section -->
      <div class="filter-section">
        <div class="filter-row">
          <div class="filter-group">
            <label class="form-label">Date Range</label>
            <select class="form-control" id="dateRangeFilter">
              <option value="today">Today</option>
              <option value="yesterday">Yesterday</option>
              <option value="last7days">Last 7 Days</option>
              <option value="last30days" selected>Last 30 Days</option>
              <option value="thisMonth">This Month</option>
              <option value="lastMonth">Last Month</option>
              <option value="custom">Custom Range</option>
            </select>
          </div>
          <div class="filter-group">
            <label class="form-label">Category</label>
            <select class="form-control" id="categoryFilter">
              <option value="all" selected>All Categories</option>
              <option value="electronics">Electronics</option>
              <option value="furniture">Furniture</option>
              <option value="office-supplies">Office Supplies</option>
              <option value="kitchen">Kitchen Supplies</option>
              <option value="stationery">Stationery</option>
            </select>
          </div>
          <div class="filter-group">
            <label class="form-label">Movement Type</label>
            <select class="form-control" id="movementTypeFilter">
              <option value="all" selected>All Movements</option>
              <option value="in">Stock In</option>
              <option value="out">Stock Out</option>
              <option value="adjustment">Adjustments</option>
            </select>
          </div>
          <div class="filter-group">
            <label class="form-label">Sort By</label>
            <select class="form-control" id="sortByFilter">
              <option value="quantity-desc" selected>Highest Movement</option>
              <option value="quantity-asc">Lowest Movement</option>
              <option value="value-desc">Highest Value</option>
              <option value="recent">Most Recent</option>
            </select>
          </div>
        </div>
      </div>

      <!-- Custom Date Range (initially hidden) -->
      <div class="custom-date-range" id="customDateRange" style="display: none">
        <div class="filter-section">
          <div class="filter-row">
            <div class="filter-group">
              <label class="form-label">Start Date</label>
              <input type="date" class="form-control" id="startDate" />
            </div>
            <div class="filter-group">
              <label class="form-label">End Date</label>
              <input type="date" class="form-control" id="endDate" />
            </div>
            <div
              class="filter-group"
              style="flex: 0 0 auto; align-self: flex-end"
            >
              <button class="btn btn-primary" id="applyDateRange">Apply</button>
            </div>
          </div>
        </div>
      </div>

      <!-- Charts Row -->
      <div class="charts-row">
        <div class="chart-card large-chart">
          <div class="chart-card-header">
            <h3 class="chart-title">Stock Movement Trends</h3>
            <div class="chart-actions">
              <button class="btn btn-sm btn-outline me-2" id="viewDailyBtn">
                Daily
              </button>
              <button class="btn btn-sm btn-outline me-2" id="viewWeeklyBtn">
                Weekly
              </button>
              <button class="btn btn-sm btn-primary" id="viewMonthlyBtn">
                Monthly
              </button>
            </div>
          </div>
          <div class="chart-card-body">
            <div class="chart-container">
              <canvas id="stockMovementChart"></canvas>
            </div>
          </div>
        </div>
        <div class="chart-card small-chart">
          <div class="chart-card-header">
            <h3 class="chart-title">Movement by Category</h3>
          </div>
          <div class="chart-card-body">
            <div class="chart-container">
              <canvas id="categoryChart"></canvas>
            </div>
            <div class="category-distribution">
              <div class="distribution-item">
                <div class="distribution-label">Electronics</div>
                <div class="distribution-value">42%</div>
                <div class="distribution-bar">
                  <div
                    class="distribution-progress"
                    style="width: 42%; background-color: var(--primary-color)"
                  ></div>
                </div>
              </div>
              <div class="distribution-item">
                <div class="distribution-label">Furniture</div>
                <div class="distribution-value">28%</div>
                <div class="distribution-bar">
                  <div
                    class="distribution-progress"
                    style="width: 28%; background-color: var(--secondary-color)"
                  ></div>
                </div>
              </div>
              <div class="distribution-item">
                <div class="distribution-label">Office Supplies</div>
                <div class="distribution-value">15%</div>
                <div class="distribution-bar">
                  <div
                    class="distribution-progress"
                    style="width: 15%; background-color: #2e7d32"
                  ></div>
                </div>
              </div>
              <div class="distribution-item">
                <div class="distribution-label">Kitchen</div>
                <div class="distribution-value">10%</div>
                <div class="distribution-bar">
                  <div
                    class="distribution-progress"
                    style="width: 10%; background-color: #4caf50"
                  ></div>
                </div>
              </div>
              <div class="distribution-item">
                <div class="distribution-label">Stationery</div>
                <div class="distribution-value">5%</div>
                <div class="distribution-bar">
                  <div
                    class="distribution-progress"
                    style="width: 5%; background-color: var(--gray-dark)"
                  ></div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>

      <!-- Top Moving Products -->
      <div class="card">
        <div class="card-header">
          <h3 class="card-title">Top Moving Products</h3>
          <div>
            <button class="btn btn-sm btn-outline" id="viewAllProductsBtn">
              View All Products
            </button>
          </div>
        </div>
        <div class="card-body">
          <div class="table-container">
            <table class="data-table">
              <thead>
                <tr>
                  <th>Item</th>
                  <th>Category</th>
                  <th>Total Movement</th>
                  <th>Stock In</th>
                  <th>Stock Out</th>
                  <th>Current Stock</th>
                  <th>Movement Trend</th>
                  <th>Actions</th>
                </tr>
              </thead>
              <tbody>
                <tr>
                  <td>
                    <div class="product-info">
                      <div class="product-icon">
                        <i class="bi bi-laptop"></i>
                      </div>
                      <div>
                        <div class="product-name">Laptop - Dell XPS 13</div>
                        <div class="product-sku">SKU: TECH-001</div>
                      </div>
                    </div>
                  </td>
                  <td>Electronics</td>
                  <td>125</td>
                  <td>75</td>
                  <td>50</td>
                  <td>25</td>
                  <td>
                    <div class="trend-indicator trend-up">
                      <i class="bi bi-arrow-up-right"></i> 15%
                    </div>
                  </td>
                  <td>
                    <button
                      class="btn btn-sm btn-outline view-details"
                      data-id="1"
                    >
                      <i class="bi bi-eye"></i> Details
                    </button>
                  </td>
                </tr>
                <tr>
                  <td>
                    <div class="product-info">
                      <div class="product-icon">
                        <i class="bi bi-display"></i>
                      </div>
                      <div>
                        <div class="product-name">Monitor - 27" 4K</div>
                        <div class="product-sku">SKU: TECH-002</div>
                      </div>
                    </div>
                  </td>
                  <td>Electronics</td>
                  <td>98</td>
                  <td>58</td>
                  <td>40</td>
                  <td>18</td>
                  <td>
                    <div class="trend-indicator trend-up">
                      <i class="bi bi-arrow-up-right"></i> 8%
                    </div>
                  </td>
                  <td>
                    <button
                      class="btn btn-sm btn-outline view-details"
                      data-id="2"
                    >
                      <i class="bi bi-eye"></i> Details
                    </button>
                  </td>
                </tr>
                <tr>
                  <td>
                    <div class="product-info">
                      <div class="product-icon">
                        <i class="bi bi-chair"></i>
                      </div>
                      <div>
                        <div class="product-name">Office Chair - Ergonomic</div>
                        <div class="product-sku">SKU: FURN-001</div>
                      </div>
                    </div>
                  </td>
                  <td>Furniture</td>
                  <td>85</td>
                  <td>45</td>
                  <td>40</td>
                  <td>5</td>
                  <td>
                    <div class="trend-indicator trend-down">
                      <i class="bi bi-arrow-down-right"></i> 5%
                    </div>
                  </td>
                  <td>
                    <button
                      class="btn btn-sm btn-outline view-details"
                      data-id="3"
                    >
                      <i class="bi bi-eye"></i> Details
                    </button>
                  </td>
                </tr>
                <tr>
                  <td>
                    <div class="product-info">
                      <div class="product-icon">
                        <i class="bi bi-mouse"></i>
                      </div>
                      <div>
                        <div class="product-name">Wireless Mouse</div>
                        <div class="product-sku">SKU: TECH-003</div>
                      </div>
                    </div>
                  </td>
                  <td>Electronics</td>
                  <td>72</td>
                  <td>42</td>
                  <td>30</td>
                  <td>12</td>
                  <td>
                    <div class="trend-indicator trend-stable">
                      <i class="bi bi-arrow-right"></i> 0%
                    </div>
                  </td>
                  <td>
                    <button
                      class="btn btn-sm btn-outline view-details"
                      data-id="4"
                    >
                      <i class="bi bi-eye"></i> Details
                    </button>
                  </td>
                </tr>
                <tr>
                  <td>
                    <div class="product-info">
                      <div class="product-icon">
                        <i class="bi bi-cup-hot"></i>
                      </div>
                      <div>
                        <div class="product-name">Coffee Maker</div>
                        <div class="product-sku">SKU: KITCH-001</div>
                      </div>
                    </div>
                  </td>
                  <td>Kitchen</td>
                  <td>65</td>
                  <td>35</td>
                  <td>30</td>
                  <td>5</td>
                  <td>
                    <div class="trend-indicator trend-up">
                      <i class="bi bi-arrow-up-right"></i> 12%
                    </div>
                  </td>
                  <td>
                    <button
                      class="btn btn-sm btn-outline view-details"
                      data-id="5"
                    >
                      <i class="bi bi-eye"></i> Details
                    </button>
                  </td>
                </tr>
              </tbody>
            </table>
          </div>
        </div>
      </div>

      <!-- Movement History -->
      <div class="card">
        <div class="card-header">
          <h3 class="card-title">Recent Movement History</h3>
          <div>
            <button class="btn btn-sm btn-outline" id="exportHistoryBtn">
              <i class="bi bi-download"></i> Export
            </button>
          </div>
        </div>
        <div class="card-body">
          <div class="table-container">
            <table class="data-table">
              <thead>
                <tr>
                  <th>Date & Time</th>
                  <th>Item</th>
                  <th>Movement Type</th>
                  <th>Quantity</th>
                  <th>Source/Destination</th>
                  <th>Reference</th>
                  <th>Handled By</th>
                </tr>
              </thead>
              <tbody>
                <tr>
                  <td>Today, 10:45 AM</td>
                  <td>Laptop - Dell XPS 13</td>
                  <td>
                    <span class="status-indicator status-increase">
                      <i class="bi bi-arrow-down"></i> Stock In
                    </span>
                  </td>
                  <td>+10</td>
                  <td>Supplier: Dell Inc.</td>
                  <td>PO-2023-0542</td>
                  <td>Admin User</td>
                </tr>
                <tr>
                  <td>Today, 09:30 AM</td>
                  <td>Office Chair - Ergonomic</td>
                  <td>
                    <span class="status-indicator status-decrease">
                      <i class="bi bi-arrow-up"></i> Stock Out
                    </span>
                  </td>
                  <td>-5</td>
                  <td>Department: Marketing</td>
                  <td>REQ-2023-0128</td>
                  <td>Stock Manager</td>
                </tr>
                <tr>
                  <td>Yesterday, 3:20 PM</td>
                  <td>Wireless Mouse</td>
                  <td>
                    <span class="status-indicator status-decrease">
                      <i class="bi bi-arrow-up"></i> Stock Out
                    </span>
                  </td>
                  <td>-8</td>
                  <td>Department: IT</td>
                  <td>REQ-2023-0127</td>
                  <td>Stock Manager</td>
                </tr>
                <tr>
                  <td>Yesterday, 11:15 AM</td>
                  <td>Monitor - 27" 4K</td>
                  <td>
                    <span class="status-indicator status-increase">
                      <i class="bi bi-arrow-down"></i> Stock In
                    </span>
                  </td>
                  <td>+15</td>
                  <td>Supplier: Tech Solutions</td>
                  <td>PO-2023-0541</td>
                  <td>Admin User</td>
                </tr>
                <tr>
                  <td>May 15, 2023, 2:45 PM</td>
                  <td>Coffee Maker</td>
                  <td>
                    <span class="status-indicator status-increase">
                      <i class="bi bi-arrow-down"></i> Stock In
                    </span>
                  </td>
                  <td>+5</td>
                  <td>Supplier: Kitchen Essentials</td>
                  <td>PO-2023-0540</td>
                  <td>Admin User</td>
                </tr>
              </tbody>
            </table>
          </div>
        </div>
      </div>
    </div>

    <!-- Product Details Modal -->
    <div class="modal-backdrop" id="modalBackdrop"></div>
    <div class="modal" id="productDetailsModal">
      <div class="modal-header">
        <h3 class="modal-title">Product Movement Details</h3>
        <button class="modal-close" id="closeModal">&times;</button>
      </div>
      <div class="modal-body">
        <div class="product-details-header">
          <h4>Laptop - Dell XPS 13</h4>
          <div class="product-meta">SKU: TECH-001 | Category: Electronics</div>
        </div>

        <div class="stats-row">
          <div class="stat-card">
            <div class="stat-value">125</div>
            <div class="stat-label">Total Movement</div>
          </div>
          <div class="stat-card">
            <div class="stat-value">25</div>
            <div class="stat-label">Current Stock</div>
          </div>
          <div class="stat-card">
            <div class="stat-value">$25,000</div>
            <div class="stat-label">Value</div>
          </div>
        </div>

        <div class="chart-container">
          <div class="chart-placeholder">
            <div class="chart-placeholder-content">
              <div class="chart-placeholder-title">Movement History Chart</div>
              <div class="chart-placeholder-text">
                This is a placeholder for a line chart showing movement history
              </div>
            </div>
          </div>
        </div>

        <h5>Movement History</h5>
        <div class="table-container">
          <table class="data-table">
            <thead>
              <tr>
                <th>Date</th>
                <th>Type</th>
                <th>Quantity</th>
                <th>Reference</th>
              </tr>
            </thead>
            <tbody>
              <tr>
                <td>Today, 10:45 AM</td>
                <td>
                  <span class="status-indicator status-increase">
                    <i class="bi bi-arrow-down"></i> Stock In
                  </span>
                </td>
                <td>+10</td>
                <td>PO-2023-0542</td>
              </tr>
              <tr>
                <td>May 12, 2023</td>
                <td>
                  <span class="status-indicator status-decrease">
                    <i class="bi bi-arrow-up"></i> Stock Out
                  </span>
                </td>
                <td>-5</td>
                <td>REQ-2023-0120</td>
              </tr>
              <tr>
                <td>May 5, 2023</td>
                <td>
                  <span class="status-indicator status-increase">
                    <i class="bi bi-arrow-down"></i> Stock In
                  </span>
                </td>
                <td>+20</td>
                <td>PO-2023-0535</td>
              </tr>
              <tr>
                <td>April 28, 2023</td>
                <td>
                  <span class="status-indicator status-decrease">
                    <i class="bi bi-arrow-up"></i> Stock Out
                  </span>
                </td>
                <td>-8</td>
                <td>REQ-2023-0115</td>
              </tr>
            </tbody>
          </table>
        </div>
      </div>
      <div class="modal-footer">
        <button class="btn btn-outline" id="closeModalBtn">Close</button>
        <button class="btn btn-primary" id="exportItemHistoryBtn">
          <i class="bi bi-download"></i> Export History
        </button>
      </div>
    </div>

    <!-- Chart.js Implementation -->
    <script>
      document.addEventListener("DOMContentLoaded", function () {
        // Define our limited color palette
        const colors = {
          primary: "#2e7d32", // Green
          secondary: "#4caf50", // Lighter green
          dark: "#1b5e20", // Dark green
          light: "#e8f5e9", // Very light green
          grayLight: "#f5f5f5", // Light grey
          grayMedium: "#e0e0e0", // Medium grey
          grayDark: "#757575", // Dark grey
          black: "#212121", // Near black
          white: "#ffffff", // White
        };

        // Stock Movement Trend Chart
        const stockMovementCtx = document
          .getElementById("stockMovementChart")
          .getContext("2d");
        const stockMovementChart = new Chart(stockMovementCtx, {
          type: "line",
          data: {
            labels: [
              "Jan",
              "Feb",
              "Mar",
              "Apr",
              "May",
              "Jun",
              "Jul",
              "Aug",
              "Sep",
              "Oct",
              "Nov",
              "Dec",
            ],
            datasets: [
              {
                label: "Stock In",
                data: [65, 72, 86, 81, 56, 55, 80, 75, 90, 85, 91, 100],
                borderColor: colors.primary,
                backgroundColor: colors.light,
                tension: 0.4,
                fill: false,
              },
              {
                label: "Stock Out",
                data: [28, 48, 40, 19, 36, 27, 40, 42, 56, 55, 70, 75],
                borderColor: colors.grayDark,
                backgroundColor: colors.grayLight,
                tension: 0.4,
                fill: false,
              },
            ],
          },
          options: {
            responsive: true,
            maintainAspectRatio: false,
            plugins: {
              legend: {
                position: "top",
                labels: {
                  color: colors.black,
                },
              },
              tooltip: {
                backgroundColor: colors.white,
                titleColor: colors.black,
                bodyColor: colors.black,
                borderColor: colors.grayMedium,
                borderWidth: 1,
                boxShadow: "0 4px 15px rgba(0, 0, 0, 0.08)",
              },
            },
            scales: {
              x: {
                grid: {
                  color: colors.grayLight,
                },
                ticks: {
                  color: colors.black,
                },
              },
              y: {
                beginAtZero: true,
                grid: {
                  color: colors.grayLight,
                },
                ticks: {
                  color: colors.black,
                },
              },
            },
          },
        });

        // Category Distribution Chart
        const categoryCtx = document
          .getElementById("categoryChart")
          .getContext("2d");
        const categoryChart = new Chart(categoryCtx, {
          type: "doughnut",
          data: {
            labels: [
              "Electronics",
              "Furniture",
              "Office Supplies",
              "Kitchen",
              "Stationery",
            ],
            datasets: [
              {
                data: [42, 28, 15, 10, 5],
                backgroundColor: [
                  colors.primary,
                  colors.secondary,
                  colors.dark,
                  colors.grayMedium,
                  colors.grayDark,
                ],
                borderColor: colors.white,
                borderWidth: 2,
              },
            ],
          },
          options: {
            responsive: true,
            maintainAspectRatio: false,
            plugins: {
              legend: {
                position: "bottom",
                labels: {
                  color: colors.black,
                  padding: 20,
                  font: {
                    size: 12,
                  },
                },
              },
              tooltip: {
                backgroundColor: colors.white,
                titleColor: colors.black,
                bodyColor: colors.black,
                borderColor: colors.grayMedium,
                borderWidth: 1,
              },
            },
            cutout: "65%",
          },
        });

        // Handle time period buttons for the trend chart
        document
          .getElementById("viewDailyBtn")
          .addEventListener("click", function () {
            updateTimeScale(this, "daily");
          });

        document
          .getElementById("viewWeeklyBtn")
          .addEventListener("click", function () {
            updateTimeScale(this, "weekly");
          });

        document
          .getElementById("viewMonthlyBtn")
          .addEventListener("click", function () {
            updateTimeScale(this, "monthly");
          });

        function updateTimeScale(button, period) {
          // Remove active class from all buttons
          document.querySelectorAll(".chart-actions .btn").forEach((btn) => {
            btn.classList.remove("btn-primary");
            btn.classList.add("btn-outline");
          });

          // Add active class to clicked button
          button.classList.remove("btn-outline");
          button.classList.add("btn-primary");

          // Update chart data based on selected period
          let labels, stockIn, stockOut;

          if (period === "daily") {
            labels = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"];
            stockIn = [12, 19, 15, 8, 22, 14, 10];
            stockOut = [8, 12, 10, 5, 15, 8, 6];
          } else if (period === "weekly") {
            labels = ["Week 1", "Week 2", "Week 3", "Week 4"];
            stockIn = [45, 52, 38, 65];
            stockOut = [30, 25, 28, 40];
          } else {
            labels = [
              "Jan",
              "Feb",
              "Mar",
              "Apr",
              "May",
              "Jun",
              "Jul",
              "Aug",
              "Sep",
              "Oct",
              "Nov",
              "Dec",
            ];
            stockIn = [65, 72, 86, 81, 56, 55, 80, 75, 90, 85, 91, 100];
            stockOut = [28, 48, 40, 19, 36, 27, 40, 42, 56, 55, 70, 75];
          }

          stockMovementChart.data.labels = labels;
          stockMovementChart.data.datasets[0].data = stockIn;
          stockMovementChart.data.datasets[1].data = stockOut;
          stockMovementChart.update();
        }

        // Product details modal chart
        document.querySelectorAll(".view-details").forEach((button) => {
          button.addEventListener("click", function () {
            document.getElementById("modalBackdrop").style.display = "block";
            document.getElementById("productDetailsModal").style.display =
              "block";

            // Initialize product details chart
            setTimeout(() => {
              const productChartCtx = document.createElement("canvas");
              productChartCtx.id = "productMovementChart";

              // Replace placeholder with canvas
              const chartPlaceholder = document.querySelector(
                "#productDetailsModal .chart-placeholder"
              );
              chartPlaceholder.innerHTML = "";
              chartPlaceholder.appendChild(productChartCtx);

              new Chart(productChartCtx, {
                type: "line",
                data: {
                  labels: ["Jan", "Feb", "Mar", "Apr", "May", "Jun"],
                  datasets: [
                    {
                      label: "Stock Level",
                      data: [25, 30, 22, 17, 29, 25],
                      borderColor: colors.primary,
                      backgroundColor: colors.light,
                      tension: 0.4,
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
                    x: {
                      grid: {
                        color: colors.grayLight,
                      },
                      ticks: {
                        color: colors.black,
                      },
                    },
                    y: {
                      beginAtZero: true,
                      grid: {
                        color: colors.grayLight,
                      },
                      ticks: {
                        color: colors.black,
                      },
                    },
                  },
                },
              });
            }, 100);
          });
        });

        // Close modal
        document
          .getElementById("closeModal")
          .addEventListener("click", function () {
            document.getElementById("modalBackdrop").style.display = "none";
            document.getElementById("productDetailsModal").style.display =
              "none";
          });

        // Close modal when clicking on backdrop
        document
          .getElementById("modalBackdrop")
          .addEventListener("click", function () {
            document.getElementById("modalBackdrop").style.display = "none";
            document.getElementById("productDetailsModal").style.display =
              "none";
          });

        // Close modal when clicking the footer close button
        document
          .getElementById("closeModalBtn")
          .addEventListener("click", function () {
            document.getElementById("modalBackdrop").style.display = "none";
            document.getElementById("productDetailsModal").style.display =
              "none";
          });
      });
    </script>
  </body>
</html>
