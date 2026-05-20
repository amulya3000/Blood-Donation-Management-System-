<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Users — BDMS Admin</title>
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
                <a href="${pageContext.request.contextPath}/admin/dashboard" class="sidebar-link"><span class="link-icon"><i class="fa-solid fa-chart-line"></i></span> Overview</a>
                <a href="${pageContext.request.contextPath}/admin/request" class="sidebar-link"><span class="link-icon"><i class="fa-solid fa-droplet"></i></span> Blood Requests</a>
                <a href="${pageContext.request.contextPath}/admin/users" class="sidebar-link active"><span class="link-icon"><i class="fa-solid fa-users"></i></span> Manage Users</a>
                <a href="${pageContext.request.contextPath}/admin/donors" class="sidebar-link"><span class="link-icon"><i class="fa-solid fa-vial"></i></span> Manage Donors</a>
                <a href="${pageContext.request.contextPath}/admin/inventory" class="sidebar-link"><span class="link-icon"><i class="fa-solid fa-box-open"></i></span> Inventory</a>
                <a href="${pageContext.request.contextPath}/admin/reports" class="sidebar-link"><span class="link-icon"><i class="fa-solid fa-chart-column"></i></span> Reports</a>
            </nav>
        </aside>
        <div class="sidebar-overlay"></div>

        <main class="main-content">
            <div class="control-hero">
                <div class="hero-badge"><i class="fa-solid fa-users"></i></div>
                <div class="hero-copy-block">
                    <div class="control-title-row"><h1>Manage Users</h1><span class="badge badge-pending">Governance</span></div>
                    <p class="control-support">Create accounts, approve registrations, and keep the user base tidy.</p>
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
                        <h3><i class="fa-solid fa-user-plus" style="color:var(--accent)"></i> Add New User</h3>
                        <p class="hero-support">Create a new donor or admin account manually.</p>
                    </div>
                </div>
                <form action="${pageContext.request.contextPath}/admin/users" method="post" class="form-grid">
                        <input type="hidden" name="action" value="add">
                        <div class="form-group">
                            <label class="form-label">Full Name</label>
                            <input type="text" name="fullName" class="form-control" placeholder="Full Name" required>
                        </div>
                        <div class="form-group">
                            <label class="form-label">Email</label>
                            <input type="email" name="email" class="form-control" placeholder="Email" required>
                        </div>
                        <div class="form-group">
                            <label class="form-label">Phone</label>
                            <input type="text" name="phone" class="form-control" placeholder="9800000000" required>
                        </div>
                        <div class="form-group">
                            <label class="form-label">Date of Birth</label>
                            <input type="date" name="dob" class="form-control" required>
                        </div>
                        <div class="form-group">
                            <label class="form-label">Blood Type</label>
                            <select name="bloodType" class="form-control" required>
                                <option value="">Select...</option>
                                <option>A+</option><option>A-</option><option>B+</option><option>B-</option>
                                <option>AB+</option><option>AB-</option><option>O+</option><option>O-</option>
                            </select>
                        </div>
                        <div class="form-group">
                            <label class="form-label">Location</label>
                            <input type="text" name="location" class="form-control" placeholder="City/District" required>
                        </div>
                        <div class="form-group">
                            <label class="form-label">Address</label>
                            <input type="text" name="address" class="form-control" placeholder="Full address" required>
                        </div>
                        <div class="form-group">
                            <label class="form-label">Role</label>
                            <select name="role" class="form-control" required>
                                <option value="user" selected>User</option>
                                <option value="admin">Admin</option>
                            </select>
                        </div>
                        <div class="form-group full-width">
                            <label class="form-label">Password</label>
                            <input type="password" name="password" class="form-control" placeholder="Password" required>
                        </div>
                        <div class="form-group full-width">
                            <button type="submit" class="btn btn-primary">Create User</button>
                        </div>
                </form>
            </div>

            <div class="section-card">
                <div class="toolbar-row">
                    <div><h3><i class="fa-regular fa-hourglass-half" style="color:var(--warning)"></i> Pending Approvals</h3></div>
                </div>
                <c:choose>
                    <c:when test="${empty pendingUsers}">
                        <p class="table-empty">No pending registrations.</p>
                    </c:when>
                    <c:otherwise>
                        <div class="table-scroll"><div class="table-container"><table class="data-table">
                            <thead>
                                <tr>
                                    <th>ID</th><th>Name</th><th>Email</th><th>Phone</th><th>Blood Type</th><th>Location</th><th>Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="user" items="${pendingUsers}">
                                    <tr>
                                        <td>#${user.userId}</td>
                                        <td style="font-weight: 600;">${user.fullName}</td>
                                        <td>${user.email}</td>
                                        <td>${user.phone}</td>
                                        <td><span class="badge badge-blood">${user.bloodType}</span></td>
                                        <td>${user.location}</td>
                                        <td>
                                            <div class="action-group">
                                                <form action="${pageContext.request.contextPath}/admin/users" method="post" class="inline-form">
                                                    <input type="hidden" name="action" value="approve">
                                                    <input type="hidden" name="userId" value="${user.userId}">
                                                    <button type="submit" class="btn btn-success btn-sm" onclick="return confirm('Approve this user?');">Approve</button>
                                                </form>
                                                <form action="${pageContext.request.contextPath}/admin/users" method="post" class="inline-form">
                                                    <input type="hidden" name="action" value="reject">
                                                    <input type="hidden" name="userId" value="${user.userId}">
                                                    <button type="submit" class="btn btn-danger btn-sm" onclick="return confirm('Reject this user?');">Reject</button>
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

            <div class="section-card">
                <div class="toolbar-row"><div><h3><i class="fa-solid fa-users" style="color:var(--accent)"></i> All Users</h3></div></div>
                <div class="table-scroll"><div class="table-container"><table class="data-table">
                    <thead>
                        <tr>
                            <th>ID</th><th>Name</th><th>Email</th><th>Role</th><th>Status</th><th>Location</th><th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="user" items="${allUsers}">
                            <tr>
                                <td>#${user.userId}</td>
                                <td style="font-weight: 600;">${user.fullName}</td>
                                <td>${user.email}</td>
                                <td><span class="badge ${user.role == 'admin' ? 'badge-critical' : 'badge-approved'}" style="animation: none;">${user.role}</span></td>
                                <td><span class="badge badge-${user.status}">${user.status}</span></td>
                                <td>${user.location}</td>
                                <td>
                                    <c:if test="${user.role ne 'admin'}">
                                        <form action="${pageContext.request.contextPath}/admin/users" method="post" class="inline-form" onsubmit="return confirm('Delete this user permanently?');">
                                            <input type="hidden" name="action" value="delete">
                                            <input type="hidden" name="userId" value="${user.userId}">
                                            <button type="submit" class="btn btn-danger btn-sm">Delete</button>
                                        </form>
                                    </c:if>
                                    <c:if test="${user.role eq 'admin'}">
                                        <span style="color: var(--stone); font-size: 0.82rem;">Protected</span>
                                    </c:if>
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


