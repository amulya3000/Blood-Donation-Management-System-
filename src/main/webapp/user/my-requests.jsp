<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Requests — BDMS</title>
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
                <a href="${pageContext.request.contextPath}/user/request" class="sidebar-link active"><span class="link-icon"><i class="fa-solid fa-clipboard-list"></i></span> My Requests</a>
                <a href="${pageContext.request.contextPath}/user/wishlist" class="sidebar-link"><span class="link-icon"><i class="fa-solid fa-star"></i></span> Wishlist</a>
            </nav>
        </aside>

        <main class="main-content">
            <div class="control-hero">
                <div class="hero-badge"><i class="fa-solid fa-clipboard-list"></i></div>
                <div class="hero-copy-block">
                    <div class="control-title-row"><h1>My Blood Requests</h1><span class="badge badge-approved">History</span></div>
                    <p class="control-support">Track every request, from submission to final status, in one uninterrupted list.</p>
                </div>
            </div>

            <c:if test="${not empty sessionScope.success}">
                <div class="alert alert-success">${sessionScope.success}</div>
                <c:remove var="success" scope="session" />
            </c:if>

            <div class="section-card">
                <div class="toolbar-row">
                    <div>
                        <h3><i class="fa-solid fa-clipboard-list" style="color:var(--accent)"></i> Request History</h3>
                        <p class="hero-support">Review the detail and save requests to your wishlist if needed.</p>
                    </div>
                    <a href="${pageContext.request.contextPath}/user/request-form.jsp" class="btn btn-primary btn-sm">+ New Request</a>
                </div>
                <div class="filter-tabs" id="filterTabs">
                    <button class="filter-tab active" data-filter="all" type="button">All</button>
                    <button class="filter-tab" data-filter="PENDING" type="button">Pending</button>
                    <button class="filter-tab" data-filter="APPROVED" type="button">Approved</button>
                    <button class="filter-tab" data-filter="FULFILLED" type="button">Fulfilled</button>
                    <button class="filter-tab" data-filter="REJECTED" type="button">Rejected</button>
                </div>
                <c:choose>
                    <c:when test="${empty requests}">
                        <p class="table-empty">You have not submitted any blood requests yet.</p>
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
                                    <th>Issue Date</th>
                                    <th>Return Date</th>
                                    <th>Requested</th>
                                    <th>Wishlist</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="req" items="${requests}">
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
                                        <td style="font-size:0.85rem;">${req.issueDate != null ? req.issueDate : '—'}</td>
                                        <td style="font-size:0.85rem;">${req.returnDate != null ? req.returnDate : '—'}</td>
                                        <td style="font-size:0.85rem; color:var(--stone);">${req.requestedAt}</td>
                                        <td>
                                            <form action="${pageContext.request.contextPath}/user/wishlist" method="post" class="inline-form">
                                                <input type="hidden" name="action" value="add">
                                                <input type="hidden" name="requestId" value="${req.requestId}">
                                                <button type="submit" class="btn btn-outline btn-sm" title="Save to wishlist" aria-label="Save to wishlist"><i class="fa-solid fa-star"></i></button>
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
        <script>
            (function () {
                var tabs = document.querySelectorAll('.filter-tab');
                if (!tabs.length) return;
                tabs.forEach(function (tab) {
                    tab.addEventListener('click', function () {
                        tabs.forEach(function (t) { t.classList.remove('active'); });
                        this.classList.add('active');
                        var filter = this.dataset.filter;
                        document.querySelectorAll('tbody tr').forEach(function (row) {
                            if (filter === 'all') {
                                row.style.display = '';
                                return;
                            }
                            var statusBadge = row.querySelector('td:nth-child(6) .badge');
                            var match = statusBadge && statusBadge.textContent.trim().toUpperCase() === filter;
                            row.style.display = match ? '' : 'none';
                        });
                    });
                });
            })();
        </script>
</body>
</html>



