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
    <jsp:include page="../components/Sidebar.jsp" />

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
        // Initialize Charts
        const trendsCtx = document
          .getElementById("productTrendsChart")
          .getContext("2d");
        const distributionCtx = document
          .getElementById("productDistributionChart")
          .getContext("2d");

        // Product Trends Chart
        const trendsChart = new Chart(trendsCtx, {
          type: "line",
          data: {
            labels: ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"],
            datasets: [
              {
                label: "Product Movement",
                data: [30, 45, 60, 35, 25, 50, 40],
                borderColor: "#2e7d32",
                backgroundColor: "rgba(46, 125, 50, 0.1)",
                tension: 0.4,
              },
            ],
          },
          options: {
            responsive: true,
            maintainAspectRatio: false,
            plugins: {
              legend: {
                position: "top",
              },
            },
          },
        });

        // Product Distribution Chart
        const distributionChart = new Chart(distributionCtx, {
          type: "doughnut",
          data: {
            labels: ["Electronics", "Furniture", "Office Supplies"],
            datasets: [
              {
                data: [50, 30, 20],
                backgroundColor: ["#2e7d32", "#4caf50", "#8bc34a"],
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
          },
        });

        // Date Filter Functionality
        const dateRangeBtn = document.querySelector(".date-range-btn");
        const dateOptions = document.querySelectorAll(".date-option");

        dateOptions.forEach((option) => {
          option.addEventListener("click", (e) => {
            e.preventDefault();
            const selectedRange = e.target.textContent;
            dateRangeBtn.innerHTML = `<i class="bi bi-calendar3"></i> ${selectedRange} <i class="bi bi-chevron-down"></i>`;
            dateOptions.forEach((opt) => opt.classList.remove("active"));
            option.classList.add("active");
            // TODO: Add date range filter logic here
          });
        });

        // Share Button Functionality
        const shareBtn = document.querySelector(".btn-outline.me-2");
        shareBtn.addEventListener("click", async () => {
          try {
            await navigator.share({
              title: "Dashboard - The Nest Inventory System",
              text: "Check out our inventory dashboard",
              url: window.location.href,
            });
          } catch (err) {
            alert("Sharing is not supported on this browser");
          }
        });

        // Export Button Functionality
        const exportBtn = document.querySelector(".btn-primary");
        exportBtn.addEventListener("click", () => {
          if (confirm("Do you want to export the dashboard data?")) {
            exportBtn.classList.add("loading");

            setTimeout(() => {
              try {
                const tables = document.querySelectorAll(".data-table");
                let csvContent = "";

                tables.forEach((table) => {
                  const title = table
                    .closest(".table-card")
                    .querySelector(".table-title").textContent;
                  csvContent += title + "\n\n";

                  const headers = Array.from(table.querySelectorAll("th"))
                    .map((th) => th.textContent)
                    .join(",");
                  csvContent += headers + "\n";

                  const rows = table.querySelectorAll("tbody tr");
                  rows.forEach((row) => {
                    const cells = Array.from(row.querySelectorAll("td"))
                      .map((td) => td.textContent.trim())
                      .join(",");
                    csvContent += cells + "\n";
                  });

                  csvContent += "\n\n";
                });

                const blob = new Blob([csvContent], { type: "text/csv" });
                const url = window.URL.createObjectURL(blob);
                const a = document.createElement("a");
                a.setAttribute("href", url);
                a.setAttribute("download", "dashboard-report.csv");
                a.click();
                window.URL.revokeObjectURL(url);
                alert("Export completed successfully!");
              } catch (error) {
                alert("Failed to export data. Please try again.");
                console.error("Export error:", error);
              } finally {
                exportBtn.classList.remove("loading");
              }
            }, 1000);
          }
        });

        // Stock Availability Actions
        document.querySelectorAll(".action-buttons a").forEach((button) => {
          button.addEventListener("click", (e) => {
            e.preventDefault();
            const action = button.classList.contains("view-item")
              ? "view"
              : button.classList.contains("edit-item")
              ? "edit"
              : "delete";
            const productId = button.getAttribute("data-id");
            const productName = button
              .closest("tr")
              .querySelector("td").textContent;

            switch (action) {
              case "view":
                alert(`Viewing details for ${productName}`);
                // TODO: Implement view functionality
                break;
              case "edit":
                if (confirm(`Do you want to edit ${productName}?`)) {
                  // TODO: Implement edit functionality
                  alert("Edit functionality will be implemented soon");
                }
                break;
              case "delete":
                if (
                  confirm(`Are you sure you want to delete ${productName}?`)
                ) {
                  button.closest("tr").remove();
                  alert(`${productName} has been deleted`);
                }
                break;
            }
          });
        });

        // Chart View Controls
        const chartControls = document.querySelectorAll(
          ".chart-controls button"
        );
        chartControls.forEach((control) => {
          control.addEventListener("click", (e) => {
            const parent = control.closest(".chart-controls");
            parent
              .querySelectorAll("button")
              .forEach((btn) => btn.classList.remove("active"));
            control.classList.add("active");

            const view = control.getAttribute("data-chart-view");
            const chartId = control
              .closest(".chart-card")
              .querySelector("canvas").id;

            if (chartId === "productTrendsChart") {
              updateTrendsChart(view);
            } else if (chartId === "productDistributionChart") {
              updateDistributionChart(view);
            }
          });
        });

        // Chart update functions
        function updateTrendsChart(view) {
          let labels, data;
          switch (view) {
            case "daily":
              labels = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"];
              data = [30, 45, 60, 35, 25, 50, 40];
              break;
            case "weekly":
              labels = ["Week 1", "Week 2", "Week 3", "Week 4"];
              data = [150, 200, 175, 225];
              break;
            case "monthly":
              labels = ["Jan", "Feb", "Mar", "Apr", "May", "Jun"];
              data = [500, 600, 750, 800, 900, 1000];
              break;
          }

          trendsChart.data.labels = labels;
          trendsChart.data.datasets[0].data = data;
          trendsChart.update();
        }

        function updateDistributionChart(view) {
          let labels, data, colors;
          switch (view) {
            case "category":
              labels = ["Electronics", "Furniture", "Office Supplies"];
              data = [50, 30, 20];
              colors = ["#2e7d32", "#4caf50", "#8bc34a"];
              break;
            case "status":
              labels = ["In Stock", "Low Stock", "Out of Stock"];
              data = [70, 20, 10];
              colors = ["#4caf50", "#ff9800", "#f44336"];
              break;
          }

          distributionChart.data.labels = labels;
          distributionChart.data.datasets[0].data = data;
          distributionChart.data.datasets[0].backgroundColor = colors;
          distributionChart.update();
        }
      });
    </script>
  </body>
</html>
