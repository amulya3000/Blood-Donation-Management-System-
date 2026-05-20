package com.bdms.search.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.bdms.model.User;
import com.bdms.service.BloodDonorService;

@WebServlet("/user/search")
public class SearchServlet extends HttpServlet {

    private final BloodDonorService donorService = new BloodDonorService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String bloodType = request.getParameter("bloodType");
        String location = request.getParameter("location");

        List<User> donors = donorService.findDonors(bloodType, location);

        if (donors.isEmpty() && (bloodType != null || location != null)) {
            request.setAttribute("noResults", true);
        }

        request.setAttribute("donors", donors);
        request.getRequestDispatcher("/user/search.jsp").forward(request, response);
    }
}