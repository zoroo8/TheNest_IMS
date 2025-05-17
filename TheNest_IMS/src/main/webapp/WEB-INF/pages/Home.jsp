<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>The Nest - Inventory Management System</title>
    <link
      rel="stylesheet"
      href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css"
    />
    <style>
      :root {
        --primary-color: #2e7d32;
        --secondary-color: #81c784;
        --accent-color: #ffeb3b;
        --dark-color: #1b5e20;
        --light-color: #e8f5e9;
        --text-dark: #333333;
        --text-light: #6c757d;
      }

      * {
        margin: 0;
        padding: 0;
        box-sizing: border-box;
        font-family: "Segoe UI", Tahoma, Geneva, Verdana, sans-serif;
      }

      body {
        background: linear-gradient(
          135deg,
          var(--light-color) 0%,
          #ffffff 100%
        );
        color: var(--text-dark);
        min-height: 100vh;
        overflow-x: hidden;
      }

      .container {
        width: 100%;
        max-width: 1200px;
        margin: 0 auto;
        padding: 0 20px;
      }

      /* Header Styles */
      header {
        background-color: white;
        box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        position: sticky;
        top: 0;
        z-index: 100;
      }

      .navbar {
        display: flex;
        justify-content: space-between;
        align-items: center;
        padding: 15px 0;
      }

      .logo {
        display: flex;
        align-items: center;
        gap: 10px;
        text-decoration: none;
        color: var(--primary-color);
      }

      .logo img {
        height: 40px;
      }

      .logo-text {
        font-size: 24px;
        font-weight: 700;
      }

      .nav-links {
        display: flex;
        gap: 30px;
        list-style: none;
      }

      .nav-links a {
        text-decoration: none;
        color: var(--text-dark);
        font-weight: 500;
        transition: color 0.3s;
        position: relative;
      }

      .nav-links a:hover {
        color: var(--primary-color);
      }

      .nav-links a::after {
        content: "";
        position: absolute;
        width: 0;
        height: 2px;
        bottom: -5px;
        left: 0;
        background-color: var(--primary-color);
        transition: width 0.3s;
      }

      .nav-links a:hover::after {
        width: 100%;
      }

      .login-btn {
        background-color: var(--primary-color);
        color: white;
        border: none;
        padding: 10px 20px;
        border-radius: 50px;
        font-weight: 600;
        cursor: pointer;
        transition: all 0.3s;
        text-decoration: none;
        display: inline-block;
      }

      .login-btn:hover {
        background-color: var(--dark-color);
        transform: translateY(-2px);
        box-shadow: 0 5px 15px rgba(46, 125, 50, 0.3);
      }

      /* Hero Section */
      .hero {
        padding: 80px 0;
        display: flex;
        align-items: center;
        position: relative;
        overflow: hidden;
      }

      .hero-content {
        flex: 1;
        padding-right: 50px;
      }

      .hero-image {
        flex: 1;
        display: flex;
        justify-content: center;
      }

      .hero-image img {
        width: 40%;
        height: 5%;
        animation: float 6s ease-in-out infinite;
      }

      @keyframes float {
        0% {
          transform: translateY(0px);
        }
        50% {
          transform: translateY(-20px);
        }
        100% {
          transform: translateY(0px);
        }
      }

      .hero h1 {
        font-size: 48px;
        margin-bottom: 20px;
        color: var(--dark-color);
        line-height: 1.2;
      }

      .hero p {
        font-size: 18px;
        margin-bottom: 30px;
        color: var(--text-light);
        line-height: 1.6;
      }

      .hero-btns {
        display: flex;
        gap: 15px;
      }

      .btn-secondary {
        background-color: white;
        color: var(--primary-color);
        border: 2px solid var(--primary-color);
        padding: 10px 20px;
        border-radius: 50px;
        font-weight: 600;
        cursor: pointer;
        transition: all 0.3s;
        text-decoration: none;
      }

      .btn-secondary:hover {
        background-color: var(--light-color);
        transform: translateY(-2px);
      }

      /* Features Section */
      .features {
        padding: 80px 0;
        background-color: white;
      }

      .section-title {
        text-align: center;
        margin-bottom: 60px;
      }

      .section-title h2 {
        font-size: 36px;
        color: var(--dark-color);
        margin-bottom: 15px;
      }

      .section-title p {
        color: var(--text-light);
        max-width: 600px;
        margin: 0 auto;
      }

      .features-grid {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
        gap: 30px;
      }

      .feature-card {
        background-color: white;
        border-radius: 15px;
        padding: 30px;
        box-shadow: 0 5px 20px rgba(0, 0, 0, 0.05);
        transition: transform 0.3s, box-shadow 0.3s;
      }

      .feature-card:hover {
        transform: translateY(-10px);
        box-shadow: 0 15px 30px rgba(0, 0, 0, 0.1);
      }

      .feature-icon {
        width: 70px;
        height: 70px;
        background-color: var(--light-color);
        border-radius: 50%;
        display: flex;
        align-items: center;
        justify-content: center;
        margin-bottom: 20px;
        font-size: 30px;
        color: var(--primary-color);
      }

      .feature-card h3 {
        font-size: 22px;
        margin-bottom: 15px;
        color: var(--dark-color);
      }

      .feature-card p {
        color: var(--text-light);
        line-height: 1.6;
      }

      /* Stats Section */
      .stats {
        padding: 80px 0;
        background-color: var(--light-color);
        text-align: center;
      }

      .stats-grid {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
        gap: 30px;
        margin-top: 50px;
      }

      .stat-item h3 {
        font-size: 48px;
        color: var(--primary-color);
        margin-bottom: 10px;
      }

      .stat-item p {
        color: var(--text-dark);
        font-weight: 500;
      }

      /* CTA Section */
      .cta {
        padding: 80px 0;
        text-align: center;
      }

      .cta-box {
        background-color: var(--primary-color);
        border-radius: 20px;
        padding: 60px;
        color: white;
        box-shadow: 0 15px 30px rgba(46, 125, 50, 0.2);
      }

      .cta-box h2 {
        font-size: 36px;
        margin-bottom: 20px;
      }

      .cta-box p {
        font-size: 18px;
        margin-bottom: 30px;
        max-width: 600px;
        margin-left: auto;
        margin-right: auto;
      }

      .btn-light {
        background-color: white;
        color: var(--primary-color);
        border: none;
        padding: 12px 30px;
        border-radius: 50px;
        font-weight: 600;
        cursor: pointer;
        transition: all 0.3s;
        text-decoration: none;
        display: inline-block;
      }

      .btn-light:hover {
        background-color: var(--light-color);
        transform: translateY(-2px);
        box-shadow: 0 5px 15px rgba(255, 255, 255, 0.2);
      }

      /* Footer */
      footer {
        background-color: var(--dark-color);
        color: white;
        padding: 60px 0 30px;
      }

      .footer-content {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
        gap: 40px;
        margin-bottom: 40px;
      }

      .footer-logo {
        display: flex;
        align-items: center;
        gap: 10px;
        margin-bottom: 20px;
      }

      .footer-logo img {
        height: 40px;
      }

      .footer-about p {
        line-height: 1.6;
        margin-bottom: 20px;
      }

      .footer-links h4 {
        font-size: 18px;
        margin-bottom: 20px;
        position: relative;
        padding-bottom: 10px;
      }

      .footer-links h4::after {
        content: "";
        position: absolute;
        left: 0;
        bottom: 0;
        width: 30px;
        height: 2px;
        background-color: var(--secondary-color);
      }

      .footer-links ul {
        list-style: none;
      }

      .footer-links li {
        margin-bottom: 10px;
      }

      .footer-links a {
        color: #e0e0e0;
        text-decoration: none;
        transition: color 0.3s;
      }

      .footer-links a:hover {
        color: var(--secondary-color);
      }

      .footer-contact p {
        display: flex;
        align-items: center;
        gap: 10px;
        margin-bottom: 15px;
      }

      .footer-bottom {
        text-align: center;
        padding-top: 30px;
        border-top: 1px solid rgba(255, 255, 255, 0.1);
      }

      /* Responsive Design */
      @media (max-width: 768px) {
        .hero {
          flex-direction: column;
          text-align: center;
        }

        .hero-content {
          padding-right: 0;
          margin-bottom: 40px;
        }

        .hero-btns {
          justify-content: center;
        }

        .nav-links {
          display: none;
        }
      }
    </style>
  </head>
  <body>
    <!-- Header -->
    <header>
      <div class="container">
        <nav class="navbar">
          <a href="home" class="logo">
            <img
              src="${pageContext.request.contextPath}/assets/images/nest-logo.png"
              alt="The Nest Logo"
            />
            <span class="logo-text">The Nest</span>
          </a>
          <ul class="nav-links">
            <li><a href="home">Home</a></li>
            <li><a href="#features">Features</a></li>
            <li><a href="#about">About</a></li>
            <li><a href="#contact">Contact</a></li>
          </ul>
          <a href="/TheNest_IMS/Login" class="login-btn"
            >Login <i class="bi bi-box-arrow-in-right"></i
          ></a>
        </nav>
      </div>
    </header>

    <!-- Hero Section -->
    <section class="hero">
      <div class="container">
        <div class="hero-content">
          <h1>Streamline Your Inventory Management</h1>
          <p>
            The Nest provides a comprehensive solution for managing your
            inventory, tracking stock levels, and optimizing your supply chain
            operations. Increase efficiency and reduce costs with our intuitive
            system.
          </p>
          <div class="hero-btns">
            <a href="/TheNest_IMS/Login" class="login-btn">Get Started</a>
            <a href="#features" class="btn-secondary">Learn More</a>
          </div>
        </div>
        <div class="hero-image">
          <img
            src="${pageContext.request.contextPath}/assets/images/inventory-illustration.jpg"
            alt="Inventory Management Illustration"
          />
        </div>
      </div>
    </section>

    <!-- Features Section -->
    <section class="features" id="features">
      <div class="container">
        <div class="section-title">
          <h2>Powerful Features</h2>
          <p>
            Discover how The Nest can transform your inventory management
            process
          </p>
        </div>
        <div class="features-grid">
          <div class="feature-card">
            <div class="feature-icon">
              <i class="bi bi-box-seam"></i>
            </div>
            <h3>Stock Management</h3>
            <p>
              Track stock levels in real-time, set reorder points, and receive
              alerts when inventory is running low.
            </p>
          </div>
          <div class="feature-card">
            <div class="feature-icon">
              <i class="bi bi-graph-up"></i>
            </div>
            <h3>Analytics & Reports</h3>
            <p>
              Generate comprehensive reports and gain valuable insights into
              your inventory performance.
            </p>
          </div>
          <div class="feature-card">
            <div class="feature-icon">
              <i class="bi bi-truck"></i>
            </div>
            <h3>Supplier Management</h3>
            <p>
              Manage supplier relationships, track orders, and streamline your
              procurement process.
            </p>
          </div>
          <div class="feature-card">
            <div class="feature-icon">
              <i class="bi bi-qr-code"></i>
            </div>
            <h3>Barcode Integration</h3>
            <p>
              Scan barcodes for quick and accurate inventory updates and product
              information retrieval.
            </p>
          </div>
          <div class="feature-card">
            <div class="feature-icon">
              <i class="bi bi-people"></i>
            </div>
            <h3>User Management</h3>
            <p>
              Assign roles and permissions to ensure secure access to your
              inventory system.
            </p>
          </div>
          <div class="feature-card">
            <div class="feature-icon">
              <i class="bi bi-bell"></i>
            </div>
            <h3>Notifications</h3>
            <p>
              Receive timely alerts for low stock, pending orders, and other
              important inventory events.
            </p>
          </div>
        </div>
      </div>
    </section>

    <!-- Stats Section -->
    <section class="stats">
      <div class="container">
        <div class="section-title">
          <h2>Why Choose The Nest?</h2>
          <p>
            Our system delivers measurable results for businesses of all sizes
          </p>
        </div>
        <div class="stats-grid">
          <div class="stat-item">
            <h3>99%</h3>
            <p>Inventory Accuracy</p>
          </div>
          <div class="stat-item">
            <h3>30%</h3>
            <p>Reduction in Stockouts</p>
          </div>
          <div class="stat-item">
            <h3>25%</h3>
            <p>Increase in Efficiency</p>
          </div>
          <div class="stat-item">
            <h3>24/7</h3>
            <p>System Availability</p>
          </div>
        </div>
      </div>
    </section>

    <!-- CTA Section -->
    <section class="cta">
      <div class="container">
        <div class="cta-box">
          <h2>Ready to Optimize Your Inventory?</h2>
          <p>
            Join thousands of businesses that have transformed their inventory
            management with The Nest.
          </p>
          <a href="/TheNest_IMS/Login" class="btn-light">Get Started Today</a>
        </div>
      </div>
    </section>

    <!-- Footer -->
    <footer>
      <div class="container">
        <div class="footer-content">
          <div class="footer-about">
            <div class="footer-logo">
              <img
                src="${pageContext.request.contextPath}/assets/images/nest-logo.png"
                alt="The Nest Logo"
              />
              <span>The Nest</span>
            </div>
            <p>
              The Nest provides a comprehensive inventory management solution
              designed to help businesses optimize their stock levels and
              streamline operations.
            </p>
          </div>
          <div class="footer-links">
            <h4>Quick Links</h4>
            <ul>
              <li><a href="home">Home</a></li>
              <li><a href="#features">Features</a></li>
              <li><a href="#about">About Us</a></li>
              <li><a href="#contact">Contact</a></li>
              <li><a href="/Login">Login</a></li>
            </ul>
          </div>
          <div class="footer-links">
            <h4>Features</h4>
            <ul>
              <li><a href="#">Stock Management</a></li>
              <li><a href="#">Analytics & Reports</a></li>
              <li><a href="#">Supplier Management</a></li>
              <li><a href="#">Barcode Integration</a></li>
              <li><a href="#">User Management</a></li>
            </ul>
          </div>
          <div class="footer-contact">
            <h4>Contact Us</h4>
            <p><i class="bi bi-envelope"></i> info@thenest.com</p>
            <p><i class="bi bi-telephone"></i> +1 (123) 456-7890</p>
            <p>
              <i class="bi bi-geo-alt"></i> 123 Inventory St, Suite 456,
              Business District
            </p>
          </div>
        </div>
        <div class="footer-bottom">
          <p>
            &copy; 2025 The Nest Inventory Management System. All rights
            reserved.
          </p>
        </div>
      </div>
    </footer>
  </body>
</html>
