package com.bdms.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.bdms.dao.ContactMessageDAO;
import com.bdms.model.ContactMessage;
import com.bdms.util.ValidationUtil;

@WebServlet("/contact")
public class ContactServlet extends HttpServlet {

    private final ContactMessageDAO messageDAO = new ContactMessageDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("/contact.jsp").forward(request, response);
    }

    private String param(HttpServletRequest req, String name) {
        String v = req.getParameter(name);
        return v != null ? v.trim() : "";
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String name = param(request, "name");
        String email = param(request, "email");
        String subject = param(request, "subject");
        String message = param(request, "message");

        HttpSession session = request.getSession();

        // Validation
        if (ValidationUtil.isEmpty(name)) {
            session.setAttribute("error", "Name is required.");
            response.sendRedirect(request.getContextPath() + "/contact");
            return;
        }

        if (!ValidationUtil.isValidEmail(email)) {
            session.setAttribute("error", "Please enter a valid email address.");
            response.sendRedirect(request.getContextPath() + "/contact");
            return;
        }

        if (ValidationUtil.isEmpty(subject)) {
            session.setAttribute("error", "Subject is required.");
            response.sendRedirect(request.getContextPath() + "/contact");
            return;
        }

        if (ValidationUtil.isEmpty(message) || message.length() < 10) {
            session.setAttribute("error", "Message must be at least 10 characters.");
            response.sendRedirect(request.getContextPath() + "/contact");
            return;
        }

        // Create message
        ContactMessage msg = new ContactMessage();
        msg.setName(name);
        msg.setEmail(email);
        msg.setSubject(subject);
        msg.setMessage(message);

        int messageId = messageDAO.createMessage(msg);
        if (messageId > 0) {
            session.setAttribute("success", "Thank you! Your message has been sent. We'll respond within 24 hours.");
        } else {
            session.setAttribute("error", "Failed to send message. Please try again.");
        }

        response.sendRedirect(request.getContextPath() + "/contact");
    }
}
