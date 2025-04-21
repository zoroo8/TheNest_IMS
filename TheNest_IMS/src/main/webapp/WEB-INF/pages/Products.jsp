<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
    <!-- Mobile Menu Toggle -->
    <button class="mobile-toggle" id="mobileToggle">
      <i class="bi bi-list"></i>
    </button>
    
    <!-- Sidebar -->
    <div class="sidebar" id="sidebar">
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
        <a href="stock-in" class="menu-item">
          <i class="bi bi-box-arrow-in-down"></i>
          <span>Stock In</span>
        </a>
        <a href="stock-out" class="menu-item">
          <i class="bi bi-box-arrow-up"></i>
          <span>Stock Out</span>
        </a>
        <a href="low-stock" class="menu-item">
          <i class="bi bi-exclamation-triangle"></i>
          <span>Low Stock</span>
        </a>
        <a href="stock-history" class="menu-item">
          <i class="bi bi-clock-history"></i>
          <span>Stock History</span>
        </a>
        <a href="trucks" class="menu-item">
          <i class="bi bi-truck"></i>
          <span>Trucks</span>
        </a>
        <a href="deliveries" class="menu-item">
          <i class="bi bi-box-seam"></i>
          <span>Deliveries</span>
        </a>
        <a href="drivers" class="menu-item">
          <i class="bi bi-person"></i>
          <span>Drivers</span>
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
            <select class="form-control" id="filterStock">
              <option value="all" selected>All Stock</option>
              <option value="instock">In Stock</option>
              <option value="lowstock">Low Stock</option>
              <option value="outofstock">Out of Stock</option>
            </select>
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
                  <th class="sortable">Products <i class="bi bi-caret-up-fill"></i></th>
                  <th class="sortable">Quantity(unit) <i class="bi bi-caret-down-fill"></i></th>
                  <th>Category</th>
                  <th>Price (Rs)</th>
                  <th>Edit</th>
                  <th>Delete</th>
                </tr>
              </thead>
              <tbody>
                <tr>
                  <td>Rice</td>
                  <td>403</td>
                  <td><span class="category-badge badge-groceries">Groceries</span></td>
                  <td>2400</td>
                  <td>
                    <button class="action-btn edit-btn" data-id="1">
                      <i class="bi bi-pencil"></i>
                    </button>
                  </td>
                  <td>
                    <button class="action-btn delete-btn" data-id="1">
                      <i class="bi bi-x-lg"></i>
                    </button>
                  </td>
                </tr>
                <tr>
                  <td>Lentils</td>
                  <td>381</td>
                  <td><span class="category-badge badge-groceries">Groceries</span></td>
                  <td>1500</td>
                  <td>
                    <button class="action-btn edit-btn" data-id="2">
                      <i class="bi bi-pencil"></i>
                    </button>
                  </td>
                  <td>
                    <button class="action-btn delete-btn" data-id="2">
                      <i class="bi bi-x-lg"></i>
                    </button>
                  </td>
                </tr>
                <tr>
                  <td>Chair</td>
                  <td>41</td>
                  <td><span class="category-badge badge-furnitures">Furnitures</span></td>
                  <td>4500</td>
                  <td>
                    <button class="action-btn edit-btn" data-id="3">
                      <i class="bi bi-pencil"></i>
                    </button>
                  </td>
                  <td>
                    <button class="action-btn delete-btn" data-id="3">
                      <i class="bi bi-x-lg"></i>
                    </button>
                  </td>
                </tr>
                <tr>
                  <td>Sprite</td>
                  <td>500</td>
                  <td><span class="category-badge badge-beverages">Beverages</span></td>
                  <td>150</td>
                  <td>
                    <button class="action-btn edit-btn" data-id="4">
                      <i class="bi bi-pencil"></i>
                    </button>
                  </td>
                  <td>
                    <button class="action-btn delete-btn" data-id="4">
                      <i class="bi bi-x-lg"></i>
                    </button>
                  </td>
                </tr>
                <tr>
                  <td>T-shirt</td>
                  <td>120</td>
                  <td><span class="category-badge badge-clothing">Clothing</span></td>
                  <td>800</td>
                  <td>
                    <button class="action-btn edit-btn" data-id="5">
                      <i class="bi bi-pencil"></i>
                    </button>
                  </td>
                  <td>
                    <button class="action-btn delete-btn" data-id="5">
                      <i class="bi bi-x-lg"></i>
                    </button>
                  </td>
                </tr>
                <tr>
                  <td>Headphones</td>
                  <td>25</td>
                  <td><span class="category-badge badge-electronics">Electronics</span></td>
                  <td>3500</td>
                  <td>
                    <button class="action-btn edit-btn" data-id="6">
                      <i class="bi bi-pencil"></i>
                    </button>
                  </td>
                  <td>
                    <button class="action-btn delete-btn" data-id="6">
                      <i class="bi bi-x-lg"></i>
                    </button>
                  </td>
                </tr>
              </tbody>
            </table>
          </div>
        </div>
        <div class="card-footer">
          <ul class="pagination">
            <li class="page-item">
              <a href="#" class="page-link"><i class="bi bi-chevron-left"></i></a>
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
              <a href="#" class="page-link"><i class="bi bi-chevron-right"></i></a>
            </li>
          </ul>
        </div>
      </div>
    </div>

    <!-- JavaScript for Search and Filter Functionality -->
    <script>
      // Wait for the DOM to be fully loaded
      document.addEventListener('DOMContentLoaded', function() {
          // Initialize elements
          const searchInput = document.getElementById('searchProducts');
          const categoryFilter = document.getElementById('filterCategory');
          const supplierFilter = document.getElementById('filterSupplier');
          const stockFilter = document.getElementById('filterStock');
          const productRows = document.querySelectorAll('tbody tr');
          const mobileToggle = document.getElementById('mobileToggle');
          const sidebar = document.getElementById('sidebar');
          
          // Mobile menu toggle functionality
          if (mobileToggle) {
              mobileToggle.addEventListener('click', function() {
                  sidebar.classList.toggle('show');
              });
          }
          
          // Search functionality
          if (searchInput) {
              searchInput.addEventListener('input', filterProducts);
          }
          
          // Filter dropdown functionality
          if (categoryFilter) {
              categoryFilter.addEventListener('change', filterProducts);
          }
          
          if (supplierFilter) {
              supplierFilter.addEventListener('change', filterProducts);
          }
          
          if (stockFilter) {
              stockFilter.addEventListener('change', filterProducts);
          }
          
          // Sort functionality
          const sortableHeaders = document.querySelectorAll('th.sortable');
          sortableHeaders.forEach(header => {
              header.addEventListener('click', function() {
                  const isAscending = this.querySelector('i').classList.contains('bi-caret-up-fill');
                  sortTable(this, !isAscending);
              });
          });
          
          // Add Product Button functionality
          const addProductBtn = document.getElementById('addProductBtn');
          if (addProductBtn) {
              addProductBtn.addEventListener('click', function() {
                  // Add your code to show the add product modal or redirect to add product page
                  alert('Add Product functionality will be implemented here');
              });
          }
          
          // Edit and Delete button functionality
          const editButtons = document.querySelectorAll('.edit-btn');
          const deleteButtons = document.querySelectorAll('.delete-btn');
          
          editButtons.forEach(button => {
              button.addEventListener('click', function() {
                  const productId = this.getAttribute('data-id');
                  // Add your code to show the edit product modal or redirect to edit product page
                  alert(`Edit Product with ID: ${productId}`);
              });
          });
          
          deleteButtons.forEach(button => {
              button.addEventListener('click', function() {
                  const productId = this.getAttribute('data-id');
                  if (confirm('Are you sure you want to delete this product?')) {
                      // Add your code to delete the product
                      alert(`Delete Product with ID: ${productId}`);
                  }
              });
          });
          
          // Main filtering function
          function filterProducts() {
              const searchTerm = searchInput.value.toLowerCase();
              const categoryValue = categoryFilter.value;
              const supplierValue = supplierFilter.value;
              const stockValue = stockFilter.value;
              
              let visibleCount = 0;
              
              productRows.forEach(row => {
                  const productName = row.cells[0].textContent.toLowerCase();
                  const quantity = parseInt(row.cells[1].textContent);
                  const categoryElement = row.cells[2].querySelector('.category-badge');
                  const categoryText = categoryElement ? categoryElement.textContent.toLowerCase() : '';
                  const categoryClass = categoryElement ? categoryElement.className : '';
                  
                  // Check if product matches search term
                  const matchesSearch = productName.includes(searchTerm);
                  
                  // Check if product matches category filter
                  const matchesCategory = categoryValue === 'all' || 
                                         (categoryValue === 'groceries' && categoryClass.includes('badge-groceries')) ||
                                         (categoryValue === 'furnitures' && categoryClass.includes('badge-furnitures')) ||
                                         (categoryValue === 'beverages' && categoryClass.includes('badge-beverages')) ||
                                         (categoryValue === 'clothing' && categoryClass.includes('badge-clothing')) ||
                                         (categoryValue === 'electronics' && categoryClass.includes('badge-electronics'));
                  
                  // For supplier - assuming we'd add a data attribute or hidden column for supplier
                  const matchesSupplier = supplierValue === 'all'; // Update this based on your data structure
                  
                  // Check if product matches stock filter
                  const matchesStock = stockValue === 'all' || 
                                     (stockValue === 'instock' && quantity > 10) ||
                                     (stockValue === 'lowstock' && quantity <= 10 && quantity > 0) ||
                                     (stockValue === 'outofstock' && quantity === 0);
                  
                  // Show or hide the row based on all filters
                  if (matchesSearch && matchesCategory && matchesSupplier && matchesStock) {
                      row.style.display = '';
                      visibleCount++;
                  } else {
                      row.style.display = 'none';
                  }
              });
              
              // Update the total products count in the badge
              const totalBadge = document.querySelector('.badge-primary');
              if (totalBadge) {
                  totalBadge.textContent = `Total: ${visibleCount} Products`;
              }
          }
          
          // Function to sort the table
          function sortTable(header, ascending) {
              const table = header.closest('table');
              const columnIndex = Array.from(header.parentNode.children).indexOf(header);
              const rows = Array.from(table.querySelectorAll('tbody tr'));
              
              // Update sort icon
              const icons = header.querySelectorAll('i');
              icons.forEach(icon => {
                  if (ascending) {
                      icon.className = 'bi bi-caret-up-fill';
                  } else {
                      icon.className = 'bi bi-caret-down-fill';
                  }
              });
              
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
              const tbody = table.querySelector('tbody');
              rows.forEach(row => tbody.appendChild(row));
          }
      });
    </script>
  </body>
</html>