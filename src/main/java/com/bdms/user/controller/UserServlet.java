package com.bdms.user.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/admin/users")
public class UserServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        new ViewUserServlet().handle(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        switch (action) {
            case "add":
                new AddUserServlet().handle(request, response);
                break;
            case "approve":
            case "reject":
                new UpdateUserServlet().handle(request, response);
                break;
            case "delete":
                new DeleteUserServlet().handle(request, response);
                break;
            default:
                request.getSession().setAttribute("error", "Unsupported admin user action.");
                break;
        }

        response.sendRedirect(request.getContextPath() + "/admin/users");
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
