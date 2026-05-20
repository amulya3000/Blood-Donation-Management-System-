package com.bdms.inventory.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/admin/inventory")
public class InventoryServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        new ViewBloodServlet().handle(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        if (action == null || action.trim().isEmpty() || "add".equalsIgnoreCase(action) || "restock".equalsIgnoreCase(action)) {
            new AddBloodServlet().handle(request, response);
            return;
        }

        if ("delete".equalsIgnoreCase(action) || "deduct".equalsIgnoreCase(action)) {
            new DeleteBloodServlet().handle(request, response);
            return;
        }

        if ("update".equalsIgnoreCase(action) || "set".equalsIgnoreCase(action)) {
            new UpdateBloodServlet().handle(request, response);
            return;
        }

        request.getSession().setAttribute("error", "Unsupported inventory action.");

        response.sendRedirect(request.getContextPath() + "/admin/inventory");
    }

    public void handle(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        if ("GET".equalsIgnoreCase(request.getMethod())) {
            doGet(request, response);
        } else {
            doPost(request, response);
        }
    }
}
