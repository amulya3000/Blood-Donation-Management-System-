<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>500 — Server Error — BDMS</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&family=Space+Grotesk:wght@500;600;700;800&display=swap" rel="stylesheet">
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
            <div class="error-code" style="color: var(--warning);">500</div>
            <h2>Server Error</h2>
            <p>Something went wrong on our end. We're working to fix it.</p>
            <div class="error-actions">
                <a href="${pageContext.request.contextPath}/" class="btn btn-primary">Go Home</a>
                <a href="javascript:window.location.reload();" class="btn btn-outline">Try Again</a>
            </div>
            <p style="margin-top: 2rem; font-size: 0.85rem; color: var(--stone);">Please try again in a few minutes or contact support if the problem persists.</p>
        </div>
    </div>
</body>
</html>
