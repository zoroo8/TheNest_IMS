<%@ page language="java" contentType="text/html; charset=UTF-8"

pageEncoding="UTF-8"%>
<%@ page session="true" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<% String role = (String)

session.getAttribute("role"); if (role == null || !role.equals("admin")) {

response.sendRedirect("Error"); return; } %>

<!DOCTYPE html>

<html lang="en">

 <head>

 <meta charset="UTF-8" />

 <meta name="viewport" content="width=device-width, initial-scale=1.0" />

 <title>Suppliers - The Nest Inventory System</title>

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

 href="${pageContext.request.contextPath}/resources/css/Suppliers.css"

 />

 </head>

 <body>

 <jsp:include page="../components/Sidebar.jsp" />



 <!-- Main Content -->

 <div class="main-content">

 <div class="page-header">

 <h1 class="page-title">Manage Suppliers</h1>

 <button class="btn btn-primary" id="addSupplierBtn">

 <i class="bi bi-plus-circle"></i> Add New Supplier

 </button>

 </div>



 <!-- Stats Cards -->

 <div class="stats-row">

 <div class="stat-card">

 <div class="stat-icon total-suppliers-icon">

 <i class="bi bi-truck"></i>

 </div>

 <div class="stat-info">

 <div class="stat-value" id="totalSuppliers">5</div>

 <div class="stat-label">Total Suppliers</div>

 </div>

 </div>

 <div class="stat-card">

 <div class="stat-icon active-suppliers-icon">

 <i class="bi bi-building"></i>

 </div>

 <div class="stat-info">

 <div class="stat-value" id="activeSuppliers">5</div>

 <div class="stat-label">Active Partners</div>

 </div>

 </div>

 <div class="stat-card">

 <div class="stat-icon recent-suppliers-icon">

 <i class="bi bi-calendar-check"></i>

 </div>

 <div class="stat-info">

 <div class="stat-value" id="recentSuppliers">2</div>

 <div class="stat-label">Recent Additions</div>

 </div>

 </div>

 </div>



 <!-- Filter Section -->

 <div class="search-filters">

 <div class="row">

 <div class="col-md-8">

 <div class="input-group">

 <i class="bi bi-search input-icon"></i>

 <input

 type="text"

 class="form-control input-with-icon"

 placeholder="Search suppliers by name, email or phone..."

 id="searchSuppliers"

 />

 </div>

 </div>

 <div class="col-md-2">

 <select class="form-control" id="sortOptions">

 <option value="name_asc">Name (A-Z)</option>

 <option value="name_desc">Name (Z-A)</option>

 <option value="date_asc">Date (Oldest)</option>

 <option value="date_desc">Date (Newest)</option>

 </select>

 </div>

 <div class="col-md-2" style="flex: 0 0 auto">

 <button class="btn btn-outline" id="resetFilters">Reset</button>

 </div>

 </div>

 </div>

 <!-- Suppliers Table -->

 <div class="card">

 <div class="card-header">

 <h2 class="card-title">All Suppliers</h2>

 <span class="badge badge-primary"

 >Total: <span id="visibleSuppliers">5</span> Suppliers</span

 >

 </div>

 <div class="card-body">

 <div class="table-container">

 <table>

 <thead>

 <tr>

 <th class="sortable" data-sort="name">

 Supplier Name <i class="bi bi-caret-up-fill"></i>

 </th>

 <th>Logo</th>

 <th>Phone Number</th>

 <th>Email</th>

 <th>Created Date</th>

 <th>Actions</th>

 </tr>

 </thead>

 <tbody id="suppliersTableBody">

 

 <!-- Suppliers will be populated dynamically-->

 <c:forEach items="${suppliers}" var="supplier">

 <tr data-id="${supplier.supplierId}">

 <td>${supplier.supplierName}</td>

 <td>

 <div class="supplier-logo">

 <c:choose>

 <c:when test="${not empty supplier.logo}">

 <img

 src="${pageContext.request.contextPath}/uploads/suppliers/${supplier.logo}"

 alt="${supplier.supplierName} Logo"

 />

 </c:when>

 <c:otherwise>

 <div class="default-logo">

 <i class="bi bi-building"></i>

 </div>

 </c:otherwise>

 </c:choose>

 </div>

 </td>

 <td>${supplier.phoneNumber}</td>

 <td>${supplier.email}</td>
 
  <td>${supplier.createdAt}</td>

 <td>

 <div class="action-buttons">

 <button

 class="action-btn view-btn"

 data-id="${supplier.supplierId}"

 title="View"

 >

 <i class="bi bi-eye"></i>

 </button>

 <button

 class="action-btn edit-btn"

 data-id="${supplier.supplierId}"

 title="Edit"

 >

 <i class="bi bi-pencil"></i>

 </button>

 <button

 class="action-btn delete-btn"

 data-id="${supplier.supplierId}"

 title="Delete"

 >

 <i class="bi bi-trash"></i>

 </button>

 </div>

 </td>

 </tr>

 </c:forEach>



 <!-- Example row for UI testing -->

 <tr data-id="1">

 <td>Tech World</td>

 <td>

 <div class="supplier-logo">

 <div class="default-logo">

 <i class="bi bi-building"></i>

 </div>

 </div>

 </td>

 <td>+94 112 345 678</td>

 <td>info@techworld.com</td>

 <td>2023-05-15 09:30:00</td>

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



 <!-- Additional dummy data rows -->

 <tr data-id="2">

 <td>Office Solutions</td>

 <td>

 <div class="supplier-logo">

 <div class="default-logo">

 <i class="bi bi-briefcase"></i>

 </div>

 </div>

 </td>

 <td>+94 114 567 890</td>

 <td>contact@officesolutions.com</td>

 <td>2023-06-20 14:45:00</td>

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

 <tr data-id="3">

 <td>Electronics Hub</td>

 <td>

 <div class="supplier-logo">

 <div class="default-logo">

 <i class="bi bi-cpu"></i>

 </div>

 </div>

 </td>

 <td>+94 117 890 123</td>

 <td>sales@electronicshub.com</td>

 <td>2023-07-10 11:20:00</td>

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

 <tr data-id="4">

 <td>Stationary World</td>

 <td>

 <div class="supplier-logo">

 <div class="default-logo">

 <i class="bi bi-pen"></i>

 </div>

 </div>

 </td>

 <td>+94 112 345 678</td>

 <td>info@stationaryworld.com</td>

 <td>2023-08-05 09:15:00</td>

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

 <tr data-id="5">

 <td>Furniture Plus</td>

 <td>

 <div class="supplier-logo">

 <div class="default-logo">

 <i class="bi bi-house"></i>

 </div>

 </div>

 </td>

 <td>+94 113 456 789</td>

 <td>orders@furnitureplus.com</td>

 <td>2023-08-15 13:40:00</td>

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

 </tbody>

 </table>

 </div>

 </div>

 <!-- Moved pagination inside card footer -->

 <div class="card-footer">

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

 <li class="page-item active">

 <a href="#" class="page-link">1</a>

 </li>

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

 <!-- Remove the separate pagination container -->

 </div>



 <!-- Modal Backdrop -->

 <div class="modal-backdrop" id="modalBackdrop"></div>



 <!-- Supplier Modal -->

 <div class="modal" id="supplierModal">

 <div class="modal-header">

 <h3 class="modal-title" id="modalTitle">Add New Supplier</h3>

 <button class="modal-close" id="closeModal">&times;</button>

 </div>

 <div class="modal-body">
 <%-- Show success or error message --%>
<c:if test="${not empty successMessage}">
    <div class="alert alert-success">${successMessage}</div>
</c:if>
<c:if test="${not empty errorMessage}">
    <div class="alert alert-danger">${errorMessage}</div>
</c:if>

 <form

 id="supplierForm"

 method="post"

 action="suppliers"

 enctype="multipart/form-data"

 >

 <input type="hidden" id="supplierId" name="supplierId" />



 <div class="form-group">

 <label for="supplierName" class="form-label">Supplier Name</label>

 <input

 type="text"

 class="form-control"

 id="supplierName"

 name="supplierName"

 required

 />

 </div>



 <div class="form-group">

 <label for="supplierLogo" class="form-label">Logo</label>

 <input

 type="file"

 class="form-control"

 id="supplierLogo"

 name="supplierLogo"

 accept="image/*"

 />

 <div class="logo-preview" id="logoPreview"></div>

 </div>



 <div class="row">

 <div class="col-md-6">

 <div class="form-group">

 <label for="phoneNumber" class="form-label">Phone Number</label>

 <input

 type="tel"

 class="form-control"

 id="phoneNumber"

 name="phoneNumber"

 />

 </div>

 </div>

 <div class="col-md-6">

 <div class="form-group">

 <label for="email" class="form-label">Email</label>

 <input

 type="email"

 class="form-control"

 id="email"

 name="email"

 />

 </div>

 </div>

 </div>



 <div class="form-group">

 <label for="address" class="form-label">Address</label>

 <textarea

 class="form-control"

 id="address"

 name="address"

 rows="3"

 ></textarea>

 </div>

 <div class="modal-footer">

 <button class="btn btn-outline" id="cancelBtn">Cancel</button>

 <button class="btn btn-primary" type="submit" id="saveSupplierBtn">

 Save Supplier

 </button>

 </div>

 </form>

 </div>

 

 </div>



 <!-- View Supplier Modal -->

 <div class="modal" id="viewSupplierModal">

 <div class="modal-header">

 <h3 class="modal-title">Supplier Details</h3>

 <button class="modal-close" id="closeViewModal">&times;</button>

 </div>

 <div class="modal-body">

 <div class="supplier-details">

 <div class="supplier-logo-large" id="viewLogoContainer">

 <img id="viewSupplierLogo" src="" alt="Supplier Logo" />

 </div>

 <h4 id="viewSupplierName">Supplier Name</h4>

 <div class="supplier-info-row">

 <div class="supplier-info-label">Phone:</div>

 <div class="supplier-info-value" id="viewPhoneNumber">Phone</div>

 </div>

 <div class="supplier-info-row">

 <div class="supplier-info-label">Email:</div>

 <div class="supplier-info-value" id="viewEmail">Email</div>

 </div>

 <div class="supplier-info-row">

 <div class="supplier-info-label">Address:</div>

 <div class="supplier-info-value" id="viewAddress">Address</div>

 </div>

 <div class="supplier-info-row">

 <div class="supplier-info-label">Created:</div>

 <div class="supplier-info-value" id="viewCreatedAt">Date</div>

 </div>

 </div>

 </div>

 <div class="modal-footer">

 <button class="btn btn-outline" id="closeViewBtn">Close</button>

 <button class="btn btn-primary" id="editFromViewBtn">Edit</button>

 </div>

 </div>



 <!-- Delete Supplier Modal -->

 <div class="modal" id="deleteModal">

 <div class="modal-header">

 <h3 class="modal-title">Delete Supplier</h3>

 <button class="modal-close" id="closeDeleteModal">&times;</button>

 </div>

 <div class="modal-body">

 <p>Are you sure you want to delete this Supplier?</p>

 <p class="text-danger">

 <strong>Supplier: <span id="deleteSupplierName"></span></strong>

 </p>

 </div>

 <div class="modal-footer">

 <button class="btn btn-outline" id="cancelDeleteBtn">Cancel</button>

 <button class="btn btn-danger" id="confirmDeleteBtn">

 Confirm Deletion

 </button>

 </div>

 </div>



 <!-- JavaScript for functionality -->

 <script>

 document.addEventListener("DOMContentLoaded", function () {

 const searchInput = document.getElementById("searchSuppliers");

 const sortSelect = document.getElementById("sortOptions");

 const resetFiltersBtn = document.getElementById("resetFilters");

 const suppliersTableBody = document.getElementById("suppliersTableBody");

 const supplierRows = suppliersTableBody.querySelectorAll("tr");

 const totalBadge = document.getElementById("visibleSuppliers");



 document.getElementById("totalSuppliers").textContent =

 supplierRows.length;

 document.getElementById("activeSuppliers").textContent =

 supplierRows.length;

 document.getElementById("recentSuppliers").textContent = "2";

 updateVisibleCount();



 const modalBackdrop = document.getElementById("modalBackdrop");

 const supplierModal = document.getElementById("supplierModal");

 const viewSupplierModal = document.getElementById("viewSupplierModal");

 const deleteModal = document.getElementById("deleteModal");

 const closeModal = document.getElementById("closeModal");

 const closeViewModal = document.getElementById("closeViewModal");

 const closeDeleteModal = document.getElementById("closeDeleteModal");

 const addSupplierBtn = document.getElementById("addSupplierBtn");

 const saveSupplierBtn = document.getElementById("saveSupplierBtn");

 const cancelBtn = document.getElementById("cancelBtn");

 const closeViewBtn = document.getElementById("closeViewBtn");

 const editFromViewBtn = document.getElementById("editFromViewBtn");

 const cancelDeleteBtn = document.getElementById("cancelDeleteBtn");

 const confirmDeleteBtn = document.getElementById("confirmDeleteBtn");



 const supplierForm = document.getElementById("supplierForm");

 const supplierId = document.getElementById("supplierId");

 const supplierName = document.getElementById("supplierName");

 const supplierLogo = document.getElementById("supplierLogo");

 const phoneNumber = document.getElementById("phoneNumber");

 const email = document.getElementById("email");

 const address = document.getElementById("address");

 const logoPreview = document.getElementById("logoPreview");



 const viewSupplierName = document.getElementById("viewSupplierName");

 const viewPhoneNumber = document.getElementById("viewPhoneNumber");

 const viewEmail = document.getElementById("viewEmail");

 const viewAddress = document.getElementById("viewAddress");

 const viewCreatedAt = document.getElementById("viewCreatedAt");

 const viewSupplierLogo = document.getElementById("viewSupplierLogo");

 const viewLogoContainer = document.getElementById("viewLogoContainer");



 const deleteSupplierName =

 document.getElementById("deleteSupplierName");



 if (supplierLogo) {

 supplierLogo.addEventListener("change", function () {

 if (this.files && this.files[0]) {

 const reader = new FileReader();

 reader.onload = function (e) {

 logoPreview.innerHTML = `<img src="${e.target.result}" alt="Logo Preview" />`;

 logoPreview.style.display = "block";

 };

 reader.readAsDataURL(this.files[0]);

 } else {

 logoPreview.innerHTML = "";

 logoPreview.style.display = "none";

 }

 });

 }



 function openModal(modal) {

 if (!modal || typeof modal.style === "undefined") {

 console.error("Invalid modal element passed to openModal:", modal);

 return;

 }

 if (!modalBackdrop || typeof modalBackdrop.style === "undefined") {

 console.error("Modal backdrop element not found or invalid.");

 return;

 }

 modal.style.display = "block";

 modalBackdrop.style.display = "block";

 document.body.style.overflow = "hidden";

 console.log("Modal opened:", modal.id);

 }



 function closeAllModals() {

 console.log("Closing all modals");

 if (supplierModal) supplierModal.style.display = "none";

 if (viewSupplierModal) viewSupplierModal.style.display = "none";

 if (deleteModal) deleteModal.style.display = "none";

 if (modalBackdrop) modalBackdrop.style.display = "none";

 document.body.style.overflow = "auto";

 }



 function filterSuppliers() {

 const searchTerm = searchInput.value.toLowerCase();

 const sortOption = sortSelect.value;



 const filteredRows = Array.from(supplierRows).filter((row) => {

 const name = row.cells[0].textContent.toLowerCase();

 const phone = row.cells[2].textContent.toLowerCase();

 const email = row.cells[3].textContent.toLowerCase();

 return (

 name.includes(searchTerm) ||

 phone.includes(searchTerm) ||

 email.includes(searchTerm)

 );

 });



 filteredRows.sort((a, b) => {

 if (sortOption === "name_asc") {

 return a.cells[0].textContent.localeCompare(

 b.cells[0].textContent

 );

 } else if (sortOption === "name_desc") {

 return b.cells[0].textContent.localeCompare(

 a.cells[0].textContent

 );

 } else if (sortOption === "date_asc") {

 return (

 new Date(a.cells[4].textContent) -

 new Date(b.cells[4].textContent)

 );

 } else if (sortOption === "date_desc") {

 return (

 new Date(b.cells[4].textContent) -

 new Date(a.cells[4].textContent)

 );

 }

 return 0;

 });



 supplierRows.forEach((row) => {

 row.style.display = "none";

 });



 filteredRows.forEach((row) => {

 row.style.display = "";

 });



 updateVisibleCount();

 }



 function updateVisibleCount() {

 const visibleRows = Array.from(supplierRows).filter(

 (row) => row.style.display !== "none"

 );

 totalBadge.textContent = visibleRows.length;

 }



 searchInput.addEventListener("keyup", filterSuppliers);

 sortSelect.addEventListener("change", filterSuppliers);



 resetFiltersBtn.addEventListener("click", function () {

 searchInput.value = "";

 sortSelect.value = "name_asc";

 filterSuppliers();

 });



 if (addSupplierBtn) {

 addSupplierBtn.addEventListener("click", function () {

 if (

 !supplierForm ||

 !supplierId ||

 !logoPreview ||

 !supplierModal

 ) {

 console.error(

 "One or more elements for Add Supplier modal are missing."

 );

 return;

 }

 supplierForm.reset();

 supplierId.value = "";

 logoPreview.innerHTML = "";

 logoPreview.style.display = "none";

 const modalTitleEl = document.getElementById("modalTitle");

 if (modalTitleEl) modalTitleEl.textContent = "Add New Supplier";

 openModal(supplierModal);

 });

 } else {

 console.error("Add Supplier button not found.");

 }



 document.querySelectorAll(".view-btn").forEach(function (btn) {

 btn.addEventListener("click", function () {

 try {

 console.log("View button clicked:", this);

 const row = this.closest("tr");



 if (!row) {

 console.error(

 "View button: Could not find parent <tr> for button:",

 this

 );

 return;

 }



 const id = row.getAttribute("data-id");

 console.log("Found parent row with data-id:", id);



 const rowViaQuerySelector = suppliersTableBody.querySelector(`tr[data-id="${id}"]`);

 



 if (

 !viewSupplierModal ||

 !viewSupplierName ||

 !viewLogoContainer ||

 !viewPhoneNumber ||

 !viewEmail ||

 !viewCreatedAt ||

 !viewAddress

 ) {

 console.error(

 "One or more elements for View Supplier modal are missing."

 );

 return;

 }



 viewSupplierName.textContent = row.cells[0].textContent;



 const logoCell = row.cells[1];

 viewLogoContainer.innerHTML = "";

 viewLogoContainer.className = "supplier-logo-large";



 if (logoCell) {

 const logoInRow = logoCell.querySelector(".supplier-logo img");

 const defaultLogoIconInRow = logoCell.querySelector(

 ".supplier-logo .default-logo i"

 );



 if (logoInRow) {

 const imgElement = document.createElement("img");

 imgElement.src = logoInRow.src;

 imgElement.alt = logoInRow.alt || "Supplier Logo";

 viewLogoContainer.appendChild(imgElement);

 } else if (defaultLogoIconInRow) {

 viewLogoContainer.innerHTML = `<i class="${defaultLogoIconInRow.className}"></i>`;

 viewLogoContainer.classList.add("default-logo");

 } else {

 viewLogoContainer.innerHTML =

 '<i class="bi bi-building"></i>';

 viewLogoContainer.classList.add("default-logo");

 }

 } else {

 viewLogoContainer.innerHTML = '<i class="bi bi-building"></i>';

 viewLogoContainer.classList.add("default-logo");

 }



 viewPhoneNumber.textContent = row.cells[2]

 ? row.cells[2].textContent

 : "N/A";

 viewEmail.textContent = row.cells[3]

 ? row.cells[3].textContent

 : "N/A";

 viewCreatedAt.textContent = row.cells[4]

 ? row.cells[4].textContent

 : "N/A";

 viewAddress.textContent = "123 Main Street, Colombo, Sri Lanka";



 openModal(viewSupplierModal);

 } catch (error) {

 console.error("Error in view-btn click handler:", error);

 }

 });

 });



 document.querySelectorAll(".edit-btn").forEach(function (btn) {

 btn.addEventListener("click", function () {

 try {

 console.log("Edit button clicked:", this);

 const row = this.closest("tr");



 if (!row) {

 console.error(

 "Edit button: Could not find parent <tr> for button:",

 this

 );

 return;

 }

 const id = row.getAttribute("data-id");

 console.log("Found parent row with data-id:", id);



 if (

 !supplierModal ||

 !supplierId ||

 !supplierName ||

 !phoneNumber ||

 !email ||

 !address ||

 !logoPreview

 ) {

 console.error(

 "One or more elements for Edit Supplier modal are missing."

 );

 return;

 }



 const modalTitleEl = document.getElementById("modalTitle");

 if (modalTitleEl) modalTitleEl.textContent = "Edit Supplier";



 supplierId.value = id;

 supplierName.value = row.cells[0].textContent;

 phoneNumber.value = row.cells[2] ? row.cells[2].textContent : "";

 email.value = row.cells[3] ? row.cells[3].textContent : "";

 address.value = "123 Main Street, Colombo, Sri Lanka";



 logoPreview.innerHTML = "";

 logoPreview.style.display = "none";

 if (supplierForm) supplierForm.reset();



 openModal(supplierModal);

 } catch (error) {

 console.error("Error in edit-btn click handler:", error);

 }

 });

 });



 document.querySelectorAll(".delete-btn").forEach(function (btn) {

 btn.addEventListener("click", function () {

 try {

 console.log("Delete button clicked:", this);

 const row = this.closest("tr");



 if (!row) {

 console.error(

 "Delete button: Could not find parent <tr> for button:",

 this

 );

 return;

 }



 if (!deleteModal || !deleteSupplierName) {

 console.error(

 "One or more elements for Delete Supplier modal are missing."

 );

 return;

 }



 deleteSupplierName.textContent = row.cells[0].textContent;

 openModal(deleteModal);

 } catch (error) {

 console.error("Error in delete-btn click handler:", error);

 }

 });

 });



 if (editFromViewBtn) {

 editFromViewBtn.addEventListener("click", function () {

 if (

 !viewSupplierName ||

 !viewPhoneNumber ||

 !viewEmail ||

 !viewAddress ||

 !supplierModal

 ) {

 console.error(

 "One or more elements for Edit from View functionality are missing."

 );

 return;

 }

 closeAllModals();



 const modalTitleEl = document.getElementById("modalTitle");

 if (modalTitleEl) modalTitleEl.textContent = "Edit Supplier";



 if (supplierName) supplierName.value = viewSupplierName.textContent;

 if (phoneNumber) phoneNumber.value = viewPhoneNumber.textContent;

 if (email) email.value = viewEmail.textContent;

 if (address) address.value = viewAddress.textContent;



 if (logoPreview) {

 logoPreview.innerHTML = "";

 logoPreview.style.display = "none";

 }

 if (supplierForm) supplierForm.reset();



 openModal(supplierModal);

 });

 }



 const allCloseButtons = document.querySelectorAll(

 ".modal-close, #cancelBtn, #closeViewBtn, #cancelDeleteBtn"

 );

 if (allCloseButtons.length > 0) {

 allCloseButtons.forEach((btn) => {

 if (btn) {

 btn.addEventListener("click", closeAllModals);

 }

 });

 } else {

 console.warn(

 "No close buttons found for modals with specified selectors."

 );

 }



 if (closeModal) closeModal.addEventListener("click", closeAllModals);

 if (closeViewModal)

 closeViewModal.addEventListener("click", closeAllModals);

 if (closeDeleteModal)

 closeDeleteModal.addEventListener("click", closeAllModals);

 if (cancelBtn) cancelBtn.addEventListener("click", closeAllModals);

 if (closeViewBtn)

 closeViewBtn.addEventListener("click", closeAllModals);

 if (cancelDeleteBtn)

 cancelDeleteBtn.addEventListener("click", closeAllModals);



 if (saveSupplierBtn) {

 saveSupplierBtn.addEventListener("click", function () {

 if (supplierForm.checkValidity()) {

 const formData = new FormData(supplierForm);



 console.log("Submitting supplier data:", {

 id: formData.get("supplierId"),

 name: formData.get("supplierName"),

 phone: formData.get("phoneNumber"),

 email: formData.get("email"),

 address: formData.get("address"),

 });



 closeAllModals();



 alert("Supplier saved successfully!");

 } else {

 supplierForm.reportValidity();

 }

 });

 }



 if (confirmDeleteBtn) {

 confirmDeleteBtn.addEventListener("click", function () {

 closeAllModals();

 alert("Supplier deleted successfully!");

 });

 }



 filterSuppliers();

 });

 </script>

 </body>

</html>