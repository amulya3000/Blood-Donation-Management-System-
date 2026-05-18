<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Profile — BDMS</title>
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
                <a href="${pageContext.request.contextPath}/user/profile" class="sidebar-link active"><span class="link-icon"><i class="fa-regular fa-user"></i></span> Profile</a>
                <a href="${pageContext.request.contextPath}/user/search" class="sidebar-link"><span class="link-icon"><i class="fa-solid fa-magnifying-glass"></i></span> Find Donors</a>
                <a href="${pageContext.request.contextPath}/user/request-form.jsp" class="sidebar-link"><span class="link-icon"><i class="fa-solid fa-droplet"></i></span> Request Blood</a>
                <a href="${pageContext.request.contextPath}/user/request" class="sidebar-link"><span class="link-icon"><i class="fa-solid fa-clipboard-list"></i></span> My Requests</a>
                <a href="${pageContext.request.contextPath}/user/wishlist" class="sidebar-link"><span class="link-icon"><i class="fa-solid fa-star"></i></span> Wishlist</a>
            </nav>
        </aside>

        <main class="main-content">
            <div class="profile-hero">
                <div class="profile-avatar"><i class="fa-regular fa-user"></i></div>
                <div class="profile-copy">
                    <div class="profile-title-row">
                        <h1>${sessionScope.user.fullName}</h1>
                        <span class="badge badge-approved">Donor since ${sessionScope.user.dob}</span>
                    </div>
                    <p class="profile-support">Keep your profile current so requests, approvals, and donor search results stay accurate.</p>
                </div>
                <div class="profile-stats">
                    <a href="${pageContext.request.contextPath}/user/request-form.jsp" class="btn btn-primary btn-sm">Request blood</a>
                    <a href="${pageContext.request.contextPath}/user/search" class="btn btn-outline btn-sm">Find donors</a>
                </div>
            </div>

            <c:if test="${not empty sessionScope.success}">
                <div class="alert alert-success">${sessionScope.success}</div>
                <c:remove var="success" scope="session"/>
            </c:if>
            <c:if test="${not empty sessionScope.error}">
                <div class="alert alert-error">${sessionScope.error}</div>
                <c:remove var="error" scope="session"/>
            </c:if>

            <div class="split-grid">
                <div class="section-card">
                    <h3>Personal Information</h3>
                    <form action="${pageContext.request.contextPath}/user/profile" method="post" class="form-container">
                    <input type="hidden" name="action" value="update">

                    <div class="form-row">
                        <div class="form-group">
                            <label class="form-label" for="fullName">Full Name</label>
                            <input type="text" id="fullName" name="fullName" class="form-control" value="${sessionScope.user.fullName}" required>
                        </div>
                        <div class="form-group">
                            <label class="form-label" for="email">Email</label>
                            <input type="email" id="email" class="form-control" value="${sessionScope.user.email}" readonly>
                        </div>
                    </div>

                    <div class="form-row">
                        <div class="form-group">
                            <label class="form-label" for="phone">Phone</label>
                            <input type="tel" id="phone" name="phone" class="form-control" value="${sessionScope.user.phone}" required>
                        </div>
                        <div class="form-group">
                            <label class="form-label" for="bloodType">Blood Type</label>
                            <input type="text" id="bloodType" class="form-control" value="${sessionScope.user.bloodType}" readonly>
                        </div>
                    </div>

                    <div class="form-row">
                        <div class="form-group">
                            <label class="form-label" for="dob">Date of Birth</label>
                            <input type="date" id="dob" class="form-control" value="${sessionScope.user.dob}" readonly>
                        </div>
                        <div class="form-group">
                            <label class="form-label" for="status">Account Status</label>
                            <input type="text" id="status" class="form-control" value="${sessionScope.user.status}" readonly style="color: var(--success); font-weight: 700; text-transform: capitalize;">
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="form-label" for="address">Address</label>
                        <textarea id="address" name="address" class="form-control" rows="2" required>${sessionScope.user.address}</textarea>
                    </div>

                    <div class="form-group">
                        <label class="form-label" for="location">Location (City/District)</label>
                        <input type="text" id="location" name="location" class="form-control" value="${sessionScope.user.location}" required>
                    </div>

                    <div class="form-group">
                        <label class="form-label" for="newPassword">New Password <small style="color:var(--stone);">(leave blank to keep current)</small></label>
                        <input type="password" id="newPassword" name="newPassword" class="form-control" placeholder="Enter new password">
                    </div>

                    <div class="form-actions">
                        <button type="submit" class="btn btn-primary">Update Profile</button>
                        <a href="${pageContext.request.contextPath}/user/dashboard" class="btn btn-outline">Cancel</a>
                    </div>
                </form>
                </div>

                <div class="section-card">
                    <h3>Donation History</h3>
                    <div class="timeline-compact">
                        <div class="timeline-item">
                            <div class="timeline-title">Bir Hospital, Kathmandu</div>
                            <div class="timeline-meta">2025-01-15 · 1 unit donated</div>
                        </div>
                        <div class="timeline-item">
                            <div class="timeline-title">Tribhuvan University Teaching Hospital</div>
                            <div class="timeline-meta">2024-10-03 · 1 unit donated</div>
                        </div>
                        <div class="timeline-item">
                            <div class="timeline-title">Patan Hospital, Lalitpur</div>
                            <div class="timeline-meta">2024-07-22 · 1 unit donated</div>
                        </div>
                        <div class="timeline-item">
                            <div class="timeline-title">Nepal Red Cross Society HQ</div>
                            <div class="timeline-meta">2024-01-08 · 1 unit donated</div>
                        </div>
                    </div>
                </div>
            </div>
        </main>
    </div>

    <script src="${pageContext.request.contextPath}/js/main.js?v=20260414"></script>
</body>
</html>



