<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Dispatch Request - The Nest Inventory System</title>
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
      href="${pageContext.request.contextPath}/resources/css/DispatchRequest.css"
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
        <a href="dashboard" class="menu-item">
          <i class="bi bi-speedometer2"></i>
          <span>Dashboard</span>
        </a>
        <a href="inventory" class="menu-item">
          <i class="bi bi-box-seam"></i>
          <span>Inventory</span>
        </a>
        <a href="stock-requests" class="menu-item">
          <i class="bi bi-list-check"></i>
          <span>Stock Requests</span>
        </a>
        <a href="dispatch-request" class="menu-item active">
          <i class="bi bi-send"></i>
          <span>Dispatch Request</span>
        </a>
        <a href="suppliers" class="menu-item">
          <i class="bi bi-truck"></i>
          <span>Suppliers</span>
        </a>
        <a href="users" class="menu-item">
          <i class="bi bi-people"></i>
          <span>Users</span>
        </a>
        <a href="reports" class="menu-item">
          <i class="bi bi-graph-up"></i>
          <span>Reports</span>
        </a>
        <div class="menu-divider"></div>
        <a href="settings" class="menu-item">
          <i class="bi bi-gear"></i>
          <span>Settings</span>
        </a>
        <a href="logout" class="menu-item">
          <i class="bi bi-box-arrow-right"></i>
          <span>Logout</span>
        </a>
      </div>
    </div>

    <!-- Main Content -->
    <div class="main-content">
      <div class="page-header">
        <h1 class="page-title">Dispatch Request</h1>
        <button class="btn btn-primary" id="createDispatch">
          <i class="bi bi-plus-circle"></i> Create Dispatch
        </button>
      </div>

      <!-- Stats Cards -->
      <div class="stats-row">
        <div class="stat-card">
          <div class="stat-icon pending-icon">
            <i class="bi bi-hourglass-split"></i>
          </div>
          <div class="stat-value">12</div>
          <div class="stat-label">Pending Requests</div>
        </div>
        <div class="stat-card">
          <div class="stat-icon processing-icon">
            <i class="bi bi-arrow-repeat"></i>
          </div>
          <div class="stat-value">8</div>
          <div class="stat-label">Processing</div>
        </div>
        <div class="stat-card">
          <div class="stat-icon completed-icon">
            <i class="bi bi-check-circle"></i>
          </div>
          <div class="stat-value">24</div>
          <div class="stat-label">Completed</div>
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
              value="03/21/2023 - 04/20/2023"
            />
          </div>
          <div class="filter-group">
            <label for="departmentFilter">Department</label>
            <select id="departmentFilter" class="form-control">
              <option value="">All Departments</option>
              <option value="IT">IT Department</option>
              <option value="HR">HR Department</option>
              <option value="Finance">Finance Department</option>
              <option value="Marketing">Marketing Department</option>
            </select>
          </div>
          <div class="filter-group">
            <label for="statusFilter">Status</label>
            <select id="statusFilter" class="form-control">
              <option value="">All Status</option>
              <option value="pending">Pending</option>
              <option value="processing">Processing</option>
              <option value="completed">Completed</option>
            </select>
          </div>
        </div>
        <div class="filter-row">
          <div class="filter-group">
            <label for="priorityFilter">Priority</label>
            <select id="priorityFilter" class="form-control">
              <option value="">All Priorities</option>
              <option value="high">High</option>
              <option value="medium">Medium</option>
              <option value="low">Low</option>
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
                placeholder="Search by ID, requester, department..."
              />
            </div>
          </div>
          <div
            class="filter-group"
            style="display: flex; align-items: flex-end"
          >
            <button
              class="btn btn-primary"
              id="applyFilters"
              style="margin-right: 10px"
            >
              <i class="bi bi-funnel"></i> Apply Filters
            </button>
            <button class="btn btn-outline" id="resetFilters">
              <i class="bi bi-arrow-counterclockwise"></i> Reset
            </button>
          </div>
        </div>
      </div>

      <!-- Dispatch Requests Table -->
      <div class="card">
        <div class="card-header">
          <h2 class="card-title">Dispatch Requests</h2>
          <div>
            <span class="badge badge-primary">Pending: 12</span>
            <span class="badge badge-primary">Processing: 8</span>
            <span class="badge badge-primary">Completed: 24</span>
          </div>
        </div>
        <div class="card-body">
          <div class="table-container">
            <table>
              <thead>
                <tr>
                  <th>Request ID</th>
                  <th>Department</th>
                  <th>Requester</th>
                  <th>Date</th>
                  <th>Items</th>
                  <th>Priority</th>
                  <th>Status</th>
                  <th>Actions</th>
                </tr>
              </thead>
              <tbody>
                <tr class="priority-high">
                  <td>DR-2023-001</td>
                  <td>IT Department</td>
                  <td>John Smith</td>
                  <td>May 24, 2023</td>
                  <td>3 items</td>
                  <td><span class="badge badge-high">High</span></td>
                  <td><span class="badge badge-pending">Pending</span></td>
                  <td>
                    <div class="action-buttons">
                      <button
                        class="action-btn view-request"
                        data-id="DR-2023-001"
                      >
                        <i class="bi bi-eye"></i>
                      </button>
                      <button
                        class="action-btn edit-request"
                        data-id="DR-2023-001"
                      >
                        <i class="bi bi-pencil"></i>
                      </button>
                      <button
                        class="action-btn process-request"
                        data-id="DR-2023-001"
                      >
                        <i class="bi bi-arrow-right-circle"></i>
                      </button>
                    </div>
                  </td>
                </tr>
                <tr class="priority-medium">
                  <td>DR-2023-002</td>
                  <td>HR Department</td>
                  <td>Emma Johnson</td>
                  <td>May 23, 2023</td>
                  <td>2 items</td>
                  <td><span class="badge badge-medium">Medium</span></td>
                  <td>
                    <span class="badge badge-processing">Processing</span>
                  </td>
                  <td>
                    <div class="action-buttons">
                      <button
                        class="action-btn view-request"
                        data-id="DR-2023-002"
                      >
                        <i class="bi bi-eye"></i>
                      </button>
                      <button
                        class="action-btn edit-request"
                        data-id="DR-2023-002"
                      >
                        <i class="bi bi-pencil"></i>
                      </button>
                      <button
                        class="action-btn complete-request"
                        data-id="DR-2023-002"
                      >
                        <i class="bi bi-check-circle"></i>
                      </button>
                    </div>
                  </td>
                </tr>
                <tr class="priority-low">
                  <td>DR-2023-003</td>
                  <td>Finance Department</td>
                  <td>Robert Brown</td>
                  <td>May 22, 2023</td>
                  <td>1 item</td>
                  <td><span class="badge badge-low">Low</span></td>
                  <td><span class="badge badge-completed">Completed</span></td>
                  <td>
                    <div class="action-buttons">
                      <button
                        class="action-btn view-request"
                        data-id="DR-2023-003"
                      >
                        <i class="bi bi-eye"></i>
                      </button>
                      <button
                        class="action-btn edit-request"
                        data-id="DR-2023-003"
                      >
                        <i class="bi bi-pencil"></i>
                      </button>
                      <button
                        class="action-btn archive-request"
                        data-id="DR-2023-003"
                      >
                        <i class="bi bi-archive"></i>
                      </button>
                    </div>
                  </td>
                </tr>
                <tr class="priority-high">
                  <td>DR-2023-004</td>
                  <td>Marketing Department</td>
                  <td>Sarah Wilson</td>
                  <td>May 21, 2023</td>
                  <td>4 items</td>
                  <td><span class="badge badge-high">High</span></td>
                  <td><span class="badge badge-pending">Pending</span></td>
                  <td>
                    <div class="action-buttons">
                      <button
                        class="action-btn view-request"
                        data-id="DR-2023-004"
                      >
                        <i class="bi bi-eye"></i>
                      </button>
                      <button
                        class="action-btn edit-request"
                        data-id="DR-2023-004"
                      >
                        <i class="bi bi-pencil"></i>
                      </button>
                      <button
                        class="action-btn process-request"
                        data-id="DR-2023-004"
                      >
                        <i class="bi bi-arrow-right-circle"></i>
                      </button>
                    </div>
                  </td>
                </tr>
                <tr class="priority-medium">
                  <td>DR-2023-005</td>
                  <td>IT Department</td>
                  <td>David Lee</td>
                  <td>May 20, 2023</td>
                  <td>2 items</td>
                  <td><span class="badge badge-medium">Medium</span></td>
                  <td><span class="badge badge-completed">Completed</span></td>
                  <td>
                    <div class="action-buttons">
                      <button
                        class="action-btn view-request"
                        data-id="DR-2023-005"
                      >
                        <i class="bi bi-eye"></i>
                      </button>
                      <button
                        class="action-btn edit-request"
                        data-id="DR-2023-005"
                      >
                        <i class="bi bi-pencil"></i>
                      </button>
                      <button
                        class="action-btn archive-request"
                        data-id="DR-2023-005"
                      >
                        <i class="bi bi-archive"></i>
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
              <a href="#" class="page-link">
                <i class="bi bi-chevron-left"></i>
              </a>
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
              <a href="#" class="page-link">
                <i class="bi bi-chevron-right"></i>
              </a>
            </li>
          </ul>
        </div>
      </div>
    </div>

    <!-- View Request Modal -->
    <div class="modal-backdrop" id="viewModalBackdrop"></div>
    <div class="modal" id="viewRequestModal">
      <div class="modal-header">
        <h3 class="modal-title">Dispatch Request Details</h3>
        <button class="modal-close" id="closeViewModal">&times;</button>
      </div>
      <div class="modal-body">
        <div class="info-group">
          <h4>Request Information</h4>
          <div class="info-row">
            <div class="info-label">Request ID:</div>
            <div class="info-value" id="viewRequestId">DR-2023-001</div>
          </div>
          <div class="info-row">
            <div class="info-label">Department:</div>
            <div class="info-value" id="viewDepartment">IT Department</div>
          </div>
          <div class="info-row">
            <div class="info-label">Requester:</div>
            <div class="info-value" id="viewRequester">John Smith</div>
          </div>
          <div class="info-row">
            <div class="info-label">Date:</div>
            <div class="info-value" id="viewDate">May 24, 2023</div>
          </div>
          <div class="info-row">
            <div class="info-label">Priority:</div>
            <div class="info-value" id="viewPriority">
              <span class="badge badge-high">High</span>
            </div>
          </div>
          <div class="info-row">
            <div class="info-label">Status:</div>
            <div class="info-value" id="viewStatus">
              <span class="badge badge-pending">Pending</span>
            </div>
          </div>
          <div class="info-row">
            <div class="info-label">Notes:</div>
            <div class="info-value" id="viewNotes">
              Urgent request for new equipment for the development team.
            </div>
          </div>
        </div>

        <div class="info-group">
          <h4>Items</h4>
          <table class="items-table">
            <thead>
              <tr>
                <th>Item</th>
                <th>Quantity</th>
                <th>Status</th>
              </tr>
            </thead>
            <tbody id="viewItemsTable">
              <tr>
                <td>Laptop - Dell XPS 15</td>
                <td>2</td>
                <td><span class="badge badge-success">In Stock</span></td>
              </tr>
              <tr>
                <td>Monitor - 27" 4K</td>
                <td>2</td>
                <td><span class="badge badge-success">In Stock</span></td>
              </tr>
              <tr>
                <td>Wireless Mouse</td>
                <td>2</td>
                <td><span class="badge badge-success">In Stock</span></td>
              </tr>
            </tbody>
          </table>
        </div>

        <div class="info-group">
          <h4>Activity Log</h4>
          <div id="viewActivityLog">
            <div class="info-row">
              <div class="info-label">May 24, 2023 09:15</div>
              <div class="info-value">Request created by John Smith</div>
            </div>
            <div class="info-row">
              <div class="info-label">May 24, 2023 10:30</div>
              <div class="info-value">Request approved by Department Head</div>
            </div>
          </div>
        </div>
      </div>
      <div class="modal-footer">
        <button class="btn btn-outline" id="closeViewModalBtn">Close</button>
        <button class="btn btn-primary" id="processRequestBtn">
          <i class="bi bi-arrow-right-circle"></i> Process Request
        </button>
      </div>
    </div>

    <!-- Create/Edit Request Modal -->
    <div class="modal-backdrop" id="editModalBackdrop"></div>
    <div class="modal" id="editRequestModal">
      <div class="modal-header">
        <h3 class="modal-title" id="editModalTitle">Create Dispatch Request</h3>
        <button class="modal-close" id="closeEditModal">&times;</button>
      </div>
      <div class="modal-body">
        <form id="dispatchRequestForm">
          <div class="form-group">
            <label for="editDepartment">Department</label>
            <select id="editDepartment" class="form-control" required>
              <option value="">Select Department</option>
              <option value="IT">IT Department</option>
              <option value="HR">HR Department</option>
              <option value="Finance">Finance Department</option>
              <option value="Marketing">Marketing Department</option>
            </select>
          </div>
          <div class="form-group">
            <label for="editRequester">Requester</label>
            <input
              type="text"
              id="editRequester"
              class="form-control"
              placeholder="Enter requester name"
              required
            />
          </div>
          <div class="form-group">
            <label for="editPriority">Priority</label>
            <select id="editPriority" class="form-control" required>
              <option value="">Select Priority</option>
              <option value="high">High</option>
              <option value="medium">Medium</option>
              <option value="low">Low</option>
            </select>
          </div>
          <div class="form-group">
            <label for="editNotes">Notes</label>
            <textarea
              id="editNotes"
              class="form-control"
              placeholder="Enter additional notes"
            ></textarea>
          </div>

          <h4 class="items-section-title">Items</h4>
          <div id="itemsContainer">
            <div class="item-row">
              <div class="item-select">
                <select class="form-control item-name" required>
                  <option value="">Select Item</option>
                  <option value="laptop">Laptop - Dell XPS 15</option>
                  <option value="monitor">Monitor - 27" 4K</option>
                  <option value="mouse">Wireless Mouse</option>
                  <option value="keyboard">Wireless Keyboard</option>
                  <option value="headset">Headset</option>
                </select>
              </div>
              <div class="item-quantity">
                <input
                  type="number"
                  class="form-control item-qty"
                  min="1"
                  value="1"
                  required
                />
              </div>
              <button type="button" class="btn btn-outline remove-item">
                <i class="bi bi-trash"></i>
              </button>
            </div>
          </div>
          <div class="add-item-container">
            <button type="button" class="btn btn-outline" id="addItemBtn">
              <i class="bi bi-plus-circle"></i> Add Item
            </button>
          </div>
        </form>
      </div>
      <div class="modal-footer">
        <button class="btn btn-outline" id="cancelEditBtn">Cancel</button>
        <button class="btn btn-primary" id="saveRequestBtn">
          <i class="bi bi-save"></i> Save Request
        </button>
      </div>
    </div>

    <!-- Process Request Modal -->
    <div class="modal-backdrop" id="processModalBackdrop"></div>
    <div class="modal" id="processRequestModal">
      <div class="modal-header">
        <h3 class="modal-title">Process Dispatch Request</h3>
        <button class="modal-close" id="closeProcessModal">&times;</button>
      </div>
      <div class="modal-body">
        <div class="info-group">
          <h4>Request Information</h4>
          <div class="info-row">
            <div class="info-label">Request ID:</div>
            <div class="info-value" id="processRequestId">DR-2023-001</div>
          </div>
          <div class="info-row">
            <div class="info-label">Department:</div>
            <div class="info-value" id="processDepartment">IT Department</div>
          </div>
          <div class="info-row">
            <div class="info-label">Requester:</div>
            <div class="info-value" id="processRequester">John Smith</div>
          </div>
        </div>

        <div class="info-group">
          <h4>Items to Process</h4>
          <table class="items-table">
            <thead>
              <tr>
                <th>Item</th>
                <th>Requested Qty</th>
                <th>Available Qty</th>
                <th>Fulfill Qty</th>
              </tr>
            </thead>
            <tbody id="processItemsTable">
              <tr>
                <td>Laptop - Dell XPS 15</td>
                <td>2</td>
                <td>5</td>
                <td>
                  <input
                    type="number"
                    class="form-control fulfill-qty"
                    min="0"
                    max="2"
                    value="2"
                  />
                </td>
              </tr>
              <tr>
                <td>Monitor - 27" 4K</td>
                <td>2</td>
                <td>3</td>
                <td>
                  <input
                    type="number"
                    class="form-control fulfill-qty"
                    min="0"
                    max="2"
                    value="2"
                  />
                </td>
              </tr>
              <tr>
                <td>Wireless Mouse</td>
                <td>2</td>
                <td>10</td>
                <td>
                  <input
                    type="number"
                    class="form-control fulfill-qty"
                    min="0"
                    max="2"
                    value="2"
                  />
                </td>
              </tr>
            </tbody>
          </table>
        </div>

        <div class="form-group">
          <label for="processNotes">Processing Notes</label>
          <textarea
            id="processNotes"
            class="form-control"
            placeholder="Enter processing notes"
          ></textarea>
        </div>
      </div>
      <div class="modal-footer">
        <button class="btn btn-outline" id="cancelProcessBtn">Cancel</button>
        <button class="btn btn-primary" id="confirmProcessBtn">
          <i class="bi bi-check-circle"></i> Confirm Processing
        </button>
      </div>
    </div>

    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script
      type="text/javascript"
      src="https://cdn.jsdelivr.net/momentjs/latest/moment.min.js"
    ></script>
    <script
      type="text/javascript"
      src="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.min.js"
    ></script>

    <!-- JavaScript for Dispatch Request functionality -->
    <script>
      $(document).ready(function () {
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

        // Modal handling
        const viewModal = $("#viewRequestModal");
        const viewModalBackdrop = $("#viewModalBackdrop");
        const editModal = $("#editRequestModal");
        const editModalBackdrop = $("#editModalBackdrop");
        const processModal = $("#processRequestModal");
        const processModalBackdrop = $("#processModalBackdrop");

        // View request modal
        $(".view-request").on("click", function () {
          const requestId = $(this).data("id");
          $("#viewRequestId").text(requestId);
          viewModal.css("display", "flex");
          viewModalBackdrop.show();
        });

        $("#closeViewModal, #closeViewModalBtn").on("click", function () {
          viewModal.hide();
          viewModalBackdrop.hide();
        });

        // Create request modal
        $("#createDispatch").on("click", function () {
          $("#editModalTitle").text("Create Dispatch Request");
          // Reset form
          $("#dispatchRequestForm")[0].reset();
          // Show only one item row
          $("#itemsContainer").html(`
            <div class="item-row">
              <div class="item-select">
                <select class="form-control item-name" required>
                  <option value="">Select Item</option>
                  <option value="laptop">Laptop - Dell XPS 15</option>
                  <option value="monitor">Monitor - 27" 4K</option>
                  <option value="mouse">Wireless Mouse</option>
                  <option value="keyboard">Wireless Keyboard</option>
                  <option value="headset">Headset</option>
                </select>
              </div>
              <div class="item-quantity">
                <input
                  type="number"
                  class="form-control item-qty"
                  min="1"
                  value="1"
                  required
                />
              </div>
              <button type="button" class="btn btn-outline remove-item">
                <i class="bi bi-trash"></i>
              </button>
            </div>
          `);
          editModal.css("display", "flex");
          editModalBackdrop.show();
        });

        // Edit request modal
        $(".edit-request").on("click", function () {
          const requestId = $(this).data("id");
          $("#editModalTitle").text("Edit Dispatch Request");
          editModal.css("display", "flex");
          editModalBackdrop.show();
        });

        $("#closeEditModal, #cancelEditBtn").on("click", function () {
          editModal.hide();
          editModalBackdrop.hide();
        });

        // Process request modal
        $(".process-request, #processRequestBtn").on("click", function () {
          const requestId = $(this).data("id") || $("#viewRequestId").text();
          $("#processRequestId").text(requestId);
          processModal.css("display", "flex");
          processModalBackdrop.show();

          viewModal.hide();
          viewModalBackdrop.hide();
        });

        $("#closeProcessModal, #cancelProcessBtn").on("click", function () {
          processModal.hide();
          processModalBackdrop.hide();
        });

        // Add item button
        $("#addItemBtn").on("click", function () {
          const newItemRow = `
            <div class="item-row">
              <div class="item-select">
                <select class="form-control item-name" required>
                  <option value="">Select Item</option>
                  <option value="laptop">Laptop - Dell XPS 15</option>
                  <option value="monitor">Monitor - 27" 4K</option>
                  <option value="mouse">Wireless Mouse</option>
                  <option value="keyboard">Wireless Keyboard</option>
                  <option value="headset">Headset</option>
                </select>
              </div>
              <div class="item-quantity">
                <input
                  type="number"
                  class="form-control item-qty"
                  min="1"
                  value="1"
                  required
                />
              </div>
              <button type="button" class="btn btn-outline remove-item">
                <i class="bi bi-trash"></i>
              </button>
            </div>
          `;
          $("#itemsContainer").append(newItemRow);
          bindRemoveItemEvents();
        });

        // Function to bind remove item events
        function bindRemoveItemEvents() {
          $(".remove-item")
            .off("click")
            .on("click", function () {
              // Don't remove if it's the only item
              if ($(".item-row").length > 1) {
                $(this).closest(".item-row").remove();
              }
            });
        }

        bindRemoveItemEvents();

        // Save request button
        $("#saveRequestBtn").on("click", function () {
          // Validate form
          if (!$("#dispatchRequestForm")[0].checkValidity()) {
            $("#dispatchRequestForm")[0].reportValidity();
            return;
          }

          alert("Dispatch request saved successfully!");
          editModal.hide();
          editModalBackdrop.hide();
        });

        // Confirm processing button
        $("#confirmProcessBtn").on("click", function () {
          alert("Dispatch request processed successfully!");
          processModal.hide();
          processModalBackdrop.hide();
        });

        // Filter functionality
        $("#applyFilters").on("click", function () {
          alert("Filters applied!");
        });

        $("#resetFilters").on("click", function () {
          $("#dateRange").val("03/21/2023 - 04/20/2023");
          $("#departmentFilter").val("");
          $("#statusFilter").val("");
          $("#priorityFilter").val("");
          $("#searchInput").val("");

          alert("Filters reset!");
        });

        // Complete request functionality
        $(".complete-request").on("click", function () {
          const requestId = $(this).data("id");
          if (
            confirm("Are you sure you want to mark this request as completed?")
          ) {
            alert("Request " + requestId + " marked as completed!");
          }
        });

        // Archive request functionality
        $(".archive-request").on("click", function () {
          const requestId = $(this).data("id");
          if (confirm("Are you sure you want to archive this request?")) {
            alert("Request " + requestId + " archived!");
          }
        });
      });
    </script>
  </body>
</html>
