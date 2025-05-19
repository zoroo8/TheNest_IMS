<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>

<div class="modal-backdrop" id="logoutModalBackdrop"></div>
<div class="modal" id="logoutModal">
  <div class="modal-content">
    <div class="modal-header">
      <h3 class="modal-title">Confirm Logout</h3>
      <button class="modal-close" id="closeLogoutModal">&times;</button>
    </div>
    <div class="modal-body">
      <p>Are you sure you want to logout?</p>
      <p class="text-muted">
        You will need to login again to access the system.
      </p>
    </div>
    <div class="modal-footer">
      <button class="btn btn-outline" id="cancelLogout">No, Stay Here</button>
      <button class="btn btn-primary" id="confirmLogout">
        <i class="bi bi-box-arrow-right"></i> Yes, Logout
      </button>
    </div>
  </div>
</div>

<style>
  .modal-backdrop {
    display: none;
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background: rgba(0, 0, 0, 0.5);
    z-index: 1050;
  }

  .modal {
    display: none;
    position: fixed;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%);
    background: var(--white);
    border-radius: var(--border-radius);
    box-shadow: var(--shadow-lg);
    z-index: 1051;
    width: 90%;
    max-width: 400px;
  }

  .modal.show,
  .modal-backdrop.show {
    display: block;
  }

  .modal-content {
    position: relative;
    width: 100%;
  }

  .modal-header {
    padding: 1rem;
    border-bottom: 1px solid var(--gray-light);
    display: flex;
    align-items: center;
    justify-content: space-between;
  }

  .modal-title {
    margin: 0;
    font-size: 1.25rem;
    color: var(--text-color);
  }

  .modal-close {
    background: none;
    border: none;
    font-size: 1.5rem;
    cursor: pointer;
    color: var(--gray-dark);
    padding: 0;
    line-height: 1;
  }

  .modal-close:hover {
    color: var(--text-color);
  }

  .modal-body {
    padding: 1rem;
  }

  .modal-footer {
    padding: 1rem;
    border-top: 1px solid var(--gray-light);
    display: flex;
    justify-content: flex-end;
    gap: 0.5rem;
  }

  .text-muted {
    color: var(--gray-dark);
    font-size: 0.9rem;
  }
</style>

<script>
  document.addEventListener("DOMContentLoaded", function () {
    const logoutLink = document.getElementById("logoutLink");
    const modal = document.getElementById("logoutModal");
    const backdrop = document.getElementById("logoutModalBackdrop");
    const closeBtn = document.getElementById("closeLogoutModal");
    const cancelBtn = document.getElementById("cancelLogout");
    const confirmBtn = document.getElementById("confirmLogout");

    // Show modal when logout link is clicked
    logoutLink.addEventListener("click", function (e) {
      e.preventDefault();
      modal.classList.add("show");
      backdrop.classList.add("show");
    });

    // Close modal function
    function closeModal() {
      modal.classList.remove("show");
      backdrop.classList.remove("show");
    }

    // Close modal events
    closeBtn.addEventListener("click", closeModal);
    cancelBtn.addEventListener("click", closeModal);
    backdrop.addEventListener("click", closeModal);

    // Confirm logout
    confirmBtn.addEventListener("click", function () {
      window.location.href = "${pageContext.request.contextPath}/Logout";
    });
  });
</script>
