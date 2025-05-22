<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%> <%@ page session="true" %> <% String role = (String)
session.getAttribute("role"); if (role == null || !role.equals("staff")) {
response.sendRedirect(request.getContextPath() + "/Error"); return; } %> 
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<%@ taglib uri="jakarta.tags.functions" prefix="fn" %>

<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>My Stock Requests - The Nest Inventory System</title>
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
    <!-- Custom CSS -->
    <link
      rel="stylesheet"
      href="${pageContext.request.contextPath}/resources/css/Dashboard.css"
    />
    <link
      rel="stylesheet"
      href="${pageContext.request.contextPath}/resources/css/StaffStockRequests.css"
    />
  </head>
  <body>
    <jsp:include page="../components/Sidebar.jsp" />
    <!-- Main Content -->
    <div class="main-content">
      <div class="page-header">
        <h1 class="page-title">My Stock Requests</h1>
        <button class="btn btn-primary" id="newRequestBtn">
          <i class="material-icons">add_circle</i> New Request
        </button>
      </div>

      <!-- Container for all page alerts -->
      <div id="page-alerts-container" style="margin-bottom: 20px;">
        <c:if test="${not empty param.success}">
          <div class="alert alert-success">
            <i class="material-icons alert-icon">check_circle</i>
            <span>${param.success}</span>
            <button type="button" class="alert-dismiss-btn" onclick="dismissAlert(this.closest('.alert'))"><i class="material-icons">close</i></button>
          </div>
        </c:if>
        <c:if test="${not empty sessionScope.successMessage}">
          <div class="alert alert-success">
            <i class="material-icons alert-icon">check_circle</i>
            <span>${sessionScope.successMessage}</span>
            <button type="button" class="alert-dismiss-btn" onclick="dismissAlert(this.closest('.alert'))"><i class="material-icons">close</i></button>
          </div>
          <c:remove var="successMessage" scope="session"/>
        </c:if>

        <c:if test="${not empty param.error}">
          <div class="alert alert-danger">
            <i class="material-icons alert-icon">error</i>
            <span>${param.error}</span>
            <button type="button" class="alert-dismiss-btn" onclick="dismissAlert(this.closest('.alert'))"><i class="material-icons">close</i></button>
          </div>
        </c:if>
        <c:if test="${not empty sessionScope.errorMessage}">
          <div class="alert alert-danger">
            <i class="material-icons alert-icon">error</i>
            <span>${sessionScope.errorMessage}</span>
            <button type="button" class="alert-dismiss-btn" onclick="dismissAlert(this.closest('.alert'))"><i class="material-icons">close</i></button>
          </div>
          <c:remove var="errorMessage" scope="session"/>
        </c:if>
        <%-- This handles the 'errorMessage' attribute if it's set directly on the request --%>
        <c:if test="${not empty errorMessage && empty param.error && empty sessionScope.errorMessage}">
            <div class="alert alert-danger">
                <i class="material-icons alert-icon">error</i>
                <span>${errorMessage}</span>
                <button type="button" class="alert-dismiss-btn" onclick="dismissAlert(this.closest('.alert'))"><i class="material-icons">close</i></button>
            </div>
        </c:if>
      </div>

      <!-- Stats Cards -->
      <div class="stats-row">
        <div class="stat-card">
          <div class="stat-icon pending-icon">
            <i class="material-icons">pending_actions</i>
          </div>
          <div class="stat-value"><c:out value="${pendingRequestsCount ne null ? pendingRequestsCount : 0}"/></div>
          <div class="stat-label">Pending Requests</div>
        </div>
        <div class="stat-card">
          <div class="stat-icon approved-icon">
            <i class="material-icons">check_circle</i>
          </div>
          <div class="stat-value"><c:out value="${approvedRequestsCount ne null ? approvedRequestsCount : 0}"/></div>
          <div class="stat-label">Approved Requests</div>
        </div>
        <div class="stat-card">
          <div class="stat-icon low-stock-icon">
            <i class="material-icons">local_shipping</i>
          </div>
          <div class="stat-value"><c:out value="${dispatchedRequestsCount ne null ? dispatchedRequestsCount : 0}"/></div>
          <div class="stat-label">Dispatched Items</div>
        </div>
      </div>

      <!-- View Toggle -->
      <div class="view-toggle">
        <button class="view-toggle-btn active" data-view="all">
          All My Requests
        </button>
        <button class="view-toggle-btn" data-view="pending">Pending</button>
        <button class="view-toggle-btn" data-view="approved">Approved</button>
        <button class="view-toggle-btn" data-view="rejected">Rejected</button>
        <button class="view-toggle-btn" data-view="dispatched">
          Dispatched
        </button>
      </div>

      <!-- Search and Filters -->
      <div class="search-filters">
        <div class="row">
          <div class="col-md-6">
            <div class="input-group">
              <i class="material-icons input-icon">search</i>
              <input
                type="text"
                class="form-control input-with-icon"
                placeholder="Search my requests..."
                id="searchRequests"
              />
            </div>
          </div>
          <div class="col-md-4">
            <select class="form-control" id="filterStatus">
              <option value="all" selected>All Status</option>
              <option value="pending">Pending</option>
              <option value="approved">Approved</option>
              <option value="rejected">Rejected</option>
              <option value="dispatched">Dispatched</option>
            </select>
          </div>
          <div class="col-md-2">
            <button class="btn btn-outline" id="resetFilters">Reset</button>
          </div>
        </div>
      </div>

      <!-- Requests Table -->
      <div class="card">
        <div class="card-header">
          <h2 class="card-title">My Stock Requests</h2>
          <span class="badge badge-primary">Total: <c:out value="${totalRequestsCount ne null ? totalRequestsCount : 0}"/> Requests</span>
        </div>
        <div class="card-body">
          <div class="table-container">
            <table>
              <thead>
                <tr>
                  <th>Request ID</th>
                  <th>Department</th>
                  <th>Date</th>
                  <th>Items</th>
                  <th>Status</th>
                  <th>Actions</th>
                </tr>
              </thead>
              <tbody>
                <c:choose>
                  <c:when test="${not empty stockRequests}">
                    <c:forEach var="req" items="${stockRequests}">
                      <tr data-status="${fn:toLowerCase(req.status)}">
                        <td>REQ-${req.requestId}</td>
                        <td><c:out value="${req.department}"/></td>
                        <td><fmt:formatDate value="${req.date}" pattern="yyyy-MM-dd HH:mm" /></td>
                        <td>${req.itemCount} items</td>
                        <td>
                          <span class="badge badge-${req.statusClass}">${req.status}</span>
                        </td>
                        <td>
                          <div class="action-buttons">
                            <button
                              class="action-btn view-btn"
                              data-id="REQ-${req.requestId}"
                              data-department="${req.department}"
                              data-date="<fmt:formatDate value="${req.date}" pattern="yyyy-MM-dd HH:mm" />"
                              data-status="${req.status}"
                              data-notes="${fn:escapeXml(req.notes)}"
                              data-item-count="${req.itemCount}"
                            >
                              <i class="material-icons">visibility</i>
                            </button>
                            <c:if test="${req.status == 'Pending'}">
                              <button
                                class="action-btn cancel-btn"
                                data-id="REQ-${req.requestId}"
                                title="Cancel Request"
                              >
                                <i class="material-icons">close</i>
                              </button>
                            </c:if>
                            <c:if test="${req.status == 'Rejected'}">
                              <button
                                class="action-btn resubmit-btn"
                                data-id="REQ-${req.requestId}"
                                title="Resubmit Request"
                              >
                                <i class="material-icons">refresh</i>
                              </button>
                            </c:if>
                            <c:if test="${req.status == 'Dispatched'}">
                              <button
                                class="action-btn receive-btn"
                                data-id="REQ-${req.requestId}"
                                title="Mark as Received"
                              >
                                <i class="material-icons">check_circle</i>
                              </button>
                            </c:if>
                          </div>
                        </td>
                      </tr>
                    </c:forEach>
                  </c:when>
                  <c:otherwise>
                    <tr>
                      <td colspan="6" style="text-align: center">
                        No requests found.
                      </td>
                    </tr>
                  </c:otherwise>
                </c:choose>
              </tbody>
            </table>
          </div>
        </div>
        <div class="card-footer">
          <ul class="pagination">
            <li class="page-item">
              <a href="#" class="page-link">
                <i class="material-icons">first_page</i>
              </a>
            </li>
            <li class="page-item">
              <a href="#" class="page-link">
                <i class="material-icons">chevron_left</i>
              </a>
            </li>
            <li class="page-item active">
              <a href="#" class="page-link">1</a>
            </li>
            <li class="page-item">
              <a href="#" class="page-link">2</a>
            </li>
            <li class="page-item">
              <a href="#" class="page-link">
                <i class="material-icons">chevron_right</i>
              </a>
            </li>
            <li class="page-item">
              <a href="#" class="page-link">
                <i class="material-icons">last_page</i>
              </a>
            </li>
          </ul>
        </div>
      </div>
    </div>

    <!-- Modal Backdrop -->
    <div class="modal-backdrop" id="modalBackdrop"></div>

    <!-- View Request Modal -->
    <div class="modal" id="viewRequestModal">
      <div class="modal-header">
        <h3 class="modal-title">Request Details</h3>
        <button class="modal-close" id="closeViewModal">&times;</button>
      </div>
      <div class="modal-body">
        <div class="info-group">
          <h4>Request Information</h4>
          <div class="info-row">
            <div class="info-label">Request ID:</div>
            <div class="info-value" id="modalRequestId"></div>
          </div>
          <div class="info-row">
            <div class="info-label">Department:</div>
            <div class="info-value" id="modalDepartment"></div>
          </div>
          <div class="info-row">
            <div class="info-label">Date:</div>
            <div class="info-value" id="modalDate"></div>
          </div>
          <div class="info-row">
            <div class="info-label">Status:</div>
            <div class="info-value" id="modalStatus">
            </div>
          </div>
        </div>

        <div class="info-group">
          <h4>Requested Items (<span id="modalItemCount"></span>)</h4>
          <table class="items-table">
            <thead>
              <tr>
                <th>Item</th>
                <th>Quantity</th>
              </tr>
            </thead>
            <tbody id="modalItemsTableBody">
              <tr>
                <td colspan="2" style="text-align: center">
                  Loading items...
                </td>
              </tr>
            </tbody>
          </table>
        </div>

        <div class="info-group">
          <h4>Request Notes</h4>
          <p id="modalRequestNotes"></p>
        </div>

        <div class="info-group" id="adminFeedback" style="display: none">
          <h4>Admin Feedback</h4>
          <p class="admin-feedback" id="modalAdminFeedback"></p>
        </div>
      </div>
      <div class="modal-footer">
        <button class="btn btn-outline" id="closeViewModalBtn">Close</button>
        <button
          class="btn btn-outline cancel-btn"
          id="modalCancelRequestBtn"
          style="display: none"
        >
          <i class="material-icons">close</i> Cancel Request
        </button>
        <button
          class="btn btn-primary resubmit-btn"
          id="modalResubmitRequestBtn"
          style="display: none"
        >
          <i class="material-icons">refresh</i> Resubmit
        </button>
      </div>
    </div>

    <!-- Cancel Confirmation Modal -->
    <div class="modal" id="cancelConfirmModal">
      <div class="modal-header">
        <h3 class="modal-title">Confirm Cancellation</h3>
        <button class="modal-close" id="closeCancelConfirmModal">&times;</button>
      </div>
      <div class="modal-body">
        <p>Are you sure you want to cancel this request?</p>
        <p><strong>Request ID: <span id="cancelConfirmRequestIdText"></span></strong></p>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-outline" id="cancelConfirm_CancelBtn">No, Keep It</button>
        <button type="button" class="btn btn-danger" id="cancelConfirm_ConfirmBtn">Yes, Cancel Request</button>
      </div>
    </div>

    <!-- New Request Modal -->
    <div class="modal" id="newRequestModal">
      <div class="modal-header">
        <h3 class="modal-title">New Stock Request</h3>
        <button class="modal-close" id="closeNewModal">&times;</button>
      </div>
      <div class="modal-body">
        <form
          id="newRequestForm"
          method="post"
          action="${pageContext.request.contextPath}/staff/my-requests"
        >
          <div class="form-group">
            <label>Items</label>
            <div id="itemsList">
              <!-- Initial item row -->
              <div class="item-row">
                <select class="form-control product-select" name="productId[]" required>
                  <option value="">Select Product</option>
                  <c:forEach var="product" items="${products}">
                    <option
                      value="${product.productId}"
                      data-stock="${product.stock}"
                    >
                      ${product.productName} (Stock: ${product.stock})
                    </option>
                  </c:forEach>
                </select>
                <input
                  type="number"
                  name="quantity[]"
                  class="form-control item-quantity"
                  min="1"
                  placeholder="Qty"
                  required
                  disabled 
                />
                <button type="button" class="btn btn-outline remove-item" title="Remove Item">
                  <i class="material-icons">delete</i>
                </button>
              </div>
            </div>
            <button type="button" class="btn btn-outline" id="addItemBtn">
              <i class="material-icons">add_circle</i> Add Another Item
            </button>
          </div>

          <div class="form-group">
            <label for="notes">Notes (Optional)</label>
            <textarea
              class="form-control"
              id="notes"
              name="notes"
              rows="3"
              placeholder="Add any additional information or special instructions..."
            ></textarea>
          </div>
          <div class="modal-footer">
            <button type="button" class="btn btn-outline" id="closeNewModalBtn">
              Cancel
            </button>
            <button type="submit" class="btn btn-primary" id="submitRequestBtn">
              <i class="material-icons">send</i> Submit Request
            </button>
          </div>
        </form>
      </div>
    </div>
    <!-- JavaScript -->
    <script>
        document.addEventListener("DOMContentLoaded", function () {
          const modalBackdrop = document.getElementById("modalBackdrop");
          const viewRequestModal = document.getElementById("viewRequestModal");
          const newRequestModal = document.getElementById("newRequestModal");
          const pageAlertsContainer = document.getElementById('page-alerts-container');
          const cancelConfirmModal = document.getElementById("cancelConfirmModal"); // For cancel confirmation
          

          // --- Alert Functions (adapted from Categories.jsp) ---
          function dismissAlert(alertElement) {
              if (alertElement) {
                  alertElement.classList.add('fade-out');
                  setTimeout(() => {
                      if (alertElement.parentNode) {
                          alertElement.parentNode.removeChild(alertElement);
                      }
                  }, 300); // Match CSS animation duration
              }
          }

          function showPageAlert(message, type = 'info', duration = 3000) {
              if (!pageAlertsContainer) {
                  console.error("Page alerts container not found! Falling back to console.");
                  console.log(`${type.toUpperCase()}: ${message}`);
                  return;
              }

              const alertDiv = document.createElement('div');
              let alertTypeClass = type;
              if (type === 'error') alertTypeClass = 'danger'; // Map 'error' to 'danger' class
              alertDiv.className = `alert alert-${alertTypeClass}`;

              const icon = document.createElement('i');
              icon.className = 'material-icons alert-icon';
              if (type === 'success') icon.textContent = 'check_circle';
              else if (type === 'danger' || type === 'error') icon.textContent = 'error';
              else if (type === 'warning') icon.textContent = 'warning';
              else icon.textContent = 'info';

              const messageSpan = document.createElement('span');
              messageSpan.textContent = message;

              const dismissButton = document.createElement('button');
              dismissButton.type = 'button';
              dismissButton.className = 'alert-dismiss-btn';
              dismissButton.innerHTML = '<i class="material-icons">close</i>';
              dismissButton.onclick = () => dismissAlert(alertDiv);

              alertDiv.appendChild(icon);
              alertDiv.appendChild(messageSpan);
              alertDiv.appendChild(dismissButton);

              pageAlertsContainer.appendChild(alertDiv);

              if (duration > 0) {
                  setTimeout(() => {
                      dismissAlert(alertDiv);
                  }, duration);
              }
          }

          // Auto-dismiss server-rendered alerts and any other .alert elements present on load
          const allAlertsOnLoad = document.querySelectorAll('#page-alerts-container .alert');
          if (allAlertsOnLoad.length > 0) {
              allAlertsOnLoad.forEach(alert => {
                  setTimeout(() => {
                      dismissAlert(alert);
                  }, 3000); 
              });
          }
          // --- End Alert Functions ---
  
          function getCleanRequestId(requestIdFull) {
              if (!requestIdFull) return null;
              let idPart = requestIdFull.startsWith("REQ-") ? requestIdFull.substring(4) : requestIdFull;
              if (idPart.startsWith(":")) {
                  idPart = idPart.substring(1);
              }
              const numericId = parseInt(idPart, 10);
              if (isNaN(numericId)) {
                  console.error("Failed to parse a valid numeric ID from:", requestIdFull, "Derived part:", idPart);
                  showPageAlert("Error: Could not process Request ID.", "error");
                  return null;
              }
              return numericId;
          }
  
          // View request modal population
          document.querySelectorAll(".view-btn").forEach((btn) => {
            btn.addEventListener("click", function () {
              const requestIdFull = this.dataset.id; 
              const department = this.dataset.department;
              const date = this.dataset.date;
              const notes = this.dataset.notes;
              const itemCount = this.dataset.itemCount;
              const rawStatusFromDataset = this.dataset.status;
              const status = String(rawStatusFromDataset || "").trim(); 
  
              console.log("View button clicked. Initial requestIdFull:", requestIdFull, "Processed Status for modal:", status);
  
              document.getElementById("modalRequestId").textContent = requestIdFull;
              document.getElementById("modalDepartment").textContent = department;
              document.getElementById("modalDate").textContent = date;
              document.getElementById("modalRequestNotes").textContent = notes || "No notes provided.";
              document.getElementById("modalItemCount").textContent = itemCount + (itemCount == 1 ? " item" : " items");

              if (status && status.length > 0) { 
                const statusClassValue = status.toLowerCase();
                console.log("[Modal Status Update] Applying statusClass:", `badge-${statusClassValue || 'unknown'}`, "Status text:", status, "Raw class value:", statusClassValue);
                document.getElementById("modalStatus").innerHTML = `<span class="badge badge-${statusClassValue || 'unknown'}">${status}</span>`;
              } else {
                document.getElementById("modalStatus").innerHTML = `<span class="badge badge-unknown">Unknown</span>`;
                console.warn("[Modal Status Update] Status from dataset was effectively empty. Raw value was:", rawStatusFromDataset, "Request ID:", requestIdFull);
              }
              
              const modalCancelBtn = document.getElementById("modalCancelRequestBtn");
              const modalResubmitBtn = document.getElementById("modalResubmitRequestBtn");

              if (modalCancelBtn) modalCancelBtn.style.display = "none";
              if (modalResubmitBtn) modalResubmitBtn.style.display = "none";

              if (status) { 
                  const lowerCaseStatus = status.toLowerCase();
                  if (lowerCaseStatus.includes("pending") && modalCancelBtn) {
                      modalCancelBtn.style.display = "inline-block";
                      modalCancelBtn.dataset.id = requestIdFull; 
                  } else if (lowerCaseStatus.includes("rejected") && modalResubmitBtn) {
                      modalResubmitBtn.style.display = "inline-block";
                      modalResubmitBtn.dataset.id = requestIdFull; 
                  }
              }
  
              const itemsTableBody = document.getElementById("modalItemsTableBody");
              itemsTableBody.innerHTML = '<tr><td colspan="2" style="text-align:center;">Loading items...</td></tr>';
              
              const actualRequestId = getCleanRequestId(requestIdFull);
              console.log("Cleaned actualRequestId for getRequestItems:", actualRequestId);
              
              if (actualRequestId === null || typeof actualRequestId === 'undefined') {
                  itemsTableBody.innerHTML = '<tr><td colspan="2" style="text-align:center; color: red;">Invalid Request ID. Cannot fetch items.</td></tr>';
                  showPageAlert("Invalid Request ID. Cannot fetch items for modal.", "error");
                  viewRequestModal.style.display = "block"; 
                  modalBackdrop.style.display = "block";
                  return;
              }
              
              const jsContextPath = '${pageContext.request.contextPath}';
              const constructedBaseUrl = jsContextPath + "/staff/my-requests"; 
              const paramsForItems = new URLSearchParams({
                  action: 'getRequestItems',
                  requestId: actualRequestId
              });
              const fetchUrlForItems = constructedBaseUrl + "?" + paramsForItems.toString();
              
              fetch(fetchUrlForItems)
                  .then(response => {
                      if (!response.ok) {
                           return response.text().then(text => {
                              console.error("[getRequestItems] Server error response text:", text.substring(0, 500)); 
                              try {
                                  const err = JSON.parse(text);
                                  console.error("[getRequestItems] Parsed server error JSON:", err);
                                  throw err; 
                              } catch (e) {
                                  throw new Error(`Network response was not ok: ${response.status} ${response.statusText}. Server response: ${text.substring(0,100)}`);
                              }
                          });
                      }
                      return response.json();
                  })
                  .then(items => {
                      itemsTableBody.innerHTML = ''; 
                      if (items && items.length > 0) {
                          items.forEach(item => {
                              const row = itemsTableBody.insertRow();
                              const cell1 = row.insertCell();
                              const cell2 = row.insertCell();
                              cell1.textContent = item.productName;
                              cell2.textContent = item.quantity;
                          });
                      } else if (items && items.error) { 
                           itemsTableBody.innerHTML = `<tr><td colspan="2" style="text-align:center; color: red;">${items.error}</td></tr>`;
                           showPageAlert(items.error, "error");
                      } 
                      else {
                          itemsTableBody.innerHTML = '<tr><td colspan="2" style="text-align:center;">No items found for this request.</td></tr>';
                      }
                  })
                  .catch(error => {
                      console.error('[getRequestItems] Error fetching or processing request items:', error);
                      let errorMessageText = "Error loading items.";
                      if (error && error.message) { 
                          errorMessageText = error.message;
                      } else if (error && error.error) { 
                          errorMessageText = error.error;
                      }
                      itemsTableBody.innerHTML = `<tr><td colspan="2" style="text-align:center; color: red;">${errorMessageText}</td></tr>`;
                      showPageAlert(`Error loading request items: ${errorMessageText}`, 'error');
                  });

              viewRequestModal.style.display = "block";
              modalBackdrop.style.display = "block";
            });
          });
          
          document.getElementById("closeViewModal").addEventListener("click", () => {
              viewRequestModal.style.display = "none";
              modalBackdrop.style.display = "none";
          });
          document.getElementById("closeViewModalBtn").addEventListener("click", () => {
              viewRequestModal.style.display = "none";
              modalBackdrop.style.display = "none";
          });
  
          const newRequestButton = document.getElementById("newRequestBtn");
          if (newRequestButton) {
            newRequestButton.addEventListener("click", function () {
              newRequestModal.style.display = "block";
              modalBackdrop.style.display = "block";
              document.getElementById("newRequestForm").reset();
              const itemsListEl = document.getElementById("itemsList");
              while (itemsListEl.children.length > 1) {
                  itemsListEl.removeChild(itemsListEl.lastChild);
              }
              const firstItemRow = itemsListEl.querySelector(".item-row");
              if (firstItemRow) {
                  firstItemRow.querySelector(".product-select").value = "";
                  const qtyInput = firstItemRow.querySelector(".item-quantity");
                  qtyInput.value = "";
                  qtyInput.disabled = true;
                  qtyInput.placeholder = "Qty";
              }
            });
          }
          document.getElementById("closeNewModal").addEventListener("click", () => {
              newRequestModal.style.display = "none";
              modalBackdrop.style.display = "none";
          });
          document.getElementById("closeNewModalBtn").addEventListener("click", () => {
              newRequestModal.style.display = "none";
              modalBackdrop.style.display = "none";
          });
  
          const itemsList = document.getElementById("itemsList");
          const addItemBtn = document.getElementById("addItemBtn");
  
          function onItemProductChange(event) {
              const selectElement = event.target;
              const selectedOption = selectElement.options[selectElement.selectedIndex];
              const stock = parseInt(selectedOption.dataset.stock, 10);
              const quantityInput = selectElement.closest(".item-row").querySelector(".item-quantity");
  
              if (selectElement.value && !isNaN(stock) && stock > 0) {
                  quantityInput.disabled = false;
                  quantityInput.max = stock;
                  quantityInput.placeholder = "Max: " + stock;
                  if (!quantityInput.value || parseInt(quantityInput.value, 10) < 1) {
                       quantityInput.value = 1;   
                  } else if (parseInt(quantityInput.value, 10) > stock) {
                      quantityInput.value = stock;
                  }
              } else if (selectElement.value && (isNaN(stock) || stock <= 0)) {
                  quantityInput.disabled = true;
                  quantityInput.value = "";
                  quantityInput.placeholder = "Out of stock";
              } else { 
                  quantityInput.disabled = true;
                  quantityInput.value = "";
                  quantityInput.placeholder = "Qty";
              }
          }
          
          function onQuantityInputChange(event) {
              const quantityInput = event.target;
              let value = parseInt(quantityInput.value, 10);
              const min = parseInt(quantityInput.min, 10) || 1;
              const max = parseInt(quantityInput.max, 10);
  
              if (isNaN(value) || value < min) {
                  quantityInput.value = min;
              } else if (!isNaN(max) && value > max) {
                  quantityInput.value = max;
              }
          }
  
          function addRemoveListener(button) {
               button.addEventListener("click", function () {
                  if (itemsList.querySelectorAll(".item-row").length > 1) {
                      this.closest(".item-row").remove();
                  } else {
                      showPageAlert("At least one item must be in the request.", "warning");
                  }
              });
          }
          
          itemsList.querySelectorAll(".item-row").forEach(row => {
              row.querySelector(".product-select").addEventListener("change", onItemProductChange);
              row.querySelector(".item-quantity").addEventListener("input", onQuantityInputChange);
              addRemoveListener(row.querySelector(".remove-item"));
          });
  
          if (addItemBtn) {
              addItemBtn.addEventListener("click", function () {
                  const firstItemRow = itemsList.querySelector(".item-row");
                  if (!firstItemRow) {
                      console.error("Could not find the first item row to clone.");
                      return;
                  }
                  const newItemRow = firstItemRow.cloneNode(true);
                  newItemRow.querySelector(".product-select").value = "";
                  const newQuantityInput = newItemRow.querySelector(".item-quantity");
                  newQuantityInput.value = "";
                  newQuantityInput.disabled = true;
                  newQuantityInput.placeholder = "Qty";
                  
                  newItemRow.querySelector(".product-select").addEventListener("change", onItemProductChange);
                  newQuantityInput.addEventListener("input", onQuantityInputChange);
                  addRemoveListener(newItemRow.querySelector(".remove-item"));
                  
                  itemsList.appendChild(newItemRow);
              });
          }

          // --- Cancel Confirmation Modal Logic ---
          const closeCancelConfirmModalBtn = document.getElementById("closeCancelConfirmModal");
          const cancelConfirm_CancelBtn = document.getElementById("cancelConfirm_CancelBtn");
          const cancelConfirm_ConfirmBtn = document.getElementById("cancelConfirm_ConfirmBtn");

          if (closeCancelConfirmModalBtn) {
              closeCancelConfirmModalBtn.addEventListener("click", () => {
                  cancelConfirmModal.style.display = "none";
                  modalBackdrop.style.display = "none";
              });
          }
          if (cancelConfirm_CancelBtn) {
              cancelConfirm_CancelBtn.addEventListener("click", () => {
                  cancelConfirmModal.style.display = "none";
                  modalBackdrop.style.display = "none";
              });
          }

          let currentRequestToCancel = {
              requestIdFull: null,
              actualRequestId: null,
              buttonElement: null
          };

          if (cancelConfirm_ConfirmBtn) {
            cancelConfirm_ConfirmBtn.addEventListener("click", function() {
                const { requestIdFull, actualRequestId, buttonElement } = currentRequestToCancel;

                if (!actualRequestId) {
                    showPageAlert("Error: Invalid Request ID for cancellation.", "error");
                    cancelConfirmModal.style.display = "none";
                    modalBackdrop.style.display = "none";
                    return;
                }

                const contextPath = '${pageContext.request.contextPath}';
                // Modify this line to ensure the context path is explicitly included
                const postUrl = contextPath + "/staff/my-requests";
                console.log("Sending POST request to:", postUrl); // Add for debugging
                const params = new URLSearchParams();
                params.append('action', 'cancelRequest');
                params.append('requestId', actualRequestId);
                
                fetch(postUrl, {
                    method: 'POST',
                    headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
                    body: params.toString()
                })
                .then(response => {
                    if (!response.ok) {
                        return response.text().then(text => {
                            try {
                                const err = JSON.parse(text);
                                throw err; 
                            } catch (e) {
                                // Log the full text for debugging if it's not JSON
                                console.error("Server error response (not JSON):", text.substring(0, 500));
                                throw new Error(text.substring(0,150) || `HTTP error ${response.status}`);
                            }
                        });
                    }
                    return response.json();
                })
                .then(data => {
                    if (data.success) {
                        showPageAlert(data.message, "success");
                        let tableRow;
                        if (buttonElement && buttonElement.closest('tr')) { 
                            tableRow = buttonElement.closest('tr');
                        } else { 
                            tableRow = document.querySelector(`table tbody tr td button.view-btn[data-id="${requestIdFull}"]`)?.closest('tr');
                        }

                        if (tableRow) {
                            const statusCell = tableRow.querySelector('td:nth-child(5) span.badge'); 
                            if (statusCell) {
                                statusCell.textContent = 'Cancelled';
                                statusCell.className = 'badge badge-cancelled'; 
                            }
                            const actionButtonsCell = tableRow.querySelector('td:nth-child(6) .action-buttons');
                            if (actionButtonsCell) {
                                const cancelButtonInRow = actionButtonsCell.querySelector('.cancel-btn'); // Targets general .cancel-btn
                                if(cancelButtonInRow) cancelButtonInRow.remove();
                            }
                            if(tableRow.dataset) tableRow.dataset.status = "cancelled"; 
                        }

                        if (viewRequestModal.style.display === "block" && document.getElementById("modalRequestId").textContent === requestIdFull) {
                            document.getElementById("modalStatus").innerHTML = `<span class="badge badge-cancelled">Cancelled</span>`;
                            const modalCancel = document.getElementById("modalCancelRequestBtn");
                            const modalResubmit = document.getElementById("modalResubmitRequestBtn");
                            if(modalCancel) modalCancel.style.display = "none";
                            if(modalResubmit) modalResubmit.style.display = "none"; 
                            
                            // If cancellation was triggered from within the view modal
                            if (buttonElement && buttonElement.id === "modalCancelRequestBtn") {
                                // No need to close viewRequestModal here, it will be closed by the finally block if successful
                            }
                        }
                    } else {
                        showPageAlert(data.message || "Could not cancel request.", "error");
                    }
                })
                .catch(error => {
                    console.error('[cancelRequest] Error cancelling or processing request:', error);
                    showPageAlert(error.message || 'An error occurred while trying to cancel the request.', "error");
                })
                .finally(() => {
                    cancelConfirmModal.style.display = "none";
                    modalBackdrop.style.display = "none";
                    // If the view modal was open and its cancel button was clicked, and the operation was successful,
                    // we might want to close the viewRequestModal as well.
                    // However, the success case already handles UI updates. Closing the confirm modal is sufficient here.
                    if (buttonElement && buttonElement.id === "modalCancelRequestBtn" && viewRequestModal.style.display === "block" && document.getElementById("modalRequestId").textContent === requestIdFull) {
                        // If the cancel was successful (checked in .then(data)), the view modal's status is updated.
                        // We can choose to close the view modal here or let the user do it.
                        // For now, let's assume the user might want to see the updated status in the view modal before closing it.
                        // If you want to auto-close it on success:
                        // viewRequestModal.style.display = "none";
                    }
                    currentRequestToCancel = { requestIdFull: null, actualRequestId: null, buttonElement: null }; // Reset
                });
            });
          }
          // --- End New Cancel Confirmation Modal Logic ---
  
          document.querySelectorAll(".cancel-btn").forEach(btn => {
              btn.addEventListener("click", function(event) {
                  event.preventDefault(); 
                  const buttonElement = this; 
                  const requestIdFull = this.dataset.id; 
                  const actualRequestId = getCleanRequestId(requestIdFull);
  
                  if (actualRequestId === null || typeof actualRequestId === 'undefined') {
                      showPageAlert("Error: Invalid Request ID for cancellation.", "error");
                      return;
                  }
  
                  // Store details for the confirmation modal
                  currentRequestToCancel.requestIdFull = requestIdFull;
                  currentRequestToCancel.actualRequestId = actualRequestId;
                  currentRequestToCancel.buttonElement = buttonElement; 

                  // Populate and show the custom confirmation modal
                  document.getElementById("cancelConfirmRequestIdText").textContent = requestIdFull;
                  if (cancelConfirmModal) cancelConfirmModal.style.display = "block";
                  if (modalBackdrop) modalBackdrop.style.display = "block";
              });
          });
  
           document.querySelectorAll(".resubmit-btn").forEach(btn => {
              btn.addEventListener("click", function() {
                  showPageAlert("Resubmission feature will be available soon.", "info");
                   if(viewRequestModal.style.display === "block") {
                      viewRequestModal.style.display = "none"; 
                      modalBackdrop.style.display = "none"; 
                   }
              });
          });
  
          document.querySelectorAll(".receive-btn").forEach(btn => {
              btn.addEventListener("click", function() {
                   if (confirm("Confirm receipt of all items for request " + this.dataset.id + "?")) { // Standard confirm for now
                      showPageAlert("Mark as received feature will be available soon.", "info");
                   }
              });
          });
  
          document.querySelectorAll(".view-toggle-btn").forEach((btn) => {
            btn.addEventListener("click", function () {
              document.querySelectorAll(".view-toggle-btn").forEach((b) => b.classList.remove("active"));
              this.classList.add("active");
              const view = this.getAttribute("data-view");
              const rows = document.querySelectorAll("tbody tr");
              rows.forEach((row) => {
                if (row.dataset.status) { 
                  const status = row.dataset.status.toLowerCase();
                  if (view === "all" || status.includes(view)) {
                    row.style.display = "";
                  } else {
                    row.style.display = "none";
                  }
                } else if (view === "all") { 
                   row.style.display = "";
                } else {
                   row.style.display = "none";
                }
              });
            });
          });
  
          const searchInput = document.getElementById("searchRequests");
          if (searchInput) {
              searchInput.addEventListener("input", function () {
                  const searchTerm = this.value.toLowerCase();
                  const rows = document.querySelectorAll("tbody tr");
                  rows.forEach((row) => {
                    const rowText = row.textContent.toLowerCase();
                    if (rowText.includes(searchTerm)) {
                      row.style.display = "";
                    } else {
                      row.style.display = "none";
                    }
                  });
              });
          }
  
          const filterStatusDropdown = document.getElementById("filterStatus");
          if (filterStatusDropdown) {
              filterStatusDropdown.addEventListener("change", function () {
                  const filterValue = this.value;
                  const rows = document.querySelectorAll("tbody tr");
                  rows.forEach((row) => {
                    if (row.dataset.status) {
                      const status = row.dataset.status.toLowerCase();
                      if (filterValue === "all" || status.includes(filterValue)) {
                        row.style.display = "";
                      } else {
                        row.style.display = "none";
                      }
                    } else if (filterValue === "all") {
                       row.style.display = "";
                    } else {
                       row.style.display = "none";
                    }
                  });
              });
          }
          
          const resetFiltersButton = document.getElementById("resetFilters");
          if (resetFiltersButton) {
              resetFiltersButton.addEventListener("click", function () {
                  if(searchInput) searchInput.value = "";
                  if(filterStatusDropdown) filterStatusDropdown.value = "all";
                  document.querySelectorAll(".view-toggle-btn").forEach(b => b.classList.remove("active"));
                  const allViewBtn = document.querySelector(".view-toggle-btn[data-view='all']");
                  if(allViewBtn) allViewBtn.classList.add("active");
                  
                  const rows = document.querySelectorAll("tbody tr");
                  rows.forEach((row) => (row.style.display = ""));
              });
          }
        });
    </script>
  </body>
</html>