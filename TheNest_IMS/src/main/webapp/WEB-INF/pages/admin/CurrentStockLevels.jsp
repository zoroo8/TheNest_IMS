<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Current Stock Levels - The Nest Inventory System</title>
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
  </head>
  <body>
    <jsp:include page="components/Sidebar.jsp" />

    <!-- Main Content -->
    <div class="main-content">
      <div class="page-header">
        <h1 class="page-title">Current Stock Levels</h1>
        <button class="btn btn-primary" id="addItemBtn">
          <i class="bi bi-plus-circle"></i> Add New Item
        </button>
      </div>

      <!-- Stats Cards -->
      <div class="stats-row">
        <div class="stat-card">
          <div class="stat-icon pending-icon">
            <i class="bi bi-boxes"></i>
          </div>
          <div class="stat-value">145</div>
          <div class="stat-label">Total Items</div>
        </div>
        <div class="stat-card">
          <div class="stat-icon low-stock-icon">
            <i class="bi bi-exclamation-triangle"></i>
          </div>
          <div class="stat-value">8</div>
          <div class="stat-label">Low Stock Items</div>
        </div>
        <div class="stat-card">
          <div class="stat-icon approved-icon">
            <i class="bi bi-arrow-repeat"></i>
          </div>
          <div class="stat-value">12</div>
          <div class="stat-label">Items on Order</div>
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
                placeholder="Search items..."
                id="searchItems"
              />
            </div>
          </div>
          <div class="filter-group">
            <select class="form-control" id="filterCategory">
              <option value="all" selected>All Categories</option>
              <option value="electronics">Electronics</option>
              <option value="office">Office Supplies</option>
              <option value="furniture">Furniture</option>
              <option value="it">IT Equipment</option>
            </select>
          </div>
          <div class="filter-group">
            <select class="form-control" id="filterStockLevel">
              <option value="all" selected>All Stock Levels</option>
              <option value="critical">Critical Stock</option>
              <option value="low">Low Stock</option>
              <option value="normal">Normal Stock</option>
              <option value="high">High Stock</option>
            </select>
          </div>
          <div class="filter-group" style="flex: 0 0 auto">
            <button class="btn btn-outline" id="resetFilters">Reset</button>
          </div>
        </div>
      </div>

      <!-- Stock Grid -->
      <div class="stock-grid">
        <!-- Item 1 -->
        <div class="stock-card">
          <div class="stock-card-header">
            <h3 class="stock-card-title">Laptop Charger</h3>
            <div class="category-icon">
              <i class="bi bi-laptop"></i>
            </div>
          </div>
          <div class="stock-card-body">
            <div class="stock-level">15</div>
            <div class="stock-info">
              <span class="stock-label">Category</span>
              <span class="stock-value">Electronics</span>
            </div>
            <div class="stock-info">
              <span class="stock-label">Min. Level</span>
              <span class="stock-value">10</span>
            </div>
            <div class="stock-info">
              <span class="stock-label">Max. Level</span>
              <span class="stock-value">50</span>
            </div>
            <div class="stock-progress">
              <div class="progress-bar normal" style="width: 30%"></div>
            </div>
            <div class="stock-info">
              <span class="stock-label">Status</span>
              <span class="badge badge-stock normal">Normal</span>
            </div>
          </div>
          <div class="stock-card-footer">
            <a href="#" class="edit-item" data-id="1">
              <i class="bi bi-pencil"></i> Edit
            </a>
            <a href="#" class="order-item" data-id="1">
              <i class="bi bi-bag-plus"></i> Order More
            </a>
          </div>
        </div>

        <!-- Item 2 -->
        <div class="stock-card">
          <div class="stock-card-header">
            <h3 class="stock-card-title">Wireless Mouse</h3>
            <div class="category-icon">
              <i class="bi bi-mouse"></i>
            </div>
          </div>
          <div class="stock-card-body">
            <div class="stock-level">5</div>
            <div class="stock-info">
              <span class="stock-label">Category</span>
              <span class="stock-value">IT Equipment</span>
            </div>
            <div class="stock-info">
              <span class="stock-label">Min. Level</span>
              <span class="stock-value">10</span>
            </div>
            <div class="stock-info">
              <span class="stock-label">Max. Level</span>
              <span class="stock-value">30</span>
            </div>
            <div class="stock-progress">
              <div class="progress-bar low" style="width: 17%"></div>
            </div>
            <div class="stock-info">
              <span class="stock-label">Status</span>
              <span class="badge badge-stock low">Low Stock</span>
            </div>
          </div>
          <div class="stock-card-footer">
            <a href="#" class="edit-item" data-id="2">
              <i class="bi bi-pencil"></i> Edit
            </a>
            <a href="#" class="order-item" data-id="2">
              <i class="bi bi-bag-plus"></i> Order More
            </a>
          </div>
        </div>

        <!-- Item 3 -->
        <div class="stock-card">
          <div class="stock-card-header">
            <h3 class="stock-card-title">HDMI Cable</h3>
            <div class="category-icon">
              <i class="bi bi-usb-symbol"></i>
            </div>
          </div>
          <div class="stock-card-body">
            <div class="stock-level">2</div>
            <div class="stock-info">
              <span class="stock-label">Category</span>
              <span class="stock-value">Electronics</span>
            </div>
            <div class="stock-info">
              <span class="stock-label">Min. Level</span>
              <span class="stock-value">5</span>
            </div>
            <div class="stock-info">
              <span class="stock-label">Max. Level</span>
              <span class="stock-value">20</span>
            </div>
            <div class="stock-progress">
              <div class="progress-bar critical" style="width: 10%"></div>
            </div>
            <div class="stock-info">
              <span class="stock-label">Status</span>
              <span class="badge badge-stock critical">Critical</span>
            </div>
          </div>
          <div class="stock-card-footer">
            <a href="#" class="edit-item" data-id="3">
              <i class="bi bi-pencil"></i> Edit
            </a>
            <a href="#" class="order-item" data-id="3">
              <i class="bi bi-bag-plus"></i> Order More
            </a>
          </div>
        </div>

        <!-- Item 4 -->
        <div class="stock-card">
          <div class="stock-card-header">
            <h3 class="stock-card-title">Office Chair</h3>
            <div class="category-icon">
              <i class="bi bi-chair"></i>
            </div>
          </div>
          <div class="stock-card-body">
            <div class="stock-level">25</div>
            <div class="stock-info">
              <span class="stock-label">Category</span>
              <span class="stock-value">Furniture</span>
            </div>
            <div class="stock-info">
              <span class="stock-label">Min. Level</span>
              <span class="stock-value">10</span>
            </div>
            <div class="stock-info">
              <span class="stock-label">Max. Level</span>
              <span class="stock-value">30</span>
            </div>
            <div class="stock-progress">
              <div class="progress-bar high" style="width: 83%"></div>
            </div>
            <div class="stock-info">
              <span class="stock-label">Status</span>
              <span class="badge badge-stock high">High Stock</span>
            </div>
          </div>
          <div class="stock-card-footer">
            <a href="#" class="edit-item" data-id="4">
              <i class="bi bi-pencil"></i> Edit
            </a>
            <a href="#" class="order-item" data-id="4">
              <i class="bi bi-bag-plus"></i> Order More
            </a>
          </div>
        </div>

        <!-- Item 5 -->
        <div class="stock-card">
          <div class="stock-card-header">
            <h3 class="stock-card-title">Desk Lamp</h3>
            <div class="category-icon">
              <i class="bi bi-lamp"></i>
            </div>
          </div>
          <div class="stock-card-body">
            <div class="stock-level">12</div>
            <div class="stock-info">
              <span class="stock-label">Category</span>
              <span class="stock-value">Office Supplies</span>
            </div>
            <div class="stock-info">
              <span class="stock-label">Min. Level</span>
              <span class="stock-value">5</span>
            </div>
            <div class="stock-info">
              <span class="stock-label">Max. Level</span>
              <span class="stock-value">15</span>
            </div>
            <div class="stock-progress">
              <div class="progress-bar normal" style="width: 80%"></div>
            </div>
            <div class="stock-info">
              <span class="stock-label">Status</span>
              <span class="badge badge-stock normal">Normal</span>
            </div>
          </div>
          <div class="stock-card-footer">
            <a href="#" class="edit-item" data-id="5">
              <i class="bi bi-pencil"></i> Edit
            </a>
            <a href="#" class="order-item" data-id="5">
              <i class="bi bi-bag-plus"></i> Order More
            </a>
          </div>
        </div>

        <!-- Item 6 -->
        <div class="stock-card">
          <div class="stock-card-header">
            <h3 class="stock-card-title">Whiteboard Markers</h3>
            <div class="category-icon">
              <i class="bi bi-pen"></i>
            </div>
          </div>
          <div class="stock-card-body">
            <div class="stock-level">8</div>
            <div class="stock-info">
              <span class="stock-label">Category</span>
              <span class="stock-value">Office Supplies</span>
            </div>
            <div class="stock-info">
              <span class="stock-label">Min. Level</span>
              <span class="stock-value">10</span>
            </div>
            <div class="stock-info">
              <span class="stock-label">Max. Level</span>
              <span class="stock-value">50</span>
            </div>
            <div class="stock-progress">
              <div class="progress-bar low" style="width: 16%"></div>
            </div>
            <div class="stock-info">
              <span class="stock-label">Status</span>
              <span class="badge badge-stock low">Low Stock</span>
            </div>
          </div>
          <div class="stock-card-footer">
            <a href="#" class="edit-item" data-id="6">
              <i class="bi bi-pencil"></i> Edit
            </a>
            <a href="#" class="order-item" data-id="6">
              <i class="bi bi-bag-plus"></i> Order More
            </a>
          </div>
        </div>
      </div>
    </div>

    <!-- Modal Backdrop -->
    <div class="modal-backdrop" id="modalBackdrop"></div>

    <!-- Add/Edit Item Modal -->
    <div class="modal" id="itemModal">
      <div class="modal-header">
        <h3 class="modal-title" id="itemModalTitle">Add New Item</h3>
        <button class="modal-close" id="closeItemModal">&times;</button>
      </div>
      <div class="modal-body">
        <form id="itemForm">
          <div class="row">
            <div class="col-md-6">
              <div class="form-group">
                <label for="itemName">Item Name</label>
                <input
                  type="text"
                  class="form-control"
                  id="itemName"
                  placeholder="Enter item name"
                  required
                />
              </div>
            </div>
            <div class="col-md-6">
              <div class="form-group">
                <label for="itemCategory">Category</label>
                <select class="form-control" id="itemCategory" required>
                  <option value="">Select Category</option>
                  <option value="electronics">Electronics</option>
                  <option value="office">Office Supplies</option>
                  <option value="furniture">Furniture</option>
                  <option value="it">IT Equipment</option>
                </select>
              </div>
            </div>
          </div>

          <div class="row">
            <div class="col-md-4">
              <div class="form-group">
                <label for="currentStock">Current Stock</label>
                <input
                  type="number"
                  class="form-control"
                  id="currentStock"
                  min="0"
                  placeholder="Current quantity"
                  required
                />
              </div>
            </div>
            <div class="col-md-4">
              <div class="form-group">
                <label for="minLevel">Minimum Level</label>
                <input
                  type="number"
                  class="form-control"
                  id="minLevel"
                  min="0"
                  placeholder="Min stock level"
                  required
                />
              </div>
            </div>
            <div class="col-md-4">
              <div class="form-group">
                <label for="maxLevel">Maximum Level</label>
                <input
                  type="number"
                  class="form-control"
                  id="maxLevel"
                  min="0"
                  placeholder="Max stock level"
                  required
                />
              </div>
            </div>
          </div>

          <div class="form-group">
            <label for="itemLocation">Storage Location</label>
            <input
              type="text"
              class="form-control"
              id="itemLocation"
              placeholder="Where is this item stored?"
            />
          </div>

          <div class="form-group">
            <label for="itemNotes">Notes</label>
            <textarea
              class="form-control"
              id="itemNotes"
              placeholder="Additional information about this item"
            ></textarea>
          </div>
        </form>
      </div>
      <div class="modal-footer">
        <button class="btn btn-outline" id="closeItemModalBtn">Cancel</button>
        <button class="btn btn-primary" id="saveItemBtn">
          <i class="bi bi-save"></i> Save Item
        </button>
      </div>
    </div>

    <!-- Order Item Modal -->
    <div class="modal" id="orderModal">
      <div class="modal-header">
        <h3 class="modal-title">Order More Stock</h3>
        <button class="modal-close" id="closeOrderModal">&times;</button>
      </div>
      <div class="modal-body">
        <form id="orderForm">
          <div class="form-group">
            <label for="orderItem">Item</label>
            <input type="text" class="form-control" id="orderItem" readonly />
          </div>

          <div class="row">
            <div class="col-md-6">
              <div class="form-group">
                <label for="currentQuantity">Current Stock</label>
                <input
                  type="number"
                  class="form-control"
                  id="currentQuantity"
                  readonly
                />
              </div>
            </div>
            <div class="col-md-6">
              <div class="form-group">
                <label for="orderQuantity">Order Quantity</label>
                <input
                  type="number"
                  class="form-control"
                  id="orderQuantity"
                  min="1"
                  required
                />
              </div>
            </div>
          </div>

          <div class="form-group">
            <label for="supplier">Supplier</label>
            <select class="form-control" id="supplier" required>
              <option value="">Select Supplier</option>
              <option value="1">ABC Office Supplies</option>
              <option value="2">Tech Solutions Inc.</option>
              <option value="3">Furniture World</option>
              <option value="4">General Distributors</option>
            </select>
          </div>

          <div class="form-group">
            <label for="urgency">Urgency</label>
            <select class="form-control" id="urgency" required>
              <option value="low">Low - Standard Delivery</option>
              <option value="medium">Medium - Priority Delivery</option>
              <option value="high">High - Express Delivery</option>
            </select>
          </div>

          <div class="form-group">
            <label for="orderNotes">Notes</label>
            <textarea
              class="form-control"
              id="orderNotes"
              placeholder="Additional information for this order"
            ></textarea>
          </div>
        </form>
      </div>
      <div class="modal-footer">
        <button class="btn btn-outline" id="closeOrderModalBtn">Cancel</button>
        <button class="btn btn-primary" id="submitOrderBtn">
          <i class="bi bi-send"></i> Submit Order
        </button>
      </div>
    </div>

    <!-- JavaScript -->
    <script>
      document.addEventListener("DOMContentLoaded", function () {
        // Modal elements
        const modalBackdrop = document.getElementById("modalBackdrop");
        const itemModal = document.getElementById("itemModal");
        const orderModal = document.getElementById("orderModal");

        // Add new item button
        document
          .getElementById("addItemBtn")
          .addEventListener("click", function () {
            document.getElementById("itemModalTitle").textContent =
              "Add New Item";
            document.getElementById("itemForm").reset();
            itemModal.style.display = "block";
            modalBackdrop.style.display = "block";
          });

        // Edit item buttons
        document.querySelectorAll(".edit-item").forEach((btn) => {
          btn.addEventListener("click", function (e) {
            e.preventDefault();
            const itemId = this.getAttribute("data-id");
            document.getElementById("itemModalTitle").textContent = "Edit Item";
            itemModal.style.display = "block";
            modalBackdrop.style.display = "block";
          });
        });

        // Order more buttons
        document.querySelectorAll(".order-item").forEach((btn) => {
          btn.addEventListener("click", function (e) {
            e.preventDefault();
            const itemId = this.getAttribute("data-id");
            const itemName =
              this.closest(".stock-card").querySelector(
                ".stock-card-title"
              ).textContent;
            const currentStock =
              this.closest(".stock-card").querySelector(
                ".stock-level"
              ).textContent;

            document.getElementById("orderItem").value = itemName;
            document.getElementById("currentQuantity").value = currentStock;
            document.getElementById("orderQuantity").value = "";

            orderModal.style.display = "block";
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

        // Close order modal
        document
          .getElementById("closeOrderModal")
          .addEventListener("click", function () {
            orderModal.style.display = "none";
            modalBackdrop.style.display = "none";
          });

        document
          .getElementById("closeOrderModalBtn")
          .addEventListener("click", function () {
            orderModal.style.display = "none";
            modalBackdrop.style.display = "none";
          });

        // Save item
        document
          .getElementById("saveItemBtn")
          .addEventListener("click", function () {
            const form = document.getElementById("itemForm");
            if (form.checkValidity()) {
              alert("Item saved successfully!");
              itemModal.style.display = "none";
              modalBackdrop.style.display = "none";
            } else {
              form.reportValidity();
            }
          });

        // Submit order
        document
          .getElementById("submitOrderBtn")
          .addEventListener("click", function () {
            const form = document.getElementById("orderForm");
            if (form.checkValidity()) {
              alert("Order submitted successfully!");
              orderModal.style.display = "none";
              modalBackdrop.style.display = "none";
            } else {
              form.reportValidity();
            }
          });

        // Search functionality
        document
          .getElementById("searchItems")
          .addEventListener("input", function () {
            const searchTerm = this.value.toLowerCase();
            const cards = document.querySelectorAll(".stock-card");

            cards.forEach((card) => {
              const itemName = card
                .querySelector(".stock-card-title")
                .textContent.toLowerCase();
              const category = card
                .querySelector(".stock-value")
                .textContent.toLowerCase();

              if (
                itemName.includes(searchTerm) ||
                category.includes(searchTerm)
              ) {
                card.style.display = "";
              } else {
                card.style.display = "none";
              }
            });
          });

        // Filter by category
        document
          .getElementById("filterCategory")
          .addEventListener("change", function () {
            const category = this.value.toLowerCase();
            const cards = document.querySelectorAll(".stock-card");

            if (category === "all") {
              cards.forEach((card) => (card.style.display = ""));
            } else {
              cards.forEach((card) => {
                const cardCategory = card
                  .querySelector(".stock-value")
                  .textContent.toLowerCase();
                if (cardCategory.includes(category)) {
                  card.style.display = "";
                } else {
                  card.style.display = "none";
                }
              });
            }
          });

        // Filter by stock level
        document
          .getElementById("filterStockLevel")
          .addEventListener("change", function () {
            const stockLevel = this.value.toLowerCase();
            const cards = document.querySelectorAll(".stock-card");

            if (stockLevel === "all") {
              cards.forEach((card) => (card.style.display = ""));
            } else {
              cards.forEach((card) => {
                const badge = card.querySelector(".badge-stock");
                if (badge && badge.classList.contains(stockLevel)) {
                  card.style.display = "";
                } else {
                  card.style.display = "none";
                }
              });
            }
          });

        // Reset filters
        document
          .getElementById("resetFilters")
          .addEventListener("click", function () {
            document.getElementById("searchItems").value = "";
            document.getElementById("filterCategory").value = "all";
            document.getElementById("filterStockLevel").value = "all";

            // Show all cards
            document.querySelectorAll(".stock-card").forEach((card) => {
              card.style.display = "";
            });
          });
      });
    </script>
  </body>
</html>
