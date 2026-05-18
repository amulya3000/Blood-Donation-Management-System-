package com.bdms.dao;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.bdms.model.BloodRequest;
import com.bdms.model.User;
import com.bdms.util.DatabaseUtil;

/**
 * Data Access Object for the blood_requests table.
 * Provides CRUD operations and query methods for blood request records.
 */
public class BloodRequestDAO {

    /**
     * Creates a new blood request record in the database.
     * @param req the blood request to persist
     * @return the generated request ID, or 0 on failure
     */
    public int createRequest(BloodRequest req) {
        String sql = "INSERT INTO blood_requests (user_id, blood_type_needed, units_required, urgency_level, patient_name, hospital_name, reason) VALUES (?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setInt(1, req.getUserId());
            ps.setString(2, req.getBloodTypeNeeded());
            ps.setDouble(3, req.getUnitsRequired());
            ps.setString(4, req.getUrgencyLevel());
            ps.setString(5, req.getPatientName());
            ps.setString(6, req.getHospitalName());
            ps.setString(7, req.getReason());
            ps.executeUpdate();

            try (ResultSet rs = ps.getGeneratedKeys()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        } catch (SQLException e) {
            System.err.println("Failed to create blood request: " + e.getMessage());
        }
        return 0;
    }

    /**
     * Retrieves a single blood request by its ID, with requester name.
     * @param requestId the request ID to look up
     * @return the BloodRequest or null if not found
     */
    public BloodRequest getRequestById(int requestId) {
        String sql = "SELECT br.*, u.full_name as requester_name "
                + "FROM blood_requests br JOIN users u ON br.user_id = u.user_id "
                + "WHERE br.request_id = ?";
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, requestId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    BloodRequest req = mapRow(rs);
                    User requester = new User();
                    requester.setFullName(rs.getString("requester_name"));
                    req.setRequester(requester);
                    return req;
                }
            }
        } catch (SQLException e) {
            System.err.println("Failed to fetch request by ID: " + e.getMessage());
        }
        return null;
    }

    /**
     * Retrieves all pending blood requests, ordered by urgency then date.
     * Joins with users table to include requester names.
     * @return list of pending requests
     */
    public List<BloodRequest> getAllPendingRequests() {
        List<BloodRequest> requests = new ArrayList<>();
        String sql = "SELECT br.*, u.full_name as requester_name "
                + "FROM blood_requests br JOIN users u ON br.user_id = u.user_id "
                + "WHERE br.status = 'pending' "
                + "ORDER BY FIELD(br.urgency_level, 'CRITICAL', 'HIGH', 'MEDIUM', 'LOW'), br.requested_at ASC";
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                BloodRequest req = mapRow(rs);
                User requester = new User();
                requester.setFullName(rs.getString("requester_name"));
                req.setRequester(requester);
                requests.add(req);
            }
        } catch (SQLException e) {
            System.err.println("Failed to load pending requests: " + e.getMessage());
        }
        return requests;
    }

    /**
     * Retrieves all blood requests for a specific user.
     * @param userId the user ID to filter by
     * @return list of requests for that user
     */
    public List<BloodRequest> getRequestsByUserId(int userId) {
        List<BloodRequest> requests = new ArrayList<>();
        String sql = "SELECT * FROM blood_requests WHERE user_id = ? ORDER BY requested_at DESC";
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    requests.add(mapRow(rs));
                }
            }
        } catch (SQLException e) {
            System.err.println("Failed to load user requests: " + e.getMessage());
        }
        return requests;
    }

    /**
     * Retrieves ALL blood requests (all statuses) with requester info.
     * Used by the admin to see the complete request history.
     * @return list of all blood requests ordered by date descending
     */
    public List<BloodRequest> getAllRequests() {
        List<BloodRequest> requests = new ArrayList<>();
        String sql = "SELECT br.*, u.full_name as requester_name "
                + "FROM blood_requests br JOIN users u ON br.user_id = u.user_id "
                + "ORDER BY br.requested_at DESC";
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                BloodRequest req = mapRow(rs);
                User requester = new User();
                requester.setFullName(rs.getString("requester_name"));
                req.setRequester(requester);
                requests.add(req);
            }
        } catch (SQLException e) {
            System.err.println("Failed to load all requests: " + e.getMessage());
        }
        return requests;
    }

    /**
     * Updates the status of a blood request, with optional issue and return dates.
     * Can use an existing connection (for transactional operations) or create its own.
     * @param requestId the request to update
     * @param status the new status value
     * @param issueDate the date blood was issued (nullable)
     * @param returnDate the expected return/follow-up date (nullable)
     * @param conn existing connection or null
     * @throws SQLException if the update fails
     */
    public void updateRequestStatus(int requestId, String status, Date issueDate, Date returnDate, Connection conn) throws SQLException {
        boolean localConn = false;
        if (conn == null) {
            conn = DatabaseUtil.getConnection();
            localConn = true;
        }
        try {
            String sql = "UPDATE blood_requests SET status = ?, issue_date = ?, return_date = ?";
            if ("fulfilled".equals(status) || "rejected".equals(status)) {
                sql += ", resolved_at = CURRENT_TIMESTAMP";
            }
            sql += " WHERE request_id = ?";

            try (PreparedStatement ps = conn.prepareStatement(sql)) {
                ps.setString(1, status);
                ps.setDate(2, issueDate);
                ps.setDate(3, returnDate);
                ps.setInt(4, requestId);
                ps.executeUpdate();
            }
        } finally {
            if (localConn) {
                DatabaseUtil.closeConnection(conn);
            }
        }
    }

    /**
     * Maps a single ResultSet row to a BloodRequest object.
     */
    private BloodRequest mapRow(ResultSet rs) throws SQLException {
        BloodRequest req = new BloodRequest();
        req.setRequestId(rs.getInt("request_id"));
        req.setUserId(rs.getInt("user_id"));
        req.setBloodTypeNeeded(rs.getString("blood_type_needed"));
        req.setUnitsRequired(rs.getDouble("units_required"));
        req.setUrgencyLevel(rs.getString("urgency_level"));
        req.setPatientName(rs.getString("patient_name"));
        req.setHospitalName(rs.getString("hospital_name"));
        req.setReason(rs.getString("reason"));
        req.setStatus(rs.getString("status"));
        req.setRequestedAt(rs.getTimestamp("requested_at"));
        req.setResolvedAt(rs.getTimestamp("resolved_at"));
        req.setIssueDate(rs.getDate("issue_date"));
        req.setReturnDate(rs.getDate("return_date"));
        return req;
    }
}
