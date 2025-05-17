<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>My Profile - The Nest Inventory System</title>
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
      href="${pageContext.request.contextPath}/resources/css/Profile.css"
    />
  </head>
  <body>
    <jsp:include page="components/Sidebar.jsp" />

    <!-- Main Content -->
    <div class="main-content">
      <div class="page-header">
        <h1 class="page-title">My Profile</h1>
        <button class="btn btn-primary" id="saveChangesBtn">
          <i class="bi bi-check-circle"></i> Save Changes
        </button>
      </div>

      <!-- Profile Content -->
      <div class="profile-container">
        <!-- Profile Card -->
        <div class="profile-card">
          <div class="profile-header">
            <div class="profile-avatar">
              <img
                src="${pageContext.request.contextPath}/assets/images/avatars/admin1.jpg"
                alt="Profile Picture"
              />
              <div class="avatar-overlay">
                <i class="bi bi-camera"></i>
              </div>
            </div>
            <div class="profile-info">
              <h2 class="profile-name">John Doe</h2>
              <span class="badge badge-admin">Administrator</span>
              <p class="profile-email">john.doe@thenest.com</p>
            </div>
          </div>
          <div class="profile-stats">
            <div class="stat-item">
              <div class="stat-value">15</div>
              <div class="stat-label">Requests</div>
            </div>
            <div class="stat-item">
              <div class="stat-value">42</div>
              <div class="stat-label">Approvals</div>
            </div>
            <div class="stat-item">
              <div class="stat-value">128</div>
              <div class="stat-label">Items Managed</div>
            </div>
          </div>
        </div>

        <!-- Profile Tabs -->
        <div class="profile-tabs">
          <div class="tab-header">
            <button class="tab-btn active" data-tab="personal">
              <i class="bi bi-person"></i> Personal Information
            </button>
            <button class="tab-btn" data-tab="password">
              <i class="bi bi-shield-lock"></i> Change Password
            </button>
          </div>

          <!-- Tab Content -->
          <div class="tab-content">
            <!-- Personal Information Tab -->
            <div class="tab-pane active" id="personal-tab">
              <div class="form-section">
                <h3 class="section-title">Personal Details</h3>
                <div class="form-row">
                  <div class="form-group">
                    <label for="firstName">First Name</label>
                    <input
                      type="text"
                      id="firstName"
                      class="form-control"
                      value="John"
                    />
                  </div>
                  <div class="form-group">
                    <label for="lastName">Last Name</label>
                    <input
                      type="text"
                      id="lastName"
                      class="form-control"
                      value="Doe"
                    />
                  </div>
                </div>
                <div class="form-row">
                  <div class="form-group">
                    <label for="email">Email Address</label>
                    <input
                      type="email"
                      id="email"
                      class="form-control"
                      value="john.doe@thenest.com"
                    />
                  </div>
                  <div class="form-group">
                    <label for="phone">Phone Number</label>
                    <input
                      type="tel"
                      id="phone"
                      class="form-control"
                      value="+1 (555) 123-4567"
                    />
                  </div>
                </div>
                <div class="form-row">
                  <div class="form-group">
                    <label for="department">Department</label>
                    <select id="department" class="form-control">
                      <option value="it" selected>IT Department</option>
                      <option value="hr">HR Department</option>
                      <option value="finance">Finance Department</option>
                      <option value="operations">Operations</option>
                      <option value="marketing">Marketing</option>
                    </select>
                  </div>
                  <div class="form-group">
                    <label for="position">Position</label>
                    <input
                      type="text"
                      id="position"
                      class="form-control"
                      value="System Administrator"
                    />
                  </div>
                </div>
              </div>
            </div>

            <!-- Change Password Tab -->
            <div class="tab-pane" id="password-tab">
              <div class="form-section">
                <h3 class="section-title">Change Password</h3>
                <div class="password-requirements">
                  <p>
                    <i class="bi bi-info-circle"></i> Password must be at least
                    8 characters long and include:
                  </p>
                  <ul>
                    <li>At least one uppercase letter</li>
                    <li>At least one lowercase letter</li>
                    <li>At least one number</li>
                    <li>At least one special character</li>
                  </ul>
                </div>
                <div class="form-group">
                  <label for="currentPassword">Current Password</label>
                  <div class="password-input-group">
                    <input
                      type="password"
                      id="currentPassword"
                      class="form-control"
                      placeholder="Enter your current password"
                    />
                    <button class="password-toggle" type="button">
                      <i class="bi bi-eye"></i>
                    </button>
                  </div>
                </div>
                <div class="form-group">
                  <label for="newPassword">New Password</label>
                  <div class="password-input-group">
                    <input
                      type="password"
                      id="newPassword"
                      class="form-control"
                      placeholder="Enter your new password"
                    />
                    <button class="password-toggle" type="button">
                      <i class="bi bi-eye"></i>
                    </button>
                  </div>
                  <div class="password-strength">
                    <div class="strength-meter">
                      <div class="strength-bar" style="width: 70%"></div>
                    </div>
                    <span class="strength-text">Strong</span>
                  </div>
                </div>
                <div class="form-group">
                  <label for="confirmPassword">Confirm New Password</label>
                  <div class="password-input-group">
                    <input
                      type="password"
                      id="confirmPassword"
                      class="form-control"
                      placeholder="Confirm your new password"
                    />
                    <button class="password-toggle" type="button">
                      <i class="bi bi-eye"></i>
                    </button>
                  </div>
                </div>
                <button class="btn btn-primary" id="changePasswordBtn">
                  <i class="bi bi-shield-check"></i> Update Password
                </button>
              </div>
            </div>

            </div>
    </div>

    <!-- JavaScript -->
    <script>
      document.addEventListener("DOMContentLoaded", function () {
        // Tab switching functionality
        const tabButtons = document.querySelectorAll(".tab-btn");
        const tabPanes = document.querySelectorAll(".tab-pane");

        tabButtons.forEach((button) => {
          button.addEventListener("click", function () {
            // Remove active class from all buttons and panes
            tabButtons.forEach((btn) => btn.classList.remove("active"));
            tabPanes.forEach((pane) => pane.classList.remove("active"));

            // Add active class to clicked button
            this.classList.add("active");

            // Show corresponding tab pane
            const tabId = this.getAttribute("data-tab");
            document.getElementById(tabId + "-tab").classList.add("active");
          });
        });

        // Password visibility toggle
        const passwordToggles = document.querySelectorAll(".password-toggle");

        passwordToggles.forEach((toggle) => {
          toggle.addEventListener("click", function () {
            const passwordInput = this.previousElementSibling;
            const icon = this.querySelector("i");

            if (passwordInput.type === "password") {
              passwordInput.type = "text";
              icon.classList.remove("bi-eye");
              icon.classList.add("bi-eye-slash");
            } else {
              passwordInput.type = "password";
              icon.classList.remove("bi-eye-slash");
              icon.classList.add("bi-eye");
            }
          });
        });

        // Save changes button
        document
          .getElementById("saveChangesBtn")
          .addEventListener("click", function () {
            alert("Profile changes saved successfully!");
          });

        // Change password button
        document
          .getElementById("changePasswordBtn")
          .addEventListener("click", function () {
            const currentPassword =
              document.getElementById("currentPassword").value;
            const newPassword = document.getElementById("newPassword").value;
            const confirmPassword =
              document.getElementById("confirmPassword").value;

            if (!currentPassword || !newPassword || !confirmPassword) {
              alert("Please fill in all password fields.");
              return;
            }

            if (newPassword !== confirmPassword) {
              alert("New password and confirmation do not match.");
              return;
            }

            alert("Password updated successfully!");

            // Clear password fields
            document.getElementById("currentPassword").value = "";
            document.getElementById("newPassword").value = "";
            document.getElementById("confirmPassword").value = "";
          });

        // Avatar upload functionality
        const profileAvatar = document.querySelector(".profile-avatar");

        profileAvatar.addEventListener("click", function () {
          // In a real implementation, this would trigger a file upload dialog
          alert(
            "This would open a file upload dialog to change your profile picture."
          );
        });
      });
    </script>
  </body>
</html>
