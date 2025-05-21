<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%> <%@ page session="true" %> <%@ taglib
uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> <%@ taglib prefix="fmt"
uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Import Management - The Nest Inventory System</title>
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
    <link
      rel="stylesheet"
      href="${pageContext.request.contextPath}/resources/css/CurrentStockLevels.css"
    />
    <style>
      /* Fix for supplier name size */
      .stock-level {
        font-size: 1.2rem;
        font-weight: 600;
        margin-bottom: 10px;
      }

      .input-group {
        position: relative;
        width: 100%;
      }

      .input-icon {
        position: absolute;
        left: 12px;
        top: 50%;
        transform: translateY(-50%);
        color: #757575;
        z-index: 1;
        pointer-events: none;
      }

      .input-with-icon {
        padding-left: 45px;
        width: 100%;
        text-indent: 20px;
      }

      .alert {
        padding: 15px;
        margin-bottom: 20px;
        border-radius: 4px;
        position: relative;
      }
      .alert-success {
        background-color: #dff0d8;
        color: #3c763d;
        border: 1px solid #d6e9c6;
      }
      .alert-danger {
        background-color: #f2dede;
        color: #a94442;
        border: 1px solid #ebccd1;
      }
      .alert .dismiss-btn {
        position: absolute;
        right: 10px;
        top: 10px;
        cursor: pointer;
        font-weight: bold;
      }
    </style>
  </head>
  <body>
    <jsp:include page="components/Sidebar.jsp" />

    <!-- Main Content -->
    <div class="main-content">
      <!-- Display success/error messages -->
      <c:if test="${not empty sessionScope.successMessage}">
        <div class="alert alert-success">
          <span>${sessionScope.successMessage}</span>
          <span
            class="dismiss-btn"
            onclick="this.parentElement.style.display='none';"
            >&times;</span
          >
        </div>
        <c:remove var="successMessage" scope="session" />
      </c:if>
      <c:if test="${not empty sessionScope.errorMessage}">
        <div class="alert alert-danger">
          <span>${sessionScope.errorMessage}</span>
          <span
            class="dismiss-btn"
            onclick="this.parentElement.style.display='none';"
            >&times;</span
          >
        </div>
        <c:remove var="errorMessage" scope="session" />
      </c:if>

      <div class="page-header">
        <h1 class="page-title">Import Management</h1>
        <button class="btn btn-primary" id="addItemBtn">
          <i class="bi bi-plus-circle"></i> Add New Import
        </button>
      </div>

      <!-- Stats Cards -->
      <div class="stats-row">
        <div class="stat-card">
          <div class="stat-icon pending-icon">
            <i class="bi bi-box-seam"></i>
          </div>
          <div class="stat-value">${totalImports}</div>
          <div class="stat-label">Total Imports</div>
        </div>
        <div class="stat-card">
          <div class="stat-icon low-stock-icon">
            <i class="bi bi-calendar-check"></i>
          </div>
          <div class="stat-value">${currentMonthImports}</div>
          <div class="stat-label">This Month</div>
        </div>
        <div class="stat-card">
          <div class="stat-icon approved-icon">
            <i class="bi bi-building"></i>
          </div>
          <div class="stat-value">${activeSuppliers}</div>
          <div class="stat-label">Active Suppliers</div>
        </div>
      </div>

      <!-- Filter Section -->
      <div class="filter-section">
        <div class="filter-row">
          <div class="filter-group">
            <div class="input-group">
              <i class="bi bi-search input-icon"></i>
              <input
                type="text"
                class="form-control input-with-icon"
                placeholder="Search imports..."
                id="searchItems"
              />
            </div>
          </div>
          <div class="filter-group">
            <select class="form-control" id="filterSupplier">
              <option value="all" selected>All Suppliers</option>
              <c:forEach var="supplier" items="${suppliers}">
                <option value="${supplier.supplierId}">
                  ${supplier.supplierName}
                </option>
              </c:forEach>
            </select>
          </div>
          <div class="filter-group">
            <select class="form-control" id="filterDate">
              <option value="all" selected>All Dates</option>
              <option value="today">Today</option>
              <option value="week">This Week</option>
              <option value="month">This Month</option>
              <option value="quarter">This Quarter</option>
            </select>
          </div>
          <div class="filter-group" style="flex: 0 0 auto">
            <button class="btn btn-outline" id="resetFilters">Reset</button>
          </div>
        </div>
      </div>

      <!-- Import Grid -->
      <div class="stock-grid">
        <c:choose>
          <c:when test="${empty imports}">
            <div class="no-data-message">
              <p>No imports found. Click "Add New Import" to create one.</p>
            </div>
          </c:when>
          <c:otherwise>
            <c:forEach var="importItem" items="${imports}">
              <div
                class="stock-card"
                data-id="${importItem.importId}"
                data-supplier="${importItem.supplierId}"
              >
                <div class="stock-card-header">
                  <h3 class="stock-card-title">${importItem.importName}</h3>
                  <div class="category-icon">
                    <i class="bi bi-building"></i>
                  </div>
                </div>
                <div class="stock-card-body">
                  <div class="stock-level">${importItem.supplierName}</div>
                  <div class="stock-info">
                    <span class="stock-label">Import ID</span>
                    <span class="stock-value">IMP${importItem.importId}</span>
                  </div>
                  <div class="stock-info">
                    <span class="stock-label">Date</span>
                    <span class="stock-value">${importItem.importDate}</span>
                  </div>
                  <div class="stock-info">
                    <span class="stock-label">Supplier ID</span>
                    <span class="stock-value">${importItem.supplierId}</span>
                  </div>
                  <div class="stock-info">
                    <span class="stock-label">Status</span>
                    <span class="badge badge-stock normal">Completed</span>
                  </div>
                </div>
                <div class="stock-card-footer">
                  <a
                    href="#"
                    class="edit-item"
                    data-id="${importItem.importId}"
                  >
                    <i class="bi bi-pencil"></i> Edit
                  </a>
                  <a
                    href="#"
                    class="view-details"
                    data-id="${importItem.importId}"
                  >
                    <i class="bi bi-eye"></i> View Details
                  </a>
                </div>
              </div>
            </c:forEach>
          </c:otherwise>
        </c:choose>
      </div>
    </div>

    <!-- Modal Backdrop -->
    <div class="modal-backdrop" id="modalBackdrop"></div>

    <!-- Add/Edit Import Modal -->
    <div class="modal" id="itemModal">
      <div class="modal-header">
        <h3 class="modal-title" id="itemModalTitle">Add New Import</h3>
        <button class="modal-close" id="closeItemModal">&times;</button>
      </div>
      <div class="modal-body">
        <form
          id="itemForm"
          method="post"
          action="${pageContext.request.contextPath}/import"
        >
          <input type="hidden" id="editImportId" name="importId" value="" />
          <div class="row">
            <div class="col-md-6">
              <div class="form-group">
                <label for="importName">Import Name</label>
                <input
                  type="text"
                  class="form-control"
                  id="importName"
                  name="importName"
                  placeholder="Enter import name"
                  required
                />
              </div>
            </div>
            <div class="col-md-6">
              <div class="form-group">
                <label for="importDate">Import Date</label>
                <input
                  type="date"
                  class="form-control"
                  id="importDate"
                  name="importDate"
                  required
                />
              </div>
            </div>
          </div>

          <div class="form-group">
            <label for="supplier">Supplier</label>
            <select class="form-control" name="supplier" id="supplier" required>
              <option value="">Select Supplier</option>
              <c:forEach var="sup" items="${suppliers}">
                <option value="${sup.supplierId}">${sup.supplierName}</option>
              </c:forEach>
            </select>
          </div>

          <div class="modal-footer">
            <button
              type="button"
              class="btn btn-outline"
              id="closeItemModalBtn"
            >
              Cancel
            </button>
            <button type="submit" class="btn btn-primary" id="saveItemBtn">
              <i class="bi bi-save"></i> Save Import
            </button>
          </div>
        </form>
      </div>
    </div>

    <!-- View Import Details Modal -->
    <div class="modal" id="orderModal">
      <div class="modal-header">
        <h3 class="modal-title">Import Details</h3>
        <button class="modal-close" id="closeOrderModal">&times;</button>
      </div>
      <div class="modal-body">
        <div id="importDetails">
          <div class="form-group">
            <label>Import Name</label>
            <p id="detailImportName" class="form-control-static">Loading...</p>
          </div>

          <div class="row">
            <div class="col-md-6">
              <div class="form-group">
                <label>Import Date</label>
                <p id="detailImportDate" class="form-control-static">
                  Loading...
                </p>
              </div>
            </div>
            <div class="col-md-6">
              <div class="form-group">
                <label>Import ID</label>
                <p id="detailImportId" class="form-control-static">
                  Loading...
                </p>
              </div>
            </div>
          </div>

          <div class="form-group">
            <label>Supplier</label>
            <p id="detailSupplier" class="form-control-static">Loading...</p>
          </div>

          <div class="form-group">
            <label>Supplier Contact</label>
            <p id="detailSupplierContact" class="form-control-static">
              Loading...
            </p>
          </div>
        </div>
      </div>
      <div class="modal-footer">
        <button class="btn btn-outline" id="closeOrderModalBtn">Close</button>
        <button class="btn btn-primary" id="printDetailsBtn">
          <i class="bi bi-printer"></i> Print Details
        </button>
      </div>
    </div>

    <!-- JavaScript -->
    <script>
      document.addEventListener("DOMContentLoaded", function () {
        const contextPath = "${pageContext.request.contextPath}";

        // Modal elements
        const modalBackdrop = document.getElementById("modalBackdrop");
        const itemModal = document.getElementById("itemModal");
        const detailsModal = document.getElementById("orderModal");
        const editImportIdField = document.getElementById("editImportId");

        // Today's date for the date input default value
        document.getElementById("importDate").valueAsDate = new Date();

        // Add new import button
        document
          .getElementById("addItemBtn")
          .addEventListener("click", function () {
            document.getElementById("itemModalTitle").textContent =
              "Add New Import";
            document.getElementById("itemForm").reset();
            document.getElementById("importDate").valueAsDate = new Date();
            editImportIdField.value = "";
            openModal(itemModal);
          });

        // Edit import buttons
        document.querySelectorAll(".edit-item").forEach((btn) => {
          btn.addEventListener("click", function (e) {
            e.preventDefault();
            const importId = this.getAttribute("data-id");

            fetch(
              `${contextPath}/import?action=getImportDetails&id=${importId}`
            )
              .then((response) => {
                if (!response.ok)
                  throw new Error("Failed to fetch import details");
                return response.json();
              })
              .then((data) => {
                document.getElementById("itemModalTitle").textContent =
                  "Edit Import";
                document.getElementById("importName").value = data.importName;
                document.getElementById("importDate").value = data.importDate;
                document.getElementById("supplier").value = data.supplierId;
                editImportIdField.value = data.importId;

                openModal(itemModal);
              })
              .catch((error) => {
                console.error("Error fetching import details:", error);
                alert("Error loading import details. Please try again.");
              });
          });
        });

        // View details buttons
        document.querySelectorAll(".view-details").forEach((btn) => {
          btn.addEventListener("click", function (e) {
            e.preventDefault();
            const importId = this.getAttribute("data-id");

            // Reset the fields
            document.getElementById("detailImportName").textContent =
              "Loading...";
            document.getElementById("detailImportDate").textContent =
              "Loading...";
            document.getElementById("detailImportId").textContent =
              "Loading...";
            document.getElementById("detailSupplier").textContent =
              "Loading...";
            document.getElementById("detailSupplierContact").textContent =
              "Loading...";

            fetch(
              `${contextPath}/import?action=getImportDetails&id=${importId}`
            )
              .then((response) => {
                if (!response.ok)
                  throw new Error("Failed to fetch import details");
                return response.json();
              })
              .then((data) => {
                document.getElementById("detailImportName").textContent =
                  data.importName;
                document.getElementById("detailImportDate").textContent =
                  data.importDate;
                document.getElementById("detailImportId").textContent =
                  "IMP" + data.importId;
                document.getElementById("detailSupplier").textContent =
                  data.supplierName;

                let contactInfo = "";
                if (data.supplierPhone)
                  contactInfo += `Phone: ${data.supplierPhone}`;
                if (data.supplierPhone && data.supplierEmail)
                  contactInfo += " | ";
                if (data.supplierEmail)
                  contactInfo += `Email: ${data.supplierEmail}`;

                document.getElementById("detailSupplierContact").textContent =
                  contactInfo || "No contact information available";

                openModal(detailsModal);
              })
              .catch((error) => {
                console.error("Error fetching import details:", error);
                alert("Error loading import details. Please try again.");
              });
          });
        });

        function openModal(modal) {
          modalBackdrop.style.display = "block";
          modal.style.display = "block";
          document.body.style.overflow = "hidden";
        }

        function closeModal(modal) {
          modalBackdrop.style.display = "none";
          modal.style.display = "none";
          document.body.style.overflow = "";
        }

        // Close item modal
        document
          .getElementById("closeItemModal")
          .addEventListener("click", () => closeModal(itemModal));

        document
          .getElementById("closeItemModalBtn")
          .addEventListener("click", (e) => {
            e.preventDefault();
            closeModal(itemModal);
          });

        // Close details modal
        document
          .getElementById("closeOrderModal")
          .addEventListener("click", () => closeModal(detailsModal));

        document
          .getElementById("closeOrderModalBtn")
          .addEventListener("click", () => closeModal(detailsModal));

        // Print details
        document
          .getElementById("printDetailsBtn")
          .addEventListener("click", function () {
            const content = document.getElementById("importDetails").innerHTML;
            const printWindow = window.open("", "_blank");
            printWindow.document.write(`
              <html>
                <head>
                  <title>Import Details</title>
                  <style>
                    body { font-family: Arial, sans-serif; line-height: 1.6; }
                    .form-group { margin-bottom: 15px; }
                    label { font-weight: bold; display: block; }
                    .row { display: flex; }
                    .col-md-6 { width: 50%; padding: 0 10px; }
                    @media print {
                      body { padding: 20px; }
                    }
                  </style>
                </head>
                <body>
                  <h1>Import Details</h1>
                  ${content}
                </body>
              </html>
            `);
            printWindow.document.close();
            printWindow.focus();
            setTimeout(() => {
              printWindow.print();
              printWindow.close();
            }, 250);
          });

        // Search functionality
        document
          .getElementById("searchItems")
          .addEventListener("input", function () {
            filterImports();
          });

        // Filter by supplier
        document
          .getElementById("filterSupplier")
          .addEventListener("change", function () {
            filterImports();
          });

        // Filter by date
        document
          .getElementById("filterDate")
          .addEventListener("change", function () {
            filterImports();
          });

        // Reset filters
        document
          .getElementById("resetFilters")
          .addEventListener("click", function () {
            document.getElementById("searchItems").value = "";
            document.getElementById("filterSupplier").value = "all";
            document.getElementById("filterDate").value = "all";
            filterImports();
          });

        // Filter function to apply all filters at once
        function filterImports() {
          const searchTerm = document
            .getElementById("searchItems")
            .value.toLowerCase();
          const supplierFilter =
            document.getElementById("filterSupplier").value;
          const dateFilter = document.getElementById("filterDate").value;
          const today = new Date();
          const cards = document.querySelectorAll(".stock-card");

          cards.forEach((card) => {
            const importName = card
              .querySelector(".stock-card-title")
              .textContent.toLowerCase();
            const supplierName = card
              .querySelector(".stock-level")
              .textContent.toLowerCase();
            const supplierId = card.getAttribute("data-supplier");
            const dateText = card.querySelector(
              ".stock-info:nth-child(3) .stock-value"
            ).textContent;
            const importDate = new Date(dateText);

            // Search filter
            const matchesSearch =
              importName.includes(searchTerm) ||
              supplierName.includes(searchTerm);

            // Supplier filter
            const matchesSupplier =
              supplierFilter === "all" || supplierId === supplierFilter;

            // Date filter
            let matchesDate = true;
            if (dateFilter !== "all") {
              if (dateFilter === "today") {
                matchesDate =
                  importDate.toDateString() === today.toDateString();
              } else if (dateFilter === "week") {
                const weekAgo = new Date(today);
                weekAgo.setDate(today.getDate() - 7);
                matchesDate = importDate >= weekAgo;
              } else if (dateFilter === "month") {
                matchesDate =
                  importDate.getMonth() === today.getMonth() &&
                  importDate.getFullYear() === today.getFullYear();
              } else if (dateFilter === "quarter") {
                const currentQuarter = Math.floor(today.getMonth() / 3);
                const importQuarter = Math.floor(importDate.getMonth() / 3);
                matchesDate =
                  importQuarter === currentQuarter &&
                  importDate.getFullYear() === today.getFullYear();
              }
            }

            // Show or hide based on all filters
            if (matchesSearch && matchesSupplier && matchesDate) {
              card.style.display = "";
            } else {
              card.style.display = "none";
            }
          });

          // Show "no results" message if needed
          const visibleCards = document.querySelectorAll(
            ".stock-card:not([style='display: none;'])"
          );
          const noDataMessage = document.querySelector(".no-data-message");

          if (visibleCards.length === 0 && !noDataMessage) {
            const stockGrid = document.querySelector(".stock-grid");
            const message = document.createElement("div");
            message.className = "no-data-message";
            message.innerHTML = "<p>No imports match your filter criteria.</p>";
            stockGrid.appendChild(message);
          } else if (visibleCards.length > 0 && noDataMessage) {
            noDataMessage.remove();
          }
        }

        // Auto-dismiss alerts after 5 seconds
        const alerts = document.querySelectorAll(".alert");
        alerts.forEach((alert) => {
          setTimeout(() => {
            if (alert && alert.parentNode) {
              alert.style.display = "none";
            }
          }, 5000);
        });
      });
    </script>
  </body>
</html>
