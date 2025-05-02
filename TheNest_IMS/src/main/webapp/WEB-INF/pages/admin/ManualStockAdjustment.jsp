<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Manual Stock Adjustment - The Nest Inventory System</title>
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
      href="${pageContext.request.contextPath}/resources/css/ManualStockAdjustment.css"
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
          class="menu-item"
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
          class="menu-item active"
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
        <a href="${pageContext.request.contextPath}/logout" class="menu-item">
          <i class="bi bi-box-arrow-right"></i>
          <span>Logout</span>
        </a>
      </div>
    </div>

    <!-- Main Content -->
    <div class="main-content">
      <div class="page-header">
        <h1 class="page-title">Manual Stock Adjustment</h1>
        <div>
          <button class="btn btn-outline me-2" id="viewHistoryBtn">
            <i class="bi bi-clock-history"></i> View History
          </button>
          <button class="btn btn-primary" id="newAdjustmentBtn">
            <i class="bi bi-plus-circle"></i> New Adjustment
          </button>
        </div>
      </div>

      <!-- Stats Cards -->
      <div class="stats-row">
        <div class="stat-card">
          <div class="stat-icon total-icon">
            <i class="bi bi-sliders"></i>
          </div>
          <div class="stat-value">42</div>
          <div class="stat-label">Total Adjustments</div>
        </div>
        <div class="stat-card">
          <div class="stat-icon decrease-icon">
            <i class="bi bi-arrow-down-circle"></i>
          </div>
          <div class="stat-value">28</div>
          <div class="stat-label">Stock Decreases</div>
        </div>
        <div class="stat-card">
          <div class="stat-icon increase-icon">
            <i class="bi bi-arrow-up-circle"></i>
          </div>
          <div class="stat-value">14</div>
          <div class="stat-label">Stock Increases</div>
        </div>
        <div class="stat-card">
          <div class="stat-icon month-icon">
            <i class="bi bi-calendar-check"></i>
          </div>
          <div class="stat-value">12</div>
          <div class="stat-label">This Month</div>
        </div>
      </div>

      <!-- Search and Filters -->
      <div class="filter-section">
        <div class="filter-row">
          <div class="filter-group">
            <div class="input-group">
              <i class="bi bi-search input-icon"></i>
              <input
                type="text"
                class="form-control input-with-icon"
                placeholder="Search items..."
                id="searchItems"
              />
            </div>
          </div>
          <div class="filter-group">
            <select class="form-control" id="filterCategory">
              <option value="all" selected>All Categories</option>
              <option value="electronics">Electronics</option>
              <option value="furniture">Furniture</option>
              <option value="office-supplies">Office Supplies</option>
              <option value="kitchen">Kitchen Supplies</option>
              <option value="stationery">Stationery</option>
            </select>
          </div>
          <div class="filter-group">
            <select class="form-control" id="filterAdjustmentType">
              <option value="all" selected>All Adjustment Types</option>
              <option value="increase">Stock Increase</option>
              <option value="decrease">Stock Decrease</option>
            </select>
          </div>
          <div class="filter-group" style="flex: 0 0 auto; min-width: 120px">
            <button class="btn btn-outline w-100" id="filterButton">
              <i class="bi bi-funnel"></i> Filter
            </button>
          </div>
        </div>
      </div>

      <!-- Current Inventory Card -->
      <div class="card">
        <div class="card-header">
          <h3 class="card-title">Current Inventory</h3>
          <div>
            <span class="text-muted">Last updated: Today at 10:45 AM</span>
          </div>
        </div>
        <div class="card-body">
          <div class="table-container">
            <table>
              <thead>
                <tr>
                  <th>Item ID</th>
                  <th>Item Name</th>
                  <th>Category</th>
                  <th>Current Stock</th>
                  <th>Status</th>
                  <th>Actions</th>
                </tr>
              </thead>
              <tbody>
                <tr>
                  <td>ITM-1001</td>
                  <td>Wireless Mouse</td>
                  <td>Electronics</td>
                  <td>24</td>
                  <td>
                    <span class="badge badge-success">In Stock</span>
                  </td>
                  <td>
                    <div class="action-buttons">
                      <button
                        class="action-btn adjust-btn"
                        data-item-id="ITM-1001"
                        data-item-name="Wireless Mouse"
                        data-item-stock="24"
                      >
                        <i class="bi bi-pencil"></i>
                      </button>
                      <button
                        class="action-btn history-btn"
                        data-item-id="ITM-1001"
                      >
                        <i class="bi bi-clock-history"></i>
                      </button>
                    </div>
                  </td>
                </tr>
                <tr>
                  <td>ITM-1002</td>
                  <td>Wireless Keyboard</td>
                  <td>Electronics</td>
                  <td>18</td>
                  <td>
                    <span class="badge badge-success">In Stock</span>
                  </td>
                  <td>
                    <div class="action-buttons">
                      <button
                        class="action-btn adjust-btn"
                        data-item-id="ITM-1002"
                        data-item-name="Wireless Keyboard"
                        data-item-stock="18"
                      >
                        <i class="bi bi-pencil"></i>
                      </button>
                      <button
                        class="action-btn history-btn"
                        data-item-id="ITM-1002"
                      >
                        <i class="bi bi-clock-history"></i>
                      </button>
                    </div>
                  </td>
                </tr>
                <tr>
                  <td>ITM-1003</td>
                  <td>Office Chair</td>
                  <td>Furniture</td>
                  <td>5</td>
                  <td>
                    <span class="badge badge-warning">Low Stock</span>
                  </td>
                  <td>
                    <div class="action-buttons">
                      <button
                        class="action-btn adjust-btn"
                        data-item-id="ITM-1003"
                        data-item-name="Office Chair"
                        data-item-stock="5"
                      >
                        <i class="bi bi-pencil"></i>
                      </button>
                      <button
                        class="action-btn history-btn"
                        data-item-id="ITM-1003"
                      >
                        <i class="bi bi-clock-history"></i>
                      </button>
                    </div>
                  </td>
                </tr>
                <tr>
                  <td>ITM-1004</td>
                  <td>Desk Lamp</td>
                  <td>Office Supplies</td>
                  <td>12</td>
                  <td>
                    <span class="badge badge-success">In Stock</span>
                  </td>
                  <td>
                    <div class="action-buttons">
                      <button
                        class="action-btn adjust-btn"
                        data-item-id="ITM-1004"
                        data-item-name="Desk Lamp"
                        data-item-stock="12"
                      >
                        <i class="bi bi-pencil"></i>
                      </button>
                      <button
                        class="action-btn history-btn"
                        data-item-id="ITM-1004"
                      >
                        <i class="bi bi-clock-history"></i>
                      </button>
                    </div>
                  </td>
                </tr>
                <tr>
                  <td>ITM-1005</td>
                  <td>Whiteboard Markers</td>
                  <td>Stationery</td>
                  <td>0</td>
                  <td>
                    <span class="badge badge-danger">Out of Stock</span>
                  </td>
                  <td>
                    <div class="action-buttons">
                      <button
                        class="action-btn adjust-btn"
                        data-item-id="ITM-1005"
                        data-item-name="Whiteboard Markers"
                        data-item-stock="0"
                      >
                        <i class="bi bi-pencil"></i>
                      </button>
                      <button
                        class="action-btn history-btn"
                        data-item-id="ITM-1005"
                      >
                        <i class="bi bi-clock-history"></i>
                      </button>
                    </div>
                  </td>
                </tr>
              </tbody>
            </table>
          </div>
        </div>
      </div>

      <!-- Pagination -->
      <div class="card-footer">
        <ul class="pagination">
          <li class="page-item">
            <a href="#" class="page-link">
              <i class="material-icons">first_page</i>
            </a>
          </li>
          <li class="page-item">
            <a href="#" class="page-link">
              <i class="material-icons">chevron_left</i>
            </a>
          </li>
          <li class="page-item active">
            <a href="#" class="page-link">1</a>
          </li>
          <li class="page-item">
            <a href="#" class="page-link">2</a>
          </li>
          <li class="page-item">
            <a href="#" class="page-link">
              <i class="material-icons">chevron_right</i>
            </a>
          </li>
          <li class="page-item">
            <a href="#" class="page-link">
              <i class="material-icons">last_page</i>
            </a>
          </li>
        </ul>
      </div>
    </div>

    <!-- New Adjustment Modal -->
    <div class="modal-backdrop" id="adjustmentModalBackdrop"></div>
    <div class="modal" id="adjustmentModal">
      <div class="modal-header">
        <h3 class="modal-title">Adjust Stock Level</h3>
        <button class="modal-close" id="closeAdjustmentModal">&times;</button>
      </div>
      <div class="modal-body">
        <div class="info-group">
          <h4>Item Information</h4>
          <div class="info-row">
            <div class="info-label">Item ID:</div>
            <div class="info-value" id="adjustItemId">ITM-1001</div>
          </div>
          <div class="info-row">
            <div class="info-label">Item Name:</div>
            <div class="info-value" id="adjustItemName">Wireless Mouse</div>
          </div>
          <div class="info-row">
            <div class="info-label">Current Stock:</div>
            <div class="info-value" id="adjustCurrentStock">24</div>
          </div>
        </div>

        <div class="form-group">
          <label for="adjustmentType">Adjustment Type</label>
          <select class="form-control" id="adjustmentType" required>
            <option value="">Select Adjustment Type</option>
            <option value="increase">Stock Increase</option>
            <option value="decrease">Stock Decrease</option>
          </select>
        </div>

        <div class="form-group">
          <label for="adjustmentQuantity">Quantity</label>
          <input
            type="number"
            class="form-control"
            id="adjustmentQuantity"
            min="1"
            required
          />
        </div>

        <div class="form-group">
          <label for="adjustmentReason">Reason for Adjustment</label>
          <select class="form-control" id="adjustmentReason" required>
            <option value="">Select Reason</option>
            <option value="damaged">Damaged Items</option>
            <option value="lost">Lost Items</option>
            <option value="found">Found Items</option>
            <option value="inventory-count">Inventory Count Correction</option>
            <option value="returned">Customer Return</option>
            <option value="other">Other (Please Specify)</option>
          </select>
        </div>

        <div class="form-group" id="otherReasonGroup" style="display: none">
          <label for="otherReason">Specify Reason</label>
          <input
            type="text"
            class="form-control"
            id="otherReason"
            placeholder="Enter reason for adjustment"
          />
        </div>

        <div class="form-group">
          <label for="adjustmentNotes">Additional Notes</label>
          <textarea
            class="form-control"
            id="adjustmentNotes"
            rows="3"
            placeholder="Enter any additional notes about this adjustment"
          ></textarea>
        </div>
      </div>
      <div class="modal-footer">
        <button class="btn btn-outline" id="cancelAdjustmentBtn">Cancel</button>
        <button class="btn btn-primary" id="saveAdjustmentBtn">
          <i class="bi bi-save"></i> Save Adjustment
        </button>
      </div>
    </div>

    <!-- History Modal -->
    <div class="modal-backdrop" id="historyModalBackdrop"></div>
    <div class="modal" id="historyModal">
      <div class="modal-header">
        <h3 class="modal-title">Adjustment History</h3>
        <button class="modal-close" id="closeHistoryModal">&times;</button>
      </div>
      <div class="modal-body">
        <div class="info-group">
          <h4>Item Information</h4>
          <div class="info-row">
            <div class="info-label">Item ID:</div>
            <div class="info-value" id="historyItemId">ITM-1001</div>
          </div>
          <div class="info-row">
            <div class="info-label">Item Name:</div>
            <div class="info-value" id="historyItemName">Wireless Mouse</div>
          </div>
          <div class="info-row">
            <div class="info-label">Current Stock:</div>
            <div class="info-value" id="historyCurrentStock">24</div>
          </div>
        </div>

        <div class="timeline">
          <div class="timeline-item timeline-increase">
            <div class="timeline-date">April 15, 2023 - 10:30 AM</div>
            <div class="timeline-title">Stock Increase: +5 units</div>
            <div class="timeline-details">
              <strong>Reason:</strong> Found Items<br />
              <strong>Notes:</strong> Found additional units in storage room
              during inventory check.<br />
              <strong>Adjusted by:</strong> John Smith
            </div>
          </div>
          <div class="timeline-item timeline-decrease">
            <div class="timeline-date">April 10, 2023 - 2:15 PM</div>
            <div class="timeline-title">Stock Decrease: -2 units</div>
            <div class="timeline-details">
              <strong>Reason:</strong> Damaged Items<br />
              <strong>Notes:</strong> Units were damaged during
              transportation.<br />
              <strong>Adjusted by:</strong> Jane Doe
            </div>
          </div>
          <div class="timeline-item timeline-increase">
            <div class="timeline-date">March 28, 2023 - 9:45 AM</div>
            <div class="timeline-title">Stock Increase: +10 units</div>
            <div class="timeline-details">
              <strong>Reason:</strong> Inventory Count Correction<br />
              <strong>Notes:</strong> Physical count showed more items than
              system record.<br />
              <strong>Adjusted by:</strong> John Smith
            </div>
          </div>
        </div>
      </div>
      <div class="modal-footer">
        <button class="btn btn-outline" id="closeHistoryBtn">Close</button>
      </div>
    </div>

    <!-- JavaScript -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script>
      $(document).ready(function () {
        // New Adjustment Button
        $("#newAdjustmentBtn").on("click", function () {
          // Reset form
          $("#adjustmentType").val("");
          $("#adjustmentQuantity").val("");
          $("#adjustmentReason").val("");
          $("#otherReason").val("");
          $("#adjustmentNotes").val("");
          $("#otherReasonGroup").hide();

          // Show modal
          $("#adjustmentModal").css("display", "flex");
          $("#adjustmentModalBackdrop").show();
        });

        // View History Button
        $("#viewHistoryBtn").on("click", function () {
          $("#historyModal").css("display", "flex");
          $("#historyModalBackdrop").show();
        });

        // Adjust Button Click
        $(".adjust-btn").on("click", function () {
          const itemId = $(this).data("item-id");
          const itemName = $(this).data("item-name");
          const itemStock = $(this).data("item-stock");

          // Set values in modal
          $("#adjustItemId").text(itemId);
          $("#adjustItemName").text(itemName);
          $("#adjustCurrentStock").text(itemStock);

          // Reset form
          $("#adjustmentType").val("");
          $("#adjustmentQuantity").val("");
          $("#adjustmentReason").val("");
          $("#otherReason").val("");
          $("#adjustmentNotes").val("");
          $("#otherReasonGroup").hide();

          // Show modal
          $("#adjustmentModal").css("display", "flex");
          $("#adjustmentModalBackdrop").show();
        });

        // History Button Click
        $(".history-btn").on("click", function () {
          const itemId = $(this).data("item-id");
          const itemRow = $(this).closest("tr");
          const itemName = itemRow.find("td:nth-child(2)").text();
          const itemStock = itemRow.find("td:nth-child(4)").text();

          // Set values in modal
          $("#historyItemId").text(itemId);
          $("#historyItemName").text(itemName);
          $("#historyCurrentStock").text(itemStock);

          // Show modal
          $("#historyModal").css("display", "flex");
          $("#historyModalBackdrop").show();
        });

        // Close Adjustment Modal
        $("#closeAdjustmentModal, #cancelAdjustmentBtn").on(
          "click",
          function () {
            $("#adjustmentModal").hide();
            $("#adjustmentModalBackdrop").hide();
          }
        );

        // Close History Modal
        $("#closeHistoryModal, #closeHistoryBtn").on("click", function () {
          $("#historyModal").hide();
          $("#historyModalBackdrop").hide();
        });

        // Show/Hide Other Reason Field
        $("#adjustmentReason").on("change", function () {
          if ($(this).val() === "other") {
            $("#otherReasonGroup").show();
          } else {
            $("#otherReasonGroup").hide();
          }
        });

        // Save Adjustment
        $("#saveAdjustmentBtn").on("click", function () {
          // Validate form
          if (!validateAdjustmentForm()) {
            return;
          }

          // In a real app, you would submit the form data to the server
          // For now, we'll just show a success message and close the modal
          alert("Stock adjustment saved successfully!");
          $("#adjustmentModal").hide();
          $("#adjustmentModalBackdrop").hide();
        });

        // Form Validation
        function validateAdjustmentForm() {
          let isValid = true;

          if (!$("#adjustmentType").val()) {
            alert("Please select an adjustment type");
            isValid = false;
          } else if (
            !$("#adjustmentQuantity").val() ||
            $("#adjustmentQuantity").val() < 1
          ) {
            alert("Please enter a valid quantity (minimum 1)");
            isValid = false;
          } else if (!$("#adjustmentReason").val()) {
            alert("Please select a reason for adjustment");
            isValid = false;
          } else if (
            $("#adjustmentReason").val() === "other" &&
            !$("#otherReason").val()
          ) {
            alert("Please specify the reason for adjustment");
            isValid = false;
          }

          return isValid;
        }

        // Filter Button
        $("#filterButton").on("click", function () {
          // In a real app, you would apply the filters and refresh the table
          alert("Filters applied!");
        });
      });
    </script>
  </body>
</html>
