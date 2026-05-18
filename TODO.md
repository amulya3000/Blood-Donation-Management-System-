# BDMS Fix Tracker

## SECTION 1 — js/main.js
- [x] DELETE setupTheme() method
- [x] DELETE setupThemeToggle() method
- [x] DELETE calls in init()
- [x] ADD setupSidebarDrawer()
- [x] ADD hamburger open/close state in setupMenu()
- [x] ADD setupFormValidation()
- [x] ADD setupPasswordStrength()
- [x] ADD setupPasswordToggle()
- [x] ADD bdmsToast API
- [x] ADD submit button loading state

## SECTION 2 — css/style.css
- [x] DELETE html[data-theme='dark'] root block
- [x] DELETE html[data-theme='dark'] selectors at bottom
- [x] DELETE .theme-toggle CSS
- [x] ADD missing :root custom properties
- [x] ADD missing CSS classes (.glass-panel, .split-grid, .profile-avatar, .profile-copy, .empty-state, .about-card-icon, .metric-card-low, .form-container, .sidebar-brand)
- [x] FIX .hamburger hover state
- [x] ADD .sidebar-toggle / .sidebar-overlay / .sidebar.open mobile rules
- [x] FIX badge severity mapping
- [x] ADD .btn.loading spinner
- [x] ADD input validation states
- [x] ADD password strength bar classes
- [x] ADD .input-wrap CSS
- [x] ADD toast system classes
- [x] FIX .cta-shell accent border + gradient

## SECTION 3 — JSP Fixes
- [x] login.jsp — hamburger, password wrap, toastContainer
- [x] register.jsp — hamburger, password wraps, confirm main.js
- [x] contact.jsp — hamburger, form-label classes
- [x] about.jsp — replace var(--accent), about-content padding
- [x] user/dashboard.jsp — fix vars, add toastContainer
- [x] user/profile.jsp — fix vars, toolbar-row, donation history empty state
- [x] user/my-requests.jsp — fix vars, date display
- [x] user/wishlist.jsp — fix title, vars, toastContainer
- [x] user/search.jsp — fix vars, result count
- [x] user/request-form.jsp — add toastContainer
- [x] admin/dashboard.jsp — meta tags, fix vars, null-safe size
- [x] admin/manage-donors.jsp — fix broken badge HTML, dangling input, available property, vars, toastContainer
- [x] admin/manage-users.jsp — fix vars, remove animation:none
- [x] admin/reports.jsp — fix all undefined vars
- [x] admin/inventory.jsp — add toastContainer
- [x] error/404.jsp — fix vars, button label
- [x] error/500.jsp — fix vars

## SECTION 4 — Duplicate JSP Cleanup
- [ ] DELETE /WEB-INF/views/ tree (dead code)

## SECTION 5 — Servlet / Backend
- [x] WishlistServlet.java — add session success message
- [x] web.xml — add 403 error-page mapping

## SECTION 6 — Final Polish
- [x] Add toastContainer to all dashboard pages
- [x] contact.jsp form labels
- [x] about.jsp bottom padding
- [x] Auth footer mobile collapse
- [x] Remove dead animation:none
- [x] Global undefined CSS var replacement

