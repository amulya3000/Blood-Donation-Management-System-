<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Requests — BDMS Admin</title>
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
        <a href="${pageContext.request.contextPath}/admin/dashboard" class="nav-brand">
            <span class="brand-icon"><i class="fa-solid fa-droplet"></i></span> BDMS Admin
        </a>
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
                <a href="${pageContext.request.contextPath}/admin/dashboard" class="sidebar-link">
                    <span class="link-icon"><i class="fa-solid fa-chart-line"></i></span> Overview
                </a>
                <a href="${pageContext.request.contextPath}/admin/request" class="sidebar-link active">
                    <span class="link-icon"><i class="fa-solid fa-droplet"></i></span> Blood Requests
                </a>
                <a href="${pageContext.request.contextPath}/admin/users" class="sidebar-link">
                    <span class="link-icon"><i class="fa-solid fa-users"></i></span> Manage Users
                </a>
                <a href="${pageContext.request.contextPath}/admin/donors" class="sidebar-link">
                    <span class="link-icon"><i class="fa-solid fa-vial"></i></span> Manage Donors
                </a>
                <a href="${pageContext.request.contextPath}/admin/inventory" class="sidebar-link">
                    <span class="link-icon"><i class="fa-solid fa-box-open"></i></span> Inventory
                </a>
                <a href="${pageContext.request.contextPath}/admin/reports" class="sidebar-link">
                    <span class="link-icon"><i class="fa-solid fa-chart-column"></i></span> Reports
                </a>
            </nav>
        </aside>
        <div class="sidebar-overlay"></div>

        <main class="main-content">
            <div class="control-hero">
                <div class="hero-badge"><i class="fa-solid fa-droplet"></i></div>
                <div class="hero-copy-block">
                    <div class="control-title-row"><h1>Pending Blood Requests</h1><span class="badge badge-critical">Urgent Queue</span></div>
                    <p class="control-support">Review, fulfill, or reject requests before they sit too long in the queue.</p>
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
            <c:if test="${not empty error}">
                <div class="alert alert-error">${error}</div>
            </c:if>

            <div class="section-card">
                <c:choose>
                    <c:when test="${empty requests}">
                        <p class="table-empty">No pending requests at the moment.</p>
                    </c:when>
                    <c:otherwise>
                        <div class="table-scroll"><div class="table-container"><table class="data-table">
                            <thead>
                                <tr>
                                    <th>ID</th>
                                    <th>Patient</th>
                                    <th>Hospital</th>
                                    <th>Blood Type</th>
                                    <th>Units</th>
                                    <th>Urgency</th>
                                    <th>Requested By</th>
                                    <th>Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="req" items="${requests}">
                                    <tr>
                                        <td>#${req.requestId}</td>
                                        <td style="font-weight: 600;">${req.patientName}</td>
                                        <td>${req.hospitalName}</td>
                                        <td><span class="badge badge-blood">${req.bloodTypeNeeded}</span></td>
                                        <td style="font-weight: 700;">${req.unitsRequired}</td>
                                        <td>
                                            <span class="badge badge-${req.urgencyLevel == 'CRITICAL' ? 'critical' : (req.urgencyLevel == 'HIGH' ? 'high' : (req.urgencyLevel == 'MEDIUM' ? 'medium' : 'low'))}">
                                                ${req.urgencyLevel}
                                            </span>
                                        </td>
                                        <td>${req.requester.fullName}</td>
                                        <td>
                                            <div class="action-group">
                                                <form action="${pageContext.request.contextPath}/admin/request" method="post" class="inline-form">
                                                    <input type="hidden" name="action" value="fulfill">
                                                    <input type="hidden" name="requestId" value="${req.requestId}">
                                                    <input type="hidden" name="bloodType" value="${req.bloodTypeNeeded}">
                                                    <input type="hidden" name="units" value="${req.unitsRequired}">
                                                    <button type="submit" class="btn btn-success btn-sm" onclick="return confirm('Fulfill this request?');">Fulfill</button>
                                                </form>
                                                <form action="${pageContext.request.contextPath}/admin/request" method="post" class="inline-form">
                                                    <input type="hidden" name="action" value="reject">
                                                    <input type="hidden" name="requestId" value="${req.requestId}">
                                                    <button type="submit" class="btn btn-danger btn-sm" onclick="return confirm('Reject this request?');">Reject</button>
                                                </form>
                                            </div>
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



