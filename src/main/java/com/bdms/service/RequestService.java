package com.bdms.service;

import java.sql.Connection;
import java.sql.Date;
import java.sql.SQLException;
import java.time.LocalDate;

import com.bdms.dao.BloodInventoryDAO;
import com.bdms.dao.BloodRequestDAO;
import com.bdms.model.BloodRequest;
import com.bdms.util.DatabaseUtil;
import com.bdms.util.ValidationUtil;

/**
 * Service layer encapsulating all business logic for blood requests.
 * Coordinates between BloodRequestDAO and BloodInventoryDAO within
 * transactions.
 */
public class RequestService {

    private final BloodRequestDAO requestDAO = new BloodRequestDAO();
    private final BloodInventoryDAO inventoryDAO = new BloodInventoryDAO();

    /**
     * Validates and submits a new blood request.
     *
     * @param req the blood request object populated from the form
     * @return "SUCCESS" or an error message
     */
    public String addBloodRequest(BloodRequest req) {
        // Validate units
        if (req.getUnitsRequired() <= 0) {
            return "Units required must be greater than zero.";
        }
        // Validate blood type
        if (!ValidationUtil.isValidBloodType(req.getBloodTypeNeeded())) {
            return "Invalid blood type selected.";
        }
        // Validate patient name
        if (ValidationUtil.isEmpty(req.getPatientName())) {
            return "Patient name is required.";
        }
        // Validate hospital name
        if (ValidationUtil.isEmpty(req.getHospitalName())) {
            return "Hospital name is required.";
        }

        int id = requestDAO.createRequest(req);
        if (id > 0) {
            return "SUCCESS";
        }
        return "Failed to submit request. Please try again.";
    }

    /**
     * Fulfills a blood request using inventory in a single transaction. Sets
     * issue date to today and return date to 30 days later.
     *
     * @param requestId the request ID to fulfill
     * @param bloodType the blood type to remove from inventory
     * @param unitsUsed the number of units to remove
     * @throws Exception if inventory is insufficient or DB error occurs
     */
    public void fulfillBloodRequest(int requestId, String bloodType, double unitsUsed) throws Exception {
        Connection conn = null;
        try {
            conn = DatabaseUtil.getConnection();
            conn.setAutoCommit(false);

            // Remove from inventory (throws SQLException if insufficient stock)
            inventoryDAO.decrementInventory(bloodType, unitsUsed, conn);

            // Set issue and return dates
            Date issueDate = Date.valueOf(LocalDate.now());
            Date returnDate = Date.valueOf(LocalDate.now().plusDays(30));

            // Update request status to fulfilled with dates
            requestDAO.updateRequestStatus(requestId, "fulfilled", issueDate, returnDate, conn);

            conn.commit();
        } catch (SQLException e) {
            if (conn != null) {
                try {
                    conn.rollback();
                } catch (SQLException ex) {
                    /* log */ }
            }
            throw new Exception("Fulfilment failed: " + e.getMessage());
        } finally {
            if (conn != null) {
                try {
                    conn.setAutoCommit(true);
                } catch (SQLException ex) {
                    /* log */ }
                DatabaseUtil.closeConnection(conn);
            }
        }
    }

    /**
     * Rejects a blood request.
     *
     * @param requestId the request ID to reject
     * @throws Exception if DB error occurs
     */
    public void rejectBloodRequest(int requestId) throws Exception {
        try {
            requestDAO.updateRequestStatus(requestId, "rejected", null, null, null);
        } catch (SQLException e) {
            throw new Exception("Rejection failed: " + e.getMessage());
        }
    }

    public void cancelBloodRequest(int userId, int requestId) throws Exception {
        BloodRequest request = requestDAO.getRequestById(requestId);
        if (request == null || request.getUserId() != userId) {
            throw new SecurityException("Not authorised to cancel this request");
        }

        if (!"pending".equals(request.getStatus())) {
            throw new IllegalStateException("Only pending requests can be cancelled");
        }

        try {
            requestDAO.updateRequestStatus(requestId, "cancelled", null, null, null);
        } catch (SQLException e) {
            throw new Exception("Cancellation failed: " + e.getMessage());
        }
    }

    public java.util.List<BloodRequest> getAllPendingRequests() {
        return requestDAO.getAllPendingRequests();
    }

    public java.util.List<BloodRequest> getRequestsByUserId(int userId) {
        return requestDAO.getRequestsByUserId(userId);
    }
}
