package com.bdms.request.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.bdms.model.User;
import com.bdms.service.RequestService;

@WebServlet("/user/request/cancel")
public class CancelRequestServlet extends HttpServlet {

    private final RequestService requestService = new RequestService();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        User user = (User) session.getAttribute("user");
        try {
            int requestId = Integer.parseInt(request.getParameter("requestId"));
            // verify ownership and status inside RequestService/DAO
            requestService.cancelBloodRequest(user.getUserId(), requestId);
            session.setAttribute("success", "Request #" + requestId + " cancelled.");
        } catch (NumberFormatException e) {
            session.setAttribute("error", "Invalid request ID.");
        } catch (Exception e) {
            session.setAttribute("error", e.getMessage());
        }

        response.sendRedirect(request.getContextPath() + "/user/request/view");
    }

    public void handle(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doPost(request, response);
    }
}
