<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Inventory — BDMS Admin</title>
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
                <a href="${pageContext.request.contextPath}/admin/inventory" class="sidebar-link active"><span class="link-icon"><i class="fa-solid fa-box-open"></i></span> Inventory</a>
                <a href="${pageContext.request.contextPath}/admin/reports" class="sidebar-link"><span class="link-icon"><i class="fa-solid fa-chart-column"></i></span> Reports</a>
            </nav>
        </aside>
        <div class="sidebar-overlay"></div>

        <main class="main-content">
            <div class="control-hero">
                <div class="hero-badge"><i class="fa-solid fa-box-open"></i></div>
                <div class="hero-copy-block">
                    <div class="control-title-row"><h1>Blood Inventory</h1><span class="badge badge-approved">Stock Control</span></div>
                    <p class="control-support">Monitor and restock inventory across every blood type from one calm, readable screen.</p>
                </div>
                <div class="control-stats">
                    <a href="${pageContext.request.contextPath}/admin/request" class="btn btn-outline btn-sm">Requests</a>
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
                <div class="toolbar-row">
                    <div>
                        <h3>Inventory Overview</h3>
                        <p class="hero-support">A quick summary of stock levels by blood type.</p>
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

            <div class="section-card">
                <div class="toolbar-row">
                    <div>
                        <h3><i class="fa-solid fa-box-open" style="color:var(--accent)"></i> Restock Inventory</h3>
                        <p class="hero-support">Add units directly by blood group.</p>
                    </div>
                </div>
                <div class="table-scroll"><div class="table-container"><table class="data-table">
                    <thead>
                        <tr>
                            <th>Blood Type</th>
                            <th>Current Units</th>
                            <th>Restock</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="inv" items="${inventory}">
                            <tr>
                                <td><span class="badge badge-blood">${inv.bloodType}</span></td>
                                <td style="font-weight: 700;">${inv.unitsAvailable}</td>
                                <td>
                                    <form action="${pageContext.request.contextPath}/admin/inventory" method="post" style="display:flex; gap:0.5rem; align-items:center;">
                                        <input type="hidden" name="bloodType" value="${inv.bloodType}">
                                        <input type="number" name="units" step="0.5" min="0.5" class="form-control" style="max-width:120px;" placeholder="Units" required>
                                        <button type="submit" class="btn btn-primary btn-sm">Add</button>
                                    </form>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table></div></div>
            </div>
        </main>
    </div>

    <script src="${pageContext.request.contextPath}/js/main.js?v=20260414"></script>
</body>
</html>


