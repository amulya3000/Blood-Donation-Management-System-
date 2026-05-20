package com.bdms.report.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.bdms.service.ReportService;

@WebServlet("/admin/reports")
public class ReportServlet extends HttpServlet {

    private final ReportService reportService = new ReportService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setAttribute("donorsByBloodType", reportService.getDonorsByBloodType());
        request.setAttribute("fulfillmentStats", reportService.getRequestFulfillmentRate());
        request.setAttribute("mostRequested", reportService.getMostRequestedBloodTypes());
        request.setAttribute("totalCounts", reportService.getTotalCounts());

        request.getRequestDispatcher("/admin/reports.jsp").forward(request, response);
    }
}