<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ page session="true" %>
<%
    String role = (String) session.getAttribute("role");
    if (role == null || !role.equals("staff")) {
        response.sendRedirect(request.getContextPath() + "/Error");
        return;
    }
%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

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

      <!-- Stats Cards -->
      <div class="stats-row">
        <div class="stat-card">
          <div class="stat-icon pending-icon">
            <i class="material-icons">pending_actions</i>
          </div>
          <div class="stat-value">3</div>
          <div class="stat-label">Pending Requests</div>
        </div>
        <div class="stat-card">
          <div class="stat-icon approved-icon">
            <i class="material-icons">check_circle</i>
          </div>
          <div class="stat-value">5</div>
          <div class="stat-label">Approved Requests</div>
        </div>
        <div class="stat-card">
          <div class="stat-icon low-stock-icon">
            <i class="material-icons">local_shipping</i>
          </div>
          <div class="stat-value">2</div>
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
          <div class="col-md-4">
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
          <div class="col-md-3">
            <select class="form-control" id="filterStatus">
              <option value="all" selected>All Status</option>
              <option value="pending">Pending</option>
              <option value="approved">Approved</option>
              <option value="rejected">Rejected</option>
              <option value="dispatched">Dispatched</option>
            </select>
          </div>
          <div class="col-md-3">
            <select class="form-control" id="filterPriority">
              <option value="all" selected>All Priorities</option>
              <option value="high">High</option>
              <option value="medium">Medium</option>
              <option value="low">Low</option>
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
          <span class="badge badge-primary">Total: 10 Requests</span>
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
                  <th>Priority</th>
                  <th>Status</th>
                  <th>Actions</th>
                </tr>
              </thead>
              <tbody>
                <tr class="priority-high">
                  <td>REQ-2023-001</td>
                  <td>IT Department</td>
                  <td>Today, 10:30 AM</td>
                  <td>3 items</td>
                  <td><span class="badge badge-danger">High</span></td>
                  <td><span class="badge badge-warning">Pending</span></td>
                  <td>
                    <div class="action-buttons">
                      <button
                        class="action-btn view-btn"
                        data-id="REQ-2023-001"
                      >
                        <i class="material-icons">visibility</i>
                      </button>
                      <button
                        class="action-btn cancel-btn"
                        data-id="REQ-2023-001"
                      >
                        <i class="material-icons">close</i>
                      </button>
                    </div>
                  </td>
                </tr>
                <tr class="priority-medium">
                  <td>REQ-2023-008</td>
                  <td>IT Department</td>
                  <td>Today, 09:15 AM</td>
                  <td>2 items</td>
                  <td><span class="badge badge-warning">Medium</span></td>
                  <td><span class="badge badge-success">Approved</span></td>
                  <td>
                    <div class="action-buttons">
                      <button
                        class="action-btn view-btn"
                        data-id="REQ-2023-008"
                      >
                        <i class="material-icons">visibility</i>
                      </button>
                    </div>
                  </td>
                </tr>
                <tr class="priority-low">
                  <td>REQ-2023-012</td>
                  <td>IT Department</td>
                  <td>Yesterday, 03:45 PM</td>
                  <td>5 items</td>
                  <td><span class="badge badge-success">Low</span></td>
                  <td><span class="badge badge-info">Dispatched</span></td>
                  <td>
                    <div class="action-buttons">
                      <button
                        class="action-btn view-btn"
                        data-id="REQ-2023-012"
                      >
                        <i class="material-icons">visibility</i>
                      </button>
                      <button
                        class="action-btn receive-btn"
                        data-id="REQ-2023-012"
                      >
                        <i class="material-icons">check_circle</i>
                      </button>
                    </div>
                  </td>
                </tr>
                <tr class="priority-high">
                  <td>REQ-2023-015</td>
                  <td>IT Department</td>
                  <td>Yesterday, 01:20 PM</td>
                  <td>1 item</td>
                  <td><span class="badge badge-danger">High</span></td>
                  <td><span class="badge badge-danger">Rejected</span></td>
                  <td>
                    <div class="action-buttons">
                      <button
                        class="action-btn view-btn"
                        data-id="REQ-2023-015"
                      >
                        <i class="material-icons">visibility</i>
                      </button>
                      <button
                        class="action-btn resubmit-btn"
                        data-id="REQ-2023-015"
                      >
                        <i class="material-icons">refresh</i>
                      </button>
                    </div>
                  </td>
                </tr>
                <tr class="priority-medium">
                  <td>REQ-2023-018</td>
                  <td>IT Department</td>
                  <td>3 days ago</td>
                  <td>4 items</td>
                  <td><span class="badge badge-warning">Medium</span></td>
                  <td><span class="badge badge-success">Approved</span></td>
                  <td>
                    <div class="action-buttons">
                      <button
                        class="action-btn view-btn"
                        data-id="REQ-2023-018"
                      >
                        <i class="material-icons">visibility</i>
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
            <div class="info-value">REQ-2023-001</div>
          </div>
          <div class="info-row">
            <div class="info-label">Department:</div>
            <div class="info-value">IT Department</div>
          </div>
          <div class="info-row">
            <div class="info-label">Date:</div>
            <div class="info-value">Today, 10:30 AM</div>
          </div>
          <div class="info-row">
            <div class="info-label">Priority:</div>
            <div class="info-value">
              <span class="badge badge-danger">High</span>
            </div>
          </div>
          <div class="info-row">
            <div class="info-label">Status:</div>
            <div class="info-value">
              <span class="badge badge-warning">Pending</span>
            </div>
          </div>
        </div>

        <div class="info-group">
          <h4>Requested Items</h4>
          <table class="items-table">
            <thead>
              <tr>
                <th>Item</th>
                <th>Quantity</th>
              </tr>
            </thead>
            <tbody>
              <tr>
                <td>Laptop Charger</td>
                <td>2</td>
              </tr>
              <tr>
                <td>Wireless Mouse</td>
                <td>3</td>
              </tr>
              <tr>
                <td>HDMI Cable</td>
                <td>1</td>
              </tr>
            </tbody>
          </table>
        </div>

        <div class="info-group">
          <h4>Request Notes</h4>
          <p>
            Urgent request for new equipment for the IT team. We need these
            items for the new employees starting next week.
          </p>
        </div>

        <div class="info-group" id="adminFeedback" style="display: none">
          <h4>Admin Feedback</h4>
          <p class="admin-feedback">
            Your request has been rejected because some items are currently out
            of stock. Please resubmit with alternative items or wait until next
            week when we expect new stock.
          </p>
        </div>
      </div>
      <div class="modal-footer">
        <button class="btn btn-outline" id="closeViewModalBtn">Close</button>
        <button
          class="btn btn-outline cancel-btn"
          data-id="REQ-2023-001"
          id="cancelRequestBtn"
          style="display: none"
        >
          <i class="material-icons">close</i> Cancel Request
        </button>
        <button
          class="btn btn-primary resubmit-btn"
          data-id="REQ-2023-001"
          id="resubmitRequestBtn"
          style="display: none"
        >
          <i class="material-icons">refresh</i> Resubmit
        </button>
      </div>
    </div>

    <!-- New Request Modal -->
    <div class="modal" id="newRequestModal">
      <div class="modal-header">
        <h3 class="modal-title">New Stock Request</h3>
        <button class="modal-close" id="closeNewModal">&times;</button>
      </div>
      <div class="modal-body">
        <form id="newRequestForm" method="post" action="${pageContext.request.contextPath}/staff/my-requests" >

          <div class="form-group">
            <label>Items</label>
            <div id="itemsList">
              <div class="item-row">
              <select class="form-control" name="productId[]" required>
				  <option value="">Select Product</option>
				 <c:forEach var="product" items="${products}">
				    <option value="${product.productId}" data-stock="${product.stock}">
				      ${product.productName}
				    </option>
				</c:forEach>
				</select>
				
                <input 
                type="number" 
                name="quantity[]" 
                class="form-control item-quantity" 
                min="1" placeholder="Qty" 
                required />
                
                <button type="button" class="btn btn-outline remove-item">
                  <i class="material-icons">delete</i>
                </button>
              </div>
            </div>
            <button type="button" class="btn btn-outline" id="addItemBtn">
              <i class="material-icons">add_circle</i> Add Item
            </button>
          </div>

          <div class="form-group">
            <label for="notes">Notes</label>
            <textarea
              class="form-control"
              id="notes"
              name="notes"
              placeholder="Add any additional information..."
            ></textarea>
          </div>
          <div class="modal-footer">
        <button type="button" class="btn btn-outline" id="closeNewModalBtn">Cancel</button>
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
        // Modal elements
        const modalBackdrop = document.getElementById("modalBackdrop");
        const viewRequestModal = document.getElementById("viewRequestModal");
        const newRequestModal = document.getElementById("newRequestModal");

        // View request modal
        const viewBtns = document.querySelectorAll(".view-btn");
        viewBtns.forEach((btn) => {
          btn.addEventListener("click", function () {
            const requestId = this.getAttribute("data-id");

            // Show/hide appropriate buttons based on request status
            const statusCell = this.closest("tr")
              .querySelector("td:nth-child(6)")
              .textContent.toLowerCase();
            const cancelBtn = document.getElementById("cancelRequestBtn");
            const resubmitBtn = document.getElementById("resubmitRequestBtn");
            const adminFeedback = document.getElementById("adminFeedback");

            // Reset all buttons and sections
            cancelBtn.style.display = "none";
            resubmitBtn.style.display = "none";
            adminFeedback.style.display = "none";

            // Show appropriate buttons based on status
            if (statusCell.includes("pending")) {
              cancelBtn.style.display = "inline-block";
            } else if (statusCell.includes("rejected")) {
              resubmitBtn.style.display = "inline-block";
              adminFeedback.style.display = "block";
            }

            // Show the modal
            viewRequestModal.style.display = "block";
            modalBackdrop.style.display = "block";
          });
        });
        //Ends total stock display

        // Close view modal
        document
          .getElementById("closeViewModal")
          .addEventListener("click", function () {
            viewRequestModal.style.display = "none";
            modalBackdrop.style.display = "none";
          });

        document
          .getElementById("closeViewModalBtn")
          .addEventListener("click", function () {
            viewRequestModal.style.display = "none";
            modalBackdrop.style.display = "none";
          });

        // New request modal
        const newRequestButton = document.getElementById("newRequestBtn");
		if (newRequestButton) {
		  console.log("newRequestBtn found");
		  newRequestButton.addEventListener("click", function () {
		    console.log("Add Request clicked");
		    newRequestModal.style.display = "block";
		    modalBackdrop.style.display = "block";
		  });
		} else {
		  console.log("newRequestBtn NOT found");
		}

        
        //Auto-fill stock quantity after selecting

	  const itemsList = document.getElementById("itemsList");
	  const addItemBtn = document.getElementById("addItemBtn");
	
	  // Function to create a new item row
	  function createItemRow() {
	    const div = document.createElement("div");
	    div.className = "item-row";
	
	    // Create select element with products copied from the first one
	    const firstSelect = document.querySelector("#itemsList .item-row select");
	    const selectClone = firstSelect.cloneNode(true);
	    selectClone.value = ""; // reset selection
	
	 // Create quantity input
	    const quantityInput = document.createElement("input");
	    quantityInput.name = "quantity[]";
	    quantityInput.type = "number";
	    quantityInput.min = 1;
	    quantityInput.placeholder = "Qty";
	    quantityInput.required = true;
	    quantityInput.className = "form-control item-quantity";
	    quantityInput.disabled = true; 
	
	    // Create remove button
	    const removeBtn = document.createElement("button");
	    removeBtn.type = "button";
	    removeBtn.className = "btn btn-outline remove-item";
	    removeBtn.innerHTML = '<i class="material-icons">delete</i>';
	
	    // Append children
	    div.appendChild(selectClone);
	    div.appendChild(quantityInput);
	    div.appendChild(removeBtn);
	
	    // Add event listeners
	    selectClone.addEventListener("change", onProductChange);
	    quantityInput.addEventListener("input", onQuantityInput);
	    removeBtn.addEventListener("click", () => {
	      itemsList.removeChild(div);
	    });
	
	    return div;
	  }
	
	  // Event handler for product change
	  function onProductChange(e) {
	    const select = e.target;
	    const selectedOption = select.options[select.selectedIndex];
	    const quantityInput = select.nextElementSibling;
	
	    const stock = selectedOption.getAttribute("data-stock");
	    const stockNum = parseInt(stock, 10);
	
	    if (!stock || isNaN(stockNum) || stockNum <= 0) {
	      quantityInput.disabled = true;
	      quantityInput.value = "";
	      quantityInput.placeholder = "Out of stock";
	      quantityInput.removeAttribute("max");
	    } else {
	      quantityInput.disabled = false;
	      quantityInput.max = stockNum;
	      quantityInput.value = 1;
	      quantityInput.placeholder = `Max: ${stockNum}`;
	    }
	  }
	
	  // Event handler for quantity input
	  function onQuantityInput(e) {
	    const input = e.target;
	    const max = input.max ? parseInt(input.max, 10) : null;
	    const min = input.min ? parseInt(input.min, 10) : 1;
	    let val = parseInt(input.value, 10);
	
	    if (isNaN(val) || val < min) {
	      input.value = min;
	    } else if (max !== null && val > max) {
	      input.value = max;
	    }
	  }
	
	  // Initial wiring for existing item row
	  const initialSelect = document.querySelector("#itemsList .item-row select");
	  const initialQuantityInput = document.querySelector("#itemsList .item-row .item-quantity");
	  const initialRemoveBtn = document.querySelector("#itemsList .item-row .remove-item");
	
	  initialQuantityInput.disabled = true; // disable quantity initially
	
	  initialSelect.addEventListener("change", onProductChange);
	  initialQuantityInput.addEventListener("input", onQuantityInput);
	
	  initialRemoveBtn.addEventListener("click", () => {
	    if (itemsList.children.length > 1) {
	      itemsList.removeChild(initialSelect.parentElement);
	    }
	  });
	
	  // Add new item row on button click
	  addItemBtn.addEventListener("click", () => {
	    const newRow = createItemRow();
	    itemsList.appendChild(newRow);
	  });


        // Close new request modal
        document
          .getElementById("closeNewModal")
          .addEventListener("click", function () {
            newRequestModal.style.display = "none";
            modalBackdrop.style.display = "none";
          });

        document
          .getElementById("closeNewModalBtn")
          .addEventListener("click", function () {
            newRequestModal.style.display = "none";
            modalBackdrop.style.display = "none";
          });

        // Add item row in new request form
        const productContainer = document.getElementById("productContainer");
        const existing = productContainer.querySelector(".product-entry");
        document.getElementById("addProductBtn").addEventListener("click", () => {
        	  const clone = existing.cloneNode(true);
        	  clone.querySelector("select").selectedIndex = 0;
        	  clone.querySelector("input").value = "";
        	  productContainer.appendChild(clone);
        	});


        document.addEventListener("click", function (e) {
        	  if (e.target.closest(".remove-item")) {
        	    const entries = document.querySelectorAll(".product-entry");
        	    if (entries.length > 1) {
        	      e.target.closest(".product-entry").remove();
        	    }
        	  }
        	});

            
        // Remove item row
        document.querySelectorAll(".remove-item").forEach((btn) => {
		  btn.addEventListener("click", function () {
		    const itemRow = this.closest(".item-row");
		    if (document.querySelectorAll(".item-row").length > 1) {
		      itemRow.parentNode.removeChild(itemRow);
		    }
		  });
		});


        // Submit request form
        document
          .getElementById("submitRequestBtn")
          .addEventListener("click", function () {
            const form = document.getElementById("newRequestForm");
            if (form.checkValidity()) {
              alert("Request submitted successfully!");
              newRequestModal.style.display = "none";
              modalBackdrop.style.display = "none";
              // Reset form
              form.reset();
            } else {
              // Trigger browser's native form validation
              form.reportValidity();
            }
          });

        // Cancel request functionality
        document.querySelectorAll(".cancel-btn").forEach((btn) => {
          btn.addEventListener("click", function () {
            const requestId = this.getAttribute("data-id");
            if (confirm("Are you sure you want to cancel this request?")) {
              alert(`Request ${requestId} cancelled.`);
              viewRequestModal.style.display = "none";
              modalBackdrop.style.display = "none";
            }
          });
        });

        // Resubmit request functionality
        document.querySelectorAll(".resubmit-btn").forEach((btn) => {
          btn.addEventListener("click", function () {
            const requestId = this.getAttribute("data-id");
            alert(`Resubmitting request ${requestId}...`);
            viewRequestModal.style.display = "none";
            newRequestModal.style.display = "block";
          });
        });

        // Receive items functionality
        document.querySelectorAll(".receive-btn").forEach((btn) => {
          btn.addEventListener("click", function () {
            const requestId = this.getAttribute("data-id");
            if (
              confirm(
                "Confirm that you have received all items in this request?"
              )
            ) {
              alert(`Request ${requestId} marked as received!`);
            }
          });
        });

     // View toggle functionality
        document.querySelectorAll(".view-toggle-btn").forEach((btn) => {
          btn.addEventListener("click", function () {
            // Remove active class from all buttons
            document.querySelectorAll(".view-toggle-btn").forEach((b) => b.classList.remove("active"));
            this.classList.add("active");

            const view = this.getAttribute("data-view"); // pending / approved / rejected / all
            const rows = document.querySelectorAll("tbody tr");

            rows.forEach((row) => {
              const statusCell = row.querySelector("td:nth-child(6)");
              if (statusCell) {
                const status = statusCell.textContent.toLowerCase();
                if (view === "all" || status.includes(view)) {
                  row.style.display = "";
                } else {
                  row.style.display = "none";
                }
              }
            });
          });
        });


     // Search functionality
        document.getElementById("searchRequests").addEventListener("input", function () {
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



        // Filter by status
        document
		  .getElementById("filterStatus")
		  .addEventListener("change", function () {
		    const status = this.value;
		    const rows = document.querySelectorAll("tbody tr");
		
		    if (status === "all") {
		      rows.forEach((row) => (row.style.display = ""));
		    } else {
		      rows.forEach((row) => {
		        const statusCell = row
		          .querySelector("td:nth-child(6)")
		          .textContent.toLowerCase();
		        if (statusCell.includes(status)) {
		          row.style.display = "";
		        } else {
		          row.style.display = "none";
		        }
		      });
		    }
		  });


        // Filter by priority
        document
          .getElementById("filterPriority")
          .addEventListener("change", function () {
            const priority = this.value;
            const rows = document.querySelectorAll("tbody tr");

            if (priority === "all") {
              rows.forEach((row) => (row.style.display = ""));
            } else {
              rows.forEach((row) => {
                const priorityCell = row
                  .querySelector("td:nth-child(5)")
                  .textContent.toLowerCase();
                if (priorityCell.includes(priority)) {
                  row.style.display = "";
                } else {
                  row.style.display = "none";
                }
              });
            }
          });

        // Reset filters
        document
          .getElementById("resetFilters")
          .addEventListener("click", function () {
            document.getElementById("searchRequests").value = "";
            document.getElementById("filterStatus").value = "all";
            document.getElementById("filterPriority").value = "all";

            // Show all rows
            const rows = document.querySelectorAll("tbody tr");
            rows.forEach((row) => (row.style.display = ""));
          });
      });
    </script>
  </body>
</html>