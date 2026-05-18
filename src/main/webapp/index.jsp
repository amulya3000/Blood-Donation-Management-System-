<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="BDMS - Blood Donation Management System. Donate blood, save lives. Join the platform to connect donors with those in need.">
    <title>BDMS — Blood Donation Management System</title>
<link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&family=Space+Grotesk:wght@500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" integrity="sha512-DTOQO9RWCH3ppGqcWaEA1BIZOC6xxalwEsw9c2QQeAIftl+Vegovlnee1c9QX4TctnWMn13TZye+giMm8e2LwA==" crossorigin="anonymous" referrerpolicy="no-referrer" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link rel="manifest" href="${pageContext.request.contextPath}/manifest.json">
    <meta name="theme-color" content="#C62828">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-status-bar-style" content="default">
    <link rel="apple-touch-icon" href="${pageContext.request.contextPath}/favicon.ico">

</head>
<body class="route-public landing-page">
    <nav class="navbar">
        <a href="${pageContext.request.contextPath}/" class="nav-brand">
            <span class="brand-icon"><i class="fa-solid fa-droplet"></i></span> BDMS
        </a>
        <button class="hamburger" aria-label="Toggle menu">
            <span></span><span></span><span></span>
        </button>
<div class="nav-links">
            <a href="${pageContext.request.contextPath}/" class="nav-active">Home</a>
            <a href="${pageContext.request.contextPath}/about.jsp">About</a>
            <a href="${pageContext.request.contextPath}/contact.jsp">Contact</a>
            <a href="${pageContext.request.contextPath}/login.jsp" class="btn btn-primary btn-sm">Sign In</a>
        </div>
    </nav>

    <section class="hero">
        <div class="hero-panel">
            <div class="hero-copy">
                <div class="hero-particles" aria-hidden="true"></div>
                <div class="hero-kicker">Real-time blood response network</div>
                <h1>Built for urgency.<br><span class="highlight">Designed for trust.</span></h1>
                <p>BDMS connects donor discovery, blood requests, and administrative decisions in one fast, transparent flow for real emergencies.</p>
<div class="hero-actions">
                    <a href="${pageContext.request.contextPath}/login.jsp" class="btn btn-primary">Sign In</a>
                    <a href="${pageContext.request.contextPath}/register.jsp" class="btn btn-outline">Register</a>
                </div>
                <div class="hero-mini-grid">
                    <div class="hero-mini-item">
                        <span class="hero-mini-label">Coverage</span>
                        <strong>All Major Types</strong>
                    </div>
                    <div class="hero-mini-item">
                        <span class="hero-mini-label">Routing</span>
                        <strong>Urgency First</strong>
                    </div>
                    <div class="hero-mini-item">
                        <span class="hero-mini-label">Access</span>
                        <strong>Admin + User Roles</strong>
                    </div>
                </div>
            </div>
            <div class="hero-side">
                <div class="hero-side-grid" aria-hidden="true">
                    <div class="hero-bt-grid-glow"></div>
                    <div class="hero-bt-grid">
                        <span>O-</span><span>O+</span>
                        <span>A-</span><span>A+</span>
                        <span>B-</span><span>B+</span>
                        <span>AB-</span><span>AB+</span>
                    </div>
                </div>
                <div class="hero-stat">
                    <strong>Live donor access</strong>
                    <span>Search compatible donors by location and blood type.</span>
                </div>
                <div class="hero-stat">
                    <strong>Request tracking</strong>
                    <span>Monitor approvals, rejections, and fulfilled requests.</span>
                </div>
                <div class="hero-stat">
                    <strong>Admin oversight</strong>
                    <span>Inventory, user approvals, and analytics stay in one panel.</span>
                </div>
            </div>
        </div>
    </section>

    <div class="stats-strip">
        <div class="stat-card stat-critical">
            <span class="stat-type">O-</span>
            <span class="stat-label">Critical Need</span>
        </div>
        <div class="stat-card stat-low">
            <span class="stat-type">A-</span>
            <span class="stat-label">Low Supply</span>
        </div>
        <div class="stat-card stat-ok">
            <span class="stat-type">B+</span>
            <span class="stat-label">Adequate</span>
        </div>
        <div class="stat-card">
            <span class="stat-type">AB+</span>
            <span class="stat-label">Normal</span>
        </div>
    </div>

    <section class="experience-band" aria-label="BDMS highlights">
        <div class="experience-band-track">
            <span>Fast Donor Discovery</span>
            <span>Urgency-Based Request Routing</span>
            <span>Admin Verified Accounts</span>
            <span>Live Inventory Awareness</span>
            <span>Built for Real Emergencies</span>
            <span>Fast Donor Discovery</span>
            <span>Urgency-Based Request Routing</span>
            <span>Admin Verified Accounts</span>
            <span>Live Inventory Awareness</span>
            <span>Built for Real Emergencies</span>
        </div>
    </section>

    <section class="section section-process">
        <div class="section-title">
            <h2>Rapid Response Flow</h2>
            <p>A practical sequence that keeps actions visible from registration to final fulfillment.</p>
        </div>
        <div class="process-lane">
            <div class="process-step ps-item">
                <span class="process-index ps-num">01</span>
                <h3>Register</h3>
                <p>Users create accounts with required donor and contact details.</p>
                <div class="ps-line" aria-hidden="true"></div>
            </div>
            <div class="process-step ps-item">
                <span class="process-index ps-num">02</span>
                <h3>Approve</h3>
                <p>Admin verifies and controls donor records before activation.</p>
                <div class="ps-line" aria-hidden="true"></div>
            </div>
            <div class="process-step ps-item">
                <span class="process-index ps-num">03</span>
                <h3>Request</h3>
                <p>Patients submit requests by type, unit, and urgency level.</p>
                <div class="ps-line" aria-hidden="true"></div>
            </div>
            <div class="process-step ps-item">
                <span class="process-index ps-num">04</span>
                <h3>Fulfill</h3>
                <p>Inventory and request actions are handled from one control space.</p>
            </div>
        </div>
    </section>

    <!-- Features Section -->
    <section class="section">
        <div class="section-title">
            <h2>How BDMS Works</h2>
            <p>A streamlined process designed to make blood donation accessible, safe, and efficient for everyone.</p>
        </div>
        <div class="feature-grid">
            <div class="feature-card">
                <div class="gf-icon-wrap"><i class="fa-solid fa-user-check"></i></div>
                <h3>Register &amp; Get Approved</h3>
                <p>Create your account with personal and medical details. An admin reviews and approves your registration.</p>
            </div>
            <div class="feature-card">
                <div class="gf-icon-wrap"><i class="fa-solid fa-magnifying-glass"></i></div>
                <h3>Search Donors</h3>
                <p>Find available donors by blood type and location. Connect with potential donors instantly.</p>
            </div>
            <div class="feature-card">
                <div class="gf-icon-wrap"><i class="fa-solid fa-droplet"></i></div>
                <h3>Request Blood</h3>
                <p>Submit blood requests for patients with urgency levels. Administrators process and fulfill requests.</p>
            </div>
            <div class="feature-card">
                <div class="gf-icon-wrap"><i class="fa-solid fa-chart-line"></i></div>
                <h3>Track Everything</h3>
                <p>Monitor your donation history, request status, and view comprehensive reports and analytics.</p>
            </div>
        </div>
    </section>

    <section class="section section-cta">
        <div class="cta-shell">
            <div>
                <div class="hero-kicker">Emergency-ready platform</div>
                <h2>Need blood support now?</h2>
                <p>Sign in to submit and monitor requests, or register as a donor to become available in search results.</p>
            </div>
<div class="hero-actions">
                <a href="${pageContext.request.contextPath}/login.jsp" class="btn btn-primary">Sign In</a>
                <a href="${pageContext.request.contextPath}/register.jsp" class="btn btn-outline">Register</a>
            </div>
        </div>
    </section>

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

    <div class="toast-container" id="toastContainer" aria-live="polite" aria-atomic="true"></div>
    <script src="${pageContext.request.contextPath}/js/main.js?v=20260414"></script>
</body>
</html>


