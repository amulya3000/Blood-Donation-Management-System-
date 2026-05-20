package com.bdms.request.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.bdms.service.RequestService;

@WebServlet("/admin/request/reject")
public class RejectRequestServlet extends HttpServlet {

    private final RequestService requestService = new RequestService();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            int requestId = Integer.parseInt(request.getParameter("requestId"));
            requestService.rejectBloodRequest(requestId);
            request.getSession().setAttribute("success", "Request #" + requestId + " rejected.");
        } catch (NumberFormatException e) {
            request.getSession().setAttribute("error", "Invalid request ID.");
        } catch (Exception e) {
            request.getSession().setAttribute("error", e.getMessage());
        }
        response.sendRedirect(request.getContextPath() + "/admin/request/view");
    }

    public void handle(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doPost(request, response);
    }
}
