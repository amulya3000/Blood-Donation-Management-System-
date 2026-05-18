package com.bdms.user.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.bdms.service.UserService;

@WebServlet("/admin/user/update")
public class UpdateUserServlet extends HttpServlet {

    private final UserService userService = new UserService();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        int userId = Integer.parseInt(request.getParameter("userId"));

        switch (action == null ? "" : action) {
            case "approve":
                userService.updateStatus(userId, "approved");
                request.getSession().setAttribute("success", "User approved successfully!");
                break;
            case "reject":
                userService.updateStatus(userId, "rejected");
                request.getSession().setAttribute("success", "User rejected successfully!");
                break;
            default:
                request.getSession().setAttribute("error", "Unsupported admin user action.");
                break;
        }

        response.sendRedirect(request.getContextPath() + "/admin/users");
    }

    public void handle(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doPost(request, response);
    }
}
