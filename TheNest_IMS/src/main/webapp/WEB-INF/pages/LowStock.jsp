<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%> <%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Low Stock Report - The Nest Inventory System</title>
    <link rel="preconnect" href="https://fonts.googleapis.com" />
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
    <link
      href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap"
      rel="stylesheet"
    />
    <link
      rel="stylesheet"
      href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css"
    />
    <link rel="stylesheet" href="<c:url value='/resources/css/main.css' />" />
    <link
      rel="stylesheet"
      href="<c:url value='/resources/css/LowStock.css' />"
    />
  </head>
  <body>
    <!-- Include the sidebar -->
    <jsp:include page="components/Sidebar.jsp" />

    <!-- Main Content -->
    <div class="main-content">
      <div class="page-header">
        <h1 class="page-title">Low Stock Report</h1>
        <div>
          <button class="btn btn-outline me-2" id="emailSuppliersBtn">
            <i class="bi bi-envelope"></i> Email Suppliers
          </button>
          <button class="btn btn-primary" id="bulkRestockBtn">
            <i class="bi bi-bag-plus"></i> Bulk Restock
          </button>
        </div>
      </div>

      <!-- Stats Row -->
      <div class="stats-row">
        <div class="stat-card">
          <div class="stat-icon critical-icon">
            <i class="bi bi-exclamation-triangle-fill"></i>
          </div>
          <div>
            <div class="stat-value">8</div>
            <div class="stat-label">Critical Stock</div>
          </div>
        </div>
        <div class="stat-card">
          <div class="stat-icon warning-icon">
            <i class="bi bi-exclamation-circle-fill"></i>
          </div>
          <div>
            <div class="stat-value">15</div>
            <div class="stat-label">Low Stock</div>
          </div>
        </div>
        <div class="stat-card">
          <div class="stat-icon restock-icon">
            <i class="bi bi-arrow-repeat"></i>
          </div>
          <div>
            <div class="stat-value">5</div>
            <div class="stat-label">Pending Restocks</div>
          </div>
        </div>
        <div class="stat-card">
          <div class="stat-icon value-icon">
            <i class="bi bi-cash-stack"></i>
          </div>
          <div>
            <div class="stat-value">$12,450</div>
            <div class="stat-label">Restock Value</div>
          </div>
        </div>
      </div>

      <!-- Filter Section -->
      <div class="filter-section">
        <div class="filter-row">
          <div class="filter-group">
            <label class="form-label">Category</label>
            <select class="form-control" id="categoryFilter">
              <option value="all" selected>All Categories</option>
              <option value="electronics">Electronics</option>
              <option value="furniture">Furniture</option>
              <option value="office-supplies">Office Supplies</option>
              <option value="kitchen">Kitchen Supplies</option>
              <option value="stationery">Stationery</option>
            </select>
          </div>
          <div class="filter-group">
            <label class="form-label">Supplier</label>
            <select class="form-control" id="supplierFilter">
              <option value="all" selected>All Suppliers</option>
              <option value="tech-world">Tech World</option>
              <option value="office-plus">Office Plus</option>
              <option value="furniture-depot">Furniture Depot</option>
              <option value="kitchen-essentials">Kitchen Essentials</option>
            </select>
          </div>
          <div class="filter-group">
            <label class="form-label">Stock Level</label>
            <select class="form-control" id="stockLevelFilter">
              <option value="all" selected>All Levels</option>
              <option value="critical">Critical Only</option>
              <option value="low">Low Only</option>
              <option value="normal">Normal</option>
            </select>
          </div>
          <div class="filter-group">
            <label class="form-label">Sort By</label>
            <select class="form-control" id="sortByFilter">
              <option value="stock-asc" selected>Lowest Stock First</option>
              <option value="stock-desc">Highest Stock First</option>
              <option value="name-asc">Name (A-Z)</option>
              <option value="name-desc">Name (Z-A)</option>
              <option value="value-desc">Highest Value</option>
            </select>
          </div>
        </div>
      </div>

      <!-- Low Stock Table -->
      <div class="card">
        <div class="card-header">
          <h2 class="card-title">Low Stock Items</h2>
          <div class="card-actions">
            <div class="search-box">
              <i class="bi bi-search search-icon"></i>
              <input
                type="text"
                class="form-control"
                placeholder="Search items..."
                id="searchItems"
              />
            </div>
          </div>
        </div>
        <div class="card-body">
          <div class="table-responsive">
            <table class="table">
              <thead>
                <tr>
                  <th>Item Name</th>
                  <th>Category</th>
                  <th>Current Stock</th>
                  <th>Min. Stock</th>
                  <th>Reorder Qty</th>
                  <th>Supplier</th>
                  <th>Status</th>
                  <th>Actions</th>
                </tr>
              </thead>
              <tbody>
                <tr>
                  <td>
                    <div class="item-info">
                      <div>
                        <div class="item-name">Dell XPS 13 Laptop</div>
                        <div class="item-sku">SKU: TECH-001</div>
                      </div>
                    </div>
                  </td>
                  <td>Electronics</td>
                  <td>
                    <div class="stock-info">
                      <span class="stock-count">2</span>
                      <div class="stock-level-indicator">
                        <div
                          class="stock-level-bar critical"
                          style="width: 10%"
                        ></div>
                      </div>
                    </div>
                  </td>
                  <td>10</td>
                  <td>5</td>
                  <td>Tech World</td>
                  <td><span class="badge bg-danger">Critical</span></td>
                  <td>
                    <div class="action-buttons">
                      <button
                        class="action-btn restock-btn"
                        title="Restock"
                        onclick="openRestockModal('Dell XPS 13 Laptop', 'TECH-001', 2, 5)"
                      >
                        <i class="bi bi-bag-plus"></i>
                      </button>
                      <button
                        class="action-btn email-btn"
                        title="Email Supplier"
                        onclick="openEmailModal('Tech World', 'Dell XPS 13 Laptop')"
                      >
                        <i class="bi bi-envelope"></i>
                      </button>
                      <button
                        class="action-btn view-btn"
                        title="View Details"
                        onclick="viewItemDetails('TECH-001')"
                      >
                        <i class="bi bi-eye"></i>
                      </button>
                    </div>
                  </td>
                </tr>
                <tr>
                  <td>
                    <div class="item-info">
                      <div>
                        <div class="item-name">Ergonomic Office Chair</div>
                        <div class="item-sku">SKU: FURN-005</div>
                      </div>
                    </div>
                  </td>
                  <td>Furniture</td>
                  <td>
                    <div class="stock-info">
                      <span class="stock-count">3</span>
                      <div class="stock-level-indicator">
                        <div
                          class="stock-level-bar critical"
                          style="width: 15%"
                        ></div>
                      </div>
                    </div>
                  </td>
                  <td>15</td>
                  <td>10</td>
                  <td>Furniture Depot</td>
                  <td><span class="badge bg-danger">Critical</span></td>
                  <td>
                    <div class="action-buttons">
                      <button
                        class="action-btn restock-btn"
                        title="Restock"
                        onclick="openRestockModal('Ergonomic Office Chair', 'FURN-005', 3, 10)"
                      >
                        <i class="bi bi-bag-plus"></i>
                      </button>
                      <button
                        class="action-btn email-btn"
                        title="Email Supplier"
                        onclick="openEmailModal('Furniture Depot', 'Ergonomic Office Chair')"
                      >
                        <i class="bi bi-envelope"></i>
                      </button>
                      <button
                        class="action-btn view-btn"
                        title="View Details"
                        onclick="viewItemDetails('FURN-005')"
                      >
                        <i class="bi bi-eye"></i>
                      </button>
                    </div>
                  </td>
                </tr>
                <tr>
                  <td>
                    <div class="item-info">
                      <div>
                        <div class="item-name">HP LaserJet Printer</div>
                        <div class="item-sku">SKU: TECH-012</div>
                      </div>
                    </div>
                  </td>
                  <td>Electronics</td>
                  <td>
                    <div class="stock-info">
                      <span class="stock-count">5</span>
                      <div class="stock-level-indicator">
                        <div
                          class="stock-level-bar warning"
                          style="width: 25%"
                        ></div>
                      </div>
                    </div>
                  </td>
                  <td>15</td>
                  <td>10</td>
                  <td>Tech World</td>
                  <td><span class="badge bg-warning">Low</span></td>
                  <td>
                    <div class="action-buttons">
                      <button
                        class="action-btn restock-btn"
                        title="Restock"
                        onclick="openRestockModal('HP LaserJet Printer', 'TECH-012', 5, 10)"
                      >
                        <i class="bi bi-bag-plus"></i>
                      </button>
                      <button
                        class="action-btn email-btn"
                        title="Email Supplier"
                        onclick="openEmailModal('Tech World', 'HP LaserJet Printer')"
                      >
                        <i class="bi bi-envelope"></i>
                      </button>
                      <button
                        class="action-btn view-btn"
                        title="View Details"
                        onclick="viewItemDetails('TECH-012')"
                      >
                        <i class="bi bi-eye"></i>
                      </button>
                    </div>
                  </td>
                </tr>
                <tr>
                  <td>
                    <div class="item-info">
                      <div>
                        <div class="item-name">
                          A4 Printing Paper (500 sheets)
                        </div>
                        <div class="item-sku">SKU: STAT-002</div>
                      </div>
                    </div>
                  </td>
                  <td>Stationery</td>
                  <td>
                    <div class="stock-info">
                      <span class="stock-count">8</span>
                      <div class="stock-level-indicator">
                        <div
                          class="stock-level-bar warning"
                          style="width: 40%"
                        ></div>
                      </div>
                    </div>
                  </td>
                  <td>20</td>
                  <td>15</td>
                  <td>Office Plus</td>
                  <td><span class="badge bg-warning">Low</span></td>
                  <td>
                    <div class="action-buttons">
                      <button
                        class="action-btn restock-btn"
                        title="Restock"
                        onclick="openRestockModal('A4 Printing Paper (500 sheets)', 'STAT-002', 8, 15)"
                      >
                        <i class="bi bi-bag-plus"></i>
                      </button>
                      <button
                        class="action-btn email-btn"
                        title="Email Supplier"
                        onclick="openEmailModal('Office Plus', 'A4 Printing Paper (500 sheets)')"
                      >
                        <i class="bi bi-envelope"></i>
                      </button>
                      <button
                        class="action-btn view-btn"
                        title="View Details"
                        onclick="viewItemDetails('STAT-002')"
                      >
                        <i class="bi bi-eye"></i>
                      </button>
                    </div>
                  </td>
                </tr>
                <tr>
                  <td>
                    <div class="item-info">
                      <div>
                        <div class="item-name">Coffee Maker</div>
                        <div class="item-sku">SKU: KITCH-007</div>
                      </div>
                    </div>
                  </td>
                  <td>Kitchen</td>
                  <td>
                    <div class="stock-info">
                      <span class="stock-count">4</span>
                      <div class="stock-level-indicator">
                        <div
                          class="stock-level-bar warning"
                          style="width: 30%"
                        ></div>
                      </div>
                    </div>
                  </td>
                  <td>12</td>
                  <td>8</td>
                  <td>Kitchen Essentials</td>
                  <td><span class="badge bg-warning">Low</span></td>
                  <td>
                    <div class="action-buttons">
                      <button
                        class="action-btn restock-btn"
                        title="Restock"
                        onclick="openRestockModal('Coffee Maker', 'KITCH-007', 4, 8)"
                      >
                        <i class="bi bi-bag-plus"></i>
                      </button>
                      <button
                        class="action-btn email-btn"
                        title="Email Supplier"
                        onclick="openEmailModal('Kitchen Essentials', 'Coffee Maker')"
                      >
                        <i class="bi bi-envelope"></i>
                      </button>
                      <button
                        class="action-btn view-btn"
                        title="View Details"
                        onclick="viewItemDetails('KITCH-007')"
                      >
                        <i class="bi bi-eye"></i>
                      </button>
                    </div>
                  </td>
                </tr>
              </tbody>
            </table>
          </div>
        </div>
        <div class="card-footer">
          <nav aria-label="Page navigation">
            <ul class="pagination">
              <li class="page-item disabled">
                <a class="page-link" href="#" aria-label="Previous">
                  <i class="bi bi-chevron-left"></i>
                </a>
              </li>
              <li class="page-item active">
                <a class="page-link" href="#">1</a>
              </li>
              <li class="page-item"><a class="page-link" href="#">2</a></li>
              <li class="page-item"><a class="page-link" href="#">3</a></li>
              <li class="page-item">
                <a class="page-link" href="#" aria-label="Next">
                  <i class="bi bi-chevron-right"></i>
                </a>
              </li>
            </ul>
          </nav>
        </div>
      </div>
    </div>

    <!-- Email Suppliers Modal -->
    <div class="modal" id="emailSuppliersModal">
      <div class="modal-dialog">
        <div class="modal-content">
          <div class="modal-header">
            <h3 class="modal-title">Email Suppliers</h3>
            <button
              type="button"
              class="modal-close"
              data-dismiss="modal"
              aria-label="Close"
            >
              <i class="bi bi-x"></i>
            </button>
          </div>
          <div class="modal-body">
            <div class="alert alert-warning mb-3">
              <i class="bi bi-info-circle"></i>
              <div>
                This will send email notifications to suppliers for all selected
                low stock items.
              </div>
            </div>
            <div class="form-group">
              <label class="form-label">Select Suppliers</label>
              <div class="form-check">
                <input
                  class="form-check-input"
                  type="checkbox"
                  id="allSuppliers"
                  checked
                />
                <label class="form-check-label" for="allSuppliers"
                  >All Suppliers</label
                >
              </div>
              <div class="form-check">
                <input
                  class="form-check-input"
                  type="checkbox"
                  id="techWorld"
                />
                <label class="form-check-label" for="techWorld"
                  >Tech World</label
                >
              </div>
              <div class="form-check">
                <input
                  class="form-check-input"
                  type="checkbox"
                  id="officePlus"
                />
                <label class="form-check-label" for="officePlus"
                  >Office Plus</label
                >
              </div>
              <div class="form-check">
                <input
                  class="form-check-input"
                  type="checkbox"
                  id="furnitureDepot"
                />
                <label class="form-check-label" for="furnitureDepot"
                  >Furniture Depot</label
                >
              </div>
              <div class="form-check">
                <input
                  class="form-check-input"
                  type="checkbox"
                  id="kitchenEssentials"
                />
                <label class="form-check-label" for="kitchenEssentials"
                  >Kitchen Essentials</label
                >
              </div>
            </div>
            <div class="form-group">
              <label class="form-label">Include Items</label>
              <div class="form-check">
                <input
                  class="form-check-input"
                  type="checkbox"
                  id="criticalItems"
                  checked
                />
                <label class="form-check-label" for="criticalItems"
                  >Critical Stock Items</label
                >
              </div>
              <div class="form-check">
                <input
                  class="form-check-input"
                  type="checkbox"
                  id="lowItems"
                  checked
                />
                <label class="form-check-label" for="lowItems"
                  >Low Stock Items</label
                >
              </div>
            </div>
            <div class="form-group">
              <label class="form-label">Additional Message</label>
              <textarea
                class="form-control"
                id="emailMessage"
                placeholder="Add any additional information for suppliers..."
              ></textarea>
            </div>
          </div>
          <div class="modal-footer">
            <button type="button" class="btn btn-outline" data-dismiss="modal">
              Cancel
            </button>
            <button type="button" class="btn btn-primary" id="sendEmailsBtn">
              <i class="bi bi-envelope"></i> Send Emails
            </button>
          </div>
        </div>
      </div>
    </div>

    <!-- Bulk Restock Modal -->
    <div class="modal" id="bulkRestockModal">
      <div class="modal-dialog modal-lg">
        <div class="modal-content">
          <div class="modal-header">
            <h3 class="modal-title">Bulk Restock</h3>
            <button
              type="button"
              class="modal-close"
              data-dismiss="modal"
              aria-label="Close"
            >
              <i class="bi bi-x"></i>
            </button>
          </div>
          <div class="modal-body">
            <div class="table-responsive">
              <table class="table">
                <thead>
                  <tr>
                    <th>
                      <div class="form-check">
                        <input
                          class="form-check-input"
                          type="checkbox"
                          id="selectAllItems"
                          checked
                        />
                        <label
                          class="form-check-label"
                          for="selectAllItems"
                        ></label>
                      </div>
                    </th>
                    <th>Item</th>
                    <th>Current Stock</th>
                    <th>Reorder Qty</th>
                    <th>Quantity to Add</th>
                  </tr>
                </thead>
                <tbody>
                  <tr>
                    <td>
                      <div class="form-check">
                        <input
                          class="form-check-input"
                          type="checkbox"
                          id="item1"
                          checked
                        />
                        <label class="form-check-label" for="item1"></label>
                      </div>
                    </td>
                    <td>
                      <div class="item-info">
                        <div>
                          <div class="item-name">Dell XPS 13 Laptop</div>
                          <div class="item-sku">SKU: TECH-001</div>
                        </div>
                      </div>
                    </td>
                    <td>2</td>
                    <td>5</td>
                    <td>
                      <input
                        type="number"
                        class="form-control form-control-sm"
                        value="5"
                        min="1"
                      />
                    </td>
                  </tr>
                  <tr>
                    <td>
                      <div class="form-check">
                        <input
                          class="form-check-input"
                          type="checkbox"
                          id="item2"
                          checked
                        />
                        <label class="form-check-label" for="item2"></label>
                      </div>
                    </td>
                    <td>
                      <div class="item-info">
                        <div>
                          <div class="item-name">Ergonomic Office Chair</div>
                          <div class="item-sku">SKU: FURN-005</div>
                        </div>
                      </div>
                    </td>
                    <td>3</td>
                    <td>10</td>
                    <td>
                      <input
                        type="number"
                        class="form-control form-control-sm"
                        value="10"
                        min="1"
                      />
                    </td>
                  </tr>
                  <tr>
                    <td>
                      <div class="form-check">
                        <input
                          class="form-check-input"
                          type="checkbox"
                          id="item3"
                          checked
                        />
                        <label class="form-check-label" for="item3"></label>
                      </div>
                    </td>
                    <td>
                      <div class="item-info">
                        <div>
                          <div class="item-name">HP LaserJet Printer</div>
                          <div class="item-sku">SKU: TECH-012</div>
                        </div>
                      </div>
                    </td>
                    <td>5</td>
                    <td>10</td>
                    <td>
                      <input
                        type="number"
                        class="form-control form-control-sm"
                        value="10"
                        min="1"
                      />
                    </td>
                  </tr>
                </tbody>
              </table>
            </div>
          </div>
          <div class="modal-footer">
            <button type="button" class="btn btn-outline" data-dismiss="modal">
              Cancel
            </button>
            <button
              type="button"
              class="btn btn-primary"
              id="confirmRestockBtn"
            >
              <i class="bi bi-check2"></i> Confirm Restock
            </button>
          </div>
        </div>
      </div>
    </div>

    <!-- Single Item Restock Modal -->
    <div class="modal" id="restockModal">
      <div class="modal-dialog">
        <div class="modal-content">
          <div class="modal-header">
            <h3 class="modal-title">Restock Item</h3>
            <button
              type="button"
              class="modal-close"
              data-dismiss="modal"
              aria-label="Close"
            >
              <i class="bi bi-x"></i>
            </button>
          </div>
          <div class="modal-body">
            <div class="item-info mb-3">
              <img src="" alt="Item" class="item-image" id="restockItemImage" />
              <div>
                <div class="item-name" id="restockItemName"></div>
                <div class="item-sku" id="restockItemSku"></div>
              </div>
            </div>
            <div class="form-group">
              <label class="form-label">Current Stock</label>
              <input
                type="text"
                class="form-control"
                id="currentStock"
                readonly
              />
            </div>
            <div class="form-group">
              <label class="form-label">Quantity to Add</label>
              <input
                type="number"
                class="form-control"
                id="restockQuantity"
                min="1"
              />
            </div>
            <div class="form-group">
              <label class="form-label">Supplier</label>
              <select class="form-control" id="restockSupplier">
                <option value="tech-world">Tech World</option>
                <option value="office-plus">Office Plus</option>
                <option value="furniture-depot">Furniture Depot</option>
                <option value="kitchen-essentials">Kitchen Essentials</option>
              </select>
            </div>
            <div class="form-group">
              <label class="form-label">Notes</label>
              <textarea
                class="form-control"
                id="restockNotes"
                placeholder="Add any notes about this restock..."
              ></textarea>
            </div>
          </div>
          <div class="modal-footer">
            <button type="button" class="btn btn-outline" data-dismiss="modal">
              Cancel
            </button>
            <button
              type="button"
              class="btn btn-primary"
              id="confirmSingleRestockBtn"
            >
              <i class="bi bi-check2"></i> Confirm
            </button>
          </div>
        </div>
      </div>
    </div>

    <!-- Email Supplier Modal -->
    <div class="modal" id="emailModal">
      <div class="modal-dialog">
        <div class="modal-content">
          <div class="modal-header">
            <h3 class="modal-title">Email Supplier</h3>
            <button
              type="button"
              class="modal-close"
              data-dismiss="modal"
              aria-label="Close"
            >
              <i class="bi bi-x"></i>
            </button>
          </div>
          <div class="modal-body">
            <div class="form-group">
              <label class="form-label">Supplier</label>
              <input
                type="text"
                class="form-control"
                id="emailSupplier"
                readonly
              />
            </div>
            <div class="form-group">
              <label class="form-label">Subject</label>
              <input
                type="text"
                class="form-control"
                id="emailSubject"
                value="Low Stock Alert - Reorder Request"
              />
            </div>
            <div class="form-group">
              <label class="form-label">Items</label>
              <div id="emailItems">
                <div class="form-check">
                  <input
                    class="form-check-input"
                    type="checkbox"
                    id="emailItem1"
                    checked
                  />
                  <label
                    class="form-check-label"
                    for="emailItem1"
                    id="emailItemLabel"
                  ></label>
                </div>
              </div>
            </div>
            <div class="form-group">
              <label class="form-label">Message</label>
              <textarea
                class="form-control"
                id="supplierEmailMessage"
                rows="5"
              ></textarea>
            </div>
          </div>
          <div class="modal-footer">
            <button type="button" class="btn btn-outline" data-dismiss="modal">
              Cancel
            </button>
            <button
              type="button"
              class="btn btn-primary"
              id="sendSupplierEmailBtn"
            >
              <i class="bi bi-envelope"></i> Send Email
            </button>
          </div>
        </div>
      </div>
    </div>

    <!-- JavaScript for functionality -->
    <script>
      // Modal handling
      const modals = document.querySelectorAll(".modal");
      const modalCloseButtons = document.querySelectorAll(
        '[data-dismiss="modal"]'
      );

      // Open modal function
      function openModal(modalId) {
        document.getElementById(modalId).style.display = "block";
      }

      // Close modal function
      function closeModal() {
        modals.forEach((modal) => {
          modal.style.display = "none";
        });
      }

      // Event listeners for modal close buttons
      modalCloseButtons.forEach((button) => {
        button.addEventListener("click", closeModal);
      });

      // Close modal when clicking outside
      window.addEventListener("click", (e) => {
        modals.forEach((modal) => {
          if (e.target === modal) {
            closeModal();
          }
        });
      });

      // Open Email Suppliers Modal
      document
        .getElementById("emailSuppliersBtn")
        .addEventListener("click", () => {
          openModal("emailSuppliersModal");
        });

      // Open Bulk Restock Modal
      document
        .getElementById("bulkRestockBtn")
        .addEventListener("click", () => {
          openModal("bulkRestockModal");
        });

      // Open Single Item Restock Modal
      function openRestockModal(itemName, itemSku, currentStock, reorderQty) {
        document.getElementById("restockItemName").textContent = itemName;
        document.getElementById("restockItemSku").textContent =
          "SKU: " + itemSku;
        document.getElementById("currentStock").value = currentStock;
        document.getElementById("restockQuantity").value = reorderQty;

        // Set appropriate supplier based on item
        const supplierSelect = document.getElementById("restockSupplier");
        if (itemSku.startsWith("TECH")) {
          supplierSelect.value = "tech-world";
        } else if (itemSku.startsWith("FURN")) {
          supplierSelect.value = "furniture-depot";
        } else if (itemSku.startsWith("STAT")) {
          supplierSelect.value = "office-plus";
        } else if (itemSku.startsWith("KITCH")) {
          supplierSelect.value = "kitchen-essentials";
        }

        // Set image
        const itemImage = document.getElementById("restockItemImage");
        itemImage.src = getItemImagePath(itemSku);
        itemImage.alt = itemName;

        openModal("restockModal");
      }

      // Open Email Supplier Modal
      function openEmailModal(supplier, itemName) {
        document.getElementById("emailSupplier").value = supplier;
        document.getElementById("emailItemLabel").textContent = itemName;

        // Pre-populate email message
        const message = `Dear ${supplier},\n\nWe are running low on the following item(s):\n- ${itemName}\n\nPlease arrange a restock at your earliest convenience.\n\nThank you,\nThe Nest Inventory Management`;
        document.getElementById("supplierEmailMessage").value = message;

        openModal("emailModal");
      }

      // View Item Details
      function viewItemDetails(itemSku) {
        // In a real application, this would navigate to the item details page
        alert(`Viewing details for item with SKU: ${itemSku}`);
      }

      // Helper function to get item image path
      function getItemImagePath(itemSku) {
        if (itemSku.startsWith("TECH-001")) {
          return "resources/images/laptop.jpg";
        } else if (itemSku.startsWith("FURN-005")) {
          return "resources/images/chair.jpg";
        } else if (itemSku.startsWith("TECH-012")) {
          return "resources/images/printer.jpg";
        } else if (itemSku.startsWith("STAT-002")) {
          return "resources/images/paper.jpg";
        } else if (itemSku.startsWith("KITCH-007")) {
          return "resources/images/coffee.jpg";
        }
        return "resources/images/default.jpg";
      }

      // Handle Select All checkbox in Bulk Restock modal
      document
        .getElementById("selectAllItems")
        .addEventListener("change", function () {
          const checkboxes = document.querySelectorAll(
            '#bulkRestockModal tbody input[type="checkbox"]'
          );
          checkboxes.forEach((checkbox) => {
            checkbox.checked = this.checked;
          });
        });

      // Handle All Suppliers checkbox in Email Suppliers modal
      document
        .getElementById("allSuppliers")
        .addEventListener("change", function () {
          const supplierCheckboxes = [
            document.getElementById("techWorld"),
            document.getElementById("officePlus"),
            document.getElementById("furnitureDepot"),
            document.getElementById("kitchenEssentials"),
          ];

          supplierCheckboxes.forEach((checkbox) => {
            checkbox.checked = this.checked;
            checkbox.disabled = this.checked;
          });
        });

      // Send Emails button click handler
      document
        .getElementById("sendEmailsBtn")
        .addEventListener("click", function () {
          alert("Emails sent to suppliers successfully!");
          closeModal();
        });

      // Confirm Bulk Restock button click handler
      document
        .getElementById("confirmRestockBtn")
        .addEventListener("click", function () {
          alert("Bulk restock order placed successfully!");
          closeModal();
        });

      // Confirm Single Restock button click handler
      document
        .getElementById("confirmSingleRestockBtn")
        .addEventListener("click", function () {
          const itemName =
            document.getElementById("restockItemName").textContent;
          const quantity = document.getElementById("restockQuantity").value;
          alert(
            `Restock order for ${quantity} units of ${itemName} placed successfully!`
          );
          closeModal();
        });

      // Send Supplier Email button click handler
      document
        .getElementById("sendSupplierEmailBtn")
        .addEventListener("click", function () {
          const supplier = document.getElementById("emailSupplier").value;
          alert(`Email sent to ${supplier} successfully!`);
          closeModal();
        });

      // Search functionality
      document
        .getElementById("searchItems")
        .addEventListener("keyup", function () {
          const searchTerm = this.value.toLowerCase();
          const tableRows = document.querySelectorAll(".table tbody tr");

          tableRows.forEach((row) => {
            const itemName = row
              .querySelector(".item-name")
              .textContent.toLowerCase();
            const itemSku = row
              .querySelector(".item-sku")
              .textContent.toLowerCase();
            const category = row
              .querySelector("td:nth-child(2)")
              .textContent.toLowerCase();
            const supplier = row
              .querySelector("td:nth-child(6)")
              .textContent.toLowerCase();

            if (
              itemName.includes(searchTerm) ||
              itemSku.includes(searchTerm) ||
              category.includes(searchTerm) ||
              supplier.includes(searchTerm)
            ) {
              row.style.display = "";
            } else {
              row.style.display = "none";
            }
          });
        });

      // Filter functionality
      const filters = {
        category: document.getElementById("categoryFilter"),
        supplier: document.getElementById("supplierFilter"),
        stockLevel: document.getElementById("stockLevelFilter"),
        sortBy: document.getElementById("sortByFilter"),
      };

      Object.values(filters).forEach((filter) => {
        filter.addEventListener("change", applyFilters);
      });

      function applyFilters() {
        // In a real application, this would filter the data
        // For this demo, we'll just show an alert
        alert("Filters applied!");
      }
    </script>
  </body>
</html>
