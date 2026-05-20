package com.bdms.donor.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.bdms.service.BloodDonorService;

@WebServlet("/admin/donor/update")
public class UpdateDonorServlet extends HttpServlet {

    private final BloodDonorService donorService = new BloodDonorService();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int userId = Integer.parseInt(request.getParameter("userId"));
        boolean newStatus = Boolean.parseBoolean(request.getParameter("available"));
        donorService.setDonorAvailability(userId, newStatus);
        request.getSession().setAttribute("success", "Donor availability updated successfully.");
        response.sendRedirect(request.getContextPath() + "/admin/donor/view");
    }

    public void handle(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doPost(request, response);
    }
}
