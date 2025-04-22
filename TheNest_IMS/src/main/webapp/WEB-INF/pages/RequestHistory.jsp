<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Request History - The Nest Inventory System</title>
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
      href="${pageContext.request.contextPath}/resources/css/RequestHistory.css"
    />
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
  </head>
  <body>
    <jsp:include page="components/Sidebar.jsp" />

    <!-- Main Content -->
    <div class="main-content">
      <div class="page-header">
        <h1 class="page-title">Request History</h1>
        <div>
          <button class="btn btn-outline me-2" id="exportReportBtn">
            <i class="bi bi-file-earmark-excel"></i> Export Report
          </button>
          <button class="btn btn-primary" id="printReportBtn">
            <i class="bi bi-printer"></i> Print Report
          </button>
        </div>
      </div>

      <!-- Stats Cards -->
      <div class="stats-row">
        <div class="stat-card">
          <div class="stat-icon total-icon">
            <i class="bi bi-clipboard-check"></i>
          </div>
          <div class="stat-value">156</div>
          <div class="stat-label">Total Requests</div>
        </div>
        <div class="stat-card">
          <div class="stat-icon stock-icon">
            <i class="bi bi-box-seam"></i>
          </div>
          <div class="stat-value">98</div>
          <div class="stat-label">Stock Requests</div>
        </div>
        <div class="stat-card">
          <div class="stat-icon dispatch-icon">
            <i class="bi bi-truck"></i>
          </div>
          <div class="stat-value">58</div>
          <div class="stat-label">Dispatch Requests</div>
        </div>
      </div>

      <!-- Filter Section -->
      <div class="filter-section">
        <div class="filter-row">
          <div class="filter-group">
            <label for="dateRange">Date Range</label>
            <input
              type="text"
              id="dateRange"
              class="form-control"
              value="03/01/2023 - 04/30/2023"
            />
          </div>
          <div class="filter-group">
            <label for="requestType">Request Type</label>
            <select id="requestType" class="form-control">
              <option value="all">All Requests</option>
              <option value="stock">Stock Requests</option>
              <option value="dispatch">Dispatch Requests</option>
            </select>
          </div>
          <div class="filter-group">
            <label for="statusFilter">Status</label>
            <select id="statusFilter" class="form-control">
              <option value="all">All Status</option>
              <option value="pending">Pending</option>
              <option value="approved">Approved</option>
              <option value="rejected">Rejected</option>
              <option value="processing">Processing</option>
              <option value="completed">Completed</option>
              <option value="dispatched">Dispatched</option>
            </select>
          </div>
        </div>
        <div class="filter-row">
          <div class="filter-group">
            <label for="departmentFilter">Department</label>
            <select id="departmentFilter" class="form-control">
              <option value="all">All Departments</option>
              <option value="it">IT Department</option>
              <option value="hr">HR Department</option>
              <option value="finance">Finance Department</option>
              <option value="marketing">Marketing Department</option>
              <option value="operations">Operations</option>
            </select>
          </div>
          <div class="filter-group">
            <label for="searchInput">Search</label>
            <div class="input-group">
              <i class="bi bi-search input-icon"></i>
              <input
                type="text"
                id="searchInput"
                class="form-control input-with-icon"
                placeholder="Search by ID, requester, items..."
              />
            </div>
          </div>
          <div class="filter-group filter-buttons">
            <button class="btn btn-primary" id="applyFilters">
              <i class="bi bi-funnel"></i> Apply Filters
            </button>
            <button class="btn btn-outline" id="resetFilters">
              <i class="bi bi-arrow-counterclockwise"></i> Reset
            </button>
          </div>
        </div>
      </div>

      <!-- Summary Section -->
      <div class="summary-section">
        <div class="summary-card">
          <div class="summary-header">
            <h3>Request Summary</h3>
            <div class="summary-period">Mar 1, 2023 - Apr 30, 2023</div>
          </div>
          <div class="summary-body">
            <div class="summary-stats">
              <div class="summary-stat">
                <div class="stat-label">Total Requests</div>
                <div class="stat-value">156</div>
              </div>
              <div class="summary-stat">
                <div class="stat-label">Approved</div>
                <div class="stat-value">112</div>
              </div>
              <div class="summary-stat">
                <div class="stat-label">Rejected</div>
                <div class="stat-value">18</div>
              </div>
              <div class="summary-stat">
                <div class="stat-label">Pending</div>
                <div class="stat-value">26</div>
              </div>
            </div>
            <div class="chart-container">
              <canvas id="requestChart"></canvas>
            </div>
          </div>
        </div>
      </div>

      <!-- Request History Table -->
      <div class="card">
        <div class="card-header">
          <h2 class="card-title">Request History</h2>
          <div class="card-actions">
            <div class="view-toggle">
              <button class="view-toggle-btn active" data-view="all">
                All
              </button>
              <button class="view-toggle-btn" data-view="stock">Stock</button>
              <button class="view-toggle-btn" data-view="dispatch">
                Dispatch
              </button>
            </div>
          </div>
        </div>
        <div class="card-body">
          <div class="table-container">
            <table>
              <thead>
                <tr>
                  <th>Request ID</th>
                  <th>Type</th>
                  <th>Department</th>
                  <th>Requester</th>
                  <th>Date</th>
                  <th>Items</th>
                  <th>Status</th>
                  <th>Actions</th>
                </tr>
              </thead>
              <tbody>
                <!-- Stock Requests -->
                <tr class="request-stock">
                  <td>SR-2023-042</td>
                  <td><span class="badge badge-stock">Stock</span></td>
                  <td>IT Department</td>
                  <td>John Smith</td>
                  <td>Apr 28, 2023</td>
                  <td>3 items</td>
                  <td><span class="badge badge-approved">Approved</span></td>
                  <td>
                    <div class="action-buttons">
                      <button class="action-btn view-btn" data-id="SR-2023-042">
                        <i class="bi bi-eye"></i>
                      </button>
                      <button
                        class="action-btn print-btn"
                        data-id="SR-2023-042"
                      >
                        <i class="bi bi-printer"></i>
                      </button>
                    </div>
                  </td>
                </tr>
                <tr class="request-stock">
                  <td>SR-2023-041</td>
                  <td><span class="badge badge-stock">Stock</span></td>
                  <td>Finance</td>
                  <td>Emma Johnson</td>
                  <td>Apr 25, 2023</td>
                  <td>2 items</td>
                  <td><span class="badge badge-rejected">Rejected</span></td>
                  <td>
                    <div class="action-buttons">
                      <button class="action-btn view-btn" data-id="SR-2023-041">
                        <i class="bi bi-eye"></i>
                      </button>
                      <button
                        class="action-btn print-btn"
                        data-id="SR-2023-041"
                      >
                        <i class="bi bi-printer"></i>
                      </button>
                    </div>
                  </td>
                </tr>

                <!-- Dispatch Requests -->
                <tr class="request-dispatch">
                  <td>DR-2023-036</td>
                  <td><span class="badge badge-dispatch">Dispatch</span></td>
                  <td>Marketing</td>
                  <td>Sarah Wilson</td>
                  <td>Apr 22, 2023</td>
                  <td>4 items</td>
                  <td><span class="badge badge-completed">Completed</span></td>
                  <td>
                    <div class="action-buttons">
                      <button class="action-btn view-btn" data-id="DR-2023-036">
                        <i class="bi bi-eye"></i>
                      </button>
                      <button
                        class="action-btn print-btn"
                        data-id="DR-2023-036"
                      >
                        <i class="bi bi-printer"></i>
                      </button>
                    </div>
                  </td>
                </tr>
                <tr class="request-stock">
                  <td>SR-2023-040</td>
                  <td><span class="badge badge-stock">Stock</span></td>
                  <td>HR Department</td>
                  <td>Michael Brown</td>
                  <td>Apr 20, 2023</td>
                  <td>1 item</td>
                  <td><span class="badge badge-approved">Approved</span></td>
                  <td>
                    <div class="action-buttons">
                      <button class="action-btn view-btn" data-id="SR-2023-040">
                        <i class="bi bi-eye"></i>
                      </button>
                      <button
                        class="action-btn print-btn"
                        data-id="SR-2023-040"
                      >
                        <i class="bi bi-printer"></i>
                      </button>
                    </div>
                  </td>
                </tr>
                <tr class="request-dispatch">
                  <td>DR-2023-035</td>
                  <td><span class="badge badge-dispatch">Dispatch</span></td>
                  <td>Operations</td>
                  <td>Robert Johnson</td>
                  <td>Apr 18, 2023</td>
                  <td>5 items</td>
                  <td>
                    <span class="badge badge-processing">Processing</span>
                  </td>
                  <td>
                    <div class="action-buttons">
                      <button class="action-btn view-btn" data-id="DR-2023-035">
                        <i class="bi bi-eye"></i>
                      </button>
                      <button
                        class="action-btn print-btn"
                        data-id="DR-2023-035"
                      >
                        <i class="bi bi-printer"></i>
                      </button>
                    </div>
                  </td>
                </tr>
                <tr class="request-stock">
                  <td>SR-2023-039</td>
                  <td><span class="badge badge-stock">Stock</span></td>
                  <td>IT Department</td>
                  <td>Jennifer Davis</td>
                  <td>Apr 15, 2023</td>
                  <td>2 items</td>
                  <td><span class="badge badge-pending">Pending</span></td>
                  <td>
                    <div class="action-buttons">
                      <button class="action-btn view-btn" data-id="SR-2023-039">
                        <i class="bi bi-eye"></i>
                      </button>
                      <button
                        class="action-btn print-btn"
                        data-id="SR-2023-039"
                      >
                        <i class="bi bi-printer"></i>
                      </button>
                    </div>
                  </td>
                </tr>
                <tr class="request-dispatch">
                  <td>DR-2023-034</td>
                  <td><span class="badge badge-dispatch">Dispatch</span></td>
                  <td>Finance</td>
                  <td>David Wilson</td>
                  <td>Apr 12, 2023</td>
                  <td>3 items</td>
                  <td><span class="badge badge-completed">Completed</span></td>
                  <td>
                    <div class="action-buttons">
                      <button class="action-btn view-btn" data-id="DR-2023-034">
                        <i class="bi bi-eye"></i>
                      </button>
                      <button
                        class="action-btn print-btn"
                        data-id="DR-2023-034"
                      >
                        <i class="bi bi-printer"></i>
                      </button>
                    </div>
                  </td>
                </tr>
              </tbody>
            </table>
          </div>
        </div>
        <div class="card-footer">
          <ul class="pagination">
            <li class="page-item disabled">
              <a href="#" class="page-link"
                ><i class="bi bi-chevron-double-left"></i
              ></a>
            </li>
            <li class="page-item disabled">
              <a href="#" class="page-link"
                ><i class="bi bi-chevron-left"></i
              ></a>
            </li>
            <li class="page-item active">
              <a href="#" class="page-link">1</a>
            </li>
            <li class="page-item">
              <a href="#" class="page-link">2</a>
            </li>
            <li class="page-item">
              <a href="#" class="page-link">3</a>
            </li>
            <li class="page-item">
              <a href="#" class="page-link"
                ><i class="bi bi-chevron-right"></i
              ></a>
            </li>
            <li class="page-item">
              <a href="#" class="page-link"
                ><i class="bi bi-chevron-double-right"></i
              ></a>
            </li>
          </ul>
        </div>
      </div>
    </div>

    <!-- Request Details Modal -->
    <div class="modal" id="requestDetailsModal">
      <div class="modal-dialog modal-lg">
        <div class="modal-content">
          <div class="modal-header">
            <h3 class="modal-title">Request Details</h3>
            <button type="button" class="modal-close" data-dismiss="modal">
              <i class="bi bi-x"></i>
            </button>
          </div>
          <div class="modal-body">
            <div class="request-info">
              <div class="request-header">
                <div>
                  <h4 id="requestIdTitle">SR-2023-042</h4>
                  <div class="request-meta">
                    <span id="requestType">Stock Request</span> •
                    <span id="requestDate">Apr 28, 2023</span> •
                    <span id="requestStatus" class="badge badge-approved"
                      >Approved</span
                    >
                  </div>
                </div>
                <div class="request-badge" id="requestTypeBadge">
                  <i class="bi bi-box-seam"></i>
                </div>
              </div>

              <div class="detail-section">
                <h5>Requester Information</h5>
                <div class="detail-grid">
                  <div class="detail-item">
                    <div class="detail-label">Name</div>
                    <div class="detail-value" id="requesterName">
                      John Smith
                    </div>
                  </div>
                  <div class="detail-item">
                    <div class="detail-label">Department</div>
                    <div class="detail-value" id="requesterDept">
                      IT Department
                    </div>
                  </div>
                  <div class="detail-item">
                    <div class="detail-label">Email</div>
                    <div class="detail-value" id="requesterEmail">
                      john.smith@thenest.com
                    </div>
                  </div>
                  <div class="detail-item">
                    <div class="detail-label">Phone</div>
                    <div class="detail-value" id="requesterPhone">
                      (555) 123-4567
                    </div>
                  </div>
                </div>
              </div>

              <div class="detail-section">
                <h5>Request Items</h5>
                <div class="items-table">
                  <table>
                    <thead>
                      <tr>
                        <th>Item</th>
                        <th>Quantity</th>
                        <th>Status</th>
                      </tr>
                    </thead>
                    <tbody id="requestItemsList">
                      <tr>
                        <td>Dell XPS 13 Laptop</td>
                        <td>2</td>
                        <td>
                          <span class="badge badge-approved">Approved</span>
                        </td>
                      </tr>
                      <tr>
                        <td>Wireless Mouse</td>
                        <td>3</td>
                        <td>
                          <span class="badge badge-approved">Approved</span>
                        </td>
                      </tr>
                      <tr>
                        <td>HDMI Cable</td>
                        <td>5</td>
                        <td>
                          <span class="badge badge-approved">Approved</span>
                        </td>
                      </tr>
                    </tbody>
                  </table>
                </div>
              </div>

              <div class="detail-section">
                <h5>Request Timeline</h5>
                <div class="timeline">
                  <div class="timeline-item">
                    <div class="timeline-icon">
                      <i class="bi bi-plus-circle-fill"></i>
                    </div>
                    <div class="timeline-content">
                      <div class="timeline-date">Apr 28, 2023 - 09:15 AM</div>
                      <div class="timeline-title">Request Created</div>
                      <div class="timeline-desc">
                        John Smith created the request
                      </div>
                    </div>
                  </div>
                  <div class="timeline-item">
                    <div class="timeline-icon">
                      <i class="bi bi-check-circle-fill"></i>
                    </div>
                    <div class="timeline-content">
                      <div class="timeline-date">Apr 28, 2023 - 11:30 AM</div>
                      <div class="timeline-title">Request Approved</div>
                      <div class="timeline-desc">
                        Sarah Wilson approved the request
                      </div>
                    </div>
                  </div>
                  <div class="timeline-item">
                    <div class="timeline-icon">
                      <i class="bi bi-truck"></i>
                    </div>
                    <div class="timeline-content">
                      <div class="timeline-date">Apr 29, 2023 - 02:45 PM</div>
                      <div class="timeline-title">Items Dispatched</div>
                      <div class="timeline-desc">
                        Michael Brown dispatched the items
                      </div>
                    </div>
                  </div>
                </div>
              </div>

              <div class="detail-section">
                <h5>Notes</h5>
                <div class="notes-section" id="requestNotes">
                  <p>
                    Urgent request for new IT equipment for the development
                    team.
                  </p>
                  <p>
                    All items were in stock and have been dispatched to the IT
                    department.
                  </p>
                </div>
              </div>
            </div>
          </div>
          <div class="modal-footer">
            <button type="button" class="btn btn-outline" data-dismiss="modal">
              Close
            </button>
            <button type="button" class="btn btn-primary" id="printRequestBtn">
              <i class="bi bi-printer"></i> Print Details
            </button>
          </div>
        </div>
      </div>
    </div>

    <!-- JavaScript -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script
      type="text/javascript"
      src="https://cdn.jsdelivr.net/momentjs/latest/moment.min.js"
    ></script>
    <script
      type="text/javascript"
      src="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.min.js"
    ></script>
    <script>
      // Initialize date range picker
      $(function () {
        $("#dateRange").daterangepicker({
          opens: "left",
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
      });

      // Initialize Chart.js
      document.addEventListener("DOMContentLoaded", function () {
        const ctx = document.getElementById("requestChart").getContext("2d");
        const requestChart = new Chart(ctx, {
          type: "doughnut",
          data: {
            labels: ["Approved", "Rejected", "Pending", "Processing"],
            datasets: [
              {
                data: [112, 18, 26, 0],
                backgroundColor: [
                  "rgba(46, 125, 50, 0.7)", // primary-color
                  "rgba(27, 94, 32, 0.7)", // dark-color
                  "rgba(76, 175, 80, 0.7)", // secondary-color
                  "rgba(232, 245, 233, 0.7)", // light-color
                ],
                borderColor: [
                  "rgba(46, 125, 50, 1)",
                  "rgba(27, 94, 32, 1)",
                  "rgba(76, 175, 80, 1)",
                  "rgba(232, 245, 233, 1)",
                ],
                borderWidth: 1,
              },
            ],
          },
          options: {
            responsive: true,
            maintainAspectRatio: false,
            plugins: {
              legend: {
                position: "right",
                labels: {
                  font: {
                    family: "Poppins",
                    size: 12,
                  },
                },
              },
              title: {
                display: true,
                text: "Request Status Distribution",
                font: {
                  family: "Poppins",
                  size: 14,
                  weight: "bold",
                },
              },
            },
          },
        });
      });

      // Modal handling
      const modal = document.getElementById("requestDetailsModal");
      const modalCloseBtn = document.querySelector(".modal-close");

      // Open modal function
      function openModal() {
        modal.style.display = "block";
      }

      // Close modal function
      function closeModal() {
        modal.style.display = "none";
      }

      // Event listeners for modal close button
      modalCloseBtn.addEventListener("click", closeModal);

      // Close modal when clicking outside
      window.addEventListener("click", (e) => {
        if (e.target === modal) {
          closeModal();
        }
      });

      // View request details
      const viewButtons = document.querySelectorAll(".view-btn");
      viewButtons.forEach((button) => {
        button.addEventListener("click", function () {
          const requestId = this.getAttribute("data-id");
          // In a real app, you would fetch request details here
          // For now, we'll just open the modal
          openModal();
        });
      });

      // View toggle functionality
      const viewToggleBtns = document.querySelectorAll(".view-toggle-btn");
      const requestRows = document.querySelectorAll("tbody tr");

      viewToggleBtns.forEach((btn) => {
        btn.addEventListener("click", function () {
          // Remove active class from all buttons
          viewToggleBtns.forEach((b) => b.classList.remove("active"));
          // Add active class to clicked button
          this.classList.add("active");

          const view = this.getAttribute("data-view");

          // Show/hide rows based on selected view
          requestRows.forEach((row) => {
            if (view === "all") {
              row.style.display = "";
            } else if (
              view === "stock" &&
              row.classList.contains("request-stock")
            ) {
              row.style.display = "";
            } else if (
              view === "dispatch" &&
              row.classList.contains("request-dispatch")
            ) {
              row.style.display = "";
            } else {
              row.style.display = "none";
            }
          });
        });
      });

      // Apply filters button
      document
        .getElementById("applyFilters")
        .addEventListener("click", function () {
          alert("Filters applied!");
        });

      // Reset filters button
      document
        .getElementById("resetFilters")
        .addEventListener("click", function () {
          document.getElementById("dateRange").value =
            "03/01/2023 - 04/30/2023";
          document.getElementById("requestType").value = "all";
          document.getElementById("statusFilter").value = "all";
          document.getElementById("departmentFilter").value = "all";
          document.getElementById("searchInput").value = "";
          alert("Filters reset!");
        });

      // Export report button
      document
        .getElementById("exportReportBtn")
        .addEventListener("click", function () {
          alert("Report exported to Excel!");
        });

      // Print report button
      document
        .getElementById("printReportBtn")
        .addEventListener("click", function () {
          alert("Preparing report for printing...");
        });

      // Print request details button
      document
        .getElementById("printRequestBtn")
        .addEventListener("click", function () {
          alert("Printing request details...");
          closeModal();
        });
    </script>
  </body>
</html>
