package com.bdms.service;

import com.bdms.util.DatabaseUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.LinkedHashMap;
import java.util.Map;

/**
 * Service layer for generating administrative reports.
 * Provides aggregated statistics from the database for dashboard analytics.
 */
public class ReportService {

    /**
     * Counts approved donors grouped by blood type.
     * @return map of blood type to donor count
     */
    public Map<String, Integer> getDonorsByBloodType() {
        Map<String, Integer> map = new LinkedHashMap<>();
        String sql = "SELECT blood_type, COUNT(*) as count FROM users " +
                     "WHERE role='user' AND status='approved' " +
                     "GROUP BY blood_type ORDER BY count DESC";
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                map.put(rs.getString("blood_type"), rs.getInt("count"));
            }
        } catch (Exception e) {
            System.err.println("Error fetching donors by blood type: " + e.getMessage());
        }
        return map;
    }

    /**
     * Calculates request fulfillment statistics.
     * @return map with keys: total, fulfilled, pending, rejected
     */
    public Map<String, Long> getRequestFulfillmentRate() {
        Map<String, Long> map = new LinkedHashMap<>();
        String sql = "SELECT " +
                     "COUNT(*) as total, " +
                     "SUM(CASE WHEN status='fulfilled' THEN 1 ELSE 0 END) as fulfilled, " +
                     "SUM(CASE WHEN status='pending' THEN 1 ELSE 0 END) as pending, " +
                     "SUM(CASE WHEN status='rejected' THEN 1 ELSE 0 END) as rejected " +
                     "FROM blood_requests";
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                map.put("total", rs.getLong("total"));
                map.put("fulfilled", rs.getLong("fulfilled"));
                map.put("pending", rs.getLong("pending"));
                map.put("rejected", rs.getLong("rejected"));
            }
        } catch (Exception e) {
            System.err.println("Error fetching fulfillment rate: " + e.getMessage());
        }
        return map;
    }

    /**
     * Gets the most-requested blood types based on requests count.
     * @return map of blood type to request count, ordered by count descending
     */
    public Map<String, Integer> getMostRequestedBloodTypes() {
        Map<String, Integer> map = new LinkedHashMap<>();
        String sql = "SELECT blood_type_needed, COUNT(*) as count FROM blood_requests " +
                     "GROUP BY blood_type_needed ORDER BY count DESC";
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                map.put(rs.getString("blood_type_needed"), rs.getInt("count"));
            }
        } catch (Exception e) {
            System.err.println("Error fetching most requested blood types: " + e.getMessage());
        }
        return map;
    }

    /**
     * Provides aggregate system counts for the admin dashboard.
     * @return map with keys: totalUsers, totalDonors, totalRequests, fulfilledRequests
     */
    public Map<String, Long> getTotalCounts() {
        Map<String, Long> map = new LinkedHashMap<>();
        try (Connection conn = DatabaseUtil.getConnection()) {
            // Total approved users
            try (PreparedStatement ps = conn.prepareStatement(
                    "SELECT COUNT(*) as c FROM users WHERE role='user' AND status='approved'");
                 ResultSet rs = ps.executeQuery()) {
                if (rs.next()) map.put("totalUsers", rs.getLong("c"));
            }
            // Total donors (those with donor profiles)
            try (PreparedStatement ps = conn.prepareStatement(
                    "SELECT COUNT(*) as c FROM donor_profiles dp " +
                    "JOIN users u ON dp.user_id = u.user_id WHERE u.status='approved'");
                 ResultSet rs = ps.executeQuery()) {
                if (rs.next()) map.put("totalDonors", rs.getLong("c"));
            }
            // Total blood requests
            try (PreparedStatement ps = conn.prepareStatement(
                    "SELECT COUNT(*) as c FROM blood_requests");
                 ResultSet rs = ps.executeQuery()) {
                if (rs.next()) map.put("totalRequests", rs.getLong("c"));
            }
            // Fulfilled requests
            try (PreparedStatement ps = conn.prepareStatement(
                    "SELECT COUNT(*) as c FROM blood_requests WHERE status='fulfilled'");
                 ResultSet rs = ps.executeQuery()) {
                if (rs.next()) map.put("fulfilledRequests", rs.getLong("c"));
            }
            // Pending registrations
            try (PreparedStatement ps = conn.prepareStatement(
                    "SELECT COUNT(*) as c FROM users WHERE status='pending'");
                 ResultSet rs = ps.executeQuery()) {
                if (rs.next()) map.put("pendingRegistrations", rs.getLong("c"));
            }
        } catch (Exception e) {
            System.err.println("Error fetching total counts: " + e.getMessage());
        }
        return map;
    }
}
