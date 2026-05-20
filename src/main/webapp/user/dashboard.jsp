<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard — BDMS</title>
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
                <a href="${pageContext.request.contextPath}/user/dashboard" class="sidebar-link active"><span class="link-icon"><i class="fa-solid fa-house"></i></span> Dashboard</a>
                <a href="${pageContext.request.contextPath}/user/profile" class="sidebar-link"><span class="link-icon"><i class="fa-regular fa-user"></i></span> Profile</a>
                <a href="${pageContext.request.contextPath}/user/search" class="sidebar-link"><span class="link-icon"><i class="fa-solid fa-magnifying-glass"></i></span> Find Donors</a>
                <a href="${pageContext.request.contextPath}/user/request-form.jsp" class="sidebar-link"><span class="link-icon"><i class="fa-solid fa-droplet"></i></span> Request Blood</a>
                <a href="${pageContext.request.contextPath}/user/request" class="sidebar-link"><span class="link-icon"><i class="fa-solid fa-clipboard-list"></i></span> My Requests</a>
                <a href="${pageContext.request.contextPath}/user/wishlist" class="sidebar-link"><span class="link-icon"><i class="fa-solid fa-star"></i></span> Wishlist</a>
            </nav>
        </aside>

        <main class="main-content">
            <div class="dashboard-hero">
                <div class="hero-badge"><i class="fa-solid fa-droplet"></i></div>
                <div class="hero-copy-block">
                    <div class="hero-title-row">
                        <h1>Welcome, ${sessionScope.user.fullName}</h1>
                        <span class="badge badge-approved">${sessionScope.user.status}</span>
                    </div>
                    <p class="hero-support">Your donation activity, requests, and account information are gathered here so you can act quickly without hunting through menus.</p>
                </div>
                <div class="hero-stats">
                    <div class="mini-stat">
                        <span>Blood Type</span>
                        <strong>${sessionScope.user.bloodType}</strong>
                    </div>
                    <div class="mini-stat">
                        <span>Requests</span>
                        <strong>${totalRequests}</strong>
                    </div>
                    <div class="mini-stat">
                        <span>Location</span>
                        <strong>${sessionScope.user.location}</strong>
                    </div>
                </div>
            </div>

            <div class="metric-grid">
                <div class="metric-card">
                    <h4>My Blood Type</h4>
                    <div class="value" style="color: var(--crimson);">${sessionScope.user.bloodType}</div>
                </div>
                <div class="metric-card metric-card-ok">
                    <h4>Account Status</h4>
                    <div class="value"><small style="text-transform:capitalize; font-size:1.1rem;">${sessionScope.user.status}</small></div>
                </div>
                <div class="metric-card">
                    <h4>Total Requests</h4>
                    <div class="value" data-target="${totalRequests}">${totalRequests}</div>
                </div>
                <div class="metric-card metric-card-ok">
                    <h4>Fulfilled</h4>
                    <div class="value" data-target="${fulfilledRequests}">${fulfilledRequests}</div>
                </div>
                <div class="metric-card metric-card-warn">
                    <h4>Pending</h4>
                    <div class="value" data-target="${pendingRequests}">${pendingRequests}</div>
                </div>
            </div>

            <div class="quick-action-grid">
                <a class="quick-action-card" href="${pageContext.request.contextPath}/user/search">
                    <div class="quick-action-top">
                        <div class="quick-action-icon"><i class="fa-solid fa-magnifying-glass"></i></div>
                        <span class="quick-action-arrow">&#x2192;</span>
                    </div>
                    <h3>Find Donors</h3>
                    <p>Search by blood group and location to find compatible donors near you.</p>
                    <span class="btn btn-outline btn-sm">Open search</span>
                </a>
                <a class="quick-action-card" href="${pageContext.request.contextPath}/user/request-form.jsp">
                    <div class="quick-action-top">
                        <div class="quick-action-icon"><i class="fa-solid fa-droplet"></i></div>
                        <span class="quick-action-arrow">&#x2192;</span>
                    </div>
                    <h3>Request Blood</h3>
                    <p>Submit a request with urgency and hospital details in a few fields.</p>
                    <span class="btn btn-outline btn-sm">New request</span>
                </a>
                <a class="quick-action-card" href="${pageContext.request.contextPath}/user/profile">
                    <div class="quick-action-top">
                        <div class="quick-action-icon"><i class="fa-regular fa-user"></i></div>
                        <span class="quick-action-arrow">&#x2192;</span>
                    </div>
                    <h3>My Profile</h3>
                    <p>Keep your personal and contact details current for approval and follow-up.</p>
                    <span class="btn btn-outline btn-sm">Edit profile</span>
                </a>
            </div>

            <div class="section-card">
                <div class="toolbar-row">
                    <div>
                        <h3><i class="fa-solid fa-clipboard-list" style="color:var(--accent)"></i> Request History</h3>
                        <p class="hero-support">Latest requests from your account, with status shown inline.</p>
                    </div>
                    <div class="toolbar-actions">
                        <a href="${pageContext.request.contextPath}/user/request" class="btn btn-outline btn-sm">View All</a>
                        <a href="${pageContext.request.contextPath}/user/request-form.jsp" class="btn btn-primary btn-sm">+ New Request</a>
                    </div>
                </div>
                <c:choose>
                    <c:when test="${empty myRequests}">
                        <p class="table-empty">You have not made any blood requests yet. <a href="${pageContext.request.contextPath}/user/request-form.jsp">Submit one now</a>.</p>
                    </c:when>
                    <c:otherwise>
                        <div class="table-scroll"><div class="table-container"><table class="data-table">
                            <thead>
                                <tr>
                                    <th>Patient</th>
                                    <th>Hospital</th>
                                    <th>Blood Type</th>
                                    <th>Units</th>
                                    <th>Urgency</th>
                                    <th>Status</th>
                                    <th>Date</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="req" items="${myRequests}" end="4">
                                    <tr>
                                        <td style="font-weight: 600;">${req.patientName}</td>
                                        <td>${req.hospitalName}</td>
                                        <td><span class="badge badge-blood">${req.bloodTypeNeeded}</span></td>
                                        <td style="font-weight: 700;">${req.unitsRequired}</td>
                                        <td>
                                            <span class="badge badge-${req.urgencyLevel == 'CRITICAL' ? 'critical' : (req.urgencyLevel == 'HIGH' ? 'high' : (req.urgencyLevel == 'MEDIUM' ? 'medium' : 'low'))}">
                                                ${req.urgencyLevel}
                                            </span>
                                        </td>
                                        <td><span class="badge badge-${req.status}">${req.status}</span></td>
                                        <td style="font-size:0.85rem; color:var(--stone);">${req.requestedAt}</td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table></div></div>
                    </c:otherwise>
                </c:choose>
            </div>
        </main>
    </div>

    <script src="${pageContext.request.contextPath}/js/main.js?v=20260414"></script>
</body>
</html>



