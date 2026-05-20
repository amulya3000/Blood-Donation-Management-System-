<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Reports — BDMS Admin</title>
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
                <a href="${pageContext.request.contextPath}/admin/donors" class="sidebar-link"><span class="link-icon"><i class="fa-solid fa-vial"></i></span> Manage Donors</a>
                <a href="${pageContext.request.contextPath}/admin/inventory" class="sidebar-link"><span class="link-icon"><i class="fa-solid fa-box-open"></i></span> Inventory</a>
                <a href="${pageContext.request.contextPath}/admin/reports" class="sidebar-link active"><span class="link-icon"><i class="fa-solid fa-chart-column"></i></span> Reports</a>
            </nav>
        </aside>
        <div class="sidebar-overlay"></div>

        <main class="main-content">
            <div class="control-hero">
                <div class="hero-badge"><i class="fa-solid fa-chart-column"></i></div>
                <div class="hero-copy-block">
                    <div class="control-title-row"><h1>Reports &amp; Analytics</h1><span class="badge badge-approved">Insights</span></div>
                    <p class="control-support">Read the system at a glance: donors, requests, fulfillment, and volume trends.</p>
                </div>
            </div>

            <!-- Summary Counts -->
            <div class="metric-grid">
                <div class="metric-card metric-card-info">
                    <div class="metric-icon"><i class="fa-solid fa-circle-user"></i></div>
                    <h4>Total Users</h4>
                    <div class="value" data-target="${totalCounts.totalUsers}">${totalCounts.totalUsers}</div>
                    <div class="metric-subtitle">Registered accounts</div>
                </div>
                <div class="metric-card metric-card-ok">
                    <div class="metric-icon"><i class="fa-solid fa-users"></i></div>
                    <h4>Active Donors</h4>
                    <div class="value" data-target="${totalCounts.totalDonors}">${totalCounts.totalDonors}</div>
                    <div class="metric-subtitle">Approved and available</div>
                </div>
                <div class="metric-card">
                    <div class="metric-icon"><i class="fa-solid fa-droplet"></i></div>
                    <h4>Total Requests</h4>
                    <div class="value" data-target="${totalCounts.totalRequests}">${totalCounts.totalRequests}</div>
                    <div class="metric-subtitle">All-time volume</div>
                </div>
                <div class="metric-card metric-card-ok">
                    <div class="metric-icon"><i class="fa-solid fa-circle-check"></i></div>
                    <h4>Fulfilled</h4>
                    <div class="value" data-target="${totalCounts.fulfilledRequests}">${totalCounts.fulfilledRequests}</div>
                    <div class="metric-subtitle">Successfully completed</div>
                </div>
            </div>

<div class="report-row">
                <!-- Donors by Blood Type -->
                <div class="section-card">
                    <div class="toolbar-row">
                        <h3><i class="fa-solid fa-droplet" style="color:var(--accent)"></i> Donors by Blood Type</h3>
                    </div>
                    <c:choose>
                        <c:when test="${not empty donorsByBloodType}">
<div class="blood-type-grid">
                                <c:forEach var="entry" items="${donorsByBloodType}">
                                    <div class="blood-type-card">
                                        <div class="blood-drop-icon">
                                            <i class="fa-solid fa-droplet"></i>
                                        </div>
                                        <div class="blood-type-name">${entry.key}</div>
                                        <div class="blood-type-count">${entry.value}</div>
                                        <div class="blood-type-label">donors</div>
                                    </div>
                                </c:forEach>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <div class="empty-state">
                                <div class="empty-state-icon"><i class="fa-solid fa-users-slash"></i></div>
                                <h3>No Donors Yet</h3>
                                <p>No approved donors registered in the system.</p>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>

                <!-- Most Requested Blood Types -->
                <div class="section-card">
                    <div class="toolbar-row">
                        <h3><i class="fa-solid fa-heart-pulse" style="color:var(--accent)"></i> Most Requested Blood Types</h3>
                    </div>
                    <c:choose>
                        <c:when test="${not empty mostRequested}">
                            <div class="blood-type-grid">
                                <c:forEach var="entry" items="${mostRequested}">
                                    <div class="blood-type-card request-card">
                                        <div class="blood-drop-icon">
                                            <i class="fa-solid fa-heart-pulse"></i>
                                        </div>
                                        <div class="blood-type-name">${entry.key}</div>
                                        <div class="blood-type-count">${entry.value}</div>
                                        <div class="blood-type-label">requests</div>
                                    </div>
                                </c:forEach>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <div class="empty-state">
                                <div class="empty-state-icon"><i class="fa-solid fa-clipboard-list"></i></div>
                                <h3>No Requests Yet</h3>
                                <p>No blood requests made to the system.</p>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>

            <!-- Fulfillment Rate Table -->
            <div class="section-card">
                <div class="toolbar-row"><div><h3><i class="fa-solid fa-chart-column" style="color:var(--accent)"></i> Request Fulfillment Summary</h3></div></div>
                <div class="table-scroll"><div class="table-container"><table class="data-table">
                    <thead>
                        <tr>
                            <th>Metric</th>
                            <th>Count</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>Total Requests</td>
                            <td style="font-weight: 700;">${fulfillmentStats.total}</td>
                        </tr>
                        <tr>
                            <td><i class="fa-solid fa-check" style="color:var(--success)"></i> Fulfilled</td>
                            <td style="font-weight: 700; color: var(--success);">${fulfillmentStats.fulfilled}</td>
                        </tr>
                        <tr>
                            <td><i class="fa-regular fa-hourglass-half" style="color:var(--warning)"></i> Pending</td>
                            <td style="font-weight: 700; color: var(--warning);">${fulfillmentStats.pending}</td>
                        </tr>
                        <tr>
                            <td><i class="fa-solid fa-xmark" style="color:var(--danger)"></i> Rejected</td>
                            <td style="font-weight: 700; color: var(--danger);">${fulfillmentStats.rejected}</td>
                        </tr>
                    </tbody>
                </table></div></div>
            </div>
        </main>
    </div>

    <script src="${pageContext.request.contextPath}/js/main.js?v=20260414"></script>
</body>
</html>
