package com.bdms.user.controller;

import java.io.IOException;
import java.sql.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.bdms.model.User;
import com.bdms.service.UserService;
import com.bdms.util.PasswordUtil;

@WebServlet("/admin/user/add")
public class AddUserServlet extends HttpServlet {

    private final UserService userService = new UserService();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        User user = new User();
        user.setFullName(request.getParameter("fullName"));
        user.setEmail(request.getParameter("email"));
        user.setPhone(request.getParameter("phone"));
        String dob = request.getParameter("dob");
        if (dob != null && !dob.isEmpty()) {
            user.setDob(Date.valueOf(dob));
        }
        user.setBloodType(request.getParameter("bloodType"));
        user.setAddress(request.getParameter("address"));
        user.setLocation(request.getParameter("location"));
        user.setRole(request.getParameter("role") != null ? request.getParameter("role") : "user");
        user.setPassword(PasswordUtil.hashPassword(request.getParameter("password")));

        userService.createUser(user, true);
        request.getSession().setAttribute("success", "User created successfully!");
        response.sendRedirect(request.getContextPath() + "/admin/users");
    }

    public void handle(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doPost(request, response);
    }
}
