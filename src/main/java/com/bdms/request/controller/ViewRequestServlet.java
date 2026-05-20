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

@WebServlet({"/user/request/view", "/admin/request/view"})
public class ViewRequestServlet extends HttpServlet {

    private final RequestService requestService = new RequestService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String path = request.getServletPath();
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        if (path.startsWith("/admin")) {
            request.setAttribute("requests", requestService.getAllPendingRequests());
            request.getRequestDispatcher("/admin/manage-requests.jsp").forward(request, response);
        } else {
            User user = (User) session.getAttribute("user");
            request.setAttribute("requests", requestService.getRequestsByUserId(user.getUserId()));
            request.getRequestDispatcher("/user/my-requests.jsp").forward(request, response);
        }
    }

    public void handle(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
