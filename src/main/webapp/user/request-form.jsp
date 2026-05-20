<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Request Blood — BDMS</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&family=Space+Grotesk:wght@500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" integrity="sha512-DTOQO9RWCH3ppGqcWaEA1BIZOC6xxalwEsw9c2QQeAIftl+Vegovlnee1c9QX4TctnWMn13TZye+giMm8e2LwA==" crossorigin="anonymous" referrerpolicy="no-referrer" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <meta name="theme-color" content="#C62828">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-status-bar-style" content="default">
    <link rel="apple-touch-icon" href="${pageContext.request.contextPath}/favicon.ico">
</head>
<body class="route-user">
    <nav class="navbar">
        <a href="${pageContext.request.contextPath}/user/dashboard" class="nav-brand"><span class="brand-icon"><i class="fa-solid fa-droplet"></i></span> BDMS</a>
        <div class="nav-links">
            <span class="nav-user-info"><i class="fa-regular fa-user"></i> ${sessionScope.user.fullName}</span>
            <a href="${pageContext.request.contextPath}/logout" class="btn btn-outline btn-sm">Logout</a>
        </div>
    </nav>

    <div class="dashboard-layout">
        <aside class="sidebar">
            <nav class="sidebar-nav">
                <span class="sidebar-section-title">Navigation</span>
                <a href="${pageContext.request.contextPath}/user/dashboard" class="sidebar-link"><span class="link-icon"><i class="fa-solid fa-house"></i></span> Dashboard</a>
                <a href="${pageContext.request.contextPath}/user/profile" class="sidebar-link"><span class="link-icon"><i class="fa-regular fa-user"></i></span> Profile</a>
                <a href="${pageContext.request.contextPath}/user/search" class="sidebar-link"><span class="link-icon"><i class="fa-solid fa-magnifying-glass"></i></span> Find Donors</a>
                <a href="${pageContext.request.contextPath}/user/request-form.jsp" class="sidebar-link active"><span class="link-icon"><i class="fa-solid fa-droplet"></i></span> Request Blood</a>
                <a href="${pageContext.request.contextPath}/user/request" class="sidebar-link"><span class="link-icon"><i class="fa-solid fa-clipboard-list"></i></span> My Requests</a>
                <a href="${pageContext.request.contextPath}/user/wishlist" class="sidebar-link"><span class="link-icon"><i class="fa-solid fa-star"></i></span> Wishlist</a>
            </nav>
        </aside>

        <main class="main-content">
            <div class="control-hero">
                <div class="hero-badge"><i class="fa-solid fa-droplet"></i></div>
                <div class="hero-copy-block">
                    <div class="control-title-row"><h1>Request Blood Supply</h1><span class="badge badge-critical">Create request</span></div>
                    <p class="control-support">Fill out patient details, blood needs, and urgency in one clear request form.</p>
                </div>
            </div>

            <div class="section-card" style="max-width: 820px;">
                <% if (request.getAttribute("error") != null) { %>
                    <div class="alert alert-error"><%= request.getAttribute("error") %></div>
                <% } %>

                <form action="${pageContext.request.contextPath}/user/request" method="post" id="requestForm">
                    <div class="form-row">
                        <div class="form-group">
                            <label class="form-label">Patient Name</label>
                            <input type="text" name="patientName" class="form-control" required placeholder="Full name of patient">
                        </div>
                        <div class="form-group">
                            <label class="form-label">Hospital Name</label>
                            <input type="text" name="hospitalName" class="form-control" required placeholder="Hospital or clinic">
                        </div>
                    </div>

                    <div class="form-row">
                        <div class="form-group">
                            <label class="form-label">Blood Type Needed</label>
                            <select name="bloodTypeNeeded" class="form-control" required>
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
                            <label class="form-label">Units Required</label>
                            <input type="number" step="0.5" min="0.5" max="10" name="unitsRequired" class="form-control" required placeholder="e.g. 1.5">
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="form-label">Urgency Level</label>
                        <select name="urgencyLevel" class="form-control" required>
                            <option value="LOW">&#x1F7E2; Low</option>
                            <option value="MEDIUM" selected>&#x1F7E1; Medium</option>
                            <option value="HIGH">&#x1F7E0; High</option>
                            <option value="CRITICAL">&#x1F534; Critical</option>
                        </select>
                    </div>

                    <div class="form-group">
                        <label class="form-label">Reason / Condition</label>
                        <textarea name="reason" class="form-control" rows="3" required placeholder="Describe the medical condition or reason..."></textarea>
                    </div>

                    <div class="form-actions">
                        <button type="submit" class="btn btn-primary">Submit Request</button>
                        <a href="${pageContext.request.contextPath}/user/dashboard" class="btn btn-outline">Cancel</a>
                    </div>
                </form>
            </div>
        </main>
    </div>

    <script src="${pageContext.request.contextPath}/js/main.js?v=20260414"></script>
</body>
</html>



