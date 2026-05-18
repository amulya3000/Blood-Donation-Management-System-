package com.bdms.user.controller;

import java.io.IOException;
import java.sql.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.bdms.model.User;
import com.bdms.service.UserService;
import com.bdms.util.PasswordUtil;

@WebServlet("/user/profile/update")
public class UpdateProfileServlet extends HttpServlet {

    private final UserService userService = new UserService();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        User user = (User) session.getAttribute("user");
        try {
            user.setFullName(request.getParameter("fullName"));
            user.setPhone(request.getParameter("phone"));
            String dob = request.getParameter("dob");
            if (dob != null && !dob.isEmpty()) {
                user.setDob(Date.valueOf(dob));
            }
            user.setBloodType(request.getParameter("bloodType"));
            user.setAddress(request.getParameter("address"));
            user.setLocation(request.getParameter("location"));

            String newPassword = request.getParameter("newPassword");
            if (newPassword != null && !newPassword.isEmpty()) {
                user.setPassword(PasswordUtil.hashPassword(newPassword));
            }

            userService.updateProfile(user);
            session.setAttribute("user", user);
            session.setAttribute("success", "Profile updated successfully!");
        } catch (IllegalArgumentException e) {
            session.setAttribute("error", "Invalid input: " + e.getMessage());
        } catch (Exception e) {
            session.setAttribute("error", "Update failed: " + e.getMessage());
        }

        response.sendRedirect(request.getContextPath() + "/user/profile");
    }
}
