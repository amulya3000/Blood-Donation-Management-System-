<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="Learn about BDMS - Blood Donation Management System, our mission, and how we are making blood donation accessible in Nepal.">
    <title>About Us — BDMS</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&family=Space+Grotesk:wght@500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" integrity="sha512-DTOQO9RWCH3ppGqcWaEA1BIZOC6xxalwEsw9c2QQeAIftl+Vegovlnee1c9QX4TctnWMn13TZye+giMm8e2LwA==" crossorigin="anonymous" referrerpolicy="no-referrer" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body class="route-public">
    <nav class="navbar">
        <a href="${pageContext.request.contextPath}/" class="nav-brand">
            <span class="brand-icon"><i class="fa-solid fa-droplet"></i></span> BDMS
        </a>
        <button class="hamburger" aria-label="Toggle menu">
            <span></span><span></span><span></span>
        </button>
        <div class="nav-links">
            <a href="${pageContext.request.contextPath}/">Home</a>
            <a href="${pageContext.request.contextPath}/about.jsp" class="nav-active">About</a>
            <a href="${pageContext.request.contextPath}/contact.jsp">Contact</a>
<a href="${pageContext.request.contextPath}/login.jsp" class="btn btn-primary btn-sm">Sign In</a>
        </div>
    </nav>

    <!-- About Hero -->
    <section class="about-hero">
        <div class="page-kicker">BDMS Vision</div>
        <h1>About BDMS</h1>
        <p>A secure, web-based platform dedicated to streamlining blood donation activities and saving lives across communities.</p>
        <div class="about-hero-drop" aria-hidden="true">
            <i class="fa-solid fa-droplet" style="font-size: 420px;"></i>
        </div>
    </section>

    <section class="section">
        <div class="metric-grid" style="grid-template-columns: repeat(3, minmax(0, 1fr));">
            <div class="am-stat"><i class="fa-solid fa-droplet"></i><span class="am-num" data-target="8" data-suffix="+">8+</span><span class="am-label">Blood Types Managed</span></div>
            <div class="am-stat"><i class="fa-solid fa-bolt"></i><span class="am-num">24/7</span><span class="am-label">Emergency Access</span></div>
            <div class="am-stat"><i class="fa-solid fa-shield-halved"></i><span class="am-num" data-target="100" data-suffix="%">100%</span><span class="am-label">Admin Verified</span></div>
        </div>
    </section>

    <!-- About Content -->
    <div class="about-content">

        <div class="about-card">
            <h3><span class="about-card-icon"><i class="fa-solid fa-hospital"></i></span> Our Mission</h3>
            <p>The Blood Donation Management System (BDMS) is an online tool aimed at linking blood donors to recipients in an efficient and secure way. Our platform facilitates blood requests, donor registration, and administrative verification via a centralized system.</p>
            <p>We believe that no patient should suffer due to the unavailability of blood. BDMS bridges the gap between those who are willing to donate and those who desperately need blood, ensuring timely access to this life-saving resource.</p>
        </div>

        <div class="about-card">
            <h3><span class="about-card-icon"><i class="fa-solid fa-users"></i></span> Who We Serve</h3>
            <p>BDMS is designed for a wide range of users within the community:</p>
            <ul class="clean-list">
                <li><i class="fa-solid fa-check" style="color:var(--accent);width:16px"></i> Students and employees in educational institutions</li>
                <li><i class="fa-solid fa-check" style="color:var(--accent);width:16px"></i> Hospitals and clinics seeking blood supplies</li>
                <li><i class="fa-solid fa-check" style="color:var(--accent);width:16px"></i> Ordinary citizens who wish to donate or request blood</li>
                <li><i class="fa-solid fa-check" style="color:var(--accent);width:16px"></i> Healthcare administrators managing blood inventories</li>
            </ul>
        </div>

        <div class="about-card">
            <h3><span class="about-card-icon"><i class="fa-solid fa-gears"></i></span> System Features</h3>
            <p>Our platform is built with modern web technologies to provide a robust and user-friendly experience:</p>
            <ul class="clean-list">
                <li><i class="fa-solid fa-lock" style="color:var(--accent);width:16px"></i> Secure user registration with admin approval workflow</li>
                <li><i class="fa-solid fa-magnifying-glass" style="color:var(--accent);width:16px"></i> Donor search by blood type and location</li>
                <li><i class="fa-solid fa-droplet" style="color:var(--accent);width:16px"></i> Blood request management with urgency levels</li>
                <li><i class="fa-solid fa-chart-bar" style="color:var(--accent);width:16px"></i> Comprehensive reports and inventory tracking</li>
                <li><i class="fa-solid fa-user-shield" style="color:var(--accent);width:16px"></i> Role-based access control (Admin &amp; User)</li>
                <li><i class="fa-solid fa-mobile-screen" style="color:var(--accent);width:16px"></i> Responsive design for all devices</li>
            </ul>
        </div>

        <div class="about-card">
            <h3><span class="about-card-icon"><i class="fa-solid fa-handshake"></i></span> Our Values</h3>
            <div class="values-grid">
                <div class="value-item">
                    <div class="value-icon"><i class="fa-solid fa-heart"></i></div>
                    <h4>Voluntary Donation</h4>
                    <p>Promoting voluntary blood donation to save lives without commercial motives.</p>
                </div>
                <div class="value-item">
                    <div class="value-icon"><i class="fa-solid fa-lock"></i></div>
                    <h4>Data Privacy</h4>
                    <p>Securing personal and medical data with encryptions and strict access controls.</p>
                </div>
                <div class="value-item">
                    <div class="value-icon"><i class="fa-solid fa-scale-balanced"></i></div>
                    <h4>Equal Access</h4>
                    <p>Ensuring fair and equal access to blood resources for all patients regardless of background.</p>
                </div>
                <div class="value-item">
                    <div class="value-icon"><i class="fa-solid fa-lightbulb"></i></div>
                    <h4>Transparency</h4>
                    <p>Maintaining clear communication and accountability in all donation processes.</p>
                </div>
            </div>
        </div>

</div>

    <footer class="site-footer">
        <div class="footer-grid">
            <div class="footer-col">
                <h4><i class="fa-solid fa-droplet" style="color:var(--red);"></i> BDMS</h4>
                <p>Blood Donation Management System. Connecting donors with patients across Nepal.</p>
            </div>
            <div class="footer-col">
                <h4>Quick Links</h4>
                <a href="${pageContext.request.contextPath}/">Home</a>
                <a href="${pageContext.request.contextPath}/about.jsp">About</a>
                <a href="${pageContext.request.contextPath}/register.jsp">Become a Donor</a>
            </div>
            <div class="footer-col">
                <h4>Account</h4>
                <a href="${pageContext.request.contextPath}/login.jsp">Sign In</a>
                <a href="${pageContext.request.contextPath}/register.jsp">Register</a>
                <a href="${pageContext.request.contextPath}/contact.jsp">Contact</a>
            </div>
            <div class="footer-col">
                <h4>Contact</h4>
                <p><i class="fa-solid fa-envelope"></i> support@bdms.org.np</p>
                <p><i class="fa-solid fa-phone"></i> +977 980-123-4567</p>
                <p><i class="fa-solid fa-location-dot"></i> Kathmandu, Nepal</p>
            </div>
        </div>
        <div class="footer-bottom">&copy; 2026 BDMS — Blood Donation Management System. Made for Nepal.</div>
    </footer>

    <script src="${pageContext.request.contextPath}/js/main.js?v=20260414"></script>
</body>
</html>



