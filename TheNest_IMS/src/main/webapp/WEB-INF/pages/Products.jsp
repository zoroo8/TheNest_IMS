<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%> <%@ taglib uri="http://java.sun.com/jsp/jstl/core"
prefix="c" %> <%@ taglib uri="http://java.sun.com/jsp/jstl/functions"
prefix="fn" %> <% Integer userId = (Integer) session.getAttribute("userId"); if
(userId != null) { %>
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
        <c:forEach var="cat" items="${categories}">
          <button class="view-toggle-btn" data-view="${fn:toLowerCase(cat.name)}">
            <c:out value="${cat.name}" />
          </button>
        </c:forEach>
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
                  <th>Supplier</th>
                  <th>Actions</th>
                </tr>
              </thead>
              <tbody>
                <c:forEach items="${products}" var="product">
                  <tr class="category-${fn:toLowerCase(product.categoryName)}" 
                      data-supplier-id="${product.supplierId}" 
                      data-category-id="${product.categoryId}" 
                      data-product-id="${product.productId}" 
                      data-description="<c:out value="${product.description}"/>" 
                      data-supplier-name="<c:out value="${product.supplierName}"/>" 
                      data-category-name="<c:out value="${product.categoryName}"/>"
                      data-import-id="${product.importId}">
                    <td><c:out value="${product.productName}" /></td>
                    <td><c:out value="${product.stock}" /></td>
                    <td>
                      <span class="badge badge-${fn:toLowerCase(product.categoryName)}"><c:out value="${product.categoryName}"/></span>
                    </td>
                    <td><c:out value="${product.price}" /></td>
                    <td><c:out value="${product.supplierName}" /></td> 
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
      // Note: The error "net::ERR_INCOMPLETE_CHUNKED_ENCODING" is typically a server-side or network issue.
      // Review server logs and server-side code (Servlets, JSPs) for errors during response generation.
      // The following JavaScript updates address client-side logic and robustness.

      document.addEventListener("DOMContentLoaded", function () {
        // Elements
        const searchInput = document.getElementById("searchProducts");
        const categoryFilter = document.getElementById("filterCategory");
        const supplierFilter = document.getElementById("filterSupplier");
        const resetFiltersBtn = document.getElementById("resetFilters");
        const viewToggleBtns = document.querySelectorAll(".view-toggle-btn");
        const totalBadge = document.querySelector(".card-header .badge-primary");

        // Modal elements
        const modalBackdrop = document.getElementById("modalBackdrop");
        const productModal = document.getElementById("productModal");
        const viewProductModal = document.getElementById("viewProductModal");
        const deleteModal = document.getElementById("deleteModal");
        const closeModalBtn = document.getElementById("closeModal");
        const closeViewModalBtn = document.getElementById("closeViewModal");
        const closeDeleteModalBtn = document.getElementById("closeDeleteModal");
        const addProductBtn = document.getElementById("addProductBtn");
        const saveProductBtn = document.getElementById("saveProductBtn"); // This is the button of type="submit"
        const cancelBtn = document.getElementById("cancelBtn");
        const closeViewBtn = document.getElementById("closeViewBtn");
        const editFromViewBtn = document.getElementById("editFromViewBtn");
        const cancelDeleteBtn = document.getElementById("cancelDeleteBtn");
        const confirmDeleteBtn = document.getElementById("confirmDeleteBtn");

        // Form elements
        const productForm = document.getElementById("productForm");
        const productId = document.getElementById("productId");
        const productName = document.getElementById("productName");
        const productCategory = document.getElementById("productCategory");
        const productQuantity = document.getElementById("productQuantity");
        const productPrice = document.getElementById("productPrice");
        const productSupplier = document.getElementById("productSupplier");
        const productDescription = document.getElementById("productDescription");
        const productImportSelect = document.getElementById("productImport");

        // View elements
        const viewProductName = document.getElementById("viewProductName");
        const viewProductCategory = document.getElementById("viewProductCategory");
        const viewProductQuantity = document.getElementById("viewProductQuantity");
        const viewProductPrice = document.getElementById("viewProductPrice");
        const viewProductSupplier = document.getElementById("viewProductSupplier");
        const viewProductDescription = document.getElementById("viewProductDescription");

        // Delete elements
        const deleteProductName = document.getElementById("deleteProductName");

        let currentViewedRowElement = null;

        function filterProducts() {
          const currentProductRows = document.querySelectorAll("tbody tr");
          const searchTerm = searchInput.value.toLowerCase();
          const categoryValue = categoryFilter.value;
          const supplierValue = supplierFilter.value;
          const activeViewElement = document.querySelector(".view-toggle-btn.active");
          const activeView = activeViewElement ? activeViewElement.getAttribute("data-view") : "all";
          let visibleCount = 0;

          currentProductRows.forEach((row) => {
            const productNameText = row.cells[0].textContent.toLowerCase();
            const rowCategoryClass = row.className;
            const supplierIdFromRow = row.dataset.supplierId;
            const matchesSearch = productNameText.includes(searchTerm);
            const matchesCategory = categoryValue === "all" || rowCategoryClass.includes("category-" + categoryValue);
            const matchesSupplier = supplierValue === "all" || supplierIdFromRow === supplierValue;
            const matchesView = activeView === "all" || rowCategoryClass.includes("category-" + activeView);

            if (matchesSearch && matchesCategory && matchesSupplier && matchesView) {
              row.style.display = "";
              visibleCount++;
            } else {
              row.style.display = "none";
            }
          });
          if (totalBadge) totalBadge.textContent = `Total: ${visibleCount} Products`;
        }

        if (searchInput) searchInput.addEventListener("input", filterProducts);
        if (categoryFilter) categoryFilter.addEventListener("change", filterProducts);
        if (supplierFilter) supplierFilter.addEventListener("change", filterProducts);

        if (resetFiltersBtn) {
          resetFiltersBtn.addEventListener("click", function () {
            if (searchInput) searchInput.value = "";
            if (categoryFilter) categoryFilter.value = "all";
            if (supplierFilter) supplierFilter.value = "all";
            viewToggleBtns.forEach(btn => btn.classList.remove("active"));
            const allProductsToggle = document.querySelector('.view-toggle-btn[data-view="all"]');
            if (allProductsToggle) allProductsToggle.classList.add("active");
            filterProducts();
          });
        }

        viewToggleBtns.forEach((btn) => {
          btn.addEventListener("click", function () {
            viewToggleBtns.forEach((b) => b.classList.remove("active"));
            this.classList.add("active");
            filterProducts();
          });
        });

        const sortableHeaders = document.querySelectorAll("th.sortable");
        sortableHeaders.forEach((header) => {
          header.addEventListener("click", function () {
            const icon = this.querySelector("i");
            const isAscending = icon && icon.classList.contains("bi-caret-up-fill");
            sortTable(this, !isAscending);
          });
        });

        function sortTable(header, ascending) {
          const table = header.closest("table");
          const tbody = table.querySelector("tbody");
          if (!tbody) return;
          const columnIndex = Array.from(header.parentNode.children).indexOf(header);
          const rows = Array.from(tbody.querySelectorAll("tr"));
          document.querySelectorAll("th.sortable i").forEach((icon) => icon.className = "bi bi-caret-down-fill");
          const currentIcon = header.querySelector("i");
          if (currentIcon) currentIcon.className = ascending ? "bi bi-caret-up-fill" : "bi bi-caret-down-fill";

          rows.sort((a, b) => {
            let aValue = a.cells[columnIndex].textContent.trim();
            let bValue = b.cells[columnIndex].textContent.trim();
            if (!isNaN(parseFloat(aValue)) && !isNaN(parseFloat(bValue))) {
              aValue = parseFloat(aValue);
              bValue = parseFloat(bValue);
            } else {
              aValue = aValue.toLowerCase();
              bValue = bValue.toLowerCase();
            }
            if (aValue < bValue) return ascending ? -1 : 1;
            if (aValue > bValue) return ascending ? 1 : -1;
            return 0;
          });
          rows.forEach((row) => tbody.appendChild(row));
        }

        function openModal(modal) {
          if (modalBackdrop) modalBackdrop.style.display = "block";
          if (modal) modal.style.display = "block";
          document.body.style.overflow = "hidden";
        }

        function closeAllModals() {
          if (modalBackdrop) modalBackdrop.style.display = "none";
          if (productModal) productModal.style.display = "none";
          if (viewProductModal) viewProductModal.style.display = "none";
          if (deleteModal) deleteModal.style.display = "none";
          document.body.style.overflow = "";
          currentViewedRowElement = null;
        }

        if (addProductBtn) {
          addProductBtn.addEventListener("click", function () {
            document.getElementById("modalTitle").textContent = "Add New Product";
            productForm.reset();
            productId.value = "";
            if (productImportSelect && typeof productImportSelect._productImportChangeListener === 'function') {
              productImportSelect.value = "";
              productImportSelect._productImportChangeListener.call(productImportSelect);
            }
            if (productQuantity) productQuantity.disabled = true;
            openModal(productModal);
          });
        }

        function attachActionListeners(row) {
          const viewBtn = row.querySelector(".view-btn");
          const editBtn = row.querySelector(".edit-btn");
          const deleteBtn = row.querySelector(".delete-btn");

          if (viewBtn) {
            viewBtn.addEventListener("click", function () {
              const currentRow = this.closest("tr");
              currentViewedRowElement = currentRow;
              viewProductName.textContent = currentRow.cells[0].textContent;
              viewProductCategory.textContent = currentRow.dataset.categoryName || currentRow.cells[2].querySelector(".badge").textContent;
              viewProductQuantity.textContent = currentRow.cells[1].textContent;
              viewProductPrice.textContent = "Rs " + currentRow.cells[3].textContent;
              viewProductSupplier.textContent = currentRow.dataset.supplierName || "N/A";
              viewProductDescription.textContent = currentRow.dataset.description || "N/A";
              openModal(viewProductModal);
            });
          }

          if (editBtn) {
            editBtn.addEventListener("click", function () {
              const currentRow = this.closest("tr");
              document.getElementById("modalTitle").textContent = "Edit Product";
              productId.value = currentRow.dataset.productId;
              productName.value = currentRow.cells[0].textContent;
              productQuantity.value = currentRow.cells[1].textContent;
              productPrice.value = currentRow.cells[3].textContent;
              if (productCategory) productCategory.value = currentRow.dataset.categoryId || "";
              if (productSupplier) productSupplier.value = currentRow.dataset.supplierId || "";
              if (productDescription) productDescription.value = currentRow.dataset.description || "";
              if (productImportSelect) {
                productImportSelect.value = currentRow.dataset.importId || "";
                if (typeof productImportSelect._productImportChangeListener === 'function') {
                  productImportSelect._productImportChangeListener.call(productImportSelect);
                }
              }
              openModal(productModal);
            });
          }

          if (deleteBtn) {
            deleteBtn.addEventListener("click", function () {
              const currentRow = this.closest("tr");
              const prodId = this.getAttribute("data-id");
              deleteProductName.textContent = currentRow.cells[0].textContent;
              confirmDeleteBtn.setAttribute("data-id", prodId);
              openModal(deleteModal);
            });
          }
        }

        document.querySelectorAll("tbody tr").forEach(row => attachActionListeners(row));

        if (editFromViewBtn) {
          editFromViewBtn.addEventListener("click", function () {
            if (!currentViewedRowElement) {
              alert("Error: No product selected or product data is missing.");
              return;
            }
            const rowToEdit = currentViewedRowElement;
            closeAllModals();
            document.getElementById("modalTitle").textContent = "Edit Product";
            productId.value = rowToEdit.dataset.productId;
            productName.value = rowToEdit.cells[0].textContent;
            productQuantity.value = rowToEdit.cells[1].textContent;
            productPrice.value = rowToEdit.cells[3].textContent;
            if (productCategory) productCategory.value = rowToEdit.dataset.categoryId || "";
            if (productSupplier) productSupplier.value = rowToEdit.dataset.supplierId || "";
            if (productDescription) productDescription.value = rowToEdit.dataset.description || "";
            if (productImportSelect) {
              productImportSelect.value = rowToEdit.dataset.importId || "";
              if (typeof productImportSelect._productImportChangeListener === 'function') {
                productImportSelect._productImportChangeListener.call(productImportSelect);
              }
            }
            openModal(productModal);
          });
        }

        if (closeModalBtn) closeModalBtn.addEventListener("click", closeAllModals);
        if (closeViewModalBtn) closeViewModalBtn.addEventListener("click", closeAllModals);
        if (closeDeleteModalBtn) closeDeleteModalBtn.addEventListener("click", closeAllModals);
        if (cancelBtn) cancelBtn.addEventListener("click", closeAllModals);
        if (closeViewBtn) closeViewBtn.addEventListener("click", closeAllModals);
        if (cancelDeleteBtn) cancelDeleteBtn.addEventListener("click", closeAllModals);

        if (productImportSelect) {
          const productImportChangeListener = function () {
            const selectedImportId = this.value;
            const selectedOption = this.options[this.selectedIndex];
            const quantityInput = document.getElementById("productQuantity");
            const priceInput = document.getElementById("productPrice");

            if (quantityInput) quantityInput.disabled = !selectedImportId;

            if (selectedImportId && selectedOption) {
              const availableStock = selectedOption.dataset.stock;
              const importPrice = selectedOption.dataset.price;
              if (priceInput) priceInput.value = importPrice || "";
              if (quantityInput) {
                quantityInput.max = availableStock || "";
                if (availableStock && parseInt(availableStock) <= 0) {
                  quantityInput.value = 0;
                }
              }
            } else {
              if (priceInput) priceInput.value = "";
              if (quantityInput) {
                quantityInput.removeAttribute("max");
                quantityInput.value = "";
              }
            }
          };
          productImportSelect.addEventListener("change", productImportChangeListener);
          productImportSelect._productImportChangeListener = productImportChangeListener;
          if (productQuantity && !productImportSelect.value) productQuantity.disabled = true;
        }

        if (saveProductBtn) {
          saveProductBtn.addEventListener("click", function (event) {
            if (productForm.checkValidity()) {
              // Form is valid. Allow the form to submit to the server.
              // No event.preventDefault() is needed here.
              // The server (ProductsController) will handle database operations and redirect.
              // Client-side demo logic for table manipulation and alerts is removed.
              // The modal will close automatically upon page reload after successful submission.
            } else {
              // Form is invalid.
              event.preventDefault(); // Prevent the default (invalid) form submission.
              productForm.reportValidity(); // Show HTML5 validation messages.
            }
          });
        }

        if (confirmDeleteBtn) {
          confirmDeleteBtn.addEventListener("click", function () {
            const productIdToDelete = this.getAttribute("data-id");
            const deleteForm = document.getElementById("deleteProductForm");
            const deleteProductIdInput = document.getElementById("deleteProductId");

            if (deleteForm && deleteProductIdInput) {
              deleteProductIdInput.value = productIdToDelete;
              deleteForm.submit(); // This submits the hidden form for deletion.
            } else {
              console.error("Delete form or product ID input not found.");
              alert("Error initiating delete. Please try again.");
              closeAllModals();
            }
          });
        }

        filterProducts(); // Initialize filters on page load

        function dismissAlert(alertElement) {
          if (alertElement) {
            alertElement.classList.add('fade-out');
            setTimeout(() => {
              if (alertElement.parentNode) {
                alertElement.parentNode.removeChild(alertElement);
              }
            }, 300);
          }
        }

        document.querySelectorAll('.alert').forEach(alert => {
          setTimeout(() => dismissAlert(alert), 3000); // Auto-dismiss after 3 seconds
          const dismissButton = alert.querySelector('.dismiss-btn');
          if (dismissButton) {
            // The onclick is already in the HTML, but this ensures it if added dynamically
            // or if you prefer to attach listeners here.
            // For now, relying on the inline onclick in the JSP for dismiss buttons.
          }
        });

      });
    </script>
  </body>
</html>
