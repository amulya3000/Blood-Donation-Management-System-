package com.bdms.user.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.bdms.service.UserService;

@WebServlet("/admin/user/delete")
public class DeleteUserServlet extends HttpServlet {

    private final UserService userService = new UserService();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int userId = Integer.parseInt(request.getParameter("userId"));
        boolean deleted = userService.deleteUser(userId);
        request.getSession().setAttribute(
                "success",
                deleted ? "User deleted successfully!" : "Admin users cannot be deleted.");
        response.sendRedirect(request.getContextPath() + "/admin/users");
    }

    public void handle(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doPost(request, response);
    }
}
