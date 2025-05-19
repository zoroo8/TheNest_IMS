<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%
    String role = (String) session.getAttribute("role");
    if (role == null || !role.equals("admin")) {
        response.sendRedirect("Error");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Stock History - The Nest Inventory System</title>
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
      type="text/css"
      href="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.css"
    />
    <link
      rel="stylesheet"
      href="${pageContext.request.contextPath}/resources/css/Dashboard.css"
    />
    <link
      rel="stylesheet"
      href="${pageContext.request.contextPath}/resources/css/StockRequests.css"
    />
    <link
      rel="stylesheet"
      href="${pageContext.request.contextPath}/resources/css/StockHistory.css"
    />
  </head>
  <body>
    <jsp:include page="../components/Sidebar.jsp" />

    <!-- Main Content -->
    <div class="main-content">
      <div class="page-header">
        <h1 class="page-title">Stock History</h1>
        <div class="export-buttons">
          <button class="btn btn-outline" id="exportCSV">
            <i class="bi bi-file-earmark-spreadsheet"></i> Export CSV
          </button>
          <button class="btn btn-outline" id="exportPDF">
            <i class="bi bi-file-earmark-pdf"></i> Export PDF
          </button>
          <button class="btn btn-outline" id="printReport">
            <i class="bi bi-printer"></i> Print
          </button>
        </div>
      </div>

      <!-- Stats Cards -->
      <div class="stats-row">
        <div class="stat-card">
          <div class="stat-icon stock-in-icon">
            <i class="bi bi-arrow-down-circle"></i>
          </div>
          <div class="stat-value">125</div>
          <div class="stat-label">Stock In</div>
        </div>
        <div class="stat-card">
          <div class="stat-icon stock-out-icon">
            <i class="bi bi-arrow-up-circle"></i>
          </div>
          <div class="stat-value">98</div>
          <div class="stat-label">Stock Out</div>
        </div>
        <div class="stat-card">
          <div class="stat-icon total-icon">
            <i class="bi bi-clock-history"></i>
          </div>
          <div class="stat-value">223</div>
          <div class="stat-label">Total Transactions</div>
        </div>
      </div>

      <!-- Filter Section -->
      <div class="filter-section">
        <div class="filter-row">
          <div class="filter-group">
            <label for="dateRange">Date Range</label>
            <input
              type="text"
              class="form-control"
              id="dateRange"
              value="05/01/2023 - 05/25/2023"
            />
          </div>
          <div class="filter-group">
            <label for="productFilter">Product</label>
            <select class="form-control" id="productFilter">
              <option value="">All Products</option>
              <option value="1">Laptop Charger</option>
              <option value="2">Wireless Mouse</option>
              <option value="3">HDMI Cable</option>
              <option value="4">Office Chair</option>
              <option value="5">Desk Lamp</option>
            </select>
          </div>
          <div class="filter-group">
            <label for="categoryFilter">Category</label>
            <select class="form-control" id="categoryFilter">
              <option value="">All Categories</option>
              <option value="electronics">Electronics</option>
              <option value="office">Office Supplies</option>
              <option value="furniture">Furniture</option>
              <option value="it">IT Equipment</option>
            </select>
          </div>
          <div class="filter-group">
            <label for="transactionType">Transaction Type</label>
            <select class="form-control" id="transactionType">
              <option value="">All Types</option>
              <option value="IN">Stock In</option>
              <option value="OUT">Stock Out</option>
            </select>
          </div>
        </div>
        <div class="filter-row">
          <div class="filter-group">
            <label for="userFilter">User</label>
            <select class="form-control" id="userFilter">
              <option value="">All Users</option>
              <option value="1">Admin</option>
              <option value="2">John Smith</option>
              <option value="3">Emma Johnson</option>
            </select>
          </div>
          <div class="filter-group">
            <div class="input-group">
              <i class="bi bi-search input-icon"></i>
              <input
                type="text"
                class="form-control input-with-icon"
                placeholder="Search by ID, reference, notes..."
                id="searchInput"
              />
            </div>
          </div>
          <div
            class="filter-group"
            style="flex: 0 0 auto; align-self: flex-end"
          >
            <button class="btn btn-outline" id="resetFilters">Reset</button>
            <button class="btn btn-primary" id="applyFilters">
              Apply Filters
            </button>
          </div>
        </div>
      </div>

      <!-- Stock Movement Chart -->
      <div class="chart-card">
        <div class="chart-header">
          <h3 class="chart-title">Stock Movement Overview</h3>
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
            <canvas id="stockMovementChart"></canvas>
          </div>
        </div>
      </div>

      <!-- Transaction History Table -->
      <div class="table-card">
        <div class="table-header">
          <h3 class="table-title">Transaction History</h3>
          <div class="table-badges">
            <span class="badge badge-in">Stock In: 125</span>
            <span class="badge badge-out">Stock Out: 98</span>
            <span class="badge badge-total">Total: 223</span>
          </div>
        </div>
        <div class="table-responsive">
          <table class="data-table">
            <thead>
              <tr>
                <th>ID</th>
                <th>Date & Time</th>
                <th>Product</th>
                <th>Type</th>
                <th>Quantity</th>
                <th>Previous Stock</th>
                <th>New Stock</th>
                <th>Reference</th>
                <th>User</th>
                <th>Actions</th>
              </tr>
            </thead>
            <tbody>
              <tr>
                <td>TRX-2023-223</td>
                <td>2023-05-25 14:30</td>
                <td>Laptop Charger</td>
                <td><span class="badge badge-out">OUT</span></td>
                <td>20</td>
                <td>115</td>
                <td>95</td>
                <td>SO-2023-125</td>
                <td>Admin</td>
                <td class="action-buttons">
                  <a href="#" class="view-transaction" data-id="223">
                    <i class="bi bi-eye"></i>
                  </a>
                  <a href="#" class="edit-transaction" data-id="223">
                    <i class="bi bi-pencil"></i>
                  </a>
                </td>
              </tr>
              <tr>
                <td>TRX-2023-222</td>
                <td>2023-05-24 16:45</td>
                <td>Desk Lamp</td>
                <td><span class="badge badge-out">OUT</span></td>
                <td>15</td>
                <td>85</td>
                <td>70</td>
                <td>SO-2023-124</td>
                <td>Admin</td>
                <td class="action-buttons">
                  <a href="#" class="view-transaction" data-id="222">
                    <i class="bi bi-eye"></i>
                  </a>
                  <a href="#" class="edit-transaction" data-id="222">
                    <i class="bi bi-pencil"></i>
                  </a>
                </td>
              </tr>
              <tr>
                <td>TRX-2023-221</td>
                <td>2023-05-24 10:15</td>
                <td>Wireless Mouse</td>
                <td><span class="badge badge-out">OUT</span></td>
                <td>10</td>
                <td>55</td>
                <td>45</td>
                <td>SO-2023-123</td>
                <td>John Smith</td>
                <td class="action-buttons">
                  <a href="#" class="view-transaction" data-id="221">
                    <i class="bi bi-eye"></i>
                  </a>
                  <a href="#" class="edit-transaction" data-id="221">
                    <i class="bi bi-pencil"></i>
                  </a>
                </td>
              </tr>
              <tr>
                <td>TRX-2023-220</td>
                <td>2023-05-23 09:30</td>
                <td>Laptop Charger</td>
                <td><span class="badge badge-in">IN</span></td>
                <td>50</td>
                <td>65</td>
                <td>115</td>
                <td>SI-2023-089</td>
                <td>Emma Johnson</td>
                <td class="action-buttons">
                  <a href="#" class="view-transaction" data-id="220">
                    <i class="bi bi-eye"></i>
                  </a>
                  <a href="#" class="edit-transaction" data-id="220">
                    <i class="bi bi-pencil"></i>
                  </a>
                </td>
              </tr>
              <tr>
                <td>TRX-2023-219</td>
                <td>2023-05-22 14:20</td>
                <td>HDMI Cable</td>
                <td><span class="badge badge-out">OUT</span></td>
                <td>8</td>
                <td>68</td>
                <td>60</td>
                <td>SO-2023-122</td>
                <td>John Smith</td>
                <td class="action-buttons">
                  <a href="#" class="view-transaction" data-id="219">
                    <i class="bi bi-eye"></i>
                  </a>
                  <a href="#" class="edit-transaction" data-id="219">
                    <i class="bi bi-pencil"></i>
                  </a>
                </td>
              </tr>
              <tr>
                <td>TRX-2023-218</td>
                <td>2023-05-22 11:10</td>
                <td>Office Chair</td>
                <td><span class="badge badge-in">IN</span></td>
                <td>15</td>
                <td>10</td>
                <td>25</td>
                <td>SI-2023-088</td>
                <td>Emma Johnson</td>
                <td class="action-buttons">
                  <a href="#" class="view-transaction" data-id="218">
                    <i class="bi bi-eye"></i>
                  </a>
                  <a href="#" class="edit-transaction" data-id="218">
                    <i class="bi bi-pencil"></i>
                  </a>
                </td>
              </tr>
            </tbody>
          </table>
        </div>
        <div class="table-footer">
          <div class="pagination">
            <a href="#" class="page-link">&laquo;</a>
            <a href="#" class="page-link active">1</a>
            <a href="#" class="page-link">2</a>
            <a href="#" class="page-link">3</a>
            <a href="#" class="page-link">4</a>
            <a href="#" class="page-link">5</a>
            <a href="#" class="page-link">&raquo;</a>
          </div>
          <div class="page-info">Showing 1 to 6 of 223 entries</div>
        </div>
      </div>
    </div>

    <!-- Modal Backdrop -->
    <div class="modal-backdrop" id="modalBackdrop"></div>

    <!-- View Transaction Modal -->
    <div class="modal" id="viewTransactionModal">
      <div class="modal-header">
        <h3 class="modal-title">Transaction Details</h3>
        <button class="modal-close" id="closeViewModal">&times;</button>
      </div>
      <div class="modal-body">
        <div class="transaction-details">
          <div class="detail-row">
            <div class="detail-label">Transaction ID:</div>
            <div class="detail-value" id="transactionId">TRX-2023-223</div>
          </div>
          <div class="detail-row">
            <div class="detail-label">Date & Time:</div>
            <div class="detail-value" id="transactionDate">
              2023-05-25 14:30
            </div>
          </div>
          <div class="detail-row">
            <div class="detail-label">Product:</div>
            <div class="detail-value" id="transactionProduct">
              Laptop Charger
            </div>
          </div>
          <div class="detail-row">
            <div class="detail-label">Category:</div>
            <div class="detail-value" id="transactionCategory">Electronics</div>
          </div>
          <div class="detail-row">
            <div class="detail-label">Transaction Type:</div>
            <div class="detail-value">
              <span class="badge badge-out" id="transactionType"
                >Stock Out</span
              >
            </div>
          </div>
          <div class="detail-row">
            <div class="detail-label">Quantity:</div>
            <div class="detail-value" id="transactionQuantity">20</div>
          </div>
          <div class="detail-row">
            <div class="detail-label">Previous Stock:</div>
            <div class="detail-value" id="previousStock">115</div>
          </div>
          <div class="detail-row">
            <div class="detail-label">New Stock:</div>
            <div class="detail-value" id="newStock">95</div>
          </div>
          <div class="detail-row">
            <div class="detail-label">Reference:</div>
            <div class="detail-value" id="transactionReference">
              SO-2023-125
            </div>
          </div>
          <div class="detail-row">
            <div class="detail-label">User:</div>
            <div class="detail-value" id="transactionUser">Admin</div>
          </div>
          <div class="detail-row">
            <div class="detail-label">Notes:</div>
            <div class="detail-value" id="transactionNotes">
              Regular stock out for department usage.
            </div>
          </div>
        </div>
      </div>
      <div class="modal-footer">
        <button class="btn btn-outline" id="closeViewModalBtn">Close</button>
        <button class="btn btn-primary" id="printTransactionBtn">
          <i class="bi bi-printer"></i> Print
        </button>
      </div>
    </div>

    <!-- Edit Transaction Modal -->
    <div class="modal" id="editTransactionModal">
      <div class="modal-header">
        <h3 class="modal-title">Edit Transaction</h3>
        <button class="modal-close" id="closeEditModal">&times;</button>
      </div>
      <div class="modal-body">
        <form id="editTransactionForm">
          <div class="form-group">
            <label for="editTransactionId">Transaction ID</label>
            <input
              type="text"
              class="form-control"
              id="editTransactionId"
              readonly
            />
          </div>

          <div class="row">
            <div class="col-md-6">
              <div class="form-group">
                <label for="editTransactionDate">Date & Time</label>
                <input
                  type="datetime-local"
                  class="form-control"
                  id="editTransactionDate"
                  required
                />
              </div>
            </div>
            <div class="col-md-6">
              <div class="form-group">
                <label for="editTransactionType">Transaction Type</label>
                <select class="form-control" id="editTransactionType" required>
                  <option value="IN">Stock In</option>
                  <option value="OUT">Stock Out</option>
                </select>
              </div>
            </div>
          </div>

          <div class="row">
            <div class="col-md-6">
              <div class="form-group">
                <label for="editProduct">Product</label>
                <select class="form-control" id="editProduct" required>
                  <option value="1">Laptop Charger</option>
                  <option value="2">Wireless Mouse</option>
                  <option value="3">HDMI Cable</option>
                  <option value="4">Office Chair</option>
                  <option value="5">Desk Lamp</option>
                </select>
              </div>
            </div>
            <div class="col-md-6">
              <div class="form-group">
                <label for="editQuantity">Quantity</label>
                <input
                  type="number"
                  class="form-control"
                  id="editQuantity"
                  min="1"
                  required
                />
              </div>
            </div>
          </div>

          <div class="form-group">
            <label for="editReference">Reference</label>
            <input
              type="text"
              class="form-control"
              id="editReference"
              required
            />
          </div>

          <div class="form-group">
            <label for="editNotes">Notes</label>
            <textarea class="form-control" id="editNotes" rows="3"></textarea>
          </div>
        </form>
      </div>
      <div class="modal-footer">
        <button class="btn btn-outline" id="closeEditModalBtn">Cancel</button>
        <button class="btn btn-primary" id="saveTransactionBtn">
          <i class="bi bi-save"></i> Save Changes
        </button>
      </div>
    </div>

    <!-- JavaScript -->
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <script
      type="text/javascript"
      src="https://cdn.jsdelivr.net/jquery/latest/jquery.min.js"
    ></script>
    <script
      type="text/javascript"
      src="https://cdn.jsdelivr.net/momentjs/latest/moment.min.js"
    ></script>
    <script
      type="text/javascript"
      src="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.min.js"
    ></script>
    <script>
      document.addEventListener("DOMContentLoaded", function () {
        // Initialize DateRangePicker
        $("#dateRange").daterangepicker({
          startDate: moment().subtract(30, "days"),
          endDate: moment(),
          ranges: {
            Today: [moment(), moment()],
            Yesterday: [
              moment().subtract(1, "days"),
              moment().subtract(1, "days"),
            ],
            "Last 7 Days": [moment().subtract(6, "days"), moment()],
            "Last 30 Days": [moment().subtract(29, "days"), moment()],
            "This Month": [moment().startOf("month"), moment().endOf("month")],
            "Last Month": [
              moment().subtract(1, "month").startOf("month"),
              moment().subtract(1, "month").endOf("month"),
            ],
          },
        });

        // Modal elements
        const modalBackdrop = document.getElementById("modalBackdrop");
        const viewTransactionModal = document.getElementById(
          "viewTransactionModal"
        );
        const editTransactionModal = document.getElementById(
          "editTransactionModal"
        );

        // View transaction buttons
        document.querySelectorAll(".view-transaction").forEach((btn) => {
          btn.addEventListener("click", function (e) {
            e.preventDefault();
            const transactionId = this.getAttribute("data-id");
            viewTransactionModal.style.display = "block";
            modalBackdrop.style.display = "block";
          });
        });

        // Edit transaction buttons
        document.querySelectorAll(".edit-transaction").forEach((btn) => {
          btn.addEventListener("click", function (e) {
            e.preventDefault();
            const transactionId = this.getAttribute("data-id");
            document.getElementById("editTransactionId").value =
              "TRX-2023-" + transactionId;

            editTransactionModal.style.display = "block";
            modalBackdrop.style.display = "block";
          });
        });

        // Close view modal
        document
          .getElementById("closeViewModal")
          .addEventListener("click", function () {
            viewTransactionModal.style.display = "none";
            modalBackdrop.style.display = "none";
          });

        document
          .getElementById("closeViewModalBtn")
          .addEventListener("click", function () {
            viewTransactionModal.style.display = "none";
            modalBackdrop.style.display = "none";
          });

        // Close edit modal
        document
          .getElementById("closeEditModal")
          .addEventListener("click", function () {
            editTransactionModal.style.display = "none";
            modalBackdrop.style.display = "none";
          });

        document
          .getElementById("closeEditModalBtn")
          .addEventListener("click", function () {
            editTransactionModal.style.display = "none";
            modalBackdrop.style.display = "none";
          });

        // Save transaction changes
        document
          .getElementById("saveTransactionBtn")
          .addEventListener("click", function () {
            const form = document.getElementById("editTransactionForm");
            if (form.checkValidity()) {
              alert("Transaction updated successfully!");
              editTransactionModal.style.display = "none";
              modalBackdrop.style.display = "none";
            } else {
              form.reportValidity();
            }
          });

        // Chart view buttons
        document.querySelectorAll("[data-chart-view]").forEach((btn) => {
          btn.addEventListener("click", function () {
            document.querySelectorAll("[data-chart-view]").forEach((b) => {
              b.classList.remove("active");
            });
            this.classList.add("active");
            updateChart(this.getAttribute("data-chart-view"));
          });
        });

        // Initialize chart
        const ctx = document
          .getElementById("stockMovementChart")
          .getContext("2d");
        const stockChart = new Chart(ctx, {
          type: "line",
          data: {
            labels: [
              "May 19",
              "May 20",
              "May 21",
              "May 22",
              "May 23",
              "May 24",
              "May 25",
            ],
            datasets: [
              {
                label: "Stock In",
                data: [15, 10, 8, 25, 55, 5, 0],
                borderColor: "rgba(25, 135, 84, 1)",
                backgroundColor: "rgba(25, 135, 84, 0.1)",
                tension: 0.4,
                fill: true,
              },
              {
                label: "Stock Out",
                data: [5, 12, 18, 8, 10, 25, 20],
                borderColor: "rgba(105, 105, 105, 1)",
                backgroundColor: "rgba(105, 105, 105, 0.1)",
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
                position: "top",
              },
              tooltip: {
                mode: "index",
                intersect: false,
              },
            },
            scales: {
              y: {
                beginAtZero: true,
                title: {
                  display: true,
                  text: "Quantity",
                },
              },
              x: {
                title: {
                  display: true,
                  text: "Date",
                },
              },
            },
          },
        });

        function updateChart(view) {
          let labels = [];
          let stockInData = [];
          let stockOutData = [];

          if (view === "daily") {
            labels = [
              "May 19",
              "May 20",
              "May 21",
              "May 22",
              "May 23",
              "May 24",
              "May 25",
            ];
            stockInData = [15, 10, 8, 25, 55, 5, 0];
            stockOutData = [5, 12, 18, 8, 10, 25, 20];
          } else if (view === "weekly") {
            labels = ["Week 1", "Week 2", "Week 3", "Week 4"];
            stockInData = [45, 65, 85, 60];
            stockOutData = [35, 55, 45, 53];
          } else if (view === "monthly") {
            labels = ["Jan", "Feb", "Mar", "Apr", "May"];
            stockInData = [120, 150, 180, 135, 113];
            stockOutData = [100, 130, 150, 120, 98];
          }

          stockChart.data.labels = labels;
          stockChart.data.datasets[0].data = stockInData;
          stockChart.data.datasets[1].data = stockOutData;
          stockChart.update();
        }

        // Filter functionality
        document
          .getElementById("applyFilters")
          .addEventListener("click", function (e) {
            e.preventDefault();
            alert(
              "Filters applied! In a real application, this would filter the data."
            );
          });

        document
          .getElementById("resetFilters")
          .addEventListener("click", function () {
            document.getElementById("dateRange").value =
              "05/01/2023 - 05/25/2023";
            document.getElementById("productFilter").value = "";
            document.getElementById("categoryFilter").value = "";
            document.getElementById("transactionType").value = "";
            document.getElementById("userFilter").value = "";
            document.getElementById("searchInput").value = "";
          });

        // Export buttons
        document
          .getElementById("exportCSV")
          .addEventListener("click", function () {
            alert(
              "Exporting to CSV... In a real application, this would download a CSV file."
            );
          });

        document
          .getElementById("exportPDF")
          .addEventListener("click", function () {
            alert(
              "Exporting to PDF... In a real application, this would download a PDF file."
            );
          });

        document
          .getElementById("printReport")
          .addEventListener("click", function () {
            alert(
              "Preparing to print... In a real application, this would open the print dialog."
            );
          });

        document
          .getElementById("printTransactionBtn")
          .addEventListener("click", function () {
            alert(
              "Printing transaction details... In a real application, this would print the transaction details."
            );
          });
      });
    </script>
  </body>
</html>
