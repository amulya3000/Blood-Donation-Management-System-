package com.bdms.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.bdms.dao.BloodRequestDAO;
import com.bdms.dao.UserDAO;
import com.bdms.model.BloodRequest;
import com.bdms.model.DonorProfile;
import com.bdms.model.User;
import com.bdms.service.BloodDonorService;
import com.bdms.service.BloodInventoryService;
import com.bdms.service.ReportService;

/**
 * Controller for the main dashboard pages (both admin and user). Loads relevant
 * statistics and forwards to the appropriate view.
 */
@WebServlet({"/admin/dashboard", "/user/dashboard"})
public class DashboardServlet extends HttpServlet {

    private final BloodRequestDAO requestDAO = new BloodRequestDAO();
    private final UserDAO userDAO = new UserDAO();
    private final BloodInventoryService inventoryService = new BloodInventoryService();
    private final BloodDonorService donorService = new BloodDonorService();
    private final ReportService reportService = new ReportService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        User user = (User) session.getAttribute("user");
        String path = request.getServletPath();

        if (path.startsWith("/admin")) {
            loadAdminDashboard(request);
            request.getRequestDispatcher("/admin/dashboard.jsp").forward(request, response);
        } else {
            loadUserDashboard(request, user);
            request.getRequestDispatcher("/user/dashboard.jsp").forward(request, response);
        }
    }

    /**
     * Loads admin-specific data: inventory, pending requests, pending users,
     * donor statistics, and aggregate counts.
     */
    private void loadAdminDashboard(HttpServletRequest request) {
        request.setAttribute("requests", requestDAO.getAllPendingRequests());
        request.setAttribute("inventory", inventoryService.getBloodStock());
        request.setAttribute("pendingUsers", userDAO.getPendingUsers());
        request.setAttribute("totalCounts", reportService.getTotalCounts());
        request.setAttribute("donorStats", reportService.getDonorsByBloodType());
    }

    /**
     * Loads user-specific data: their requests, donor profile, and request
     * counts.
     */
    private void loadUserDashboard(HttpServletRequest request, User user) {
        List<BloodRequest> myRequests = requestDAO.getRequestsByUserId(user.getUserId());
        request.setAttribute("myRequests", myRequests);

        // Count requests by status
        long totalReqs = myRequests.size();
        long pendingReqs = myRequests.stream().filter(r -> "pending".equals(r.getStatus())).count();
        long fulfilledReqs = myRequests.stream().filter(r -> "fulfilled".equals(r.getStatus())).count();
        request.setAttribute("totalRequests", totalReqs);
        request.setAttribute("pendingRequests", pendingReqs);
        request.setAttribute("fulfilledRequests", fulfilledReqs);

        // Load donor profile if exists
        DonorProfile profile = donorService.getDonorProfile(user.getUserId());
        request.setAttribute("donorProfile", profile);
    }
}
