package com.bdms.donor.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.bdms.model.DonorProfile;
import com.bdms.service.BloodDonorService;

@WebServlet("/admin/donor/view")
public class ViewDonorServlet extends HttpServlet {

    private final BloodDonorService donorService = new BloodDonorService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<DonorProfile> donors = donorService.getAllDonorsWithUsers();
        request.setAttribute("donors", donors);
        request.getRequestDispatcher("/admin/manage-donors.jsp").forward(request, response);
    }

    public void handle(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
