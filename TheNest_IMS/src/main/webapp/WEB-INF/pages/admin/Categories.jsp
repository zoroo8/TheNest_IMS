<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%> <%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core" %>
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
    <jsp:include page="../components/Sidebar.jsp" />

    <!-- Main Content -->
    <div class="main-content">
      <!-- Display success message if available -->
      <c:if test="${not empty sessionScope.successMessage}">
  <div class="alert alert-success" id="successAlert">
    <i class="bi bi-check-circle" style="margin-right: 10px; font-size: 1.1rem;"></i>
    ${sessionScope.successMessage}
    <button type="button" class="dismiss-btn" onclick="dismissAlert(this.parentElement)"></button>
    <c:remove var="successMessage" scope="session" />
  </div>
</c:if>

<c:if test="${not empty sessionScope.errorMessage}">
  <div class="alert alert-danger" id="errorAlert">
    <i class="bi bi-exclamation-circle" style="margin-right: 10px; font-size: 1.1rem;"></i>
    ${sessionScope.errorMessage}
    <c:remove var="errorMessage" scope="session" />
  </div>
</c:if>

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
          <div class="stat-value">${stats.totalCategories}</div>
          <div class="stat-label">Total Categories</div>
        </div>
        <div class="stat-card">
          <div class="stat-icon product-icon">
            <i class="bi bi-box-seam"></i>
          </div>
          <div class="stat-value">${stats.totalProducts}</div>
          <div class="stat-label">Total Products</div>
        </div>
        <div class="stat-card">
          <div class="stat-icon recent-icon">
            <i class="bi bi-star-fill"></i>
          </div>
          <div class="stat-value">
            ${stats.topCategoryProductCount}
            <small>${stats.topCategoryName}</small>
          </div>
          <div class="stat-label">Top Category</div>
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
        <c:choose>
          <c:when test="${empty categories}">
            <div class="empty-state">
              <div class="empty-state-icon"><i class="bi bi-tags"></i></div>
              <h3 class="empty-state-title">No Categories Found</h3>
              <p class="empty-state-message">
                There are no categories in the system yet. Click the "Add New
                Category" button to create one.
              </p>
            </div>
          </c:when>
          <c:otherwise>
            <c:forEach var="category" items="${categories}">
              <div class="category-card"
    <c:choose>
      <c:when test="${category.productCount >= 30}">data-products="high"</c:when>
      <c:when test="${category.productCount >= 10}">data-products="medium"</c:when>
      <c:when test="${category.productCount >= 1}">data-products="low"</c:when>
      <c:otherwise>data-products="none"</c:otherwise>
    </c:choose>
  >
    <div class="category-card-header">
      <h3 class="category-card-title category-name">
        ${category.name}
      </h3>
      <div class="category-icon">
        <i class="bi ${category.icon}"></i>
      </div>
    </div>
    <div class="category-card-body">
      <div class="category-product-count" style="display: none">
        ${category.productCount}
      </div>

      <div class="category-info">
        <span class="category-label">Products</span>
        <span class="category-value">${category.productCount} items</span>
      </div>
      <c:if test="${not empty category.description}">
    <div class="category-description">
      <p>${category.description}</p>
    </div>
  </c:if>
    </div>
    <div class="category-card-footer">
      <a
        href="${pageContext.request.contextPath}/products?category=${category.id}"
        class="view-products"
        data-id="${category.id}"
      >
        <i class="bi bi-eye"></i> View Products
      </a>
      <a href="#" class="edit-category" data-id="${category.id}">
        <i class="bi bi-pencil"></i> Edit
      </a>
      <a
        href="#"
        class="delete-category"
        data-id="${category.id}"
      >
        <i class="bi bi-trash"></i> Delete
      </a>
    </div>
  </div>
 </c:forEach>
</c:otherwise>
</c:choose>
</div>

<!-- Pagination -->
<c:if test="${totalPages > 1}">
  <div class="pagination-info">
    <c:set var="start" value="${(currentPage-1) * pageSize + 1}"/>
    <c:set var="end" value="${(currentPage * pageSize < stats.totalCategories) ? currentPage * pageSize : stats.totalCategories}"/>
    Showing ${start} to ${end} of ${stats.totalCategories} categories
  </div>
  <div class="pagination-container">
    <ul class="pagination">
      <!-- First Page -->
      <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
        <a href="${pageContext.request.contextPath}/categories?page=1" 
           class="page-link" 
           aria-label="First"
           ${currentPage == 1 ? 'tabindex="-1"' : ''}>
          <span aria-hidden="true">&laquo;&laquo; First</span>
        </a>
      </li>

      <!-- Previous Page -->
      <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
        <a href="${pageContext.request.contextPath}/categories?page=${currentPage - 1}" 
           class="page-link" 
           aria-label="Previous"
           ${currentPage == 1 ? 'tabindex="-1"' : ''}>
          <span aria-hidden="true">&laquo; Previous</span>
        </a>
      </li>

      <!-- Page Numbers -->
      <c:set var="beginPage" value="${(currentPage - 2 < 1) ? 1 : currentPage - 2}"/>
      <c:set var="endPage" value="${(currentPage + 2 > totalPages) ? totalPages : currentPage + 2}"/>
      <c:forEach var="i" begin="${beginPage}" end="${endPage}">
        <li class="page-item ${i == currentPage ? 'active' : ''}">
          <a href="${pageContext.request.contextPath}/categories?page=${i}" class="page-link">
            ${i}
          </a>
        </li>
      </c:forEach>

      <!-- Next Page -->
      <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
        <a href="${pageContext.request.contextPath}/categories?page=${currentPage + 1}" 
           class="page-link" 
           aria-label="Next"
           ${currentPage == totalPages ? 'tabindex="-1"' : ''}>
          <span aria-hidden="true">Next &raquo;</span>
        </a>
      </li>

      <!-- Last Page -->
      <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
        <a href="${pageContext.request.contextPath}/categories?page=${totalPages}" 
           class="page-link" 
           aria-label="Last"
           ${currentPage == totalPages ? 'tabindex="-1"' : ''}>
          <span aria-hidden="true">Last &raquo;&raquo;</span>
        </a>
      </li>
    </ul>
  </div>
</c:if>

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
        <p>All associated products will no longer have this category.</p>
      </div>
      <div class="modal-footer">
        <form
          id="deleteCategoryForm"
          method="post"
          action="${pageContext.request.contextPath}/categories"
        >
          <input type="hidden" name="action" value="delete" />
          <input
            type="hidden"
            id="categoryIdToDelete"
            name="categoryIdToDelete"
            value=""
          />
          <button type="button" class="btn btn-outline" id="cancelBtn">Cancel</button>
          <button type="submit" class="btn btn-danger" id="confirmDeleteBtn">
            Confirm Deletion
          </button>
        </form>
      </div>
    </div>

    <!-- CSS for alert messages -->
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
        color: var(--success-color);
        border-left: 4px solid var(--success-color);
      }

      .alert-danger {
        background-color: rgba(66, 66, 66, 0.1);
        color: var(--danger-color);
        border-left: 4px solid var(--danger-color);
      }

      .alert .dismiss-btn {
        position: absolute;
        right: 10px;
        top: 10px;
        background: transparent;
        border: none;
        cursor: pointer;
        font-size: 1rem;
        opacity: 0.6;
        transition: opacity 0.2s;
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

    <!-- JavaScript for functionality -->
    <script>
      document.addEventListener("DOMContentLoaded", function () {
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

  const alerts = document.querySelectorAll('.alert');
      if (alerts.length > 0) {
        alerts.forEach(alert => {
          setTimeout(() => {
            dismissAlert(alert);
          }, 3000);
       });
      }
        const searchInput = document.getElementById("searchCategories");
        const categoryCards = document.querySelectorAll(".category-card");
        const filterProductCount =
          document.getElementById("filterProductCount");

        const modalBackdrop = document.getElementById("modalBackdrop");
        const categoryModal = document.getElementById("categoryModal");
        const deleteModal = document.getElementById("deleteModal");
        const closeModal = document.getElementById("closeModal");
        const closeDeleteModal = document.getElementById("closeDeleteModal");
        const addCategoryBtn = document.getElementById("addCategoryBtn");
        const saveCategoryBtn = document.getElementById("saveCategoryBtn");
        const cancelBtn = document.getElementById("cancelBtn");
        const cancelDeleteBtn = document.getElementById("cancelDeleteBtn");

        const categoryForm = document.getElementById("categoryForm");
        if (categoryForm) {
  categoryForm.addEventListener("submit", function(e) {

    categoryName.value = categoryName.value.trim();
    categoryDescription.value = categoryDescription.value.trim();
  });
}
        const categoryId = document.getElementById("categoryId");
        const categoryName = document.getElementById("categoryName");
        const categoryIcon = document.getElementById("categoryIcon");
        const categoryDescription = document.getElementById(
          "categoryDescription"
        );
        const deleteCategoryForm =
          document.getElementById("deleteCategoryForm");
        const categoryIdToDelete =
          document.getElementById("categoryIdToDelete");
        const deleteCategoryName =
          document.getElementById("deleteCategoryName");

        function filterCategories() {
          const searchTerm = searchInput.value.toLowerCase();
          const productCountFilter = filterProductCount.value;

          let visibleCount = 0;

          categoryCards.forEach((card) => {
            const name = card
              .querySelector(".category-name")
              .textContent.toLowerCase();
            const productCount = parseInt(
              card.querySelector(".category-product-count").textContent
            );

            let showBySearch = name.includes(searchTerm);
            let showByCount = true;

            if (productCountFilter !== "all") {
              if (productCountFilter === "high" && productCount < 30) {
                showByCount = false;
              } else if (
                productCountFilter === "medium" &&
                (productCount < 10 || productCount > 30)
              ) {
                showByCount = false;
              } else if (
                productCountFilter === "low" &&
                (productCount === 0 || productCount >= 10)
              ) {
                showByCount = false;
              } else if (productCountFilter === "none" && productCount > 0) {
                showByCount = false;
              }
            }

            if (showBySearch && showByCount) {
              card.style.display = "";
              visibleCount++;
            } else {
              card.style.display = "none";
            }
          });

          if (visibleCount === 0 && categoryCards.length > 0) {
            let emptyState = document.querySelector(".empty-state");
            if (!emptyState) {
              emptyState = document.createElement("div");
              emptyState.className = "empty-state";
              emptyState.innerHTML = `
              <div class="empty-state-icon"><i class="bi bi-search"></i></div>
              <h3 class="empty-state-title">No Categories Found</h3>
              <p class="empty-state-message">No categories match your search criteria. Try changing your filters.</p>
            `;
              document
                .querySelector(".categories-grid")
                .appendChild(emptyState);
            } else {
              emptyState.style.display = "block";
            }
          } else {
            const emptyState = document.querySelector(".empty-state");
            if (emptyState) {
              emptyState.style.display = "none";
            }
          }
        }

        if (searchInput) {
          searchInput.addEventListener("input", filterCategories);
        }

        if (filterProductCount) {
          filterProductCount.addEventListener("change", filterCategories);
        }

        document
          .getElementById("resetFilters")
          .addEventListener("click", function () {
            searchInput.value = "";
            filterProductCount.value = "all";
            filterCategories();
          });

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

        if (addCategoryBtn) {
          addCategoryBtn.addEventListener("click", function () {
            document.getElementById("modalTitle").textContent = "Add Category";
            categoryForm.reset();
            categoryId.value = "";
            updateIconPreview();
            openModal(categoryModal);
          });
        }

document.querySelectorAll(".edit-category").forEach((button) => {
  button.addEventListener("click", function (e) {
    e.preventDefault();
    const id = this.getAttribute("data-id");
    const card = this.closest(".category-card");
    const name = card.querySelector(".category-name").textContent.trim();
    const iconElement = card.querySelector(".category-icon i");
    const iconClass = iconElement ? iconElement.className : "";

    const descriptionElement = card.querySelector(".category-description p");
    const descriptionFromCard = descriptionElement ? descriptionElement.textContent.trim() : null;

    document.getElementById("modalTitle").textContent = "Edit Category";
    categoryId.value = id;
    categoryName.value = name;

    if (iconClass) {
      const iconValue = iconClass
        .split(" ")
        .find((cls) => cls.startsWith("bi-"));
      if (iconValue) {
        categoryIcon.value = iconValue;
      }
    }

    if (descriptionFromCard) {
      categoryDescription.value = descriptionFromCard;
      updateIconPreview();
      openModal(categoryModal);
    } else {

      categoryDescription.value = "Loading...";

      fetch(
        "${pageContext.request.contextPath}/categories?action=getCategory&id=" +
          id
      )
        .then((response) => {
          if (!response.ok) {
            throw new Error('Network response was not ok');
          }
          return response.json();
        })
        .then((data) => {

          categoryDescription.value = data.description ? data.description.trim() : "";
        })
        .catch((error) => {
          console.error("Error fetching category details:", error);

          categoryDescription.value = "";
          alert("Could not load category description. Please try again.");
        });

      updateIconPreview();
      openModal(categoryModal);
    }
  });
});

        document.querySelectorAll(".delete-category").forEach((button) => {
          button.addEventListener("click", function (e) {
            e.preventDefault();
            const id = this.getAttribute("data-id");
            const name =
              this.closest(".category-card").querySelector(
                ".category-name"
              ).textContent;

            deleteCategoryName.textContent = name;
            categoryIdToDelete.value = id;

            openModal(deleteModal);
          });
        });

        if (closeModal) closeModal.addEventListener("click", closeAllModals);
        if (closeDeleteModal)
          closeDeleteModal.addEventListener("click", closeAllModals);
          if (cancelBtn) {
  cancelBtn.addEventListener("click", function(e) {
    e.preventDefault(); 
    closeAllModals();
  });
}
        if (cancelDeleteBtn)
          cancelDeleteBtn.addEventListener("click", closeAllModals);

        function updateIconPreview() {
          const selectedIcon = categoryIcon.value;
          const iconPreview = document.querySelector(".icon-preview i");
          if (iconPreview) {
            iconPreview.className = "bi " + selectedIcon;
          }
        }

        if (categoryIcon) {
          categoryIcon.addEventListener("change", updateIconPreview);

          updateIconPreview();
        }

        document.addEventListener("keydown", function (e) {

          if (e.key === "Escape") {
            closeAllModals();
          }
        });
      });
    </script>
  </body>
</html>