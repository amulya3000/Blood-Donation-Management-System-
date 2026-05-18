package com.bdms.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.bdms.dao.BloodRequestDAO;
import com.bdms.model.BloodRequest;

@WebServlet("/user/wishlist")
public class WishlistServlet extends HttpServlet {

    private final BloodRequestDAO requestDAO = new BloodRequestDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        List<Integer> wishlistIds = (List<Integer>) session.getAttribute("wishlist");
        List<BloodRequest> wishlist = new ArrayList<>();

        if (wishlistIds != null && !wishlistIds.isEmpty()) {
            for (int id : wishlistIds) {
                BloodRequest br = requestDAO.getRequestById(id);
                if (br != null) {
                    wishlist.add(br);
                }
            }
        }

        request.setAttribute("wishlist", wishlist);
        request.getRequestDispatcher("/user/wishlist.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        List<Integer> wishlistIds = (List<Integer>) session.getAttribute("wishlist");
        if (wishlistIds == null) {
            wishlistIds = new ArrayList<>();
        }

        String action = request.getParameter("action");
        int requestId = Integer.parseInt(request.getParameter("requestId"));

        if ("add".equals(action) && !wishlistIds.contains(requestId)) {
            wishlistIds.add(requestId);
        } else if ("remove".equals(action)) {
            wishlistIds.remove((Integer) requestId);
        }

        session.setAttribute("wishlist", wishlistIds);
        response.sendRedirect(request.getContextPath() + "/user/wishlist");
    }
}
