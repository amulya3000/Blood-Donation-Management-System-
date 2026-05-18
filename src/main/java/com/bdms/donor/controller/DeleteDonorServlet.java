package com.bdms.donor.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.bdms.service.BloodDonorService;

@WebServlet("/admin/donor/delete")
public class DeleteDonorServlet extends HttpServlet {

    private final BloodDonorService donorService = new BloodDonorService();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int userId = Integer.parseInt(request.getParameter("userId"));
        donorService.deleteDonor(userId);
        request.getSession().setAttribute("success", "Donor profile removed.");
        response.sendRedirect(request.getContextPath() + "/admin/donor/view");
    }
}
