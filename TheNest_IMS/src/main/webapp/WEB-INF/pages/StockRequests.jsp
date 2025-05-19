<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Stock Requests - The Nest Inventory System</title>
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
      href="${pageContext.request.contextPath}/resources/css/StockRequests.css"
    />
  </head>
  <body>
    <jsp:include page="${pageContext.request.contextPath}/components/Sidebar.jsp" />

    <!-- Main Content -->
    <div class="main-content">
      <div class="page-header">
        <h1 class="page-title">Stock Requests</h1>
        <button class="btn btn-primary" id="newRequestBtn">
          <i class="bi bi-plus-circle"></i> New Request
        </button>
      </div>

      <!-- Stats Cards -->
      <div class="stats-row">
        <div class="stat-card">
          <div class="stat-icon pending-icon">
            <i class="bi bi-list-check"></i>
          </div>
          <div class="stat-value">3</div>
          <div class="stat-label">My Pending Requests</div>
        </div>
        <div class="stat-card">
          <div class="stat-icon approved-icon">
            <i class="bi bi-check-circle"></i>
          </div>
          <div class="stat-value">13</div>
          <div class="stat-label">Approved Requests</div>
        </div>
        <div class="stat-card">
          <div class="stat-icon low-stock-icon">
            <i class="bi bi-exclamation-triangle"></i>
          </div>
          <div class="stat-value">8</div>
          <div class="stat-label">Low Stock Items</div>
        </div>
      </div>

      <!-- View Toggle -->
      <div class="view-toggle">
        <button class="view-toggle-btn active" data-view="all">
          All Requests
        </button>
        <button class="view-toggle-btn" data-view="pending">Pending</button>
        <button class="view-toggle-btn" data-view="approved">Approved</button>
        <button class="view-toggle-btn" data-view="rejected">Rejected</button>
        <button class="view-toggle-btn" data-view="dispatched">
          Dispatched
        </button>
      </div>

      <!-- Search and Filters -->
      <div class="search-filters">
        <div class="row">
          <div class="col-md-4">
            <div class="input-group">
              <i class="bi bi-search input-icon"></i>
              <input
                type="text"
                class="form-control input-with-icon"
                placeholder="Search requests..."
                id="searchRequests"
              />
            </div>
          </div>
          <div class="col-md-3">
            <select class="form-control" id="filterStatus">
              <option value="all" selected>All Status</option>
              <option value="pending">Pending</option>
              <option value="approved">Approved</option>
              <option value="rejected">Rejected</option>
              <option value="dispatched">Dispatched</option>
            </select>
          </div>
          <div class="col-md-3">
            <select class="form-control" id="filterPriority">
              <option value="all" selected>All Priorities</option>
              <option value="high">High</option>
              <option value="medium">Medium</option>
              <option value="low">Low</option>
            </select>
          </div>
          <div class="col-md-2">
            <button class="btn btn-outline" id="resetFilters">Reset</button>
          </div>
        </div>
      </div>

      <!-- Requests Table -->
      <div class="card">
        <div class="card-header">
          <h2 class="card-title">All Stock Requests</h2>
          <span class="badge badge-primary">Total: 24 Requests</span>
        </div>
        <div class="card-body">
          <div class="table-container">
            <table>
              <thead>
                <tr>
                  <th>Request ID</th>
                  <th>Requested By</th>
                  <th>Department</th>
                  <th>Date</th>
                  <th>Items</th>
                  <th>Priority</th>
                  <th>Status</th>
                  <th>Actions</th>
                </tr>
              </thead>
              <tbody>
                <tr class="priority-high">
                  <td>REQ-2023-001</td>
                  <td>John Doe</td>
                  <td>IT Department</td>
                  <td>Today, 10:30 AM</td>
                  <td>3 items</td>
                  <td><span class="badge badge-danger">High</span></td>
                  <td><span class="badge badge-warning">Pending</span></td>
                  <td>
                    <div class="action-buttons">
                      <button
                        class="action-btn view-btn"
                        data-id="REQ-2023-001"
                      >
                        <i class="bi bi-eye"></i>
                      </button>
                      <button
                        class="action-btn approve-btn"
                        data-id="REQ-2023-001"
                      >
                        <i class="bi bi-check-lg"></i>
                      </button>
                      <button
                        class="action-btn reject-btn"
                        data-id="REQ-2023-001"
                      >
                        <i class="bi bi-x-lg"></i>
                      </button>
                    </div>
                  </td>
                </tr>
                <tr class="priority-medium">
                  <td>REQ-2023-002</td>
                  <td>Jane Smith</td>
                  <td>Finance</td>
                  <td>Today, 09:15 AM</td>
                  <td>2 items</td>
                  <td><span class="badge badge-warning">Medium</span></td>
                  <td><span class="badge badge-success">Approved</span></td>
                  <td>
                    <div class="action-buttons">
                      <button
                        class="action-btn view-btn"
                        data-id="REQ-2023-002"
                      >
                        <i class="bi bi-eye"></i>
                      </button>
                      <button
                        class="action-btn dispatch-btn"
                        data-id="REQ-2023-002"
                      >
                        <i class="bi bi-truck"></i>
                      </button>
                    </div>
                  </td>
                </tr>
                <tr class="priority-low">
                  <td>REQ-2023-003</td>
                  <td>Robert Johnson</td>
                  <td>Operations</td>
                  <td>Yesterday, 03:45 PM</td>
                  <td>5 items</td>
                  <td><span class="badge badge-success">Low</span></td>
                  <td><span class="badge badge-info">Dispatched</span></td>
                  <td>
                    <div class="action-buttons">
                      <button
                        class="action-btn view-btn"
                        data-id="REQ-2023-003"
                      >
                        <i class="bi bi-eye"></i>
                      </button>
                    </div>
                  </td>
                </tr>
                <tr class="priority-high">
                  <td>REQ-2023-004</td>
                  <td>Emily Wilson</td>
                  <td>HR</td>
                  <td>Yesterday, 01:20 PM</td>
                  <td>1 item</td>
                  <td><span class="badge badge-danger">High</span></td>
                  <td><span class="badge badge-danger">Rejected</span></td>
                  <td>
                    <div class="action-buttons">
                      <button
                        class="action-btn view-btn"
                        data-id="REQ-2023-004"
                      >
                        <i class="bi bi-eye"></i>
                      </button>
                    </div>
                  </td>
                </tr>
                <tr class="priority-medium">
                  <td>REQ-2023-005</td>
                  <td>Michael Brown</td>
                  <td>Marketing</td>
                  <td>3 days ago</td>
                  <td>4 items</td>
                  <td><span class="badge badge-warning">Medium</span></td>
                  <td><span class="badge badge-success">Approved</span></td>
                  <td>
                    <div class="action-buttons">
                      <button
                        class="action-btn view-btn"
                        data-id="REQ-2023-005"
                      >
                        <i class="bi bi-eye"></i>
                      </button>
                      <button
                        class="action-btn dispatch-btn"
                        data-id="REQ-2023-005"
                      >
                        <i class="bi bi-truck"></i>
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
            <li class="page-item">
              <a href="#" class="page-link"
                ><i class="bi bi-chevron-double-left"></i
              ></a>
            </li>
            <li class="page-item">
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

    <!-- Modal Backdrop -->
    <div class="modal-backdrop" id="modalBackdrop"></div>

    <!-- View Request Modal -->
    <div class="modal" id="viewRequestModal">
      <div class="modal-header">
        <h3 class="modal-title">Request Details</h3>
        <button class="modal-close" id="closeViewModal">&times;</button>
      </div>
      <div class="modal-body">
        <div class="info-group">
          <h4>Request Information</h4>
          <div class="info-row">
            <div class="info-label">Request ID:</div>
            <div class="info-value">REQ-2023-001</div>
          </div>
          <div class="info-row">
            <div class="info-label">Requested By:</div>
            <div class="info-value">John Doe</div>
          </div>
          <div class="info-row">
            <div class="info-label">Department:</div>
            <div class="info-value">IT Department</div>
          </div>
          <div class="info-row">
            <div class="info-label">Date:</div>
            <div class="info-value">Today, 10:30 AM</div>
          </div>
          <div class="info-row">
            <div class="info-label">Priority:</div>
            <div class="info-value">
              <span class="badge badge-danger">High</span>
            </div>
          </div>
          <div class="info-row">
            <div class="info-label">Status:</div>
            <div class="info-value">
              <span class="badge badge-warning">Pending</span>
            </div>
          </div>
        </div>

        <div class="info-group">
          <h4>Requested Items</h4>
          <table class="items-table">
            <thead>
              <tr>
                <th>Item</th>
                <th>Quantity</th>
              </tr>
            </thead>
            <tbody>
              <tr>
                <td>Laptop Charger</td>
                <td>2</td>
              </tr>
              <tr>
                <td>Wireless Mouse</td>
                <td>3</td>
              </tr>
              <tr>
                <td>HDMI Cable</td>
                <td>1</td>
              </tr>
            </tbody>
          </table>
        </div>

        <div class="info-group">
          <h4>Request Notes</h4>
          <p>
            Urgent request for new equipment for the IT team. We need these
            items for the new employees starting next week.
          </p>
        </div>
      </div>
      <div class="modal-footer">
        <button class="btn btn-outline" id="closeViewModalBtn">Close</button>
        <button class="btn btn-primary approve-btn" data-id="REQ-2023-001">
          <i class="bi bi-check-lg"></i> Approve
        </button>
        <button class="btn btn-outline reject-btn" data-id="REQ-2023-001">
          <i class="bi bi-x-lg"></i> Reject
        </button>
      </div>
    </div>

    <!-- New Request Modal -->
    <div class="modal" id="newRequestModal">
      <div class="modal-header">
        <h3 class="modal-title">New Stock Request</h3>
        <button class="modal-close" id="closeNewModal">&times;</button>
      </div>
      <div class="modal-body">
        <form id="newRequestForm">
          <div class="row">
            <div class="col-md-4">
              <div class="form-group">
                <label for="department">Department</label>
                <select class="form-control" id="department" required>
                  <option value="">Select Department</option>
                  <option value="IT">IT Department</option>
                  <option value="Finance">Finance</option>
                  <option value="HR">HR</option>
                  <option value="Marketing">Marketing</option>
                  <option value="Operations">Operations</option>
                </select>
              </div>
            </div>
            <div class="col-md-4">
              <div class="form-group">
                <label for="priority">Priority</label>
                <select class="form-control" id="priority" required>
                  <option value="">Select Priority</option>
                  <option value="low">Low</option>
                  <option value="medium">Medium</option>
                  <option value="high">High</option>
                </select>
              </div>
            </div>
          </div>

          <div class="form-group">
            <label>Items</label>
            <div id="itemsList">
              <div class="item-row">
                <select class="form-control item-select" required>
                  <option value="">Select Item</option>
                  <option value="1">Laptop Charger</option>
                  <option value="2">Wireless Mouse</option>
                  <option value="3">HDMI Cable</option>
                  <option value="4">Keyboard</option>
                  <option value="5">Monitor</option>
                </select>
                <input
                  type="number"
                  class="form-control item-quantity"
                  min="1"
                  placeholder="Qty"
                  required
                />
                <button type="button" class="btn btn-outline remove-item">
                  <i class="bi bi-trash"></i>
                </button>
              </div>
            </div>
            <button type="button" class="btn btn-outline" id="addItemBtn">
              <i class="bi bi-plus-circle"></i> Add Item
            </button>
          </div>

          <div class="form-group">
            <label for="notes">Notes</label>
            <textarea
              class="form-control"
              id="notes"
              placeholder="Add any additional information..."
            ></textarea>
          </div>
        </form>
      </div>
      <div class="modal-footer">
        <button class="btn btn-outline" id="closeNewModalBtn">Cancel</button>
        <button class="btn btn-primary" id="submitRequestBtn">
          <i class="bi bi-send"></i> Submit Request
        </button>
      </div>
    </div>

    <!-- JavaScript -->
    <script>
      document.addEventListener("DOMContentLoaded", function () {
        // Modal elements
        const modalBackdrop = document.getElementById("modalBackdrop");
        const viewRequestModal = document.getElementById("viewRequestModal");
        const newRequestModal = document.getElementById("newRequestModal");

        // View request modal
        const viewBtns = document.querySelectorAll(".view-btn");
        viewBtns.forEach((btn) => {
          btn.addEventListener("click", function () {
            const requestId = this.getAttribute("data-id");
            viewRequestModal.style.display = "block";
            modalBackdrop.style.display = "block";
          });
        });

        // Close view modal
        document
          .getElementById("closeViewModal")
          .addEventListener("click", function () {
            viewRequestModal.style.display = "none";
            modalBackdrop.style.display = "none";
          });

        document
          .getElementById("closeViewModalBtn")
          .addEventListener("click", function () {
            viewRequestModal.style.display = "none";
            modalBackdrop.style.display = "none";
          });

        // New request modal
        document
          .getElementById("newRequestBtn")
          .addEventListener("click", function () {
            newRequestModal.style.display = "block";
            modalBackdrop.style.display = "block";
          });

        // Close new request modal
        document
          .getElementById("closeNewModal")
          .addEventListener("click", function () {
            newRequestModal.style.display = "none";
            modalBackdrop.style.display = "none";
          });

        document
          .getElementById("closeNewModalBtn")
          .addEventListener("click", function () {
            newRequestModal.style.display = "none";
            modalBackdrop.style.display = "none";
          });

        // Add item row in new request form
        document
          .getElementById("addItemBtn")
          .addEventListener("click", function () {
            const itemsList = document.getElementById("itemsList");
            const newItemRow = document.createElement("div");
            newItemRow.className = "item-row";
            newItemRow.innerHTML = `
              <select class="form-control item-select" required>
                <option value="">Select Item</option>
                <option value="1">Laptop Charger</option>
                <option value="2">Wireless Mouse</option>
                <option value="3">HDMI Cable</option>
                <option value="4">Keyboard</option>
                <option value="5">Monitor</option>
              </select>
              <input type="number" class="form-control item-quantity" min="1" placeholder="Qty" required>
              <button type="button" class="btn btn-outline remove-item">
                <i class="bi bi-trash"></i>
              </button>
            `;
            itemsList.appendChild(newItemRow);

            // Add event listener to the new remove button
            newItemRow
              .querySelector(".remove-item")
              .addEventListener("click", function () {
                itemsList.removeChild(newItemRow);
              });
          });

        // Remove item row
        document.querySelectorAll(".remove-item").forEach((btn) => {
          btn.addEventListener("click", function () {
            const itemRow = this.closest(".item-row");
            // Don't remove if it's the only item row
            if (document.querySelectorAll(".item-row").length > 1) {
              itemRow.parentNode.removeChild(itemRow);
            }
          });
        });

        // Submit request form
        document
          .getElementById("submitRequestBtn")
          .addEventListener("click", function () {
            const form = document.getElementById("newRequestForm");
            if (form.checkValidity()) {
              alert("Request submitted successfully!");
              newRequestModal.style.display = "none";
              modalBackdrop.style.display = "none";
              // Reset form
              form.reset();
            } else {
              form.reportValidity();
            }
          });

        // Approve button functionality
        document.querySelectorAll(".approve-btn").forEach((btn) => {
          btn.addEventListener("click", function () {
            const requestId = this.getAttribute("data-id");
            if (confirm("Are you sure you want to approve this request?")) {
              alert(`Request ${requestId} approved successfully!`);
              viewRequestModal.style.display = "none";
              modalBackdrop.style.display = "none";
            }
          });
        });

        // Reject button functionality
        document.querySelectorAll(".reject-btn").forEach((btn) => {
          btn.addEventListener("click", function () {
            const requestId = this.getAttribute("data-id");
            if (confirm("Are you sure you want to reject this request?")) {
              alert(`Request ${requestId} rejected.`);
              viewRequestModal.style.display = "none";
              modalBackdrop.style.display = "none";
            }
          });
        });

        // Dispatch button functionality
        document.querySelectorAll(".dispatch-btn").forEach((btn) => {
          btn.addEventListener("click", function () {
            const requestId = this.getAttribute("data-id");
            if (
              confirm(
                "Are you sure you want to mark this request as dispatched?"
              )
            ) {
              alert(`Request ${requestId} marked as dispatched!`);
            }
          });
        });

        // View toggle functionality
        document.querySelectorAll(".view-toggle-btn").forEach((btn) => {
          btn.addEventListener("click", function () {
            document
              .querySelectorAll(".view-toggle-btn")
              .forEach((b) => b.classList.remove("active"));

            this.classList.add("active");

            const view = this.getAttribute("data-view");
            const rows = document.querySelectorAll("tbody tr");

            if (view === "all") {
              rows.forEach((row) => (row.style.display = ""));
            } else {
              rows.forEach((row) => {
                const statusCell = row
                  .querySelector("td:nth-child(7)")
                  .textContent.toLowerCase();
                if (statusCell.includes(view)) {
                  row.style.display = "";
                } else {
                  row.style.display = "none";
                }
              });
            }
          });
        });

        // Search functionality
        document
          .getElementById("searchRequests")
          .addEventListener("input", function () {
            const searchTerm = this.value.toLowerCase();
            const rows = document.querySelectorAll("tbody tr");

            rows.forEach((row) => {
              const text = row.textContent.toLowerCase();
              if (text.includes(searchTerm)) {
                row.style.display = "";
              } else {
                row.style.display = "none";
              }
            });
          });

        // Filter by status
        document
          .getElementById("filterStatus")
          .addEventListener("change", function () {
            const status = this.value;
            const rows = document.querySelectorAll("tbody tr");

            if (status === "all") {
              rows.forEach((row) => (row.style.display = ""));
            } else {
              rows.forEach((row) => {
                const statusCell = row
                  .querySelector("td:nth-child(7)")
                  .textContent.toLowerCase();
                if (statusCell.includes(status)) {
                  row.style.display = "";
                } else {
                  row.style.display = "none";
                }
              });
            }
          });

        // Filter by priority
        document
          .getElementById("filterPriority")
          .addEventListener("change", function () {
            const priority = this.value;
            const rows = document.querySelectorAll("tbody tr");

            if (priority === "all") {
              rows.forEach((row) => (row.style.display = ""));
            } else {
              rows.forEach((row) => {
                const priorityCell = row
                  .querySelector("td:nth-child(6)")
                  .textContent.toLowerCase();
                if (priorityCell.includes(priority)) {
                  row.style.display = "";
                } else {
                  row.style.display = "none";
                }
              });
            }
          });

        // Reset filters
        document
          .getElementById("resetFilters")
          .addEventListener("click", function () {
            document.getElementById("searchRequests").value = "";
            document.getElementById("filterStatus").value = "all";
            document.getElementById("filterPriority").value = "all";

            // Show all rows
            const rows = document.querySelectorAll("tbody tr");
            rows.forEach((row) => (row.style.display = ""));
          });
      });
    </script>
  </body>
</html>
