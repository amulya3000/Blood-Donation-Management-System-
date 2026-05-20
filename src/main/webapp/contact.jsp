<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Contact Us — BDMS</title>
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
            <a href="${pageContext.request.contextPath}/contact.jsp" class="nav-active">Contact</a>
<a href="${pageContext.request.contextPath}/login.jsp" class="btn btn-primary btn-sm">Sign In</a>
        </div>
    </nav>

    <div class="section">
        <div class="section-title">
            <div class="page-kicker">Support and Help</div>
            <h2>Contact BDMS Team</h2>
            <p>Reach us for donor support, blood request help, and technical guidance.</p>
        </div>
        <div class="contact-layout">
            <div class="contact-info glass-panel">
                <h2>Get In Touch</h2>
                <p>Have questions about blood donation, system usage, or need technical support? We're here to help.</p>
                
                <div class="contact-detail">
                    <div class="detail-icon"><i class="fa-solid fa-envelope"></i></div>
                    <div>
                        <h4>Email</h4>
                        <p>support@bdms.org.np</p>
                    </div>
                </div>

                <div class="contact-detail">
                    <div class="detail-icon"><i class="fa-solid fa-phone"></i></div>
                    <div>
                        <h4>Phone</h4>
                        <p>+977 980-123-4567</p>
                    </div>
                </div>

                <div class="contact-detail">
                    <div class="detail-icon"><i class="fa-solid fa-location-dot"></i></div>
                    <div>
                        <h4>Office</h4>
                        <p>Kathmandu, Bagmati<br>Nepal</p>
                    </div>
                </div>

                <div class="contact-detail">
                    <div class="detail-icon"><i class="fa-regular fa-clock"></i></div>
                    <div>
                        <h4>Hours</h4>
                        <p>Mon-Fri 9AM-6PM<br>Sat 10AM-4PM</p>
                    </div>
                </div>
            </div>

            <div class="contact-form-card glass-panel">
                <h2>Send Message</h2>
                                <div id="form-flash">
                                        <% if (session.getAttribute("success") != null) { %>
                                            <div class="alert alert-success" role="alert"><%= session.getAttribute("success") %></div>
                                            <% session.removeAttribute("success"); %>
                                        <% } %>
                                        <% if (session.getAttribute("error") != null) { %>
                                            <div class="alert alert-error" role="alert"><%= session.getAttribute("error") %></div>
                                            <% session.removeAttribute("error"); %>
                                        <% } %>
                                </div>
                <form action="${pageContext.request.contextPath}/contact" method="post">
                    <div class="form-row">
                        <div class="form-group">
                            <label for="name">Full Name</label>
                            <input type="text" id="name" name="name" class="form-control" required>
                        </div>
                        <div class="form-group">
                            <label for="email">Email</label>
                            <input type="email" id="email" name="email" class="form-control" required>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="subject">Subject</label>
                        <input type="text" id="subject" name="subject" class="form-control" required>
                    </div>
                    <div class="form-group">
                        <label for="message">Message</label>
                        <textarea id="message" name="message" class="form-control" rows="5" required placeholder="Tell us how we can help you..."></textarea>
                    </div>
                    <div class="form-actions">
                        <button type="submit" class="btn btn-primary">Send Message</button>
                        <button type="reset" class="btn btn-outline">Reset</button>
                    </div>
                </form>
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



