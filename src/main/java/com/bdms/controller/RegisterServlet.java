package com.bdms.controller;

import java.io.IOException;
import java.sql.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.bdms.model.User;
import com.bdms.service.UserService;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {

    private final UserService userService = new UserService();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        User user = new User();
        user.setFullName(request.getParameter("fullName"));
        user.setEmail(request.getParameter("email"));
        user.setPhone(request.getParameter("phone"));

        String dobStr = request.getParameter("dob");
        if (dobStr != null && !dobStr.isEmpty()) {
            user.setDob(Date.valueOf(dobStr));
        }

        user.setBloodType(request.getParameter("bloodType"));
        user.setAddress(request.getParameter("address"));
        user.setLocation(request.getParameter("location"));
        user.setPassword(request.getParameter("password"));
        user.setRole("user");
        user.setStatus("pending");

        String confirmPassword = request.getParameter("confirmPassword");

        String result = userService.registerUser(user, confirmPassword);

        if ("SUCCESS".equals(result)) {
            request.getSession().setAttribute("success", "Registration successful. Await admin approval.");
            response.sendRedirect(request.getContextPath() + "/login.jsp");
        } else {
            request.setAttribute("error", result);
            request.setAttribute("user", user); // preserve fields
            request.getRequestDispatcher("/register.jsp").forward(request, response);
        }
    }
}
