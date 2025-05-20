<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ page session="true" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
    </style>
  </head>
  <body>
    <jsp:include page="components/Sidebar.jsp" />

    <!-- Main Content -->
    <div class="main-content">
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
          <div class="stat-value">28</div>
          <div class="stat-label">Total Imports</div>
        </div>
        <div class="stat-card">
          <div class="stat-icon low-stock-icon">
            <i class="bi bi-calendar-check"></i>
          </div>
          <div class="stat-value">5</div>
          <div class="stat-label">This Month</div>
        </div>
        <div class="stat-card">
          <div class="stat-icon approved-icon">
            <i class="bi bi-building"></i>
          </div>
          <div class="stat-value">4</div>
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
              <option value="1">ABC Office Supplies</option>
              <option value="2">Tech Solutions Inc.</option>
              <option value="3">Furniture World</option>
              <option value="4">General Distributors</option>
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
        <!-- Import 1 -->
        <div class="stock-card">
          <div class="stock-card-header">
            <h3 class="stock-card-title">Office Supplies Restock</h3>
            <div class="category-icon">
              <i class="bi bi-building"></i>
            </div>
          </div>
          <div class="stock-card-body">
            <div class="stock-level">ABC Office Supplies</div>
            <div class="stock-info">
              <span class="stock-label">Import ID</span>
              <span class="stock-value">IMP001</span>
            </div>
            <div class="stock-info">
              <span class="stock-label">Date</span>
              <span class="stock-value">2025-05-15</span>
            </div>
            <div class="stock-info">
              <span class="stock-label">Supplier ID</span>
              <span class="stock-value">1</span>
            </div>
            <div class="stock-info">
              <span class="stock-label">Status</span>
              <span class="badge badge-stock normal">Completed</span>
            </div>
          </div>
          <div class="stock-card-footer">
            <a href="#" class="edit-item" data-id="1">
              <i class="bi bi-pencil"></i> Edit
            </a>
            <a href="#" class="view-details" data-id="1">
              <i class="bi bi-eye"></i> View Details
            </a>
          </div>
        </div>

        <!-- Import 2 -->
        <div class="stock-card">
          <div class="stock-card-header">
            <h3 class="stock-card-title">IT Equipment Order</h3>
            <div class="category-icon">
              <i class="bi bi-building"></i>
            </div>
          </div>
          <div class="stock-card-body">
            <div class="stock-level">Tech Solutions Inc.</div>
            <div class="stock-info">
              <span class="stock-label">Import ID</span>
              <span class="stock-value">IMP002</span>
            </div>
            <div class="stock-info">
              <span class="stock-label">Date</span>
              <span class="stock-value">2025-05-10</span>
            </div>
            <div class="stock-info">
              <span class="stock-label">Supplier ID</span>
              <span class="stock-value">2</span>
            </div>
            <div class="stock-info">
              <span class="stock-label">Status</span>
              <span class="badge badge-stock high">Completed</span>
            </div>
          </div>
          <div class="stock-card-footer">
            <a href="#" class="edit-item" data-id="2">
              <i class="bi bi-pencil"></i> Edit
            </a>
            <a href="#" class="view-details" data-id="2">
              <i class="bi bi-eye"></i> View Details
            </a>
          </div>
        </div>

        <!-- Import 3 -->
        <div class="stock-card">
          <div class="stock-card-header">
            <h3 class="stock-card-title">Furniture Delivery</h3>
            <div class="category-icon">
              <i class="bi bi-building"></i>
            </div>
          </div>
          <div class="stock-card-body">
            <div class="stock-level">Furniture World</div>
            <div class="stock-info">
              <span class="stock-label">Import ID</span>
              <span class="stock-value">IMP003</span>
            </div>
            <div class="stock-info">
              <span class="stock-label">Date</span>
              <span class="stock-value">2025-05-05</span>
            </div>
            <div class="stock-info">
              <span class="stock-label">Supplier ID</span>
              <span class="stock-value">3</span>
            </div>
            <div class="stock-info">
              <span class="stock-label">Status</span>
              <span class="badge badge-stock normal">Completed</span>
            </div>
          </div>
          <div class="stock-card-footer">
            <a href="#" class="edit-item" data-id="3">
              <i class="bi bi-pencil"></i> Edit
            </a>
            <a href="#" class="view-details" data-id="3">
              <i class="bi bi-eye"></i> View Details
            </a>
          </div>
        </div>

        <!-- Import 4 -->
        <div class="stock-card">
          <div class="stock-card-header">
            <h3 class="stock-card-title">General Supplies</h3>
            <div class="category-icon">
              <i class="bi bi-building"></i>
            </div>
          </div>
          <div class="stock-card-body">
            <div class="stock-level">General Distributors</div>
            <div class="stock-info">
              <span class="stock-label">Import ID</span>
              <span class="stock-value">IMP004</span>
            </div>
            <div class="stock-info">
              <span class="stock-label">Date</span>
              <span class="stock-value">2025-04-28</span>
            </div>
            <div class="stock-info">
              <span class="stock-label">Supplier ID</span>
              <span class="stock-value">4</span>
            </div>
            <div class="stock-info">
              <span class="stock-label">Status</span>
              <span class="badge badge-stock normal">Completed</span>
            </div>
          </div>
          <div class="stock-card-footer">
            <a href="#" class="edit-item" data-id="4">
              <i class="bi bi-pencil"></i> Edit
            </a>
            <a href="#" class="view-details" data-id="4">
              <i class="bi bi-eye"></i> View Details
            </a>
          </div>
        </div>

        <!-- Import 5 -->
        <div class="stock-card">
          <div class="stock-card-header">
            <h3 class="stock-card-title">Office Equipment</h3>
            <div class="category-icon">
              <i class="bi bi-building"></i>
            </div>
          </div>
          <div class="stock-card-body">
            <div class="stock-level">ABC Office Supplies</div>
            <div class="stock-info">
              <span class="stock-label">Import ID</span>
              <span class="stock-value">IMP005</span>
            </div>
            <div class="stock-info">
              <span class="stock-label">Date</span>
              <span class="stock-value">2025-04-20</span>
            </div>
            <div class="stock-info">
              <span class="stock-label">Supplier ID</span>
              <span class="stock-value">1</span>
            </div>
            <div class="stock-info">
              <span class="stock-label">Status</span>
              <span class="badge badge-stock normal">Completed</span>
            </div>
          </div>
          <div class="stock-card-footer">
            <a href="#" class="edit-item" data-id="5">
              <i class="bi bi-pencil"></i> Edit
            </a>
            <a href="#" class="view-details" data-id="5">
              <i class="bi bi-eye"></i> View Details
            </a>
          </div>
        </div>

        <!-- Import 6 -->
        <div class="stock-card">
          <div class="stock-card-header">
            <h3 class="stock-card-title">Tech Accessories</h3>
            <div class="category-icon">
              <i class="bi bi-building"></i>
            </div>
          </div>
          <div class="stock-card-body">
            <div class="stock-level">Tech Solutions Inc.</div>
            <div class="stock-info">
              <span class="stock-label">Import ID</span>
              <span class="stock-value">IMP006</span>
            </div>
            <div class="stock-info">
              <span class="stock-label">Date</span>
              <span class="stock-value">2025-04-15</span>
            </div>
            <div class="stock-info">
              <span class="stock-label">Supplier ID</span>
              <span class="stock-value">2</span>
            </div>
            <div class="stock-info">
              <span class="stock-label">Status</span>
              <span class="badge badge-stock normal">Completed</span>
            </div>
          </div>
          <div class="stock-card-footer">
            <a href="#" class="edit-item" data-id="6">
              <i class="bi bi-pencil"></i> Edit
            </a>
            <a href="#" class="view-details" data-id="6">
              <i class="bi bi-eye"></i> View Details
            </a>
          </div>
        </div>
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
        <form id="itemForm" method="post" action="<%=request.getContextPath()%>/import">
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
			  <option value="${sup.supplierId}">
			    ${sup.supplierName}
			  </option>
			  </c:forEach>
			</select>
          </div>
          <div class="modal-footer">
	        <button class="btn btn-outline" id="closeItemModalBtn">Cancel</button>
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
            <p id="detailImportName" class="form-control-static">
              Office Supplies Restock
            </p>
          </div>

          <div class="row">
            <div class="col-md-6">
              <div class="form-group">
                <label>Import Date</label>
                <p id="detailImportDate" class="form-control-static">
                  2025-05-15
                </p>
              </div>
            </div>
            <div class="col-md-6">
              <div class="form-group">
                <label>Import ID</label>
                <p id="detailImportId" class="form-control-static">IMP001</p>
              </div>
            </div>
          </div>

          <div class="form-group">
            <label>Supplier</label>
            <p id="detailSupplier" class="form-control-static">
              ABC Office Supplies
            </p>
          </div>

          <div class="form-group">
            <label>Supplier Contact</label>
            <p id="detailSupplierContact" class="form-control-static">
              Phone: (555) 123-4567 | Email: contact@abcoffice.com
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
        // Modal elements
        const modalBackdrop = document.getElementById("modalBackdrop");
        const itemModal = document.getElementById("itemModal");
        const detailsModal = document.getElementById("orderModal");

        // Add new import button
        document
          .getElementById("addItemBtn")
          .addEventListener("click", function () {
            document.getElementById("itemModalTitle").textContent =
              "Add New Import";
            document.getElementById("itemForm").reset();
            itemModal.style.display = "block";
            modalBackdrop.style.display = "block";
          });

        // Edit import buttons
        document.querySelectorAll(".edit-item").forEach((btn) => {
          btn.addEventListener("click", function (e) {
            e.preventDefault();
            const importId = this.getAttribute("data-id");
            document.getElementById("itemModalTitle").textContent =
              "Edit Import";
            itemModal.style.display = "block";
            modalBackdrop.style.display = "block";
          });
        });

        // View details buttons
        document.querySelectorAll(".view-details").forEach((btn) => {
          btn.addEventListener("click", function (e) {
            e.preventDefault();
            const importId = this.getAttribute("data-id");
            detailsModal.style.display = "block";
            modalBackdrop.style.display = "block";
          });
        });

        // Close item modal
        document
          .getElementById("closeItemModal")
          .addEventListener("click", function () {
            itemModal.style.display = "none";
            modalBackdrop.style.display = "none";
          });

        document
          .getElementById("closeItemModalBtn")
          .addEventListener("click", function () {
            itemModal.style.display = "none";
            modalBackdrop.style.display = "none";
          });

        // Close details modal
        document
          .getElementById("closeOrderModal")
          .addEventListener("click", function () {
            detailsModal.style.display = "none";
            modalBackdrop.style.display = "none";
          });

        document
          .getElementById("closeOrderModalBtn")
          .addEventListener("click", function () {
            detailsModal.style.display = "none";
            modalBackdrop.style.display = "none";
          });

        // Save import
        document
          .getElementById("saveItemBtn")
          .addEventListener("click", function () {
            const form = document.getElementById("itemForm");
            if (form.checkValidity()) {
              alert("Import saved successfully!");
              itemModal.style.display = "none";
              modalBackdrop.style.display = "none";
            } else {
              form.reportValidity();
            }
          });

        // Print details
        document
          .getElementById("printDetailsBtn")
          .addEventListener("click", function () {
            alert("Printing import details...");
          });

        // Search functionality
        document
          .getElementById("searchItems")
          .addEventListener("input", function () {
            const searchTerm = this.value.toLowerCase();
            const cards = document.querySelectorAll(".stock-card");

            cards.forEach((card) => {
              const importName = card
                .querySelector(".stock-card-title")
                .textContent.toLowerCase();
              const supplier = card
                .querySelector(".stock-level")
                .textContent.toLowerCase();

              if (
                importName.includes(searchTerm) ||
                supplier.includes(searchTerm)
              ) {
                card.style.display = "";
              } else {
                card.style.display = "none";
              }
            });
          });

        // Filter by supplier
        document
          .getElementById("filterSupplier")
          .addEventListener("change", function () {
            const supplier = this.value;
            const cards = document.querySelectorAll(".stock-card");

            if (supplier === "all") {
              cards.forEach((card) => (card.style.display = ""));
            } else {
              cards.forEach((card) => {
                const supplierId = card.querySelector(
                  ".stock-info:nth-child(4) .stock-value"
                ).textContent;
                if (supplierId === supplier) {
                  card.style.display = "";
                } else {
                  card.style.display = "none";
                }
              });
            }
          });

        // Filter by date
        document
          .getElementById("filterDate")
          .addEventListener("change", function () {
            const dateFilter = this.value;
            const cards = document.querySelectorAll(".stock-card");
            const today = new Date();

            if (dateFilter === "all") {
              cards.forEach((card) => (card.style.display = ""));
            } else {
              cards.forEach((card) => {
                const dateText = card.querySelector(
                  ".stock-info:nth-child(3) .stock-value"
                ).textContent;
                const importDate = new Date(dateText);

                let show = false;

                if (dateFilter === "today") {
                  show = importDate.toDateString() === today.toDateString();
                } else if (dateFilter === "week") {
                  const weekAgo = new Date(today);
                  weekAgo.setDate(today.getDate() - 7);
                  show = importDate >= weekAgo;
                } else if (dateFilter === "month") {
                  show =
                    importDate.getMonth() === today.getMonth() &&
                    importDate.getFullYear() === today.getFullYear();
                } else if (dateFilter === "quarter") {
                  const currentQuarter = Math.floor(today.getMonth() / 3);
                  const importQuarter = Math.floor(importDate.getMonth() / 3);
                  show =
                    importQuarter === currentQuarter &&
                    importDate.getFullYear() === today.getFullYear();
                }

                card.style.display = show ? "" : "none";
              });
            }
          });

        // Reset filters
        document
          .getElementById("resetFilters")
          .addEventListener("click", function () {
            document.getElementById("searchItems").value = "";
            document.getElementById("filterSupplier").value = "all";
            document.getElementById("filterDate").value = "all";

            // Show all cards
            document.querySelectorAll(".stock-card").forEach((card) => {
              card.style.display = "";
            });
          });
      });
    </script>
  </body>
</html>