<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Find Donors — BDMS</title>
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
                <a href="${pageContext.request.contextPath}/user/request-form.jsp" class="sidebar-link"><span class="link-icon"><i class="fa-solid fa-droplet"></i></span> Request Blood</a>
                <a href="${pageContext.request.contextPath}/user/request" class="sidebar-link"><span class="link-icon"><i class="fa-solid fa-clipboard-list"></i></span> My Requests</a>
                <a href="${pageContext.request.contextPath}/user/wishlist" class="sidebar-link active"><span class="link-icon"><i class="fa-solid fa-star"></i></span> Wishlist</a>
            </nav>
        </aside>

        <main class="main-content">
            <div class="control-hero">
                <div class="hero-badge"><i class="fa-solid fa-star"></i></div>
                <div class="hero-copy-block">
                    <div class="control-title-row"><h1>Saved Blood Requests</h1><span class="badge badge-approved">Wishlist</span></div>
                    <p class="control-support">A bookmark list for requests you want to revisit or monitor later.</p>
                </div>
            </div>

            <div class="section-card">
                <c:choose>
                    <c:when test="${empty wishlist}">
                        <div class="empty-state">
                            <i class="fa-solid fa-star fa-3x" style="color:var(--text-dim);margin-bottom:16px;display:block;"></i>
                            <h3 style="margin-bottom:8px;">Your wishlist is empty</h3>
                            <p>Your saved donors list is empty. You can save requests from the <a href="${pageContext.request.contextPath}/user/request">My Requests</a> page.</p>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <table>
                            <thead>
                                <tr>
                                    <th>Patient</th>
                                    <th>Hospital</th>
                                    <th>Blood Type</th>
                                    <th>Units</th>
                                    <th>Urgency</th>
                                    <th>Status</th>
                                    <th>Action</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="req" items="${wishlist}">
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
                                        <td>
                                            <form action="${pageContext.request.contextPath}/user/wishlist" method="post" class="inline-form">
                                                <input type="hidden" name="action" value="remove">
                                                <input type="hidden" name="requestId" value="${req.requestId}">
                                                <button type="submit" class="btn btn-danger btn-sm">Remove</button>
                                            </form>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </c:otherwise>
                </c:choose>
            </div>
        </main>
    </div>

    <script src="${pageContext.request.contextPath}/js/main.js?v=20260414"></script>
</body>
</html>


