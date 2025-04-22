<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
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
  </head>
  <body>
    <jsp:include page="components/Sidebar.jsp" />

    <!-- Main Content -->
    <div class="main-content">
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
          <div class="stat-value">5</div>
          <div class="stat-label">Admin Users</div>
        </div>
        <div class="stat-card">
          <div class="stat-icon staff-icon">
            <i class="bi bi-person-badge"></i>
          </div>
          <div class="stat-value">18</div>
          <div class="stat-label">Staff Users</div>
        </div>
        <div class="stat-card">
          <div class="stat-icon active-icon">
            <i class="bi bi-person-check"></i>
          </div>
          <div class="stat-value">22</div>
          <div class="stat-label">Active Users</div>
        </div>
      </div>

      <!-- View Toggle -->
      <div class="view-toggle">
        <button class="view-toggle-btn active" data-view="all">
          All Users
        </button>
        <button class="view-toggle-btn" data-view="admin">Admins</button>
        <button class="view-toggle-btn" data-view="staff">Staff</button>
        <button class="view-toggle-btn" data-view="active">Active</button>
        <button class="view-toggle-btn" data-view="inactive">Inactive</button>
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
                placeholder="Search users..."
                id="searchUsers"
              />
            </div>
          </div>
          <div class="col-md-3">
            <select class="form-control" id="filterRole">
              <option value="all" selected>All Roles</option>
              <option value="admin">Admin</option>
              <option value="staff">Staff</option>
            </select>
          </div>
          <div class="col-md-3">
            <select class="form-control" id="filterStatus">
              <option value="all" selected>All Status</option>
              <option value="active">Active</option>
              <option value="inactive">Inactive</option>
            </select>
          </div>
          <div class="col-md-2">
            <button class="btn btn-outline" id="resetFilters">Reset</button>
          </div>
        </div>
      </div>

      <!-- Users Table -->
      <div class="card">
        <div class="card-header">
          <h2 class="card-title">All Users</h2>
          <span class="badge badge-primary">Total: 23 Users</span>
        </div>
        <div class="card-body">
          <div class="table-container">
            <table>
              <thead>
                <tr>
                  <th>User ID</th>
                  <th>Name</th>
                  <th>Email</th>
                  <th>Role</th>
                  <th>Department</th>
                  <th>Status</th>
                  <th>Last Login</th>
                  <th>Actions</th>
                </tr>
              </thead>
              <tbody>
                <tr class="role-admin">
                  <td>USR-001</td>
                  <td>
                    <div class="user-info-cell">
                      <div class="user-avatar">
                        <img
                          src="${pageContext.request.contextPath}/assets/images/avatars/admin1.jpg"
                          alt="Admin User"
                        />
                      </div>
                      <div>John Doe</div>
                    </div>
                  </td>
                  <td>john.doe@thenest.com</td>
                  <td><span class="badge badge-admin">Admin</span></td>
                  <td>IT Department</td>
                  <td><span class="badge badge-success">Active</span></td>
                  <td>Today, 09:45 AM</td>
                  <td>
                    <div class="action-buttons">
                      <button class="action-btn view-btn" data-id="USR-001">
                        <i class="bi bi-eye"></i>
                      </button>
                      <button class="action-btn edit-btn" data-id="USR-001">
                        <i class="bi bi-pencil"></i>
                      </button>
                      <button class="action-btn delete-btn" data-id="USR-001">
                        <i class="bi bi-trash"></i>
                      </button>
                    </div>
                  </td>
                </tr>
                <tr class="role-admin">
                  <td>USR-002</td>
                  <td>
                    <div class="user-info-cell">
                      <div class="user-avatar">
                        <img
                          src="${pageContext.request.contextPath}/assets/images/avatars/admin2.jpg"
                          alt="Admin User"
                        />
                      </div>
                      <div>Jane Smith</div>
                    </div>
                  </td>
                  <td>jane.smith@thenest.com</td>
                  <td><span class="badge badge-admin">Admin</span></td>
                  <td>Finance</td>
                  <td><span class="badge badge-success">Active</span></td>
                  <td>Yesterday, 16:30 PM</td>
                  <td>
                    <div class="action-buttons">
                      <button class="action-btn view-btn" data-id="USR-002">
                        <i class="bi bi-eye"></i>
                      </button>
                      <button class="action-btn edit-btn" data-id="USR-002">
                        <i class="bi bi-pencil"></i>
                      </button>
                      <button class="action-btn delete-btn" data-id="USR-002">
                        <i class="bi bi-trash"></i>
                      </button>
                    </div>
                  </td>
                </tr>
                <tr class="role-staff">
                  <td>USR-003</td>
                  <td>
                    <div class="user-info-cell">
                      <div class="user-avatar">
                        <img
                          src="${pageContext.request.contextPath}/assets/images/avatars/staff1.jpg"
                          alt="Staff User"
                        />
                      </div>
                      <div>Robert Johnson</div>
                    </div>
                  </td>
                  <td>robert.johnson@thenest.com</td>
                  <td><span class="badge badge-staff">Staff</span></td>
                  <td>Operations</td>
                  <td><span class="badge badge-success">Active</span></td>
                  <td>Today, 11:20 AM</td>
                  <td>
                    <div class="action-buttons">
                      <button class="action-btn view-btn" data-id="USR-003">
                        <i class="bi bi-eye"></i>
                      </button>
                      <button class="action-btn edit-btn" data-id="USR-003">
                        <i class="bi bi-pencil"></i>
                      </button>
                      <button class="action-btn delete-btn" data-id="USR-003">
                        <i class="bi bi-trash"></i>
                      </button>
                    </div>
                  </td>
                </tr>
                <tr class="role-staff">
                  <td>USR-004</td>
                  <td>
                    <div class="user-info-cell">
                      <div class="user-avatar">
                        <img
                          src="${pageContext.request.contextPath}/assets/images/avatars/staff2.jpg"
                          alt="Staff User"
                        />
                      </div>
                      <div>Emily Wilson</div>
                    </div>
                  </td>
                  <td>emily.wilson@thenest.com</td>
                  <td><span class="badge badge-staff">Staff</span></td>
                  <td>HR</td>
                  <td><span class="badge badge-danger">Inactive</span></td>
                  <td>3 days ago</td>
                  <td>
                    <div class="action-buttons">
                      <button class="action-btn view-btn" data-id="USR-004">
                        <i class="bi bi-eye"></i>
                      </button>
                      <button class="action-btn edit-btn" data-id="USR-004">
                        <i class="bi bi-pencil"></i>
                      </button>
                      <button class="action-btn delete-btn" data-id="USR-004">
                        <i class="bi bi-trash"></i>
                      </button>
                    </div>
                  </td>
                </tr>
                <tr class="role-staff">
                  <td>USR-005</td>
                  <td>
                    <div class="user-info-cell">
                      <div class="user-avatar">
                        <img
                          src="${pageContext.request.contextPath}/assets/images/avatars/staff3.jpg"
                          alt="Staff User"
                        />
                      </div>
                      <div>Michael Brown</div>
                    </div>
                  </td>
                  <td>michael.brown@thenest.com</td>
                  <td><span class="badge badge-staff">Staff</span></td>
                  <td>Marketing</td>
                  <td><span class="badge badge-success">Active</span></td>
                  <td>Today, 08:15 AM</td>
                  <td>
                    <div class="action-buttons">
                      <button class="action-btn view-btn" data-id="USR-005">
                        <i class="bi bi-eye"></i>
                      </button>
                      <button class="action-btn edit-btn" data-id="USR-005">
                        <i class="bi bi-pencil"></i>
                      </button>
                      <button class="action-btn delete-btn" data-id="USR-005">
                        <i class="bi bi-trash"></i>
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
              <a href="#" class="page-link"
                ><i class="bi bi-chevron-double-left"></i
              ></a>
            </li>
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
            <li class="page-item">
              <a href="#" class="page-link"
                ><i class="bi bi-chevron-double-right"></i
              ></a>
            </li>
          </ul>
        </div>
      </div>
    </div>

    <!-- Modal Backdrop -->
    <div class="modal-backdrop" id="modalBackdrop"></div>

    <!-- View User Modal -->
    <div class="modal" id="viewUserModal">
      <div class="modal-header">
        <h3 class="modal-title">User Details</h3>
        <button class="modal-close" id="closeViewModal">&times;</button>
      </div>
      <div class="modal-body">
        <div class="user-profile-header">
          <div class="user-avatar-large">
            <img
              src="${pageContext.request.contextPath}/assets/images/avatars/admin1.jpg"
              alt="User Avatar"
            />
          </div>
          <div class="user-profile-info">
            <h3>John Doe</h3>
            <span class="badge badge-admin">Administrator</span>
            <p>IT Department</p>
          </div>
        </div>

        <div class="info-group">
          <h4>Personal Information</h4>
          <div class="info-row">
            <div class="info-label">User ID:</div>
            <div class="info-value">USR-001</div>
          </div>
          <div class="info-row">
            <div class="info-label">Full Name:</div>
            <div class="info-value">John Doe</div>
          </div>
          <div class="info-row">
            <div class="info-label">Email:</div>
            <div class="info-value">john.doe@thenest.com</div>
          </div>
          <div class="info-row">
            <div class="info-label">Phone Number:</div>
            <div class="info-value">+44 7123 456789</div>
          </div>
          <div class="info-row">
            <div class="info-label">Date of Birth:</div>
            <div class="info-value">15 April 1985</div>
          </div>
          <div class="info-row">
            <div class="info-label">Gender:</div>
            <div class="info-value">Male</div>
          </div>
          <div class="info-row">
            <div class="info-label">Address:</div>
            <div class="info-value">123 Main Street, London, UK</div>
          </div>
        </div>

        <div class="info-group">
          <h4>Account Information</h4>
          <div class="info-row">
            <div class="info-label">Role:</div>
            <div class="info-value">Administrator</div>
          </div>
          <div class="info-row">
            <div class="info-label">Department:</div>
            <div class="info-value">IT Department</div>
          </div>
          <div class="info-row">
            <div class="info-label">Status:</div>
            <div class="info-value">
              <span class="badge badge-success">Active</span>
            </div>
          </div>
          <div class="info-row">
            <div class="info-label">Created On:</div>
            <div class="info-value">10 January 2023</div>
          </div>
          <div class="info-row">
            <div class="info-label">Last Login:</div>
            <div class="info-value">Today, 09:45 AM</div>
          </div>
        </div>
      </div>
      <div class="modal-footer">
        <button class="btn btn-outline" id="closeViewModalBtn">Close</button>
        <button class="btn btn-primary edit-btn" data-id="USR-001">
          <i class="bi bi-pencil"></i> Edit User
        </button>
      </div>
    </div>

    <!-- Add/Edit User Modal -->
    <div class="modal large-modal" id="userFormModal">
      <div class="modal-header">
        <h3 class="modal-title" id="userFormTitle">Add New User</h3>
        <button class="modal-close" id="closeFormModal">&times;</button>
      </div>
      <div class="modal-body">
        <form id="userForm">
          <input type="hidden" id="userId" value="" />

          <div class="form-section">
            <h4>Personal Information</h4>
            <div class="row">
              <div class="col-md-6">
                <div class="form-group">
                  <label for="firstName"
                    >First Name <span class="required">*</span></label
                  >
                  <input
                    type="text"
                    class="form-control"
                    id="firstName"
                    required
                  />
                </div>
              </div>
              <div class="col-md-6">
                <div class="form-group">
                  <label for="lastName"
                    >Last Name <span class="required">*</span></label
                  >
                  <input
                    type="text"
                    class="form-control"
                    id="lastName"
                    required
                  />
                </div>
              </div>
            </div>

            <div class="row">
              <div class="col-md-6">
                <div class="form-group">
                  <label for="phoneNumber"
                    >Phone Number <span class="required">*</span></label
                  >
                  <input
                    type="tel"
                    class="form-control"
                    id="phoneNumber"
                    required
                  />
                </div>
              </div>
              <div class="col-md-6">
                <div class="form-group">
                  <label for="dateOfBirth"
                    >Date of Birth <span class="required">*</span></label
                  >
                  <input
                    type="date"
                    class="form-control"
                    id="dateOfBirth"
                    required
                  />
                </div>
              </div>
            </div>

            <div class="row">
              <div class="col-md-6">
                <div class="form-group">
                  <label for="gender"
                    >Gender <span class="required">*</span></label
                  >
                  <select class="form-control" id="gender" required>
                    <option value="">Select Gender</option>
                    <option value="male">Male</option>
                    <option value="female">Female</option>
                    <option value="other">Other</option>
                    <option value="prefer-not-to-say">Prefer not to say</option>
                  </select>
                </div>
              </div>
              <div class="col-md-6">
                <div class="form-group">
                  <label for="email"
                    >Email Address <span class="required">*</span></label
                  >
                  <input
                    type="email"
                    class="form-control"
                    id="email"
                    required
                  />
                </div>
              </div>
            </div>

            <div class="form-group">
              <label for="address"
                >Address <span class="required">*</span></label
              >
              <textarea
                class="form-control"
                id="address"
                rows="3"
                required
              ></textarea>
            </div>
          </div>

          <div class="form-section">
            <h4>Account Information</h4>
            <div class="row">
              <div class="col-md-6">
                <div class="form-group">
                  <label for="role">Role <span class="required">*</span></label>
                  <select class="form-control" id="role" required>
                    <option value="">Select Role</option>
                    <option value="admin">Administrator</option>
                    <option value="staff">Staff</option>
                  </select>
                </div>
              </div>
              <div class="col-md-6">
                <div class="form-group">
                  <label for="department"
                    >Department <span class="required">*</span></label
                  >
                  <select class="form-control" id="department" required>
                    <option value="">Select Department</option>
                    <option value="IT">IT Department</option>
                    <option value="Finance">Finance</option>
                    <option value="HR">HR</option>
                    <option value="Marketing">Marketing</option>
                    <option value="Operations">Operations</option>
                  </select>
                </div>
              </div>
            </div>

            <div class="form-group">
              <label for="profilePicture">Profile Picture</label>
              <div class="file-upload-container">
                <div class="file-upload-preview" id="profilePreview">
                  <i class="bi bi-person-circle"></i>
                </div>
                <div class="file-upload-controls">
                  <input
                    type="file"
                    class="form-control-file"
                    id="profilePicture"
                    accept="image/*"
                  />
                  <button
                    type="button"
                    class="btn btn-outline btn-sm"
                    id="uploadProfileBtn"
                  >
                    <i class="bi bi-upload"></i> Upload Photo
                  </button>
                </div>
              </div>
            </div>

            <div class="row password-fields">
              <div class="col-md-6">
                <div class="form-group">
                  <label for="password"
                    >Password <span class="required">*</span></label
                  >
                  <div class="password-input-group">
                    <input
                      type="password"
                      class="form-control"
                      id="password"
                      required
                    />
                    <button type="button" class="password-toggle">
                      <i class="bi bi-eye"></i>
                    </button>
                  </div>
                </div>
              </div>
              <div class="col-md-6">
                <div class="form-group">
                  <label for="confirmPassword"
                    >Confirm Password <span class="required">*</span></label
                  >
                  <div class="password-input-group">
                    <input
                      type="password"
                      class="form-control"
                      id="confirmPassword"
                      required
                    />
                    <button type="button" class="password-toggle">
                      <i class="bi bi-eye"></i>
                    </button>
                  </div>
                </div>
              </div>
            </div>

            <div class="form-group">
              <div class="checkbox-group">
                <input type="checkbox" id="activeStatus" checked />
                <label for="activeStatus">Active Account</label>
              </div>
            </div>
          </div>
        </form>
      </div>
      <div class="modal-footer">
        <button class="btn btn-outline" id="cancelFormBtn">Cancel</button>
        <button class="btn btn-primary" id="saveUserBtn">
          <i class="bi bi-save"></i> Save User
        </button>
      </div>
    </div>

    <!-- Delete Confirmation Modal -->
    <div class="modal" id="deleteConfirmModal">
      <div class="modal-header">
        <h3 class="modal-title">Confirm Delete</h3>
        <button class="modal-close" id="closeDeleteModal">&times;</button>
      </div>
      <div class="modal-body">
        <p>
          Are you sure you want to delete this user? This action cannot be
          undone.
        </p>
        <div class="alert alert-warning">
          <i class="bi bi-exclamation-triangle"></i>
          <span
            >Warning: All data associated with this user will be permanently
            removed.</span
          >
        </div>
      </div>
      <div class="modal-footer">
        <button class="btn btn-outline" id="cancelDeleteBtn">Cancel</button>
        <button class="btn btn-danger" id="confirmDeleteBtn">
          <i class="bi bi-trash"></i> Delete User
        </button>
      </div>
    </div>

    <!-- JavaScript -->
    <script>
      document.addEventListener("DOMContentLoaded", function () {
        // Modal elements
        const modalBackdrop = document.getElementById("modalBackdrop");
        const viewUserModal = document.getElementById("viewUserModal");
        const userFormModal = document.getElementById("userFormModal");
        const deleteConfirmModal =
          document.getElementById("deleteConfirmModal");

        // View user modal
        const viewBtns = document.querySelectorAll(".view-btn");
        viewBtns.forEach((btn) => {
          btn.addEventListener("click", function () {
            const userId = this.getAttribute("data-id");
            viewUserModal.style.display = "block";
            modalBackdrop.style.display = "block";
          });
        });

        // Close view modal
        document
          .getElementById("closeViewModal")
          .addEventListener("click", function () {
            viewUserModal.style.display = "none";
            modalBackdrop.style.display = "none";
          });

        document
          .getElementById("closeViewModalBtn")
          .addEventListener("click", function () {
            viewUserModal.style.display = "none";
            modalBackdrop.style.display = "none";
          });

        // Add new user
        document
          .getElementById("newUserBtn")
          .addEventListener("click", function () {
            document.getElementById("userFormTitle").textContent =
              "Add New User";
            document.getElementById("userForm").reset();
            document.getElementById("userId").value = "";
            document.querySelector(".password-fields").style.display = "flex";
            userFormModal.style.display = "block";
            modalBackdrop.style.display = "block";
          });

        // Edit user
        const editBtns = document.querySelectorAll(".edit-btn");
        editBtns.forEach((btn) => {
          btn.addEventListener("click", function () {
            const userId = this.getAttribute("data-id");
            document.getElementById("userFormTitle").textContent = "Edit User";
            document.getElementById("userId").value = userId;
            document.querySelector(".password-fields").style.display = "none";
            viewUserModal.style.display = "none";

            userFormModal.style.display = "block";
            modalBackdrop.style.display = "block";
          });
        });

        // Close user form modal
        document
          .getElementById("closeFormModal")
          .addEventListener("click", function () {
            userFormModal.style.display = "none";
            modalBackdrop.style.display = "none";
          });

        document
          .getElementById("cancelFormBtn")
          .addEventListener("click", function () {
            userFormModal.style.display = "none";
            modalBackdrop.style.display = "none";
          });

        // Delete user
        const deleteBtns = document.querySelectorAll(".delete-btn");
        deleteBtns.forEach((btn) => {
          btn.addEventListener("click", function () {
            const userId = this.getAttribute("data-id");
            document
              .getElementById("confirmDeleteBtn")
              .setAttribute("data-id", userId);
            deleteConfirmModal.style.display = "block";
            modalBackdrop.style.display = "block";
          });
        });

        // Close delete modal
        document
          .getElementById("closeDeleteModal")
          .addEventListener("click", function () {
            deleteConfirmModal.style.display = "none";
            modalBackdrop.style.display = "none";
          });

        document
          .getElementById("cancelDeleteBtn")
          .addEventListener("click", function () {
            deleteConfirmModal.style.display = "none";
            modalBackdrop.style.display = "none";
          });

        // Confirm delete
        document
          .getElementById("confirmDeleteBtn")
          .addEventListener("click", function () {
            const userId = this.getAttribute("data-id");
            alert(`User ${userId} has been deleted.`);
            deleteConfirmModal.style.display = "none";
            modalBackdrop.style.display = "none";
          });

        // Save user
        document
          .getElementById("saveUserBtn")
          .addEventListener("click", function () {
            const form = document.getElementById("userForm");
            if (form.checkValidity()) {
              const userId = document.getElementById("userId").value;
              const isNewUser = !userId;
              if (isNewUser) {
                alert("New user has been created successfully!");
              } else {
                alert(`User ${userId} has been updated successfully!`);
              }

              userFormModal.style.display = "none";
              modalBackdrop.style.display = "none";
            } else {
              form.reportValidity();
            }
          });

        // Toggle password visibility
        const passwordToggles = document.querySelectorAll(".password-toggle");
        passwordToggles.forEach((toggle) => {
          toggle.addEventListener("click", function () {
            const passwordField = this.previousElementSibling;
            const type = passwordField.getAttribute("type");

            if (type === "password") {
              passwordField.setAttribute("type", "text");
              this.innerHTML = '<i class="bi bi-eye-slash"></i>';
            } else {
              passwordField.setAttribute("type", "password");
              this.innerHTML = '<i class="bi bi-eye"></i>';
            }
          });
        });

        document
          .getElementById("profilePicture")
          .addEventListener("change", function () {
            const file = this.files[0];
            if (file) {
              const reader = new FileReader();
              reader.onload = function (e) {
                const preview = document.getElementById("profilePreview");
                preview.innerHTML = `<img src="${e.target.result}" alt="Profile Preview">`;
              };
              reader.readAsDataURL(file);
            }
          });

        document
          .getElementById("uploadProfileBtn")
          .addEventListener("click", function () {
            document.getElementById("profilePicture").click();
          });

        // View toggle buttons
        const viewToggleBtns = document.querySelectorAll(".view-toggle-btn");
        viewToggleBtns.forEach((btn) => {
          btn.addEventListener("click", function () {
            viewToggleBtns.forEach((b) => b.classList.remove("active"));
            this.classList.add("active");

            const view = this.getAttribute("data-view");
            document.querySelector(".card-title").textContent =
              view === "all"
                ? "All Users"
                : view === "admin"
                ? "Admin Users"
                : view === "staff"
                ? "Staff Users"
                : view === "active"
                ? "Active Users"
                : "Inactive Users";
          });
        });

        // Search functionality
        document
          .getElementById("searchUsers")
          .addEventListener("input", function () {
            const searchTerm = this.value.toLowerCase();
          });

        // Role filter
        document
          .getElementById("filterRole")
          .addEventListener("change", function () {
            const role = this.value;
          });

        // Status filter
        document
          .getElementById("filterStatus")
          .addEventListener("change", function () {
            const status = this.value;
          });

        // Reset filters
        document
          .getElementById("resetFilters")
          .addEventListener("click", function () {
            document.getElementById("searchUsers").value = "";
            document.getElementById("filterRole").value = "all";
            document.getElementById("filterStatus").value = "all";
          });
      });
    </script>
  </body>
</html>
