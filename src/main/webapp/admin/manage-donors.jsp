<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Donors — BDMS Admin</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&family=Space+Grotesk:wght@500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" integrity="sha512-DTOQO9RWCH3ppGqcWaEA1BIZOC6xxalwEsw9c2QQeAIftl+Vegovlnee1c9QX4TctnWMn13TZye+giMm8e2LwA==" crossorigin="anonymous" referrerpolicy="no-referrer" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <meta name="theme-color" content="#C62828">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-status-bar-style" content="default">
    <link rel="apple-touch-icon" href="${pageContext.request.contextPath}/favicon.ico">
</head>
<body class="route-admin">
    <nav class="navbar">
        <button class="hamburger" aria-label="Toggle menu" aria-expanded="false">
            <span></span><span></span><span></span>
        </button>
        <a href="${pageContext.request.contextPath}/admin/dashboard" class="nav-brand"><span class="brand-icon"><i class="fa-solid fa-droplet"></i></span> BDMS Admin</a>
        <div class="nav-links">
            <span class="nav-user-info"><i class="fa-solid fa-shield-halved"></i> Admin Panel</span>
            <a href="${pageContext.request.contextPath}/logout" class="btn btn-outline btn-sm">Logout</a>
        </div>
    </nav>

    <div class="dashboard-layout">
<aside class="sidebar">
            <div class="sidebar-brand" style="padding: 0.25rem 0.75rem 1rem;">
                <div class="nav-brand" style="font-size: 0.98rem;">
                    <span class="brand-icon" style="width: 2rem; height: 2rem; border-radius: 999px; font-size: 0.95rem;"><i class="fa-solid fa-droplet"></i></span>
                    <span>BDMS</span>
                </div>
                <div style="color: var(--muted); font-size: 0.78rem; margin-top: 0.25rem; letter-spacing: 0.04em;">Admin Portal</div>
            </div>
            <nav class="sidebar-nav">
                <span class="sidebar-section-title">Management</span>
                <a href="${pageContext.request.contextPath}/admin/dashboard" class="sidebar-link"><span class="link-icon"><i class="fa-solid fa-chart-line"></i></span> Overview</a>
                <a href="${pageContext.request.contextPath}/admin/request" class="sidebar-link"><span class="link-icon"><i class="fa-solid fa-droplet"></i></span> Blood Requests</a>
                <a href="${pageContext.request.contextPath}/admin/users" class="sidebar-link"><span class="link-icon"><i class="fa-solid fa-users"></i></span> Manage Users</a>
                <a href="${pageContext.request.contextPath}/admin/donors" class="sidebar-link active"><span class="link-icon"><i class="fa-solid fa-vial"></i></span> Manage Donors</a>
                <a href="${pageContext.request.contextPath}/admin/inventory" class="sidebar-link"><span class="link-icon"><i class="fa-solid fa-box-open"></i></span> Inventory</a>
                <a href="${pageContext.request.contextPath}/admin/reports" class="sidebar-link"><span class="link-icon"><i class="fa-solid fa-chart-column"></i></span> Reports</a>
            </nav>
        </aside>
        <div class="sidebar-overlay"></div>

        <main class="main-content">
            <div class="control-hero">
                <div class="hero-badge"><i class="fa-solid fa-vial"></i></div>
                <div class="hero-copy-block">
                    <div class="control-title-row"><h1>Manage Donors</h1><span class="badge badge-approved">Donor Directory</span></div>
                    <p class="control-support">View each donor, their blood type, and whether they are available for donation.</p>
                </div>
            </div>

            <c:if test="${not empty sessionScope.success}">
                <div class="alert alert-success">${sessionScope.success}</div>
                <c:remove var="success" scope="session" />
            </c:if>
            <c:if test="${not empty sessionScope.error}">
                <div class="alert alert-error">${sessionScope.error}</div>
                <c:remove var="error" scope="session" />
            </c:if>

            <div class="section-card">
                <div class="toolbar-row"><div><h3><i class="fa-solid fa-vial" style="color:var(--accent)"></i> Registered Donors</h3></div></div>
                <c:choose>
                    <c:when test="${empty donors}">
                        <div class="empty-state">
                            <div class="empty-state-icon"><i class="fa-solid fa-vial"></i></div>
                            <h3>No Donors Yet</h3>
                            <p>No donors have registered yet.</p>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="table-scroll"><div class="table-container"><table class="data-table">
                            <thead>
                                <tr>
                                    <th>Donor</th>
                                    <th>Blood Type</th>
                                    <th>Location</th>
                                    <th>Phone</th>
                                    <th>Available</th>
                                    <th>Last Donation</th>
                                    <th>Action</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="dp" items="${donors}">
                                    <tr>
                                        <td>
                                            <strong>${dp.user.fullName}</strong><br>
                                            <span style="font-size:0.8rem; color:var(--stone);">${dp.user.email}</span>
                                        </td>
                                        <td><span class="badge badge-blood">${dp.user.bloodType}</span></td>
                                        <td>${dp.user.location}</td>
                                        <td>${dp.user.phone}</td>
                                        <td>
                                            <span class="badge ${dp.available ? 'badge-approved' : 'badge-rejected'}">
                                                ${dp.available ? 'Available' : 'Unavailable'}
                                            </span>
                                        </td>
                                        <td>${dp.lastDonationDate != null ? dp.lastDonationDate : 'Never'}</td>
                                        <td>
                                            <form action="${pageContext.request.contextPath}/admin/donors" method="post" class="inline-form">
                                                <input type="hidden" name="action" value="toggleAvailability">
                                                <input type="hidden" name="userId" value="${dp.userId}">
                                                <button type="submit" class="btn ${dp.available ? 'btn-danger' : 'btn-success'} btn-sm">
                                                    ${dp.available ? 'Mark Unavailable' : 'Mark Available'}
                                                </button>
                                            </form>
                                        </td>
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



