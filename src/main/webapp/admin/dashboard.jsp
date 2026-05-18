<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard — BDMS</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&family=Space+Grotesk:wght@500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" integrity="sha512-DTOQO9RWCH3ppGqcWaEA1BIZOC6xxalwEsw9c2QQeAIftl+Vegovlnee1c9QX4TctnWMn13TZye+giMm8e2LwA==" crossorigin="anonymous" referrerpolicy="no-referrer" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body class="route-admin">
    <!-- Admin Navbar -->
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
                <a href="${pageContext.request.contextPath}/admin/dashboard" class="sidebar-link active">
                    <span class="link-icon"><i class="fa-solid fa-chart-line"></i></span> Overview
                </a>
                <a href="${pageContext.request.contextPath}/admin/request" class="sidebar-link">
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
            <div class="page-header" style="padding-top: 0.25rem; margin-bottom: 0.25rem;">
                <h2>Admin Dashboard</h2>
            </div>

            <div class="metric-grid">
                <div class="metric-card metric-card-info">
                    <div class="metric-icon"><i class="fa-solid fa-users"></i></div>
                    <h4>Total Donors</h4>
                    <div class="value" data-target="${totalCounts.totalDonors}">${totalCounts.totalDonors}</div>
                    <div class="metric-subtitle">Registered and approved</div>
                </div>
                <div class="metric-card metric-card-ok">
                    <div class="metric-icon"><i class="fa-solid fa-clipboard-list"></i></div>
                    <h4>Pending Requests</h4>
                    <div class="value" data-target="${requests.size()}">${requests.size()}</div>
                    <div class="metric-subtitle">Waiting for review</div>
                </div>
                <div class="metric-card">
                    <div class="metric-icon"><i class="fa-solid fa-droplet"></i></div>
                    <h4>Total Requests</h4>
                    <div class="value" data-target="${totalCounts.totalRequests}">${totalCounts.totalRequests}</div>
                    <div class="metric-subtitle">System-wide request volume</div>
                </div>
                <div class="metric-card metric-card-ok">
                    <div class="metric-icon"><i class="fa-solid fa-vial"></i></div>
                    <h4>Active Users</h4>
                    <div class="value" data-target="${totalCounts.totalUsers}">${totalCounts.totalUsers}</div>
                    <div class="metric-subtitle">Patients and donors online</div>
                </div>
            </div>

            <div class="section-card">
                <div class="toolbar-row">
                    <div>
                        <h3>Donor Management</h3>
                        <p class="hero-support">Review registrations before they join the donor network.</p>
                    </div>
                    <a href="${pageContext.request.contextPath}/admin/users" class="btn btn-outline btn-sm">Export</a>
                </div>
                <c:choose>
                    <c:when test="${empty pendingUsers}">
                        <p class="table-empty">No pending registrations right now.</p>
                    </c:when>
                    <c:otherwise>
                        <div class="table-scroll"><div class="table-container"><table class="data-table">
                            <thead>
                                <tr>
                                    <th>Name</th>
                                    <th>Email</th>
                                    <th>Blood Type</th>
                                    <th>Location</th>
                                    <th>Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="user" items="${pendingUsers}" end="4">
                                    <tr>
                                        <td style="font-weight: 600;">${user.fullName}</td>
                                        <td>${user.email}</td>
                                        <td><span class="badge badge-blood">${user.bloodType}</span></td>
                                        <td>${user.location}</td>
                                        <td>
                                            <div class="action-group">
                                                <form action="${pageContext.request.contextPath}/admin/users" method="post" class="inline-form">
                                                    <input type="hidden" name="action" value="approve">
                                                    <input type="hidden" name="userId" value="${user.userId}">
                                                    <button type="submit" class="btn btn-success btn-sm"><i class="fa-solid fa-check"></i></button>
                                                </form>
                                                <form action="${pageContext.request.contextPath}/admin/users" method="post" class="inline-form">
                                                    <input type="hidden" name="action" value="reject">
                                                    <input type="hidden" name="userId" value="${user.userId}">
                                                    <button type="submit" class="btn btn-danger btn-sm"><i class="fa-solid fa-xmark"></i></button>
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

            <!-- Blood Inventory Cards -->
            <div class="section-card">
                <div class="toolbar-row">
                    <div>
                        <h3>Blood Inventory Status</h3>
                        <p class="hero-support">Current stock across all blood types.</p>
                    </div>
                </div>
                <div class="metric-grid">
                <c:forEach var="inv" items="${inventory}">
                    <div class="metric-card ${inv.unitsAvailable < 5 ? 'metric-card-low' : 'metric-card-ok'}">
                        <h4>Type ${inv.bloodType}</h4>
                        <div class="value">${inv.unitsAvailable} <small>units</small></div>
                    </div>
                </c:forEach>
                </div>
            </div>

            <!-- Pending Requests Table -->
            <div class="section-card">
                <div class="toolbar-row">
                    <div>
                        <h3>Blood Requests</h3>
                        <p class="hero-support">One place to fulfill or reject active requests.</p>
                    </div>
                    <a href="${pageContext.request.contextPath}/admin/request" class="btn btn-outline btn-sm">View All</a>
                </div>
                <c:choose>
                    <c:when test="${empty requests}">
                        <p class="table-empty">No pending blood requests at the moment.</p>
                    </c:when>
                    <c:otherwise>
                        <div class="table-scroll"><div class="table-container"><table class="data-table">
                            <thead>
                                <tr>
                                    <th>ID</th>
                                    <th>Patient</th>
                                    <th>Blood Type</th>
                                    <th>Units</th>
                                    <th>Urgency</th>
                                    <th>Action</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="req" items="${requests}">
                                    <tr>
                                        <td>#${req.requestId}</td>
                                        <td>
                                            <strong>${req.patientName}</strong><br>
                                            <span style="font-size:0.8rem; color:var(--stone);">${req.hospitalName}</span>
                                        </td>
                                        <td><span class="badge badge-blood">${req.bloodTypeNeeded}</span></td>
                                        <td style="font-weight:700;">${req.unitsRequired}</td>
                                        <td>
                                            <span class="badge badge-${req.urgencyLevel == 'CRITICAL' ? 'critical' : (req.urgencyLevel == 'HIGH' ? 'high' : (req.urgencyLevel == 'MEDIUM' ? 'medium' : 'low'))}">
                                                ${req.urgencyLevel}
                                            </span>
                                        </td>
                                        <td>
                                            <div class="action-group">
                                                <form action="${pageContext.request.contextPath}/admin/request" method="post" class="inline-form">
                                                    <input type="hidden" name="action" value="fulfill">
                                                    <input type="hidden" name="requestId" value="${req.requestId}">
                                                    <input type="hidden" name="bloodType" value="${req.bloodTypeNeeded}">
                                                    <input type="hidden" name="units" value="${req.unitsRequired}">
                                                    <button type="submit" class="btn btn-success btn-sm" onclick="return confirm('Fulfill this request using inventory?');">Fulfill</button>
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



