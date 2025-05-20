<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%> <%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core" %> <%@ taglib prefix="fmt"
uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Users Management - The Nest Inventory System</title>
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
      href="${pageContext.request.contextPath}/resources/css/Users.css"
    />
    <link
      rel="stylesheet"
      href="${pageContext.request.contextPath}/resources/css/Categories.css"
    />

    <style>
      .input-group {
        position: relative;
        width: 100%;
      }

      .input-icon {
        position: absolute;
        left: 12px;
        top: 50%;
        transform: translateY(-50%);
        color: #757575;
        z-index: 1;
        pointer-events: none;
      }

      .input-with-icon {
        padding-left: 45px;
        width: 100%;
        text-indent: 20px;
      }

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
        background-color: rgba(244, 67, 54, 0.1);
        color: var(--danger-color); /* Adjusted for better visibility */
        border-left: 4px solid var(--danger-color);
      }
      .alert .dismiss-btn {
        position: absolute;
        right: 10px;
        top: 50%;
        transform: translateY(-50%);
        background: transparent;
        border: none;
        cursor: pointer;
        font-size: 1.2rem;
        opacity: 0.6;
        padding: 5px;
        line-height: 1;
      }
      .alert .dismiss-btn:hover {
        opacity: 1;
      }
      .alert .dismiss-btn::before {
        content: "\00D7"; /* Times symbol */
      }
      @keyframes fadeIn {
        from {
          opacity: 0;
          transform: translateY(-10px);
        }
        to {
          opacity: 1;
          transform: translateY(0);
        }
      }
      @keyframes fadeOut {
        from {
          opacity: 1;
          transform: translateY(0);
        }
        to {
          opacity: 0;
          transform: translateY(-10px);
        }
      }
      .alert.fade-out {
        animation: fadeOut 0.3s ease-out forwards;
      }

      .profile-img-sm {
        width: 40px;
        height: 40px;
        border-radius: 50%;
        margin-right: 10px;
        object-fit: cover;
      }
      .user-info-cell {
        display: flex;
        align-items: center;
      }
      .user-name {
        font-weight: 500;
      }
      .user-email-small {
        font-size: 0.85em;
        color: #777;
      }
      .action-buttons .btn-icon {
        margin: 0 3px;
        padding: 5px 8px;
        font-size: 0.9rem;
      }
      .badge {
        text-transform: capitalize;
      }
    </style>
  </head>
  <body>
    <jsp:include page="../components/Sidebar.jsp" />

    <!-- Main Content -->
    <div class="main-content">
      <!-- Display success/error messages -->
      <c:if test="${not empty sessionScope.successMessage}">
        <div class="alert alert-success" id="successAlert">
          <i
            class="bi bi-check-circle"
            style="margin-right: 10px; font-size: 1.1rem"
          ></i>
          ${sessionScope.successMessage}
          <button
            type="button"
            class="dismiss-btn"
            onclick="dismissAlert(this.parentElement)"
          ></button>
          <c:remove var="successMessage" scope="session" />
        </div>
      </c:if>
      <c:if test="${not empty sessionScope.errorMessage}">
        <div class="alert alert-danger" id="errorAlert">
          <i
            class="bi bi-exclamation-circle"
            style="margin-right: 10px; font-size: 1.1rem"
          ></i>
          ${sessionScope.errorMessage}
          <button
            type="button"
            class="dismiss-btn"
            onclick="dismissAlert(this.parentElement)"
          ></button>
          <c:remove var="errorMessage" scope="session" />
        </div>
      </c:if>

      <div class="page-header">
        <h1 class="page-title">Users Management</h1>
        <button class="btn btn-primary" id="newUserBtn">
          <i class="bi bi-person-plus"></i> Add New User
        </button>
      </div>

      <!-- Stats Cards -->
      <div class="stats-row">
        <div class="stat-card">
          <div class="stat-icon admin-icon">
            <i class="bi bi-shield-lock"></i>
          </div>
          <div class="stat-value">${stats.adminUsers}</div>
          <div class="stat-label">Admin Users</div>
        </div>
        <div class="stat-card">
          <div class="stat-icon staff-icon">
            <i class="bi bi-person-badge"></i>
          </div>
          <div class="stat-value">${stats.staffUsers}</div>
          <div class="stat-label">Staff Users</div>
        </div>
        <%-- Removed Active Users Stat Card --%>
        <div class="stat-card">
          <div class="stat-icon total-users-icon">
            <i class="bi bi-people-fill"></i>
          </div>
          <div class="stat-value">${stats.totalUsers}</div>
          <div class="stat-label">Total Users</div>
        </div>
      </div>

      <%-- Search and Filters --%>
      <div class="search-filters card">
        <div class="card-body" style="padding: 15px">
          <div class="row">
            <div class="col-md-6">
              <%-- Adjusted col width --%>
              <div class="input-group">
                <i class="bi bi-search input-icon"></i>
                <input
                  type="text"
                  class="form-control input-with-icon"
                  placeholder="Search users by name, email..."
                  id="searchUsers"
                />
              </div>
            </div>
            <div class="col-md-4">
              <%-- Adjusted col width --%>
              <select class="form-control" id="filterRole">
                <option value="all" selected>All Roles</option>
                <option value="admin">Admin</option>
                <option value="staff">Staff</option>
              </select>
            </div>
            <%-- Removed Status Filter Dropdown --%>
            <div class="col-md-2">
              <%-- Adjusted col width --%>
              <button
                class="btn btn-outline"
                id="resetFilters"
                style="width: 100%"
              >
                Reset
              </button>
            </div>
          </div>
        </div>
      </div>

      <!-- Users Table -->
      <div class="card">
        <div class="card-header">
          <h2 class="card-title">All Users</h2>
          <span
            class="badge badge-primary"
            style="background-color: var(--primary-color); color: white"
            >Total: ${stats.totalUsers} Users</span
          >
        </div>
        <div class="card-body">
          <div class="table-container">
            <table>
              <thead>
                <tr>
                  <th>User</th>
                  <th>Contact</th>
                  <th>Role</th>
                  <th>Department</th>
                  <%-- Removed Status Header --%>
                  <th>Last Login</th>
                  <th>Actions</th>
                </tr>
              </thead>
              <tbody id="usersTableBody">
                <c:choose>
                  <c:when test="${empty users}">
                    <tr>
                      <td colspan="6" style="text-align: center; padding: 20px">
                        <%-- Adjusted colspan --%>
                        <div class="empty-state">
                          <div class="empty-state-icon">
                            <i class="bi bi-people"></i>
                          </div>
                          <h3 class="empty-state-title">No Users Found</h3>
                          <p class="empty-state-message">
                            There are no users matching your criteria or no
                            users in the system yet.
                          </p>
                        </div>
                      </td>
                    </tr>
                  </c:when>
                  <c:otherwise>
                    <c:forEach var="user" items="${users}">
                      <tr
                        data-user-id="${user.userId}"
                        data-role="${user.role}"
                      >
                        <td>
                          <div class="user-info-cell">
                            <img
                              src="${pageContext.request.contextPath}/${not empty user.profilePicture ? user.profilePicture : 'assets/images/avatars/default-avatar.png'}"
                              alt="${user.firstName}"
                              class="profile-img-sm"
                              onerror="this.onerror=null;this.src='${pageContext.request.contextPath}/assets/images/avatars/default-avatar.png';"
                            />
                            <div>
                              <span class="user-name"
                                >${user.firstName} ${user.lastName}</span
                              >
                              <div class="user-email-small">${user.email}</div>
                            </div>
                          </div>
                        </td>
                        <td>${user.phoneNumber}</td>
                        <td>
                          <span
                            class="badge badge-${user.role == 'admin' ? 'admin' : 'staff'}"
                            >${user.role}</span
                          >
                        </td>
                        <td>${user.department}</td>
                        <%-- Removed Status Column Cell --%>
                        <td>${user.lastLoginFormatted}</td>
                        <td>
                          <div class="action-buttons">
                            <button
                              class="btn btn-outline btn-sm btn-icon view-btn"
                              data-id="${user.userId}"
                              title="View Details"
                            >
                              <i class="bi bi-eye"></i>
                            </button>
                            <button
                              class="btn btn-primary btn-sm btn-icon edit-btn"
                              data-id="${user.userId}"
                              title="Edit User"
                            >
                              <i class="bi bi-pencil"></i>
                            </button>
                            <button
                              class="btn btn-danger btn-sm btn-icon delete-btn"
                              data-id="${user.userId}"
                              data-name="${user.firstName} ${user.lastName}"
                              title="Delete User"
                            >
                              <i class="bi bi-trash"></i>
                            </button>
                          </div>
                        </td>
                      </tr>
                    </c:forEach>
                  </c:otherwise>
                </c:choose>
              </tbody>
            </table>
          </div>
        </div>
        <div class="card-footer"></div>
      </div>
      <%-- Pagination --%>
<c:if test="${totalPages > 1}">
  <div class="pagination-info text-center">
    <c:set var="start" value="${(currentPage - 1) * pageSize + 1}" />
    <c:set var="end" value="${(currentPage * pageSize < stats.totalUsers) ? currentPage * pageSize : stats.totalUsers}" />
    Showing ${start} to ${end} of ${stats.totalUsers} users
  </div>
  <div class="pagination-container">
    <ul class="pagination">
      <%-- First Page --%>
      <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
        <a href="${pageContext.request.contextPath}/users?page=1"
           class="page-link"
           aria-label="First"
           ${currentPage == 1 ? 'tabindex="-1"' : ''}>
          <span aria-hidden="true">&laquo;&laquo; First</span>
        </a>
      </li>

      <%-- Previous Page --%>
      <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
        <a href="${pageContext.request.contextPath}/users?page=${currentPage - 1}"
           class="page-link"
           aria-label="Previous"
           ${currentPage == 1 ? 'tabindex="-1"' : ''}>
          <span aria-hidden="true">&laquo; Previous</span>
        </a>
      </li>

      <%-- Page Numbers --%>
      <c:set var="beginPage" value="${(currentPage - 2 < 1) ? 1 : currentPage - 2}" />
      <c:set var="endPage" value="${(currentPage + 2 > totalPages) ? totalPages : currentPage + 2}" />
      <c:forEach var="i" begin="${beginPage}" end="${endPage}">
        <li class="page-item ${i == currentPage ? 'active' : ''}">
          <a href="${pageContext.request.contextPath}/users?page=${i}" class="page-link">
            ${i}
          </a>
        </li>
      </c:forEach>

      <%-- Next Page --%>
      <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
        <a href="${pageContext.request.contextPath}/users?page=${currentPage + 1}"
           class="page-link"
           aria-label="Next"
           ${currentPage == totalPages ? 'tabindex="-1"' : ''}>
          <span aria-hidden="true">Next &raquo;</span>
        </a>
      </li>

      <%-- Last Page --%>
      <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
        <a href="${pageContext.request.contextPath}/users?page=${totalPages}"
           class="page-link"
           aria-label="Last"
           ${currentPage == totalPages ? 'tabindex="-1"' : ''}>
          <span aria-hidden="true">Last &raquo;&raquo;</span>
        </a>
      </li>
    </ul>
  </div>
</c:if>
    </div>

    <!-- Modal Backdrop -->
    <div class="modal-backdrop" id="modalBackdrop"></div>

    <!-- View User Modal (Content to be populated by JS) -->
    <div class="modal" id="viewUserModal">
      <div class="modal-header">
        <h3 class="modal-title">User Details</h3>
        <button class="modal-close" id="closeViewModalBtn">&times;</button>
      </div>
      <div class="modal-body" id="viewUserModalBody">
        <p>Loading user details...</p>
      </div>
      <div class="modal-footer">
        <button
          type="button"
          class="btn btn-outline"
          id="closeViewModalFooterBtn"
        >
          Close
        </button>
        <button
          type="button"
          class="btn btn-primary edit-from-view-btn"
          data-id=""
        >
          Edit User
        </button>
      </div>
    </div>

    <!-- Add/Edit User Modal -->
    <div class="modal large-modal" id="userFormModal">
      <div class="modal-header">
        <h3 class="modal-title" id="userFormTitle">Add New User</h3>
        <button class="modal-close" id="closeFormModalBtn">&times;</button>
      </div>
      <div class="modal-body">
        <form
          id="userForm"
          method="post"
          action="${pageContext.request.contextPath}/users"
          enctype="multipart/form-data"
        >
          <input type="hidden" id="formAction" name="action" value="add" />
          <input type="hidden" id="userId" name="userId" value="" />

          <div class="form-section">
            <h4>Personal Information</h4>
            <%-- ... Personal Info fields ... --%>
            <div class="row">
              <div class="col-md-6 form-group">
                <label for="firstName"
                  >First Name <span class="required">*</span></label
                ><input
                  type="text"
                  class="form-control"
                  id="firstName"
                  name="firstName"
                  required
                />
              </div>
              <div class="col-md-6 form-group">
                <label for="lastName"
                  >Last Name <span class="required">*</span></label
                ><input
                  type="text"
                  class="form-control"
                  id="lastName"
                  name="lastName"
                  required
                />
              </div>
            </div>
            <div class="row">
              <div class="col-md-6 form-group">
                <label for="phoneNumber">Phone Number</label
                ><input
                  type="tel"
                  class="form-control"
                  id="phoneNumber"
                  name="phoneNumber"
                />
              </div>
              <div class="col-md-6 form-group">
                <label for="dob"
                  >Date of Birth <span class="required">*</span></label
                ><input
                  type="date"
                  class="form-control"
                  id="dob"
                  name="dob"
                  required
                />
              </div>
            </div>
            <div class="row">
              <div class="col-md-6 form-group">
                <label for="gender">Gender</label>
                <select class="form-control" id="gender" name="gender">
                  <option value="">Select Gender</option>
                  <option value="male">Male</option>
                  <option value="female">Female</option>
                  <option value="other">Other</option>
                </select>
              </div>
              <div class="col-md-6 form-group">
                <label for="email"
                  >Email Address <span class="required">*</span></label
                ><input
                  type="email"
                  class="form-control"
                  id="email"
                  name="email"
                  required
                />
              </div>
            </div>
            <div class="form-group">
              <label for="address">Address</label
              ><textarea
                class="form-control"
                id="address"
                name="address"
                rows="2"
              ></textarea>
            </div>
          </div>

          <div class="form-section">
            <h4>Account Information</h4>
            <div class="row">
              <div class="col-md-6 form-group">
                <label for="role">Role <span class="required">*</span></label>
                <select class="form-control" id="role" name="role" required>
                  <option value="">Select Role</option>
                  <option value="staff">Staff</option>
                  <option value="admin">Admin</option>
                </select>
              </div>
              <div class="col-md-6 form-group">
                <label for="department"
                  >Department <span class="required">*</span></label
                >
                <input
                  type="text"
                  class="form-control"
                  id="department"
                  name="department"
                  required
                />
              </div>
            </div>
            <%-- Removed Status Select Field from form --%>

            <div class="form-group">
              <label for="profilePicture">Profile Picture</label>
              <div class="file-upload-container">
                <div class="file-upload-preview" id="profilePreview">
                  <i class="bi bi-person-circle"></i
                  ><img
                    id="imgPreview"
                    src="#"
                    alt="Preview"
                    style="display: none; max-width: 100%; max-height: 100%"
                  />
                </div>
                <div class="file-upload-controls">
                  <input
                    type="file"
                    class="form-control"
                    id="profilePicture"
                    name="profilePicture"
                    accept="image/*"
                    onchange="previewImage(event)"
                  />
                </div>
              </div>
            </div>

            <div class="row password-fields">
              <%-- JS will show/hide this for edit --%>
              <div class="col-md-6 form-group">
                <label for="password"
                  >Password
                  <span class="required" id="passwordRequiredSpan"
                    >*</span
                  ></label
                >
                <input
                  type="password"
                  class="form-control"
                  id="password"
                  name="password"
                />
                <small class="form-text text-muted" id="passwordHelp"
                  >Leave blank if not changing (for edit).</small
                >
              </div>
              <div class="col-md-6 form-group">
                <label for="confirmPassword"
                  >Confirm Password
                  <span class="required" id="confirmPasswordRequiredSpan"
                    >*</span
                  ></label
                >
                <input
                  type="password"
                  class="form-control"
                  id="confirmPassword"
                  name="confirmPassword"
                />
              </div>
            </div>
          </div>
          <div class="modal-footer">
            <button type="button" class="btn btn-outline" id="cancelFormBtn">
              Cancel
            </button>
            <button type="submit" class="btn btn-primary" id="saveUserBtn">
              <i class="bi bi-save"></i> Save User
            </button>
          </div>
        </form>
      </div>
    </div>

    <!-- Delete Confirmation Modal -->
    <div class="modal" id="deleteConfirmModal">
      <div class="modal-header">
        <h3 class="modal-title">Confirm Delete</h3>
        <button class="modal-close" id="closeDeleteModalBtn">&times;</button>
      </div>
      <div class="modal-body">
        <p>
          Are you sure you want to delete user:
          <strong id="userNameToDelete"></strong>?
        </p>
        <p class="text-danger">This action cannot be undone.</p>
      </div>
      <div class="modal-footer">
        <form
          id="deleteUserForm"
          method="post"
          action="${pageContext.request.contextPath}/users"
        >
          <input type="hidden" name="action" value="delete" />
          <input
            type="hidden"
            id="userIdToDelete"
            name="userIdToDelete"
            value=""
          />
          <button type="button" class="btn btn-outline" id="cancelDeleteBtn">
            Cancel
          </button>
          <button type="submit" class="btn btn-danger">Delete User</button>
        </form>
      </div>
    </div>

    <script>
      var contextPath = "${pageContext.request.contextPath}";
      function dismissAlert(alertElement) {
        if (alertElement) {
          alertElement.classList.add("fade-out");
          setTimeout(() => {
            if (alertElement.parentNode) {
              alertElement.parentNode.removeChild(alertElement);
            }
          }, 300); // Match animation duration
        }
      }

      document.addEventListener("DOMContentLoaded", function () {
        // ... auto-dismiss alerts ...
        const alerts = document.querySelectorAll(".alert");
        alerts.forEach((alert) => {
          setTimeout(() => {
            dismissAlert(alert);
          }, 5000); // Dismiss after 5 seconds
          const dismissButton = alert.querySelector(".dismiss-btn");
          if (dismissButton && !dismissButton.getAttribute("onclick")) {
            dismissButton.addEventListener("click", function () {
              dismissAlert(alert);
            });
          }
        });

        const modalBackdrop = document.getElementById("modalBackdrop");
        const userFormModal = document.getElementById("userFormModal");
        const viewUserModal = document.getElementById("viewUserModal");
        const deleteConfirmModal =
          document.getElementById("deleteConfirmModal");

        function openModal(modal) {
          document.getElementById("modalBackdrop").style.display = "block";
          modal.style.display = "block";
          document.body.style.overflow = "hidden";
        }

        function closeModal(modal) {
          document.getElementById("modalBackdrop").style.display = "none";
          modal.style.display = "none";
          document.body.style.overflow = "";
        }

        function closeAllModals() {
          modalBackdrop.style.display = "none";
          if (userFormModal) userFormModal.style.display = "none";
          if (viewUserModal) viewUserModal.style.display = "none";
          if (deleteConfirmModal) deleteConfirmModal.style.display = "none";
          document.body.style.overflow = "";
        }

        function fetchWithJsonErrorHandling(url) {
          return fetch(url)
            .then((response) => {
              if (!response.ok) {
                throw new Error(HTTP error! Status: ${response.status});
              }
              return response.text(); // Get as text first for debugging
            })
            .then((text) => {
              try {
                // Log the raw text for debugging
                console.log("Raw response:", text);
                return JSON.parse(text);
              } catch (e) {
                console.error("JSON parsing error:", e);
                console.error("Response text was:", text);
                throw new Error("Failed to parse server response as JSON");
              }
            });
        }

        // Modal close buttons
        document
          .getElementById("closeFormModalBtn")
          ?.addEventListener("click", () => closeModal(userFormModal));
        document
          .getElementById("cancelFormBtn")
          ?.addEventListener("click", () => closeModal(userFormModal));
        document
          .getElementById("closeViewModalBtn")
          ?.addEventListener("click", () => closeModal(viewUserModal));
        document
          .getElementById("closeViewModalFooterBtn")
          ?.addEventListener("click", () => closeModal(viewUserModal));
        document
          .getElementById("closeDeleteModalBtn")
          ?.addEventListener("click", () => closeModal(deleteConfirmModal));
        document
          .getElementById("cancelDeleteBtn")
          ?.addEventListener("click", (e) => {
            e.preventDefault();
            closeModal(deleteConfirmModal);
          });

        // Add New User button
        document
          .getElementById("newUserBtn")
          ?.addEventListener("click", function () {
            document.getElementById("userFormTitle").textContent =
              "Add New User";
            document.getElementById("userForm").reset();
            document.getElementById("formAction").value = "add";
            document.getElementById("userId").value = "";
            document.getElementById("imgPreview").style.display = "none";
            document
              .getElementById("profilePreview")
              .querySelector("i").style.display = "block";
            document.getElementById("password").required = true;
            document.getElementById("confirmPassword").required = true;
            document.getElementById("passwordRequiredSpan").style.display =
              "inline";
            document.getElementById(
              "confirmPasswordRequiredSpan"
            ).style.display = "inline";
            document.getElementById("passwordHelp").style.display = "none";
            openModal(userFormModal);
          });

        // Edit User buttons
        document.querySelectorAll(".edit-btn").forEach((button) => {
          button.addEventListener("click", function () {
            const userId = this.getAttribute("data-id");
            fetchUserAndPopulateForm(userId);
          });
        });

        // Edit from View Modal button
        document
          .querySelector(".edit-from-view-btn")
          ?.addEventListener("click", function () {
            const userId = this.getAttribute("data-id");
            if (userId) {
              closeModal(viewUserModal);
              fetchUserAndPopulateForm(userId);
            }
          });

        function fetchUserAndPopulateForm(userId) {
          fetchWithJsonErrorHandling(
            contextPath + "/users?action=getUserDetails&id=" + userId
          )
            .then((data) => {
              // Rest of code stays the same
              if (data.error) {
                alert("Error fetching user details: " + data.error);
                return;
              }
              document.getElementById("userFormTitle").textContent =
                "Edit User";
              document.getElementById("formAction").value = "update";
              document.getElementById("userId").value = data.userId;
              document.getElementById("firstName").value = data.firstName || "";
              document.getElementById("lastName").value = data.lastName || "";
              document.getElementById("phoneNumber").value =
                data.phoneNumber || "";
              document.getElementById("dob").value = data.dob || "";
              document.getElementById("gender").value = data.gender || "";
              document.getElementById("email").value = data.email || "";
              document.getElementById("address").value = data.address || "";
              document.getElementById("role").value = data.role || "";
              document.getElementById("department").value =
                data.department || "";
              // Removed line for setting status field: document.getElementById("status").value = data.status;

              const imgPreview = document.getElementById("imgPreview");
              const iconPreview = document
                .getElementById("profilePreview")
                .querySelector("i");
              if (data.profilePicture) {
                imgPreview.src = contextPath + "/" + data.profilePicture;
                imgPreview.style.display = "block";
                iconPreview.style.display = "none";
              } else {
                imgPreview.src = "#"; // Clear previous image if any
                imgPreview.style.display = "none";
                iconPreview.style.display = "block";
              }

              document.getElementById("password").required = false;
              document.getElementById("confirmPassword").required = false;
              document.getElementById("passwordRequiredSpan").style.display =
                "none";
              document.getElementById(
                "confirmPasswordRequiredSpan"
              ).style.display = "none";
              document.getElementById("passwordHelp").style.display = "block";
              document.getElementById("password").value = "";
              document.getElementById("confirmPassword").value = "";

              openModal(userFormModal);
            })
            .catch((error) => {
              console.error("Error in fetchUserAndPopulateForm:", error);
              alert(
                "Could not load user details for editing: " + error.message
              );
            });
        }

        // View User buttons
        document.querySelectorAll(".view-btn").forEach((button) => {
          button.addEventListener("click", function () {
            const userId = this.getAttribute("data-id");
            fetchWithJsonErrorHandling(
              contextPath + "/users?action=getUserDetails&id=" + userId
            )
              .then((data) => {
                if (data.error) {
                  alert("Error fetching user details: " + data.error);
                  return;
                }
                const modalBody = document.getElementById("viewUserModalBody");
                const profilePicUrl = data.profilePicture
                  ? contextPath + "/" + data.profilePicture
                  : contextPath + "/assets/images/avatars/default-avatar.png";

                // Avoid template literals with JSP expressions by concatenating instead
                modalBody.innerHTML =
                  '<div class="user-profile-header">' +
                  '<div class="user-avatar-large">' +
                  '<img src="' +
                  profilePicUrl +
                  '" alt="' +
                  (data.firstName || "") +
                  '" onerror="this.onerror=null;this.src=\'' +
                  contextPath +
                  "/assets/images/avatars/default-avatar.png';\"/>" +
                  "</div>" +
                  '<div class="user-profile-info">' +
                  "<h3>" +
                  (data.firstName || "") +
                  " " +
                  (data.lastName || "") +
                  "</h3>" +
                  '<span class="badge badge-' +
                  ((data.role || "").toLowerCase() === "admin"
                    ? "admin"
                    : "staff") +
                  '">' +
                  (data.role || "N/A") +
                  "</span>" +
                  "<p>" +
                  (data.department || "N/A") +
                  "</p>" +
                  "</div>" +
                  "</div>" +
                  '<div class="info-group">' +
                  "<h4>Personal Information</h4>" +
                  '<div class="info-row"><div class="info-label">User ID:</div><div class="info-value">USR-' +
                  String(data.userId || "").padStart(3, "0") +
                  "</div></div>" +
                  '<div class="info-row"><div class="info-label">Full Name:</div><div class="info-value">' +
                  (data.firstName || "") +
                  " " +
                  (data.lastName || "") +
                  "</div></div>" +
                  '<div class="info-row"><div class="info-label">Email:</div><div class="info-value">' +
                  (data.email || "N/A") +
                  "</div></div>" +
                  '<div class="info-row"><div class="info-label">Phone:</div><div class="info-value">' +
                  (data.phoneNumber || "N/A") +
                  "</div></div>" +
                  '<div class="info-row"><div class="info-label">DOB:</div><div class="info-value">' +
                  (data.dob || "N/A") +
                  "</div></div>" +
                  '<div class="info-row"><div class="info-label">Gender:</div><div class="info-value">' +
                  (data.gender || "N/A") +
                  "</div></div>" +
                  '<div class="info-row"><div class="info-label">Address:</div><div class="info-value">' +
                  (data.address || "N/A") +
                  "</div></div>" +
                  "</div>" +
                  '<div class="info-group">' +
                  "<h4>Account Information</h4>" +
                  '<div class="info-row"><div class="info-label">Role:</div><div class="info-value">' +
                  (data.role || "N/A") +
                  "</div></div>" +
                  '<div class="info-row"><div class="info-label">Department:</div><div class="info-value">' +
                  (data.department || "N/A") +
                  "</div></div>" +
                  "</div>";

                document
                  .querySelector("#viewUserModal .edit-from-view-btn")
                  .setAttribute("data-id", data.userId);
                openModal(viewUserModal);
              })
              .catch((error) => {
                console.error("Error in view button handler:", error);
                alert(
                  "Could not load user details for viewing: " + error.message
                );
              });
          });
        });

        // Delete User buttons
        document.querySelectorAll(".delete-btn").forEach((button) => {
          button.addEventListener("click", function () {
            const userId = this.getAttribute("data-id");
            const userName = this.getAttribute("data-name");
            document.getElementById("userIdToDelete").value = userId;
            document.getElementById("userNameToDelete").textContent = userName;
            openModal(deleteConfirmModal);
          });
        });

        // User Form submission validation
        // ... (existing validation logic, no changes needed for status removal here) ...
        const userForm = document.getElementById("userForm");
        userForm.addEventListener("submit", function (event) {
          const action = document.getElementById("formAction").value;
          const password = document.getElementById("password").value;
          const confirmPassword =
            document.getElementById("confirmPassword").value;

          if (action === "update") {
            if (password || confirmPassword) {
              if (password !== confirmPassword) {
                alert("Passwords do not match.");
                event.preventDefault();
                return;
              }
              if (password.length > 0 && password.length < 6) {
                alert("Password must be at least 6 characters long.");
                event.preventDefault();
                return;
              }
            }
          } else {
            if (password !== confirmPassword) {
              alert("Passwords do not match.");
              event.preventDefault();
              return;
            }
            if (!password || password.length < 6) {
              alert(
                "Password is required and must be at least 6 characters long."
              );
              event.preventDefault();
              return;
            }
          }
        });

        // Escape key to close modals
        document.addEventListener("keydown", function (e) {
          if (e.key === "Escape") {
            closeAllModals();
          }
        });
      });

      function previewImage(event) {
        // ... (existing previewImage function) ...
        const reader = new FileReader();
        const imageField = document.getElementById("imgPreview");
        const iconPreview = document
          .getElementById("profilePreview")
          .querySelector("i");

        reader.onload = function () {
          if (reader.readyState == 2) {
            imageField.src = reader.result;
            imageField.style.display = "block";
            iconPreview.style.display = "none";
          }
        };
        if (event.target.files[0]) {
          reader.readAsDataURL(event.target.files[0]);
        } else {
          imageField.src = "#";
          imageField.style.display = "none";
          iconPreview.style.display = "block";
        }
      }

      // Search/filter logic
      document
        .getElementById("searchUsers")
        ?.addEventListener("input", applyFilters);
      document
        .getElementById("filterRole")
        ?.addEventListener("change", applyFilters);
      // Removed event listener for filterStatus
      document.getElementById("resetFilters")?.addEventListener("click", () => {
        document.getElementById("searchUsers").value = "";
        document.getElementById("filterRole").value = "all";
        // Removed reset for filterStatus
        applyFilters();
      });

      function applyFilters() {
        const searchTerm = document
          .getElementById("searchUsers")
          .value.toLowerCase();
        const roleFilter = document.getElementById("filterRole").value;
        // Removed statusFilter
        let visibleCount = 0;

        document.querySelectorAll("#usersTableBody tr").forEach((row) => {
          if (!row.hasAttribute("data-user-id")) {
            if (row.querySelector(".empty-state")) row.style.display = "none";
            return;
          }

          const userNameElement = row.querySelector(".user-name");
          const userEmailElement = row.querySelector(".user-email-small");

          const name = userNameElement
            ? userNameElement.textContent.toLowerCase()
            : "";
          const email = userEmailElement
            ? userEmailElement.textContent.toLowerCase()
            : "";

          const userRole = row.getAttribute("data-role");
          // Removed userStatus

          const matchesSearch =
            name.includes(searchTerm) || email.includes(searchTerm);
          const matchesRole = roleFilter === "all" || userRole === roleFilter;
          // Removed matchesStatus

          if (matchesSearch && matchesRole) {
            // Updated condition
            row.style.display = "";
            visibleCount++;
          } else {
            row.style.display = "none";
          }
        });

        const emptyStateRow = document
          .querySelector("#usersTableBody .empty-state")
          ?.closest("tr");
        if (emptyStateRow) {
          if (
            visibleCount === 0 &&
            document.querySelectorAll("#usersTableBody tr[data-user-id]")
              .length > 0
          ) {
            emptyStateRow.style.display = "";
            emptyStateRow.querySelector(".empty-state-message").textContent =
              "No users match your current filter criteria.";
          } else if (
            document.querySelectorAll("#usersTableBody tr[data-user-id]")
              .length === 0
          ) {
            emptyStateRow.style.display = "";
            emptyStateRow.querySelector(".empty-state-message").textContent =
              "There are no users in the system yet.";
          } else {
            emptyStateRow.style.display = "none";
          }
        }
      }
    </script>
  </body>
</html>