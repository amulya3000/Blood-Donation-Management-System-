<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Access Denied — BDMS</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" integrity="sha512-DTOQO9RWCH3ppGqcWaEA1BIZOC6xxalwEsw9c2QQeAIftl+Vegovlnee1c9QX4TctnWMn13TZye+giMm8e2LwA==" crossorigin="anonymous" referrerpolicy="no-referrer" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body class="route-public">
    <nav class="navbar">
        <a href="${pageContext.request.contextPath}/" class="nav-brand">
            <span class="brand-icon"><i class="fa-solid fa-droplet"></i></span> BDMS
        </a>
    </nav>

    <div class="error-page">
        <div class="error-card">
            <div class="error-code">403</div>
            <h2>Access Denied</h2>
            <p>You do not have permission to access this page. Please sign in with an authorized account or return to the homepage.</p>
            <div class="error-actions">
                <a class="btn btn-primary" href="${pageContext.request.contextPath}/">Go Home</a>
                <a class="btn btn-outline" href="${pageContext.request.contextPath}/login.jsp">Sign In</a>
            </div>
        </div>
    </div>
</body>
</html>