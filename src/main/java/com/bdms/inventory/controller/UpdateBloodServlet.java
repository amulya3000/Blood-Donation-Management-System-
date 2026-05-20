package com.bdms.inventory.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.bdms.service.BloodInventoryService;

@WebServlet("/admin/inventory/view")
public class UpdateBloodServlet extends HttpServlet {

    private final BloodInventoryService inventoryService = new BloodInventoryService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            request.setAttribute("inventory", inventoryService.getBloodStock());
            request.getRequestDispatcher("/admin/inventory.jsp").forward(request, response);
        } catch (ServletException | IOException e) {
            request.getSession().setAttribute("error", e.getMessage());
            response.sendRedirect(request.getContextPath() + "/admin/dashboard");
        }
    }

    public void handle(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
