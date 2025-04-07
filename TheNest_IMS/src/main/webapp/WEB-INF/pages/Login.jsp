<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Login - The Nest Inventory System</title>
    
    <link rel="preconnect" href="https://fonts.googleapis.com" />
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet" />
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet" />
    
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/Login.css" />
</head>
<body>
    <div class="container">
        <div class="login-container">
            <div class="logo-area">
                <div class="logo-icon"></div>
                <h1>The Nest</h1>
                <p class="subtitle">Inventory Management System</p>
            </div>

            <form action="login" method="post">
                <div class="form-group">
                    <label for="email" class="form-label">Email address</label>
                    <div class="input-group">
                        <span class="material-icons input-icon">mail</span>
                        <input
                            type="email"
                            class="input-with-icon"
                            id="email"
                            name="email"
                            placeholder="Enter your email"
                            required
                        />
                    </div>
                </div>

                <div class="form-group">
                    <label for="password" class="form-label">Password</label>
                    <div class="input-group">
                        <span class="material-icons input-icon">lock</span>
                        <input
                            type="password"
                            class="input-with-icon"
                            id="password"
                            name="password"
                            placeholder="Enter your password"
                            required
                        />
                        <span class="material-icons toggle-password" id="togglePassword">visibility_off</span>
                    </div>
                </div>

                <div class="form-group">
                    <label class="form-label">Select your role</label>
                    <div class="role-selector">
                        <div class="role-option" id="adminRoleOption">
                            <span class="material-icons">admin_panel_settings</span>
                            <span>Admin</span>
                        </div>
                        <div class="role-option active" id="staffRoleOption">
                            <span class="material-icons">person</span>
                            <span>Staff</span>
                        </div>
                    </div>
                    <input type="radio" name="role" id="adminRole" value="ADMIN" style="display: none" />
                    <input type="radio" name="role" id="staffRole" value="STAFF" checked style="display: none" />
                </div>

                <div class="checkbox-container">
                    <div class="custom-checkbox" id="rememberMeCheckbox"></div>
                    <label class="checkbox-label" for="rememberMeCheckbox">Remember me</label>
                    <input type="checkbox" id="rememberMe" name="rememberMe" style="display: none" />
                </div>

                <button type="submit" class="btn btn-primary">
                    <span class="material-icons">login</span>
                    <span>Login</span>
                </button>

                <div class="text-center mt-3">
                    <a href="#" class="forgot-password">Forgot password?</a>
                </div>

                <div class="divider">
                    <span>New to The Nest?</span>
                </div>

                <div class="text-center">
                    <a href="#" class="btn btn-outline-secondary">
                        Contact administrator for access
                    </a>
                </div>
            </form>
        </div>
    </div>

    <script>
        document.getElementById("togglePassword").addEventListener("click", function() {
            const passwordInput = document.getElementById("password");
            if (passwordInput.type === "password") {
                passwordInput.type = "text";
                this.textContent = "visibility";
            } else {
                passwordInput.type = "password";
                this.textContent = "visibility_off";
            }
        });

        document.getElementById("adminRoleOption").addEventListener("click", function() {
            this.classList.add("active");
            document.getElementById("staffRoleOption").classList.remove("active");
            document.getElementById("adminRole").checked = true;
        });

        document.getElementById("staffRoleOption").addEventListener("click", function() {
            this.classList.add("active");
            document.getElementById("adminRoleOption").classList.remove("active");
            document.getElementById("staffRole").checked = true;
        });
            
        document.getElementById("rememberMeCheckbox").addEventListener("click", function() {
            this.classList.toggle("checked");
            const checkbox = document.getElementById("rememberMe");
            checkbox.checked = !checkbox.checked;
        });
    </script>
</body>
</html>