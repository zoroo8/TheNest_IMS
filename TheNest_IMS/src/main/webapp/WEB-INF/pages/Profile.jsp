<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

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
	<!-- Message Display Component -->
	<c:if test="${not empty sessionScope.successMessage}">
	    <div class="alert alert-success">
	        <span>${sessionScope.successMessage}</span>
	        <span class="dismiss-btn" onclick="this.parentElement.style.display='none';">&times;</span>
	    </div>
	    <c:remove var="successMessage" scope="session" />
	</c:if>
	
	<c:if test="${not empty sessionScope.errorMessage}">
	    <div class="alert alert-danger">
	        <span>${sessionScope.errorMessage}</span>
	        <span class="dismiss-btn" onclick="this.parentElement.style.display='none';">&times;</span>
	    </div>
	    <c:remove var="errorMessage" scope="session" />
	</c:if>
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
              <form id="avatarForm" method="POST" enctype="multipart/form-data" action="uploadProfileImage">
				  <img
                src="${pageContext.request.contextPath}/uploads/profiles/1747643028873_infinity.jpeg"
                alt="Profile Picture"
              />		  
				</form>
              <div class="avatar-overlay">
                <i class="bi bi-camera"></i>
              </div>
            </div>
            <div class="profile-info">
              <h2 class="profile-name"><c:out value="${user.firstName}" /> <c:out value="${user.lastName}" /></h2>
              <c:choose>
				    <c:when test="${user.role == 'admin'}">
				        <span class="badge badge-admin">Administrator</span>
				    </c:when>
				    <c:when test="${user.role == 'staff'}">
				        <span class="badge badge-staff">Staff</span>
				    </c:when>
				    <c:otherwise>
				        <span class="badge badge-user">User</span>
				    </c:otherwise>
				</c:choose>
              <p class="profile-email">${user.email}</p>
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
            <form id="profileForm" action="${pageContext.request.contextPath}/profile" method="post">
             <input type="hidden" name="action" value="updatePersonal" />
              <div class="form-section">
                <h3 class="section-title">Personal Details</h3>
                <div class="form-row">
                  <div class="form-group">
                    <label for="firstName">First Name</label>
                    <input
                      type="text"
                      id="firstName"
               	      name="firstName"
                      class="form-control"
       				  value="${user.firstName}"
                    />
                  </div>
                  <div class="form-group">
                    <label for="lastName">Last Name</label>
                    <input
                      type="text"
                      id="lastName"
                      name="lastName"
                      class="form-control"
                      value="${user.lastName}"
                    />
                  </div>
                </div>
                <div class="form-row">
                  <div class="form-group">
                    <label for="email">Email Address</label>
                    <input
                      type="email"
                      id="email"
                      name="email"
                      class="form-control"
                      value="${user.email}"
                    />
                  </div>
                  <div class="form-group">
                    <label for="phone">Phone Number</label>
                    <input
                      type="tel"
                      id="phone"
                      name="phone"
                      class="form-control"
                      value="${user.phoneNumber}"
                    />
                  </div>
                </div>
                <div class="form-row">
                  <div class="form-group">
                    <label for="department">Department</label>
                    <select id="department" name="department" class="form-control">
			        <option value="it" ${user.department == 'it' ? 'selected' : ''}>IT Department</option>
			        <option value="hr" ${user.department == 'hr' ? 'selected' : ''}>HR Department</option>
			        <option value="finance" ${user.department == 'finance' ? 'selected' : ''}>Finance Department</option>
			        <option value="operations" ${user.department == 'operations' ? 'selected' : ''}>Operations</option>
			        <option value="marketing" ${user.department == 'marketing' ? 'selected' : ''}>Marketing</option>
			      </select>
                  </div>
                  
                  <div class="form-group">
                    <label for="position">Position</label>
                    <select class="form-control" id="position" name="position" required>
			        	<option value="">Select Position</option>
			        	<option value="admin" ${user.role == 'admin' ? 'selected' : ''}>System Administrator</option>
			        	<option value="staff" ${user.role == 'staff' ? 'selected' : ''}>Warehouse Staff</option>
			       </select>
                  </div>
                </div>
              </div>
              </form>
            </div>

            <!-- Change Password Tab -->
            <div class="tab-pane" id="password-tab">
            <form id="passwordForm" method="POST" action="#">
            <input type="hidden" name="action" value="changePassword" />
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
                      name="current_password"
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
                      name="new_password"
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
                      name="confirm_password"
                      class="form-control"
                      placeholder="Confirm your new password"
                    />
                  
                  </div>
                </div>
                
              </div>
             </form>
            </div>
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
        
     // Auto-dismiss alerts after 5 seconds
        const alerts = document.querySelectorAll(".alert");
        alerts.forEach((alert) => {
            setTimeout(() => {
                if (alert && alert.parentNode) {
                    alert.style.display = "none";
                }
            }, 5000);
        });
        
        // Save changes button
        document
          .getElementById("saveChangesBtn")
          .addEventListener("click", function () {
        	const profileForm = document.getElementById("profileForm");
        	const passwordForm = document.getElementById("passwordForm");
        	if (profileForm.offsetParent !== null) {
        	      profileForm.submit(); // profile form is visible
        	    } else if (passwordForm.offsetParent !== null) {
        	      passwordForm.submit(); // password form is visible
        	    }
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
