<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Categories - The Nest Inventory System</title>
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
      href="${pageContext.request.contextPath}/resources/css/Categories.css"
    />
  </head>
  <body>
    <jsp:include page="components/Sidebar.jsp" />

    <!-- Main Content -->
    <div class="main-content">
      <div class="page-header">
        <h1 class="page-title">Manage Categories</h1>
        <button class="btn btn-primary" id="addCategoryBtn">
          <i class="bi bi-plus-circle"></i> Add New Category
        </button>
      </div>

      <!-- Stats Cards -->
      <div class="stats-row">
        <div class="stat-card">
          <div class="stat-icon category-icon-stat">
            <i class="bi bi-tags"></i>
          </div>
          <div class="stat-value">6</div>
          <div class="stat-label">Total Categories</div>
        </div>
        <div class="stat-card">
          <div class="stat-icon product-icon">
            <i class="bi bi-box-seam"></i>
          </div>
          <div class="stat-value">145</div>
          <div class="stat-label">Total Products</div>
        </div>
        <div class="stat-card">
          <div class="stat-icon recent-icon">
            <i class="bi bi-clock-history"></i>
          </div>
          <div class="stat-value">30</div>
          <div class="stat-label">Recently Added</div>
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
                placeholder="Search categories..."
                id="searchCategories"
              />
            </div>
          </div>
          <div class="filter-group">
            <select class="form-control" id="filterProductCount">
              <option value="all" selected>All Product Counts</option>
              <option value="high">High (30+)</option>
              <option value="medium">Medium (10-30)</option>
              <option value="low">Low (1-10)</option>
              <option value="none">None (0)</option>
            </select>
          </div>
          <div class="filter-group" style="flex: 0 0 auto">
            <button class="btn btn-outline" id="resetFilters">Reset</button>
          </div>
        </div>
      </div>

      <!-- Categories Grid -->
      <div class="categories-grid">
        <!-- Category Card - Beverages -->
        <div class="category-card">
          <div class="category-card-header">
            <h3 class="category-card-title">Beverages</h3>
            <div class="category-icon">
              <i class="bi bi-cup-hot"></i>
            </div>
          </div>
          <div class="category-card-body">
            <div class="category-product-count">32</div>
            <div class="category-info">
              <span class="category-label">Products</span>
              <span class="category-value">32 items</span>
            </div>
            <div class="category-info">
              <span class="category-label">Last Updated</span>
              <span class="category-value">2 days ago</span>
            </div>
            <div class="category-progress">
              <div class="progress-bar normal" style="width: 60%"></div>
            </div>
            <div class="category-info">
              <span class="category-label">Status</span>
              <span class="badge badge-category normal">Active</span>
            </div>
          </div>
          <div class="category-card-footer">
            <a href="#" class="view-products" data-id="1">
              <i class="bi bi-eye"></i> View Products
            </a>
            <a href="#" class="edit-category" data-id="1">
              <i class="bi bi-pencil"></i> Edit
            </a>
          </div>
        </div>

        <!-- Category Card - Groceries -->
        <div class="category-card">
          <div class="category-card-header">
            <h3 class="category-card-title">Groceries</h3>
            <div class="category-icon">
              <i class="bi bi-basket"></i>
            </div>
          </div>
          <div class="category-card-body">
            <div class="category-product-count">45</div>
            <div class="category-info">
              <span class="category-label">Products</span>
              <span class="category-value">45 items</span>
            </div>
            <div class="category-info">
              <span class="category-label">Last Updated</span>
              <span class="category-value">1 day ago</span>
            </div>
            <div class="category-progress">
              <div class="progress-bar high" style="width: 80%"></div>
            </div>
            <div class="category-info">
              <span class="category-label">Status</span>
              <span class="badge badge-category high">Active</span>
            </div>
          </div>
          <div class="category-card-footer">
            <a href="#" class="view-products" data-id="2">
              <i class="bi bi-eye"></i> View Products
            </a>
            <a href="#" class="edit-category" data-id="2">
              <i class="bi bi-pencil"></i> Edit
            </a>
          </div>
        </div>

        <!-- Category Card - Furnitures -->
        <div class="category-card">
          <div class="category-card-header">
            <h3 class="category-card-title">Furnitures</h3>
            <div class="category-icon">
              <i class="bi bi-lamp"></i>
            </div>
          </div>
          <div class="category-card-body">
            <div class="category-product-count">18</div>
            <div class="category-info">
              <span class="category-label">Products</span>
              <span class="category-value">18 items</span>
            </div>
            <div class="category-info">
              <span class="category-label">Last Updated</span>
              <span class="category-value">5 days ago</span>
            </div>
            <div class="category-progress">
              <div class="progress-bar normal" style="width: 40%"></div>
            </div>
            <div class="category-info">
              <span class="category-label">Status</span>
              <span class="badge badge-category normal">Active</span>
            </div>
          </div>
          <div class="category-card-footer">
            <a href="#" class="view-products" data-id="3">
              <i class="bi bi-eye"></i> View Products
            </a>
            <a href="#" class="edit-category" data-id="3">
              <i class="bi bi-pencil"></i> Edit
            </a>
          </div>
        </div>

        <!-- Continue with other category cards in the same format -->
        <!-- Category Card - Clothing -->
        <div class="category-card">
          <div class="category-card-header">
            <h3 class="category-card-title">Clothing</h3>
            <div class="category-icon">
              <i class="bi bi-tshirt"></i>
            </div>
          </div>
          <div class="category-card-body">
            <div class="category-product-count">27</div>
            <div class="category-info">
              <span class="category-label">Products</span>
              <span class="category-value">27 items</span>
            </div>
            <div class="category-info">
              <span class="category-label">Last Updated</span>
              <span class="category-value">3 days ago</span>
            </div>
            <div class="category-progress">
              <div class="progress-bar normal" style="width: 50%"></div>
            </div>
            <div class="category-info">
              <span class="category-label">Status</span>
              <span class="badge badge-category normal">Active</span>
            </div>
          </div>
          <div class="category-card-footer">
            <a href="#" class="view-products" data-id="4">
              <i class="bi bi-eye"></i> View Products
            </a>
            <a href="#" class="edit-category" data-id="4">
              <i class="bi bi-pencil"></i> Edit
            </a>
          </div>
        </div>

        <!-- Category Card - Electronics -->
        <div class="category-card">
          <div class="category-card-header">
            <h3 class="category-card-title">Electronics</h3>
            <div class="category-icon">
              <i class="bi bi-cpu"></i>
            </div>
          </div>
          <div class="category-card-body">
            <div class="category-product-count">23</div>
            <div class="category-info">
              <span class="category-label">Products</span>
              <span class="category-value">23 items</span>
            </div>
            <div class="category-info">
              <span class="category-label">Last Updated</span>
              <span class="category-value">1 week ago</span>
            </div>
            <div class="category-progress">
              <div class="progress-bar normal" style="width: 45%"></div>
            </div>
            <div class="category-info">
              <span class="category-label">Status</span>
              <span class="badge badge-category normal">Active</span>
            </div>
          </div>
          <div class="category-card-footer">
            <a href="#" class="view-products" data-id="5">
              <i class="bi bi-eye"></i> View Products
            </a>
            <a href="#" class="edit-category" data-id="5">
              <i class="bi bi-pencil"></i> Edit
            </a>
          </div>
        </div>

        <!-- Category Card - Fragile -->
        <div class="category-card">
          <div class="category-card-header">
            <h3 class="category-card-title">Fragile</h3>
            <div class="category-icon">
              <i class="bi bi-cup"></i>
            </div>
          </div>
          <div class="category-card-body">
            <div class="category-product-count">0</div>
            <div class="category-info">
              <span class="category-label">Products</span>
              <span class="category-value">0 items</span>
            </div>
            <div class="category-info">
              <span class="category-label">Last Updated</span>
              <span class="category-value">Never</span>
            </div>
            <div class="category-progress">
              <div class="progress-bar low" style="width: 0%"></div>
            </div>
            <div class="category-info">
              <span class="category-label">Status</span>
              <span class="badge badge-category low">Empty</span>
            </div>
          </div>
          <div class="category-card-footer">
            <a href="#" class="view-products" data-id="6">
              <i class="bi bi-eye"></i> View Products
            </a>
            <a href="#" class="edit-category" data-id="6">
              <i class="bi bi-pencil"></i> Edit
            </a>
          </div>
        </div>
      </div>

      <!-- Pagination -->
      <div class="pagination-container">
        <ul class="pagination">
          <li class="page-item">
            <a href="#" class="page-link" aria-label="First">
              <span aria-hidden="true">&laquo;&laquo; First</span>
            </a>
          </li>
          <li class="page-item">
            <a href="#" class="page-link" aria-label="Previous">
              <span aria-hidden="true">&laquo; Previous</span>
            </a>
          </li>
          <li class="page-item active"><a href="#" class="page-link">1</a></li>
          <li class="page-item"><a href="#" class="page-link">2</a></li>
          <li class="page-item"><a href="#" class="page-link">3</a></li>
          <li class="page-item">
            <a href="#" class="page-link" aria-label="Next">
              <span aria-hidden="true">Next &raquo;</span>
            </a>
          </li>
          <li class="page-item">
            <a href="#" class="page-link" aria-label="Last">
              <span aria-hidden="true">Last &raquo;&raquo;</span>
            </a>
          </li>
        </ul>
      </div>
    </div>

    <!-- Add/Edit Category Modal -->
    <div class="modal-backdrop" id="modalBackdrop"></div>
    <div class="modal" id="categoryModal">
      <div class="modal-header">
        <h3 class="modal-title" id="modalTitle">Add Category</h3>
        <button class="modal-close" id="closeModal">&times;</button>
      </div>
      <div class="modal-body">
        <form id="categoryForm" method="post" action="categories">
          <input type="hidden" id="categoryId" name="categoryId" value="" />

          <div class="form-group">
            <label for="categoryName" class="form-label">Category Name</label>
            <input
              type="text"
              class="form-control"
              id="categoryName"
              name="categoryName"
              required
            />
          </div>

          <div class="form-group">
            <label for="categoryIcon" class="form-label">Icon</label>
            <select class="form-control" id="categoryIcon" name="categoryIcon">
              <option value="bi-basket">Basket</option>
              <option value="bi-cup-hot">Cup</option>
              <option value="bi-lamp">Lamp</option>
              <option value="bi-tshirt">T-shirt</option>
              <option value="bi-cpu">CPU</option>
              <option value="bi-cup">Glass</option>
              <option value="bi-box">Box</option>
              <option value="bi-tag">Tag</option>
              <option value="bi-book">Book</option>
              <option value="bi-tools">Tools</option>
              <option value="bi-phone">Phone</option>
              <option value="bi-camera">Camera</option>
              <option value="bi-headphones">Headphones</option>
              <option value="bi-tv">TV</option>
              <option value="bi-controller">Gaming</option>
              <option value="bi-bicycle">Bicycle</option>
              <option value="bi-car-front">Car</option>
              <option value="bi-house">Home</option>
              <option value="bi-flower1">Flower</option>
              <option value="bi-gem">Jewelry</option>
            </select>
            <div class="icon-preview-container">
              <div class="icon-preview">
                <i class="bi bi-basket"></i>
              </div>
              <span class="icon-preview-text">Selected Icon</span>
            </div>
          </div>

          <div class="form-group">
            <label for="categoryDescription" class="form-label"
              >Description</label
            >
            <textarea
              class="form-control"
              id="categoryDescription"
              name="categoryDescription"
              rows="3"
            ></textarea>
          </div>
           <div class="modal-footer">
	        <button class="btn btn-outline" id="cancelBtn">Cancel</button>
	        <button class="btn btn-primary" id="saveCategoryBtn" type="submit">
	          Save Category
	        </button>
	      </div>
        </form>
      </div>
     
    </div>

    <!-- Delete Confirmation Modal -->
    <div class="modal" id="deleteModal">
      <div class="modal-header">
        <h3 class="modal-title">Delete Category</h3>
        <button class="modal-close" id="closeDeleteModal">&times;</button>
      </div>
      <div class="modal-body">
        <p>Are you sure you want to delete this Category?</p>
        <p class="text-danger">
          <strong>Category: <span id="deleteCategoryName"></span></strong>
        </p>
      </div>
      <div class="modal-footer">
        <button class="btn btn-outline" id="cancelDeleteBtn">Cancel</button>
        <button class="btn btn-danger" id="confirmDeleteBtn">
          Confirm Deletion
        </button>
      </div>
    </div>

    <!-- JavaScript -->
    <script>
      document.addEventListener("DOMContentLoaded", function () {
        // Elements
        const searchInput = document.getElementById("searchCategories");
        const categoryCards = document.querySelectorAll(".category-card");

        // Modal elements
        const modalBackdrop = document.getElementById("modalBackdrop");
        const categoryModal = document.getElementById("categoryModal");
        const deleteModal = document.getElementById("deleteModal");
        const closeModal = document.getElementById("closeModal");
        const closeDeleteModal = document.getElementById("closeDeleteModal");
        const addCategoryBtn = document.getElementById("addCategoryBtn");
        const saveCategoryBtn = document.getElementById("saveCategoryBtn");
        const cancelBtn = document.getElementById("cancelBtn");
        const cancelDeleteBtn = document.getElementById("cancelDeleteBtn");
        const confirmDeleteBtn = document.getElementById("confirmDeleteBtn");

        // Action buttons
        const viewButtons = document.querySelectorAll(".view-btn");
        const editButtons = document.querySelectorAll(".edit-btn");
        const deleteButtons = document.querySelectorAll(".delete-btn");

        // Form elements
        const categoryForm = document.getElementById("categoryForm");
        const categoryId = document.getElementById("categoryId");
        const categoryName = document.getElementById("categoryName");
        const categoryIcon = document.getElementById("categoryIcon");
        const categoryDescription = document.getElementById(
          "categoryDescription"
        );

        // Delete elements
        const deleteCategoryName =
          document.getElementById("deleteCategoryName");

        // Search functionality
        function filterCategories() {
          const searchTerm = searchInput.value.toLowerCase();
          let visibleCount = 0;

          categoryCards.forEach((card) => {
            const name = card
              .querySelector(".category-name")
              .textContent.toLowerCase();
            if (name.includes(searchTerm)) {
              card.style.display = "";
              visibleCount++;
            } else {
              card.style.display = "none";
            }
          });

          // Show empty state if no results
          const emptyState = document.querySelector(".empty-state");
          if (emptyState) {
            if (visibleCount === 0) {
              emptyState.style.display = "block";
            } else {
              emptyState.style.display = "none";
            }
          }
        }

        // Add event listener for search
        if (searchInput) {
          searchInput.addEventListener("input", filterCategories);
        }

        // Modal functionality
        function openModal(modal) {
          modalBackdrop.style.display = "block";
          modal.style.display = "block";
          document.body.style.overflow = "hidden";
        }

        function closeAllModals() {
          modalBackdrop.style.display = "none";
          categoryModal.style.display = "none";
          deleteModal.style.display = "none";
          document.body.style.overflow = "";
        }

        // Add Category button
        if (addCategoryBtn) {
          addCategoryBtn.addEventListener("click", function () {
            document.getElementById("modalTitle").textContent = "Add Category";
            categoryForm.reset();
            categoryId.value = "";
            openModal(categoryModal);
          });
        }

        // View Category buttons
        viewButtons.forEach((button) => {
          button.addEventListener("click", function () {
            const categoryId = this.getAttribute("data-id");
            const categoryName =
              this.closest(".category-card").querySelector(
                ".category-name"
              ).textContent;
            window.location.href = `products?category=${categoryId}`;
          });
        });

        // Edit Category buttons
        editButtons.forEach((button) => {
          button.addEventListener("click", function () {
            const categoryId = this.getAttribute("data-id");
            const card = this.closest(".category-card");
            const categoryName =
              card.querySelector(".category-name").textContent;
            const iconClass = card.querySelector(".category-icon i").className;
            const iconValue = iconClass.replace("bi ", "");

            document.getElementById("modalTitle").textContent = "Edit Category";
            document.getElementById("categoryId").value = categoryId;
            document.getElementById("categoryName").value = categoryName;
            document.getElementById("categoryIcon").value = iconValue;
            document.getElementById(
              "categoryDescription"
            ).value = `Description for ${categoryName} category`;

            openModal(categoryModal);
          });
        });

        // Delete Category buttons
        deleteButtons.forEach((button) => {
          button.addEventListener("click", function () {
            const categoryId = this.getAttribute("data-id");
            const categoryName =
              this.closest(".category-card").querySelector(
                ".category-name"
              ).textContent;

            deleteCategoryName.textContent = categoryName;
            openModal(deleteModal);

            confirmDeleteBtn.setAttribute("data-id", categoryId);
          });
        });

        // Close modal buttons
        if (closeModal) {
          closeModal.addEventListener("click", closeAllModals);
        }

        if (closeDeleteModal) {
          closeDeleteModal.addEventListener("click", closeAllModals);
        }

        if (cancelBtn) {
          cancelBtn.addEventListener("click", closeAllModals);
        }

        if (cancelDeleteBtn) {
          cancelDeleteBtn.addEventListener("click", closeAllModals);
        }

        // Save category button
        if (saveCategoryBtn) {
          saveCategoryBtn.addEventListener("click", function () {
            if (categoryForm.checkValidity()) {
              const formData = {
                id: categoryId.value,
                name: categoryName.value,
                icon: categoryIcon.value,
                description: categoryDescription.value,
              };

              console.log("Saving category:", formData);

              const isNewCategory = !formData.id;
              const successMessage = isNewCategory
                ? `Category "${formData.name}" created successfully!`
                : `Category "${formData.name}" updated successfully!`;

              alert(successMessage);

              setTimeout(() => {
                window.location.reload();
              }, 500);

              closeAllModals();
            } else {
              categoryForm.reportValidity();
            }
          });
        }

        // Confirm delete button
        if (confirmDeleteBtn) {
          confirmDeleteBtn.addEventListener("click", function () {
            const categoryId = this.getAttribute("data-id");

            console.log("Deleting category ID:", categoryId);

            alert(`Category deleted successfully!`);
            setTimeout(() => {
              window.location.reload();
            }, 500);

            closeAllModals();
          });
        }

        if (categoryIcon) {
          categoryIcon.addEventListener("change", function () {
            const selectedIcon = this.value;
            const iconPreview = document.querySelector(".icon-preview i");
            if (iconPreview) {
              iconPreview.className = "";
              iconPreview.classList.add("bi", selectedIcon);
            }
          });

          // Initialize preview with the first option
          const initialIcon = categoryIcon.value;
          const iconPreview = document.querySelector(".icon-preview i");
          if (iconPreview) {
            iconPreview.className = "";
            iconPreview.classList.add("bi", initialIcon);
          }
        }

        // Add keyboard shortcuts
        document.addEventListener("keydown", function (e) {
          // Escape key closes modals
          if (e.key === "Escape") {
            closeAllModals();
          }

          // Ctrl+Enter in modal saves the form
          if (
            e.ctrlKey &&
            e.key === "Enter" &&
            categoryModal.style.display === "block"
          ) {
            saveCategoryBtn.click();
          }
        });
      });
    </script>
  </body>
</html>
