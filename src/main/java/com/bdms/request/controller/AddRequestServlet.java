package com.bdms.request.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.bdms.model.BloodRequest;
import com.bdms.model.User;
import com.bdms.service.RequestService;

@WebServlet("/user/request/add")
public class AddRequestServlet extends HttpServlet {

    private final RequestService requestService = new RequestService();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        User user = (User) session.getAttribute("user");

        try {
            BloodRequest br = new BloodRequest();
            br.setUserId(user.getUserId());
            br.setBloodTypeNeeded(request.getParameter("bloodTypeNeeded"));
            br.setUnitsRequired(Double.parseDouble(request.getParameter("unitsRequired")));
            br.setUrgencyLevel(request.getParameter("urgencyLevel"));
            br.setPatientName(request.getParameter("patientName"));
            br.setHospitalName(request.getParameter("hospitalName"));
            br.setReason(request.getParameter("reason"));

            String result = requestService.addBloodRequest(br);
            if ("SUCCESS".equals(result)) {
                session.setAttribute("success", "Blood request submitted successfully.");
                response.sendRedirect(request.getContextPath() + "/user/request/view");
            } else {
                request.setAttribute("error", result);
                request.getRequestDispatcher("/user/request-form.jsp").forward(request, response);
            }
        } catch (NumberFormatException e) {
            request.setAttribute("error", "Please enter valid numeric values for units.");
            request.getRequestDispatcher("/user/request-form.jsp").forward(request, response);
        }
    }

    public void handle(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doPost(request, response);
    }
}
