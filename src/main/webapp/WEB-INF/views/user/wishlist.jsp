<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Wishlist — BDMS</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body class="route-user">

<%-- Include nav partial --%>
<jsp:include page="/WEB-INF/views/partials/user-nav.jsp"/>

<main class="page-container">
    <div class="form-card">
        <div class="form-card__header">
            <h1>Submit Blood Request</h1>
            <p>Fill in the details below. We will match you with available donors.</p>
        </div>

        <%-- Error / Success Alerts --%>
        <c:if test="${not empty error}">
            <div class="alert alert--error">${error}</div>
        </c:if>

        <form action="${pageContext.request.contextPath}/user/request"
              method="post" id="requestForm" novalidate>

            <div class="form-row">
                <div class="form-group">
                    <label for="bloodType">Blood Type Required <span class="required">*</span></label>
                    <select id="bloodType" name="bloodType" required>
                        <option value="">-- Select Blood Type --</option>
                        <c:forEach var="bt" items="${['A+','A-','B+','B-','AB+','AB-','O+','O-']}">
                            <option value="${bt}"
                                    <c:if test="${bloodType == bt}">selected</c:if>>${bt}
                            </option>
                        </c:forEach>
                    </select>
                    <span class="field-error" id="bloodTypeErr"></span>
                </div>

                <div class="form-group">
                    <label for="units">Units Needed <span class="required">*</span></label>
                    <input type="number" id="units" name="units"
                           value="${units}" min="0.5" max="10" step="0.5"
                           placeholder="e.g. 1.5" required>
                    <span class="field-error" id="unitsErr"></span>
                </div>
            </div>

            <div class="form-row">
                <div class="form-group">
                    <label for="urgency">Urgency Level <span class="required">*</span></label>
                    <select id="urgency" name="urgency" required>
                        <option value="">-- Select Urgency --</option>
                        <option value="low"      ${urgency=='low'?'selected':''}>Low</option>
                        <option value="medium"   ${urgency=='medium'?'selected':''}>Medium</option>
                        <option value="high"     ${urgency=='high'?'selected':''}>High</option>
                        <option value="critical" ${urgency=='critical'?'selected':''}>Critical</option>
                    </select>
                </div>

                <div class="form-group">
                    <label for="location">Location (where blood is needed) <span class="required">*</span></label>
                    <input type="text" id="location" name="location"
                           value="${location}" placeholder="e.g. BPKIHS, Dharan" required>
                    <span class="field-error" id="locationErr"></span>
                </div>
            </div>

            <div class="form-group">
                <label for="notes">Additional Notes (optional)</label>
                <textarea id="notes" name="notes" rows="3"
                          placeholder="Patient name, ward number, doctor's contact, or any other details...">${notes}</textarea>
            </div>

            <div class="form-actions">
                <a href="${pageContext.request.contextPath}/user/dashboard"
                   class="btn btn--secondary">Cancel</a>
                <button type="submit" class="btn btn--primary">Submit Request</button>
            </div>
        </form>
    </div>
</main>

<script src="${pageContext.request.contextPath}/js/main.js?v=20260414"></script>
</body>
</html>

