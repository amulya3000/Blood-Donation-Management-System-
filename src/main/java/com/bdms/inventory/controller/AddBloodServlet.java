package com.bdms.inventory.controller;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.bdms.service.BloodInventoryService;

@WebServlet("/admin/inventory/add")
public class AddBloodServlet extends HttpServlet {

    private final BloodInventoryService inventoryService = new BloodInventoryService();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            inventoryService.addBlood(request.getParameter("bloodType"), Double.parseDouble(request.getParameter("units")));
            request.getSession().setAttribute("success", request.getParameter("units") + " units added to " + request.getParameter("bloodType") + ".");
        } catch (NumberFormatException e) {
            request.getSession().setAttribute("error", "Please enter a valid inventory amount.");
        } catch (IllegalArgumentException | SQLException e) {
            request.getSession().setAttribute("error", e.getMessage());
        }
        response.sendRedirect(request.getContextPath() + "/admin/inventory/view");
    }

    public void handle(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doPost(request, response);
    }
}
