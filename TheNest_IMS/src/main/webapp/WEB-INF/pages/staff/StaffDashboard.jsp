<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Staff Dashboard - The Nest Inventory System</title>
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
      href="${pageContext.request.contextPath}/resources/css/StaffDashboard.css"
    />
  </head>
  <body>
    <jsp:include page="components/Sidebar.jsp" />

    <!-- Main Content -->
    <div class="main-content">
      <div class="page-header">
        <h1 class="page-title">Staff Dashboard</h1>
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
          <a
            href="${pageContext.request.contextPath}/new-request"
            class="btn btn-primary"
          >
            <i class="bi bi-plus-circle"></i> New Request
          </a>
        </div>
      </div>

      <!-- Stats Cards -->
      <div class="stats-row">
        <div class="stat-card">
          <div class="stat-icon pending-requests-icon">
            <i class="bi bi-hourglass-split"></i>
          </div>
          <div class="stat-value">5</div>
          <div class="stat-label">Pending Requests</div>
        </div>
        <div class="stat-card">
          <div class="stat-icon approved-requests-icon">
            <i class="bi bi-check-circle"></i>
          </div>
          <div class="stat-value">8</div>
          <div class="stat-label">Approved Requests</div>
        </div>
        <div class="stat-card">
          <div class="stat-icon total-requests-icon">
            <i class="bi bi-clipboard-check"></i>
          </div>
          <div class="stat-value">12</div>
          <div class="stat-label">Total Requests</div>
        </div>
      </div>

      <!-- Tables Section -->
      <div class="tables-row">
        <div class="table-card">
          <div class="table-header">
            <h3 class="table-title">My Recent Requests</h3>
            <a
              href="${pageContext.request.contextPath}/my-requests"
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
                    <a
                      href="${pageContext.request.contextPath}/new-request?item=1"
                      class="request-item"
                      data-id="1"
                    >
                      <i class="bi bi-cart-plus"></i>
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
                    <a
                      href="${pageContext.request.contextPath}/new-request?item=2"
                      class="request-item"
                      data-id="2"
                    >
                      <i class="bi bi-cart-plus"></i>
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
                    <a
                      href="${pageContext.request.contextPath}/new-request?item=3"
                      class="request-item"
                      data-id="3"
                    >
                      <i class="bi bi-cart-plus"></i>
                    </a>
                  </td>
                </tr>
              </tbody>
            </table>
          </div>
        </div>
      </div>

      <!-- Quick Request Form -->
      <div class="quick-request-card">
        <div class="card-header">
          <h3 class="card-title">Quick Request</h3>
        </div>
        <div class="card-body">
          <form
            action="${pageContext.request.contextPath}/submit-request"
            method="post"
            class="quick-request-form"
          >
            <div class="form-row">
              <div class="form-group">
                <label for="itemSelect">Select Item</label>
                <select
                  id="itemSelect"
                  name="itemId"
                  class="form-control"
                  required
                >
                  <option value="" selected disabled>Choose an item...</option>
                  <option value="1">Wireless Mouse</option>
                  <option value="2">Office Chair</option>
                  <option value="3">HDMI Cable</option>
                  <option value="4">Keyboard</option>
                  <option value="5">Monitor</option>
                </select>
              </div>
              <div class="form-group">
                <label for="quantity">Quantity</label>
                <input
                  type="number"
                  id="quantity"
                  name="quantity"
                  class="form-control"
                  min="1"
                  required
                />
              </div>
              <div class="form-group">
                <label for="priority">Priority</label>
                <select id="priority" name="priority" class="form-control">
                  <option value="low">Low</option>
                  <option value="medium" selected>Medium</option>
                  <option value="high">High</option>
                </select>
              </div>
              <div class="form-group">
                <label for="notes">Notes (Optional)</label>
                <textarea
                  id="notes"
                  name="notes"
                  class="form-control"
                  rows="2"
                ></textarea>
              </div>
            </div>
            <div class="form-actions">
              <button type="submit" class="btn btn-primary">
                <i class="bi bi-send"></i> Submit Request
              </button>
            </div>
          </form>
        </div>
      </div>
    </div>

    <script>
      document.addEventListener("DOMContentLoaded", function () {
        // Date filter dropdown toggle
        const dateFilter = document.querySelector(".date-filter");
        const dateDropdown = document.querySelector(".date-dropdown");

        if (dateFilter) {
          dateFilter.addEventListener("click", function (e) {
            e.stopPropagation();
            dateDropdown.style.display =
              dateDropdown.style.display === "block" ? "none" : "block";
          });
        }

        document.addEventListener("click", function () {
          if (dateDropdown) {
            dateDropdown.style.display = "none";
          }
        });

        // Date option selection
        const dateOptions = document.querySelectorAll(".date-option");
        const dateRangeBtn = document.querySelector(".date-range-btn");

        dateOptions.forEach((option) => {
          option.addEventListener("click", function (e) {
            e.preventDefault();

            dateOptions.forEach((opt) => opt.classList.remove("active"));

            this.classList.add("active");

            if (dateRangeBtn) {
              dateRangeBtn.innerHTML =
                '<i class="bi bi-calendar3"></i> ' +
                this.textContent +
                ' <i class="bi bi-chevron-down"></i>';
            }
            dateDropdown.style.display = "none";
          });
        });
      });
    </script>
  </body>
</html>
