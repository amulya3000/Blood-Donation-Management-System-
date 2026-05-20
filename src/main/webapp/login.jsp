<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sign In — BDMS</title>
<link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&family=Space+Grotesk:wght@500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" integrity="sha512-DTOQO9RWCH3ppGqcWaEA1BIZOC6xxalwEsw9c2QQeAIftl+Vegovlnee1c9QX4TctnWMn13TZye+giMm8e2LwA==" crossorigin="anonymous" referrerpolicy="no-referrer" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link rel="manifest" href="${pageContext.request.contextPath}/manifest.json">
    <meta name="theme-color" content="#C62828">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-status-bar-style" content="default">
    <link rel="apple-touch-icon" href="${pageContext.request.contextPath}/favicon.ico">

</head>
<body class="route-public">
    <nav class="navbar">
        <a href="${pageContext.request.contextPath}/" class="nav-brand">
            <span class="brand-icon"><i class="fa-solid fa-droplet"></i></span> BDMS
        </a>
        <div class="nav-links">
            <a href="${pageContext.request.contextPath}/">Home</a>
            <a href="${pageContext.request.contextPath}/about.jsp">About</a>
            <a href="${pageContext.request.contextPath}/contact.jsp">Contact</a>
        </div>
    </nav>

    <div class="auth-container">
        <div class="auth-layout">
            <aside class="auth-visual">
                <div>
                    <div class="hero-kicker">Secure access</div>
                    <h1>Welcome back.</h1>
                    <p>Use your account to search donors, request blood, track status, and manage your profile without losing context.</p>
                </div>
                <div class="auth-points">
                    <div class="auth-point"><span>&#10003;</span> Fast donor search and request history</div>
                    <div class="auth-point"><span>&#10003;</span> Admin approval and inventory workflows</div>
                    <div class="auth-point"><span>&#10003;</span> A single dashboard for every action</div>
                </div>
            </aside>

            <div class="auth-form">
                <h2>Sign in</h2>
                <p class="auth-subtitle">Access your BDMS dashboard</p>

                <div id="alert-area">
                    <% if (session.getAttribute("error") != null) { %>
                        <div class="alert alert-error"><%= session.getAttribute("error") %></div>
                        <% session.removeAttribute("error"); %>
                    <% } %>
                    <% if (session.getAttribute("success") != null) { %>
                        <div class="alert alert-success"><%= session.getAttribute("success") %></div>
                        <% session.removeAttribute("success"); %>
                    <% } %>
                </div>

                <form action="${pageContext.request.contextPath}/login" method="post">
                    <div class="form-group">
                        <label class="form-label">Email Address</label>
                        <input type="email" name="email" class="form-control" required
                               placeholder="name@example.com"
                               value="${param.email != null ? param.email : ''}">
                    </div>
                    <div class="form-group">
                        <label class="form-label">Password</label>
                        <input type="password" name="password" class="form-control" required
                               placeholder="Enter your password">
                    </div>

                    <button type="submit" class="btn btn-primary" style="width: 100%; margin-top: 0.5rem;">
                        Sign In
                    </button>
                </form>

                <p class="auth-alt-link">
                    Don't have an account?
                    <a href="${pageContext.request.contextPath}/register.jsp">Register here</a>
                </p>
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



