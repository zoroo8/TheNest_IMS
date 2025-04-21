<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
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
        <a href="products" class="menu-item active">
          <i class="bi bi-cart"></i>
          <span>Products</span>
        </a>
        <a href="stock-requests" class="menu-item">
          <i class="bi bi-list-check"></i>
          <span>Stock Requests</span>
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
          <div class="stat-value">6</div>
          <div class="stat-label">Total Products</div>
        </div>
        <div class="stat-card">
          <div class="stat-icon low-stock-icon">
            <i class="bi bi-exclamation-triangle"></i>
          </div>
          <div class="stat-value">2</div>
          <div class="stat-label">Low Stock</div>
        </div>
        <div class="stat-card">
          <div class="stat-icon out-of-stock-icon">
            <i class="bi bi-x-circle"></i>
          </div>
          <div class="stat-value">0</div>
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
              <option value="groceries">Groceries</option>
              <option value="furnitures">Furnitures</option>
              <option value="beverages">Beverages</option>
              <option value="clothing">Clothing</option>
              <option value="electronics">Electronics</option>
            </select>
          </div>
          <div class="col-md-3">
            <select class="form-control" id="filterSupplier">
              <option value="all" selected>All Suppliers</option>
              <option value="supplier1">Supplier 1</option>
              <option value="supplier2">Supplier 2</option>
              <option value="supplier3">Supplier 3</option>
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
          <span class="badge badge-primary">Total: 6 Products</span>
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
                <tr class="category-groceries">
                  <td>Rice</td>
                  <td>403</td>
                  <td><span class="badge badge-groceries">Groceries</span></td>
                  <td>2400</td>
                  <td>
                    <div class="action-buttons">
                      <button
                        class="action-btn view-btn"
                        data-id="1"
                        title="View"
                      >
                        <i class="bi bi-eye"></i>
                      </button>
                      <button
                        class="action-btn edit-btn"
                        data-id="1"
                        title="Edit"
                      >
                        <i class="bi bi-pencil"></i>
                      </button>
                      <button
                        class="action-btn delete-btn"
                        data-id="1"
                        title="Delete"
                      >
                        <i class="bi bi-trash"></i>
                      </button>
                    </div>
                  </td>
                </tr>
                <tr class="category-groceries">
                  <td>Lentils</td>
                  <td>381</td>
                  <td><span class="badge badge-groceries">Groceries</span></td>
                  <td>1500</td>
                  <td>
                    <div class="action-buttons">
                      <button
                        class="action-btn view-btn"
                        data-id="2"
                        title="View"
                      >
                        <i class="bi bi-eye"></i>
                      </button>
                      <button
                        class="action-btn edit-btn"
                        data-id="2"
                        title="Edit"
                      >
                        <i class="bi bi-pencil"></i>
                      </button>
                      <button
                        class="action-btn delete-btn"
                        data-id="2"
                        title="Delete"
                      >
                        <i class="bi bi-trash"></i>
                      </button>
                    </div>
                  </td>
                </tr>
                <tr class="category-furnitures">
                  <td>Chair</td>
                  <td>41</td>
                  <td>
                    <span class="badge badge-furnitures">Furnitures</span>
                  </td>
                  <td>4500</td>
                  <td>
                    <div class="action-buttons">
                      <button
                        class="action-btn view-btn"
                        data-id="3"
                        title="View"
                      >
                        <i class="bi bi-eye"></i>
                      </button>
                      <button
                        class="action-btn edit-btn"
                        data-id="3"
                        title="Edit"
                      >
                        <i class="bi bi-pencil"></i>
                      </button>
                      <button
                        class="action-btn delete-btn"
                        data-id="3"
                        title="Delete"
                      >
                        <i class="bi bi-trash"></i>
                      </button>
                    </div>
                  </td>
                </tr>
                <tr class="category-beverages">
                  <td>Sprite</td>
                  <td>500</td>
                  <td><span class="badge badge-beverages">Beverages</span></td>
                  <td>150</td>
                  <td>
                    <div class="action-buttons">
                      <button
                        class="action-btn view-btn"
                        data-id="4"
                        title="View"
                      >
                        <i class="bi bi-eye"></i>
                      </button>
                      <button
                        class="action-btn edit-btn"
                        data-id="4"
                        title="Edit"
                      >
                        <i class="bi bi-pencil"></i>
                      </button>
                      <button
                        class="action-btn delete-btn"
                        data-id="4"
                        title="Delete"
                      >
                        <i class="bi bi-trash"></i>
                      </button>
                    </div>
                  </td>
                </tr>
                <tr class="category-clothing">
                  <td>T-shirt</td>
                  <td>120</td>
                  <td><span class="badge badge-clothing">Clothing</span></td>
                  <td>800</td>
                  <td>
                    <div class="action-buttons">
                      <button
                        class="action-btn view-btn"
                        data-id="5"
                        title="View"
                      >
                        <i class="bi bi-eye"></i>
                      </button>
                      <button
                        class="action-btn edit-btn"
                        data-id="5"
                        title="Edit"
                      >
                        <i class="bi bi-pencil"></i>
                      </button>
                      <button
                        class="action-btn delete-btn"
                        data-id="5"
                        title="Delete"
                      >
                        <i class="bi bi-trash"></i>
                      </button>
                    </div>
                  </td>
                </tr>
                <tr class="category-electronics">
                  <td>Headphones</td>
                  <td>25</td>
                  <td>
                    <span class="badge badge-electronics">Electronics</span>
                  </td>
                  <td>3500</td>
                  <td>
                    <div class="action-buttons">
                      <button
                        class="action-btn view-btn"
                        data-id="6"
                        title="View"
                      >
                        <i class="bi bi-eye"></i>
                      </button>
                      <button
                        class="action-btn edit-btn"
                        data-id="6"
                        title="Edit"
                      >
                        <i class="bi bi-pencil"></i>
                      </button>
                      <button
                        class="action-btn delete-btn"
                        data-id="6"
                        title="Delete"
                      >
                        <i class="bi bi-trash"></i>
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
        <form id="productForm">
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
              <option value="groceries">Groceries</option>
              <option value="furnitures">Furnitures</option>
              <option value="beverages">Beverages</option>
              <option value="clothing">Clothing</option>
              <option value="electronics">Electronics</option>
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
              <option value="supplier1">Supplier 1</option>
              <option value="supplier2">Supplier 2</option>
              <option value="supplier3">Supplier 3</option>
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
        </form>
      </div>
      <div class="modal-footer">
        <button class="btn btn-outline" id="cancelBtn">Cancel</button>
        <button class="btn btn-primary" id="saveProductBtn">
          Save Product
        </button>
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
          const categoryValue = categoryFilter.value;
          const supplierValue = supplierFilter.value;
          const activeView = document
            .querySelector(".view-toggle-btn.active")
            .getAttribute("data-view");

          let visibleCount = 0;

          productRows.forEach((row) => {
            const productName = row.cells[0].textContent.toLowerCase();
            const categoryClass = row.className;

            // Check if product matches search term
            const matchesSearch = productName.includes(searchTerm);

            // Check if product matches category filter
            const matchesCategory =
              categoryValue === "all" ||
              (categoryValue === "groceries" &&
                categoryClass.includes("category-groceries")) ||
              (categoryValue === "furnitures" &&
                categoryClass.includes("category-furnitures")) ||
              (categoryValue === "beverages" &&
                categoryClass.includes("category-beverages")) ||
              (categoryValue === "clothing" &&
                categoryClass.includes("category-clothing")) ||
              (categoryValue === "electronics" &&
                categoryClass.includes("category-electronics"));

            // Check if product matches supplier filter
            const matchesSupplier = supplierValue === "all"; // Update this based on your data structure

            // Check if product matches view toggle
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
            viewProductSupplier.textContent = "Supplier 1"; // Example data
            viewProductDescription.textContent =
              "This is a sample description for " + row.cells[0].textContent; // Example data

            openModal(viewProductModal);
          });
        });

        // Edit Product buttons
        editButtons.forEach((button) => {
          button.addEventListener("click", function () {
            const productId = this.getAttribute("data-id");
            const row = this.closest("tr");

            document.getElementById("modalTitle").textContent = "Edit Product";

            // Populate form with data from the row
            document.getElementById("productId").value = productId;
            document.getElementById("productName").value =
              row.cells[0].textContent;
            document.getElementById("productQuantity").value =
              row.cells[1].textContent;
            document.getElementById("productPrice").value =
              row.cells[3].textContent;

            // Set category based on badge class
            const categoryBadge = row.cells[2].querySelector(".badge");
            const categoryClass = categoryBadge.className;

            if (categoryClass.includes("badge-groceries")) {
              document.getElementById("productCategory").value = "groceries";
            } else if (categoryClass.includes("badge-furnitures")) {
              document.getElementById("productCategory").value = "furnitures";
            } else if (categoryClass.includes("badge-beverages")) {
              document.getElementById("productCategory").value = "beverages";
            } else if (categoryClass.includes("badge-clothing")) {
              document.getElementById("productCategory").value = "clothing";
            } else if (categoryClass.includes("badge-electronics")) {
              document.getElementById("productCategory").value = "electronics";
            }

            // Example data for supplier and description
            document.getElementById("productSupplier").value = "supplier1";
            document.getElementById("productDescription").value =
              "This is a sample description for " + row.cells[0].textContent;

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

            document.getElementById("productName").value =
              viewProductName.textContent;

            // Extract category from view modal
            const category = viewProductCategory.textContent.toLowerCase();
            if (category === "groceries") {
              document.getElementById("productCategory").value = "groceries";
            } else if (category === "furnitures") {
              document.getElementById("productCategory").value = "furnitures";
            } else if (category === "beverages") {
              document.getElementById("productCategory").value = "beverages";
            } else if (category === "clothing") {
              document.getElementById("productCategory").value = "clothing";
            } else if (category === "electronics") {
              document.getElementById("productCategory").value = "electronics";
            }

            // Extract quantity from view modal
            document.getElementById("productQuantity").value =
              viewProductQuantity.textContent;

            // Extract price from view modal (remove 'Rs ' prefix)
            const priceText = viewProductPrice.textContent;
            document.getElementById("productPrice").value = priceText.replace(
              "Rs ",
              ""
            );

            // Set supplier and description from view modal
            document.getElementById("productSupplier").value =
              viewProductSupplier.textContent === "Supplier 1"
                ? "supplier1"
                : viewProductSupplier.textContent === "Supplier 2"
                ? "supplier2"
                : "supplier3";
            document.getElementById("productDescription").value =
              viewProductDescription.textContent;

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
                  viewProductSupplier.textContent =
                    formData.supplier === "supplier1"
                      ? "Supplier 1"
                      : formData.supplier === "supplier2"
                      ? "Supplier 2"
                      : "Supplier 3";
                  viewProductDescription.textContent = formData.description;

                  openModal(viewProductModal);
                });

                newEditBtn.addEventListener("click", function () {
                  document.getElementById("modalTitle").textContent =
                    "Edit Product";

                  document.getElementById("productId").value = newId;
                  document.getElementById("productName").value = formData.name;
                  document.getElementById("productCategory").value =
                    formData.category;
                  document.getElementById("productQuantity").value =
                    formData.quantity;
                  document.getElementById("productPrice").value =
                    formData.price;
                  document.getElementById("productSupplier").value =
                    formData.supplier;
                  document.getElementById("productDescription").value =
                    formData.description;

                  openModal(productModal);
                });

                newDeleteBtn.addEventListener("click", function () {
                  deleteProductName.textContent = formData.name;
                  confirmDeleteBtn.setAttribute("data-id", newId);
                  openModal(deleteModal);
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
            const productId = this.getAttribute("data-id");
            const row = document
              .querySelector(`tr .delete-btn[data-id="${productId}"]`)
              .closest("tr");

            // Remove the row
            row.remove();

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
            alert("Product deleted successfully!");
          });
        }

        // Initialize filters
        filterProducts();
      });
    </script>
  </body>
</html>
