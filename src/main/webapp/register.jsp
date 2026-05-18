<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register — BDMS</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&family=Space+Grotesk:wght@500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" integrity="sha512-DTOQO9RWCH3ppGqcWaEA1BIZOC6xxalwEsw9c2QQeAIftl+Vegovlnee1c9QX4TctnWMn13TZye+giMm8e2LwA==" crossorigin="anonymous" referrerpolicy="no-referrer" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
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
                    <div class="hero-kicker">Join the network</div>
                    <h1>Become a donor.</h1>
                    <p>Register once, then keep your profile ready for searches, approvals, and future blood requests.</p>
                </div>
                <div class="auth-points">
                    <div class="auth-point"><span>&#10003;</span> Admin-approved onboarding</div>
                    <div class="auth-point"><span>&#10003;</span> Track donation history and availability</div>
                    <div class="auth-point"><span>&#10003;</span> Built for a clean, quick registration flow</div>
                </div>
            </aside>

            <div class="auth-form large">
                <h2>Register as a Donor</h2>
                <p class="auth-subtitle">Fill in your details below. Your account will be reviewed by an administrator.</p>

                <% if (request.getAttribute("error") != null) { %>
                    <div class="alert alert-error"><%= request.getAttribute("error") %></div>
                <% } %>

                <form action="${pageContext.request.contextPath}/register" method="post" class="form-grid" id="registerForm">
                    <div class="form-group">
                        <label class="form-label">Full Name</label>
                        <input type="text" name="fullName" class="form-control" required placeholder="John Doe"
                               value="${user != null ? user.fullName : ''}">
                    </div>
                    <div class="form-group">
                        <label class="form-label">Email Address</label>
                        <input type="email" name="email" class="form-control" required placeholder="john@example.com"
                               value="${user != null ? user.email : ''}">
                    </div>
                    <div class="form-group">
                        <label class="form-label">Phone (10-digit Nepali)</label>
                        <input type="text" name="phone" class="form-control" required placeholder="9800000000"
                               value="${user != null ? user.phone : ''}">
                    </div>
                    <div class="form-group">
                        <label class="form-label">Date of Birth</label>
                        <input type="date" name="dob" class="form-control" required>
                    </div>
                    <div class="form-group">
                        <label class="form-label">Blood Type</label>
                        <select name="bloodType" class="form-control" required>
                            <option value="">Select Blood Type...</option>
                            <option value="A+">A+</option>
                            <option value="A-">A-</option>
                            <option value="B+">B+</option>
                            <option value="B-">B-</option>
                            <option value="AB+">AB+</option>
                            <option value="AB-">AB-</option>
                            <option value="O+">O+</option>
                            <option value="O-">O-</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label class="form-label">Location (City/District)</label>
                        <input type="text" name="location" class="form-control" required placeholder="Kathmandu"
                               value="${user != null ? user.location : ''}">
                    </div>
                    <div class="form-group full-width">
                        <label class="form-label">Full Address</label>
                        <input type="text" name="address" class="form-control" required placeholder="Street name, landmark..."
                               value="${user != null ? user.address : ''}">
                    </div>
                    <div class="form-group">
                        <label class="form-label">Password</label>
                        <input type="password" name="password" class="form-control" required
                               placeholder="Min 8 chars, 1 uppercase, 1 symbol">
                    </div>
                    <div class="form-group">
                        <label class="form-label">Confirm Password</label>
                        <input type="password" name="confirmPassword" class="form-control" required
                               placeholder="Repeat password">
                    </div>

                    <div class="form-group full-width">
                        <button type="submit" class="btn btn-primary" style="width: 100%;">Complete Registration</button>
                    </div>
                </form>

                <p class="auth-alt-link">
                    Already registered? <a href="${pageContext.request.contextPath}/login.jsp">Sign in here</a>
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



