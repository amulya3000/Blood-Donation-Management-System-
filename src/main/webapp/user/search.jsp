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
                <a href="${pageContext.request.contextPath}/user/search" class="sidebar-link active"><span class="link-icon"><i class="fa-solid fa-magnifying-glass"></i></span> Find Donors</a>
                <a href="${pageContext.request.contextPath}/user/request-form.jsp" class="sidebar-link"><span class="link-icon"><i class="fa-solid fa-droplet"></i></span> Request Blood</a>
                <a href="${pageContext.request.contextPath}/user/request" class="sidebar-link"><span class="link-icon"><i class="fa-solid fa-clipboard-list"></i></span> My Requests</a>
                <a href="${pageContext.request.contextPath}/user/wishlist" class="sidebar-link"><span class="link-icon"><i class="fa-solid fa-star"></i></span> Wishlist</a>
            </nav>
        </aside>

        <main class="main-content">
            <div class="control-hero">
                <div class="hero-badge"><i class="fa-solid fa-magnifying-glass"></i></div>
                <div class="hero-copy-block">
                    <div class="control-title-row"><h1>Find Available Donors</h1><span class="badge badge-approved">Search</span></div>
                    <p class="control-support">Filter approved donors by blood group and location using a simple, direct search flow.</p>
                </div>
            </div>

            <div class="section-card">
                <form action="${pageContext.request.contextPath}/user/search" method="get" class="form-grid">
                    <div class="form-group">
                        <label class="form-label">Blood Type</label>
                        <select name="bloodType" class="form-control">
                            <option value="">All Types</option>
                            <option value="A+" ${param.bloodType == 'A+' ? 'selected' : ''}>A+</option>
                            <option value="A-" ${param.bloodType == 'A-' ? 'selected' : ''}>A-</option>
                            <option value="B+" ${param.bloodType == 'B+' ? 'selected' : ''}>B+</option>
                            <option value="B-" ${param.bloodType == 'B-' ? 'selected' : ''}>B-</option>
                            <option value="AB+" ${param.bloodType == 'AB+' ? 'selected' : ''}>AB+</option>
                            <option value="AB-" ${param.bloodType == 'AB-' ? 'selected' : ''}>AB-</option>
                            <option value="O+" ${param.bloodType == 'O+' ? 'selected' : ''}>O+</option>
                            <option value="O-" ${param.bloodType == 'O-' ? 'selected' : ''}>O-</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label class="form-label">Location</label>
                        <input type="text" name="location" class="form-control" value="${param.location}" placeholder="City or district">
                    </div>
                    <div class="form-group" style="display:flex; align-items:flex-end;">
                        <button type="submit" class="btn btn-primary">Search</button>
                    </div>
                </form>
            </div>

            <div class="section-card">
                <c:choose>
                    <c:when test="${noResults}">
                        <p class="table-empty">No donors matched your search criteria. Try different filters.</p>
                    </c:when>
                    <c:when test="${empty donors}">
                        <p class="table-empty">Use the search form above to find approved donors in the system.</p>
                    </c:when>
                    <c:otherwise>
                        <div class="table-header">
                            <h3><i class="fa-solid fa-magnifying-glass" style="color:var(--accent)"></i> Search Results</h3>
                        </div>
                        <div class="table-scroll"><div class="table-container"><table class="data-table">
                            <thead>
                                <tr>
                                    <th>Name</th>
                                    <th>Blood Type</th>
                                    <th>Location</th>
                                    <th>Email</th>
                                    <th>Phone</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="donor" items="${donors}">
                                    <tr>
                                        <td style="font-weight: 600;">${donor.fullName}</td>
                                        <td><span class="badge badge-blood">${donor.bloodType}</span></td>
                                        <td><i class="fa-solid fa-location-dot"></i> ${donor.location}</td>
                                        <td><i class="fa-solid fa-envelope"></i> ${donor.email}</td>
                                        <td><i class="fa-solid fa-phone"></i> ${donor.phone}</td>
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



