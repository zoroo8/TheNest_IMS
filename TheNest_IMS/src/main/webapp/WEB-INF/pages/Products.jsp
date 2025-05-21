<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%> <%@ taglib uri="http://java.sun.com/jsp/jstl/core"
prefix="c" %> <%@ taglib uri="http://java.sun.com/jsp/jstl/functions"
prefix="fn" %> <% Integer userId = (Integer) session.getAttribute("userId"); if
(userId != null) { %>
<p>Logged in as user ID: <%= userId %></p>
<% } %>

<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Products - The Nest Inventory System</title>
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
      href="${pageContext.request.contextPath}/resources/css/Products.css"
    />
    <style>
      .alert {
        padding: 12px 20px;
        margin-bottom: 20px;
        border-radius: var(--border-radius);
        position: relative;
        display: flex;
        align-items: center;
        animation: fadeIn 0.3s ease-out;
      }

      .alert-success {
        background-color: rgba(76, 175, 80, 0.1);
        color: var(--success-color); /* Ensure --success-color is defined in your main CSS */
        border-left: 4px solid var(--success-color); /* Ensure --success-color is defined */
      }

      .alert-danger {
        background-color: rgba(244, 67, 54, 0.1); /* Example danger color */
        color: var(--danger-color); /* Ensure --danger-color is defined in your main CSS */
        border-left: 4px solid var(--danger-color); /* Ensure --danger-color is defined */
      }

      .alert .dismiss-btn {
        position: absolute;
        right: 10px;
        top: 50%;
        transform: translateY(-50%);
        background: transparent;
        border: none;
        cursor: pointer;
        font-size: 1.2rem; /* Adjusted for better visibility */
        opacity: 0.6;
        transition: opacity 0.2s;
        padding: 5px; /* Add some padding for easier clicking */
      }
       .alert .dismiss-btn::before {
        content: "\00D7"; /* Unicode multiplication sign (X) */
        font-weight: bold;
      }

      .alert .dismiss-btn:hover {
        opacity: 1;
      }

      @keyframes fadeIn {
        from { opacity: 0; transform: translateY(-10px); }
        to { opacity: 1; transform: translateY(0); }
      }

      @keyframes fadeOut {
        from { opacity: 1; transform: translateY(0); }
        to { opacity: 0; transform: translateY(-10px); }
      }

      .alert.fade-out {
        animation: fadeOut 0.3s ease-out forwards;
      }
    </style>
  </head>
  <body>
    <jsp:include page="components/Sidebar.jsp" />

    <!-- Main Content -->
    <div class="main-content">
      <!-- Display success/error messages (New Structure) -->
      <c:if test="${not empty sessionScope.successMessage}">
        <div class="alert alert-success">
          <i class="bi bi-check-circle" style="margin-right: 10px; font-size: 1.1rem;"></i>
          <c:out value="${sessionScope.successMessage}" />
          <button type="button" class="dismiss-btn" onclick="dismissAlert(this.parentElement)"></button>
        </div>
        <c:remove var="successMessage" scope="session" />
      </c:if>

      <c:if test="${not empty sessionScope.errorMessage}">
        <div class="alert alert-danger">
          <i class="bi bi-exclamation-circle" style="margin-right: 10px; font-size: 1.1rem;"></i>
          <c:out value="${sessionScope.errorMessage}" />
          <button type="button" class="dismiss-btn" onclick="dismissAlert(this.parentElement)"></button>
        </div>
        <c:remove var="errorMessage" scope="session" />
      </c:if>

      <div class="page-header">
        <h1 class="page-title">Manage Products</h1>
        <button class="btn btn-primary" id="addProductBtn">
          <i class="bi bi-plus-circle"></i> Add New Product
        </button>
      </div>

      <!-- Stats Cards -->
      <div class="stats-row">
        <div class="stat-card">
          <div class="stat-icon total-products-icon">
            <i class="bi bi-box-seam"></i>
          </div>
          <div class="stat-value"><c:out value="${totalProducts}" /></div>
          <div class="stat-label">Total Products</div>
        </div>
        <div class="stat-card">
          <div class="stat-icon low-stock-icon">
            <i class="bi bi-exclamation-triangle"></i>
          </div>
          <div class="stat-value"><c:out value="${lowStockCount}" /></div>
          <div class="stat-label">Low Stock</div>
        </div>
        <div class="stat-card">
          <div class="stat-icon out-of-stock-icon">
            <i class="bi bi-x-circle"></i>
          </div>
          <div class="stat-value"><c:out value="${outOfStockCount}" /></div>
          <div class="stat-label">Out of Stock</div>
        </div>
      </div>

      <!-- View Toggle -->
      <div class="view-toggle">
        <button class="view-toggle-btn active" data-view="all">
          All Products
        </button>
        <button class="view-toggle-btn" data-view="groceries">Groceries</button>
        <button class="view-toggle-btn" data-view="furnitures">
          Furnitures
        </button>
        <button class="view-toggle-btn" data-view="beverages">Beverages</button>
        <button class="view-toggle-btn" data-view="clothing">Clothing</button>
        <button class="view-toggle-btn" data-view="electronics">
          Electronics
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
                placeholder="Search products..."
                id="searchProducts"
              />
            </div>
          </div>
          <div class="col-md-3">
            <select class="form-control" id="filterCategory">
              <option value="all" selected>All Categories</option>
              <c:forEach var="cat" items="${categories}">
                <option value="${fn:toLowerCase(cat.name)}">
                  <c:out value="${cat.name}" />
                </option>
              </c:forEach>
            </select>
          </div>
          <div class="col-md-3">
            <select class="form-control" id="filterSupplier">
              <option value="all" selected>All Suppliers</option>
              <c:forEach var="sup" items="${suppliers}">
                <option value="${sup.supplierId}">
                  <c:out value="${sup.supplierName}" />
                </option>
              </c:forEach>
            </select>
          </div>
          <div class="col-md-2">
            <button class="btn btn-outline" id="resetFilters">Reset</button>
          </div>
        </div>
      </div>

      <!-- Products Table -->
      <div class="card">
        <div class="card-header">
          <h2 class="card-title">All Products</h2>
          <span class="badge badge-primary">Total: <c:out value="${totalProducts}" /> Products</span>
        </div>
        <div class="card-body">
          <div class="table-container">
            <table>
              <thead>
                <tr>
                  <th class="sortable">
                    Product <i class="bi bi-caret-up-fill"></i>
                  </th>
                  <th class="sortable">
                    Quantity <i class="bi bi-caret-down-fill"></i>
                  </th>
                  <th>Category</th>
                  <th>Price (Rs)</th>
                  <th>Actions</th>
                </tr>
              </thead>
              <tbody>
                <c:forEach items="${products}" var="product">
                  <tr class="category-${fn:toLowerCase(product.categoryName)}" data-supplier-id="${product.supplierId}" data-category-id="${product.categoryId}" data-product-id="${product.productId}" data-description="<c:out value="${product.description}"/>" data-supplier-name="<c:out value="${product.supplierName}"/>" data-category-name="<c:out value="${product.categoryName}"/>">
                    <td><c:out value="${product.productName}" /></td>
                    <td><c:out value="${product.stock}" /></td>
                    <td>
                      <c:forEach items="${categories}" var="category">
                        <c:if test="${category.id == product.categoryId}">
                          <span
                            class="badge badge-${fn:toLowerCase(category.name)}"
                            ><c:out value="${category.name}"
                          /></span>
                        </c:if>
                      </c:forEach>
                    </td>
                    <td><c:out value="${product.price}" /></td>
                    <td>
                      <div class="action-buttons">
                        <button
                          class="action-btn view-btn"
                          data-id="${product.productId}"
                          title="View"
                        >
                          <i class="bi bi-eye"></i>
                        </button>
                        <button
                          class="action-btn edit-btn"
                          data-id="${product.productId}"
                          title="Edit"
                        >
                          <i class="bi bi-pencil"></i>
                        </button>
                        <button
                          class="action-btn delete-btn"
                          data-id="${product.productId}"
                          title="Delete"
                        >
                          <i class="bi bi-trash"></i>
                        </button>
                      </div>
                    </td>
                  </tr>
                </c:forEach>
              </tbody>
            </table>
          </div>
        </div>
        <div class="card-footer">
          <ul class="pagination">
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
          </ul>
        </div>
      </div>
    </div>

    <!-- Add/Edit Product Modal -->
    <div class="modal-backdrop" id="modalBackdrop"></div>
    <div class="modal" id="productModal">
      <div class="modal-header">
        <h3 class="modal-title" id="modalTitle">Add New Product</h3>
        <button class="modal-close" id="closeModal">&times;</button>
      </div>
      <div class="modal-body">
        <form
          id="productForm"
          action="<%=request.getContextPath()%>/products"
          method="post"
        >
          <input type="hidden" id="productId" name="productId" value="" />

          <div class="form-group">
            <label for="productName" class="form-label">Product Name</label>
            <input
              type="text"
              class="form-control"
              id="productName"
              name="productName"
              required
            />
          </div>

          <div class="form-group">
            <label for="productCategory" class="form-label">Category</label>
            <select
              class="form-control"
              id="productCategory"
              name="productCategory"
              required
            >
              <option value="">Select Category</option>
              <c:forEach var="cat" items="${categories}">
                <option value="${cat.id}">${cat.name}</option>
              </c:forEach>
            </select>
          </div>

          <div class="form-group">
            <label for="productQuantity" class="form-label">Quantity</label>
            <input
              type="number"
              class="form-control"
              id="productQuantity"
              name="productQuantity"
              min="0"
              required
            />
          </div>

          <div class="form-group">
            <label for="productPrice" class="form-label">Price (Rs)</label>
            <input
              type="number"
              class="form-control"
              id="productPrice"
              name="productPrice"
              min="0"
              step="0.01"
              required
            />
          </div>

          <div class="form-group">
            <label for="productSupplier" class="form-label">Supplier</label>
            <select
              class="form-control"
              id="productSupplier"
              name="productSupplier"
              required
            >
              <option value="">Select Supplier</option>
              <c:forEach var="sup" items="${suppliers}">
                <option value="${sup.supplierId}">${sup.supplierName}</option>
              </c:forEach>
            </select>
          </div>
          <div class="form-group">
            <label for="productImport" class="form-label">Import</label>
            <select
              class="form-control"
              id="productImport"
              name="productImport"
              required
            >
              <option value="">Select Import</option>
              <c:forEach var="imp" items="${imports}">
                <option value="${imp.importId}">
                  ${imp.importName} {ID:${imp.importId}}
                </option>
              </c:forEach>
            </select>
          </div>
          <div class="form-group">
            <label for="productDescription" class="form-label"
              >Description</label
            >
            <textarea
              class="form-control"
              id="productDescription"
              name="productDescription"
              rows="3"
            ></textarea>
          </div>
          <div class="modal-footer">
            <button type="button" class="btn btn-outline" id="cancelBtn">
              Cancel
            </button>
            <button
              type="submit"
              class="btn btn-primary"
              name="saveProductBtn"
              id="saveProductBtn"
            >
              Save Product
            </button>
          </div>
        </form>
      </div>
    </div>

    <!-- View Product Modal -->
    <div class="modal" id="viewProductModal">
      <div class="modal-header">
        <h3 class="modal-title">Product Details</h3>
        <button class="modal-close" id="closeViewModal">&times;</button>
      </div>
      <div class="modal-body">
        <div class="product-details">
          <h4 id="viewProductName">Product Name</h4>
          <div class="product-info-row">
            <div class="product-info-label">Category:</div>
            <div class="product-info-value" id="viewProductCategory">
              Category
            </div>
          </div>
          <div class="product-info-row">
            <div class="product-info-label">Quantity:</div>
            <div class="product-info-value" id="viewProductQuantity">0</div>
          </div>
          <div class="product-info-row">
            <div class="product-info-label">Price:</div>
            <div class="product-info-value" id="viewProductPrice">Rs 0</div>
          </div>
          <div class="product-info-row">
            <div class="product-info-label">Supplier:</div>
            <div class="product-info-value" id="viewProductSupplier">
              Supplier
            </div>
          </div>
          <div class="product-info-row">
            <div class="product-info-label">Description:</div>
            <div class="product-info-value" id="viewProductDescription">
              Description
            </div>
          </div>
        </div>
      </div>
      <div class="modal-footer">
        <button class="btn btn-outline" id="closeViewBtn">Close</button>
        <button class="btn btn-primary" id="editFromViewBtn">Edit</button>
      </div>
    </div>

    <!-- Delete Confirmation Modal -->
    <div class="modal" id="deleteModal">
      <div class="modal-header">
        <h3 class="modal-title">Confirm Delete</h3>
        <button class="modal-close" id="closeDeleteModal">&times;</button>
      </div>
      <div class="modal-body">
        <p>
          Are you sure you want to delete this product? This action cannot be
          undone.
        </p>
        <p class="text-danger">
          <strong>Product: <span id="deleteProductName"></span></strong>
        </p>
      </div>
      <div class="modal-footer">
        <button class="btn btn-outline" id="cancelDeleteBtn">Cancel</button>
        <button class="btn btn-danger" id="confirmDeleteBtn">Delete</button>
      </div>
    </div>

    <form
      id="deleteProductForm"
      action="<%=request.getContextPath()%>/products"
      method="post"
      style="display: none"
    >
      <input type="hidden" name="action" value="delete" />
      <input type="hidden" id="deleteProductId" name="productId" />
    </form>

    <!-- JavaScript for functionality -->
    <script>
      document.addEventListener("DOMContentLoaded", function () {
        // Elements
        const searchInput = document.getElementById("searchProducts");
        const categoryFilter = document.getElementById("filterCategory");
        const supplierFilter = document.getElementById("filterSupplier");
        const resetFiltersBtn = document.getElementById("resetFilters");
        const viewToggleBtns = document.querySelectorAll(".view-toggle-btn");
        const productRows = document.querySelectorAll("tbody tr");
        const totalBadge = document.querySelector(".badge-primary");

        // Modal elements
        const modalBackdrop = document.getElementById("modalBackdrop");
        const productModal = document.getElementById("productModal");
        const viewProductModal = document.getElementById("viewProductModal");
        const deleteModal = document.getElementById("deleteModal");
        const closeModal = document.getElementById("closeModal");
        const closeViewModal = document.getElementById("closeViewModal");
        const closeDeleteModal = document.getElementById("closeDeleteModal");
        const addProductBtn = document.getElementById("addProductBtn");
        const saveProductBtn = document.getElementById("saveProductBtn");
        const cancelBtn = document.getElementById("cancelBtn");
        const closeViewBtn = document.getElementById("closeViewBtn");
        const editFromViewBtn = document.getElementById("editFromViewBtn");
        const cancelDeleteBtn = document.getElementById("cancelDeleteBtn");
        const confirmDeleteBtn = document.getElementById("confirmDeleteBtn");

        // Action buttons
        const viewButtons = document.querySelectorAll(".view-btn");
        const editButtons = document.querySelectorAll(".edit-btn");
        const deleteButtons = document.querySelectorAll(".delete-btn");

        // Form elements
        const productForm = document.getElementById("productForm");
        const productId = document.getElementById("productId");
        const productName = document.getElementById("productName");
        const productCategory = document.getElementById("productCategory");
        const productQuantity = document.getElementById("productQuantity");
        const productPrice = document.getElementById("productPrice");
        const productSupplier = document.getElementById("productSupplier");
        const productDescription =
          document.getElementById("productDescription");
        const productImportSelect = document.getElementById("productImport");

        // View elements
        const viewProductName = document.getElementById("viewProductName");
        const viewProductCategory = document.getElementById(
          "viewProductCategory"
        );
        const viewProductQuantity = document.getElementById(
          "viewProductQuantity"
        );
        const viewProductPrice = document.getElementById("viewProductPrice");
        const viewProductSupplier = document.getElementById(
          "viewProductSupplier"
        );
        const viewProductDescription = document.getElementById(
          "viewProductDescription"
        );

        // Delete elements
        const deleteProductName = document.getElementById("deleteProductName");

        // Search and filter functionality
        function filterProducts() {
          const searchTerm = searchInput.value.toLowerCase();
          const categoryValue = categoryFilter.value; // This is already lowercase category name
          const supplierValue = supplierFilter.value; // This will be supplier ID or "all"
          const activeView = document
            .querySelector(".view-toggle-btn.active")
            .getAttribute("data-view");

          let visibleCount = 0;

          productRows.forEach((row) => {
            const productNameText = row.cells[0].textContent.toLowerCase();
            const categoryClass = row.className; // e.g., "category-groceries"
            const supplierIdFromRow = row.dataset.supplierId;

            // Check if product matches search term
            const matchesSearch = productNameText.includes(searchTerm);

            // Check if product matches category filter (uses category name from class)
            const matchesCategory =
              categoryValue === "all" ||
              categoryClass.includes("category-" + categoryValue);

            // Check if product matches supplier filter (uses supplier ID)
            const matchesSupplier = 
              supplierValue === "all" || 
              supplierIdFromRow === supplierValue;

            // Check if product matches view toggle (uses category name from class)
            const matchesView =
              activeView === "all" ||
              categoryClass.includes("category-" + activeView);

            // Show or hide the row based on all filters
            if (
              matchesSearch &&
              matchesCategory &&
              matchesSupplier &&
              matchesView
            ) {
              row.style.display = "";
              visibleCount++;
            } else {
              row.style.display = "none";
            }
          });

          // Update the total products count in the badge
          if (totalBadge) {
            totalBadge.textContent = `Total: ${visibleCount} Products`;
          }
        }

        // Add event listeners for search and filters
        if (searchInput) {
          searchInput.addEventListener("input", filterProducts);
        }

        if (categoryFilter) {
          categoryFilter.addEventListener("change", filterProducts);
        }

        if (supplierFilter) {
          supplierFilter.addEventListener("change", filterProducts);
        }

        if (resetFiltersBtn) {
          resetFiltersBtn.addEventListener("click", function () {
            searchInput.value = "";
            categoryFilter.value = "all";
            supplierFilter.value = "all";
            filterProducts();
          });
        }

        // View toggle functionality
        viewToggleBtns.forEach((btn) => {
          btn.addEventListener("click", function () {
            viewToggleBtns.forEach((b) => b.classList.remove("active"));
            this.classList.add("active");
            filterProducts();
          });
        });

        // Sort functionality
        const sortableHeaders = document.querySelectorAll("th.sortable");
        sortableHeaders.forEach((header) => {
          header.addEventListener("click", function () {
            const isAscending =
              this.querySelector("i").classList.contains("bi-caret-up-fill");
            sortTable(this, !isAscending);
          });
        });

        function sortTable(header, ascending) {
          const table = header.closest("table");
          const columnIndex = Array.from(header.parentNode.children).indexOf(
            header
          );
          const rows = Array.from(table.querySelectorAll("tbody tr"));

          // Update sort icon
          const icons = document.querySelectorAll("th.sortable i");
          icons.forEach((icon) => {
            icon.className = "bi bi-caret-down-fill";
          });

          const currentIcon = header.querySelector("i");
          currentIcon.className = ascending
            ? "bi bi-caret-up-fill"
            : "bi bi-caret-down-fill";

          // Sort rows
          rows.sort((a, b) => {
            let aValue = a.cells[columnIndex].textContent.trim();
            let bValue = b.cells[columnIndex].textContent.trim();

            // Check if values are numbers
            if (!isNaN(aValue) && !isNaN(bValue)) {
              aValue = parseFloat(aValue);
              bValue = parseFloat(bValue);
            } else {
              aValue = aValue.toLowerCase();
              bValue = bValue.toLowerCase();
            }

            if (aValue < bValue) {
              return ascending ? -1 : 1;
            }
            if (aValue > bValue) {
              return ascending ? 1 : -1;
            }
            return 0;
          });

          // Reappend rows in the new order
          const tbody = table.querySelector("tbody");
          rows.forEach((row) => tbody.appendChild(row));
        }

        // Modal functionality
        function openModal(modal) {
          modalBackdrop.style.display = "block";
          modal.style.display = "block";
          document.body.style.overflow = "hidden";
        }

        function closeAllModals() {
          modalBackdrop.style.display = "none";
          productModal.style.display = "none";
          viewProductModal.style.display = "none";
          deleteModal.style.display = "none";
          document.body.style.overflow = "";
        }

        // Add Product button
        if (addProductBtn) {
          addProductBtn.addEventListener("click", function () {
            document.getElementById("modalTitle").textContent =
              "Add New Product";
            productForm.reset();
            productId.value = "";
            openModal(productModal);
          });
        }

        // View Product buttons
        viewButtons.forEach((button) => {
          button.addEventListener("click", function () {
            const productId = this.getAttribute("data-id");
            const row = this.closest("tr");

            // Populate view modal with data from the row
            viewProductName.textContent = row.cells[0].textContent;
            viewProductCategory.textContent =
              row.cells[2].querySelector(".badge").textContent;
            viewProductQuantity.textContent = row.cells[1].textContent;
            viewProductPrice.textContent = "Rs " + row.cells[3].textContent;
            // viewProductSupplier.textContent = "Supplier 1"; // Example data removed
            // viewProductDescription.textContent =
            //   "This is a sample description for " + row.cells[0].textContent; // Example data removed

            // Fetch actual supplier and description if available, or leave blank/placeholder
            viewProductSupplier.textContent = ""; // Or fetch from data attribute if available
            viewProductDescription.textContent = ""; // Or fetch from data attribute if available

            openModal(viewProductModal);
          });
        });

        // Edit Product buttons
        editButtons.forEach((button) => {
          button.addEventListener("click", function () {
            const productIdValue = this.getAttribute("data-id"); // Renamed to avoid conflict
            const row = this.closest("tr");

            document.getElementById("modalTitle").textContent = "Edit Product";

            // Populate form with data from the row
            productId.value = productIdValue; // Use the renamed variable
            productName.value = row.cells[0].textContent;
            productQuantity.value = row.cells[1].textContent;
            productPrice.value = row.cells[3].textContent;

            // Set category based on badge class
            const categoryBadge = row.cells[2].querySelector(".badge");
            const categoryClass = categoryBadge.className;
            let categoryValue = ""; // Variable to hold the category value

            if (categoryClass.includes("badge-groceries")) {
              categoryValue = "groceries";
            } else if (categoryClass.includes("badge-furnitures")) {
              categoryValue = "furnitures";
            } else if (categoryClass.includes("badge-beverages")) {
              categoryValue = "beverages";
            } else if (categoryClass.includes("badge-clothing")) {
              categoryValue = "clothing";
            } else if (categoryClass.includes("badge-electronics")) {
              categoryValue = "electronics";
            }
            // Ensure productCategory element exists before setting its value
            if (productCategory) {
              productCategory.value = categoryValue;
            }

            // Example data for supplier and description removed
            // document.getElementById("productSupplier").value = "supplier1";
            // document.getElementById("productDescription").value =
            //   "This is a sample description for " + row.cells[0].textContent;

            // Clear or fetch actual supplier and description
            if (productSupplier) {
              productSupplier.value = ""; // Or fetch from data attribute if available
            }
            if (productDescription) {
              productDescription.value = ""; // Or fetch from data attribute if available
            }

            openModal(productModal);
          });
        });

        // Delete Product buttons
        deleteButtons.forEach((button) => {
          button.addEventListener("click", function () {
            const productId = this.getAttribute("data-id");
            const row = this.closest("tr");

            deleteProductName.textContent = row.cells[0].textContent;
            openModal(deleteModal);

            // Store the product ID for the delete confirmation
            confirmDeleteBtn.setAttribute("data-id", productId);
          });
        });

        // Edit from view button
        if (editFromViewBtn) {
          editFromViewBtn.addEventListener("click", function () {
            closeAllModals();

            document.getElementById("modalTitle").textContent = "Edit Product";

            productName.value = viewProductName.textContent;

            // Extract category from view modal
            const categoryText = viewProductCategory.textContent.toLowerCase();
            let categoryValue = "";
            if (categoryText === "groceries") {
              categoryValue = "groceries";
            } else if (categoryText === "furnitures") {
              categoryValue = "furnitures";
            } else if (categoryText === "beverages") {
              categoryValue = "beverages";
            } else if (categoryText === "clothing") {
              categoryValue = "clothing";
            } else if (categoryText === "electronics") {
              categoryValue = "electronics";
            }
            if (productCategory) {
              productCategory.value = categoryValue;
            }

            // Extract quantity from view modal
            productQuantity.value = viewProductQuantity.textContent;

            // Extract price from view modal (remove 'Rs ' prefix)
            const priceText = viewProductPrice.textContent;
            productPrice.value = priceText.replace("Rs ", "");

            // Set supplier and description from view modal - remove hardcoding
            // productSupplier.value =
            //   viewProductSupplier.textContent === "Supplier 1"
            //     ? "supplier1"
            //     : viewProductSupplier.textContent === "Supplier 2"
            //     ? "supplier2"
            //     : "supplier3";
            if (productSupplier) {
              productSupplier.value = ""; // Or map from viewProductSupplier.textContent if it holds actual value/ID
            }
            if (productDescription) {
              productDescription.value = viewProductDescription.textContent; // This can stay if description is meant to be copied
            }

            openModal(productModal);
          });
        }

        // Close modal buttons
        if (closeModal) {
          closeModal.addEventListener("click", closeAllModals);
        }

        if (closeViewModal) {
          closeViewModal.addEventListener("click", closeAllModals);
        }

        if (closeDeleteModal) {
          closeDeleteModal.addEventListener("click", closeAllModals);
        }

        if (cancelBtn) {
          cancelBtn.addEventListener("click", closeAllModals);
        }

        if (closeViewBtn) {
          closeViewBtn.addEventListener("click", closeAllModals);
        }

        if (cancelDeleteBtn) {
          cancelDeleteBtn.addEventListener("click", closeAllModals);
        }

        // Save product button
        if (saveProductBtn) {
          saveProductBtn.addEventListener("click", function () {
            // Validate form
            if (productForm.checkValidity()) {
              // Get form data
              const formData = {
                id: productId.value,
                name: productName.value,
                category: productCategory.value,
                quantity: productQuantity.value,
                price: productPrice.value,
                supplier: productSupplier.value,
                description: productDescription.value,
              };

              // Here you would typically send the data to the server
              console.log("Saving product:", formData);

              // For demo purposes, update the UI directly
              if (formData.id) {
                // Update existing product
                const row = document
                  .querySelector(`tr .edit-btn[data-id="${formData.id}"]`)
                  .closest("tr");
                row.cells[0].textContent = formData.name;
                row.cells[1].textContent = formData.quantity;
                row.cells[3].textContent = formData.price;

                // Update category badge
                const badge = row.cells[2].querySelector(".badge");
                badge.textContent =
                  formData.category.charAt(0).toUpperCase() +
                  formData.category.slice(1);
                badge.className = `badge badge-${formData.category}`;

                // Update row class for filtering
                row.className = `category-${formData.category}`;
              } else {
                // Add new product
                const tbody = document.querySelector("tbody");
                const newRow = document.createElement("tr");
                newRow.className = `category-${formData.category}`;

                // Generate a new ID
                const newId = Date.now().toString();

                newRow.innerHTML = `
                  <td>${formData.name}</td>
                  <td>${formData.quantity}</td>
                  <td><span class="badge badge-${formData.category}">${
                  formData.category.charAt(0).toUpperCase() +
                  formData.category.slice(1)
                }</span></td>
                  <td>${formData.price}</td>
                  <td>
                    <div class="action-buttons">
                      <button class="action-btn view-btn" data-id="${newId}" title="View">
                        <i class="bi bi-eye"></i>
                      </button>
                      <button class="action-btn edit-btn" data-id="${newId}" title="Edit">
                        <i class="bi bi-pencil"></i>
                      </button>
                      <button class="action-btn delete-btn" data-id="${newId}" title="Delete">
                        <i class="bi bi-trash"></i>
                      </button>
                    </div>
                  </td>
                `;

                tbody.appendChild(newRow);

                // Add event listeners to new buttons
                const newViewBtn = newRow.querySelector(".view-btn");
                const newEditBtn = newRow.querySelector(".edit-btn");
                const newDeleteBtn = newRow.querySelector(".delete-btn");

                newViewBtn.addEventListener("click", function () {
                  viewProductName.textContent = formData.name;
                  viewProductCategory.textContent =
                    formData.category.charAt(0).toUpperCase() +
                    formData.category.slice(1);
                  viewProductQuantity.textContent = formData.quantity;
                  viewProductPrice.textContent = "Rs " + formData.price;
                  // viewProductSupplier.textContent =
                  //   formData.supplier === "supplier1"
                  //     ? "Supplier 1"
                  //     : formData.supplier === "supplier2"
                  //     ? "Supplier 2"
                  //     : "Supplier 3"; // Example data removed
                  // Fetch actual supplier name based on formData.supplier (which should be an ID)
                  viewProductSupplier.textContent = formData.supplier; // Or look up name
                  viewProductDescription.textContent = formData.description;

                  openModal(viewProductModal);
                });

                newEditBtn.addEventListener("click", function () {
                  document.getElementById("modalTitle").textContent =
                    "Edit Product";

                  productId.value = newId;
                  productName.value = formData.name;
                  if (productCategory)
                    productCategory.value = formData.category;
                  productQuantity.value = formData.quantity;
                  productPrice.value = formData.price;
                  if (productSupplier)
                    productSupplier.value = formData.supplier;
                  if (productDescription)
                    productDescription.value = formData.description;

                  openModal(productModal);
                });

                newDeleteBtn.addEventListener("click", function () {
                  deleteProductName.textContent = formData.name;
                  confirmDeleteBtn.setAttribute("data-id", newId);
                  openModal(deleteModal);
                });
              }
              if (productImportSelect) {
                productImportSelect.addEventListener("change", function () {
                  const selectedImportId = this.value;
                  const selectedOption = this.options[this.selectedIndex];

                  // Example: Enable quantity field only when import is selected
                  document.getElementById("productQuantity").disabled =
                    !selectedImportId;

                  // Example: Get data attributes from option
                  const availableStock = selectedOption.dataset.stock;
                  const importPrice = selectedOption.dataset.price;

                  // Example: Update form fields
                  if (selectedImportId) {
                    document.getElementById("productPrice").value =
                      importPrice || "";
                    document.getElementById("productQuantity").max =
                      availableStock || 0;
                  }

                  // Example: Show warning for out-of-stock imports
                  if (availableStock <= 0) {
                    alert("Selected import has no available stock!");
                    this.value = "";
                  }
                });
              }

              // Update stats
              const totalProductsValue = document.querySelector(
                ".total-products-icon"
              ).nextElementSibling;
              totalProductsValue.textContent =
                document.querySelectorAll("tbody tr").length;

              // Update badge count
              totalBadge.textContent = `Total: ${
                document.querySelectorAll("tbody tr").length
              } Products`;

              // Close modal
              closeAllModals();

              // Show success message (you could add a toast notification here)
              alert("Product saved successfully!");
            } else {
              // Form is invalid, trigger browser validation UI
              productForm.reportValidity();
            }
          });
        }

        // Confirm delete button
        if (confirmDeleteBtn) {
          confirmDeleteBtn.addEventListener("click", function () {
            const productIdToDelete = this.getAttribute("data-id");

            // Set the product ID in the hidden form and submit
            const deleteForm = document.getElementById("deleteProductForm");
            const deleteProductIdInput =
              document.getElementById("deleteProductId");

            if (deleteForm && deleteProductIdInput) {
              deleteProductIdInput.value = productIdToDelete;
              deleteForm.submit();
              // The page will reload due to form submission and redirect from servlet.
              // Client-side row removal and alert will be handled by page reload and success/error messages from server.
            } else {
              console.error("Delete form or product ID input not found.");
              alert("Error initiating delete. Please try again.");
              closeAllModals();
            }
          });
        }

        // Initialize filters
        filterProducts();

        function dismissAlert(alertElement) {
            if (alertElement) {
                alertElement.classList.add('fade-out');
                setTimeout(() => {
                    if (alertElement.parentNode) {
                        alertElement.parentNode.removeChild(alertElement);
                    }
                }, 300); // Matches animation duration
            }
        }

        const alerts = document.querySelectorAll('.alert'); // Select all alerts on the page
        if (alerts.length > 0) {
            alerts.forEach(alert => {
                // Auto-dismiss after 3 seconds
                setTimeout(() => {
                    dismissAlert(alert);
                }, 3000);

                // Allow manual dismissal
                const dismissButton = alert.querySelector('.dismiss-btn');
                if (dismissButton) {
                    dismissButton.onclick = function() {
                        dismissAlert(alert);
                    };
                }
            });
        }
      });
    </script>
  </body>
</html>
