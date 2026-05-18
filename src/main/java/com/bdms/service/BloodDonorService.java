package com.bdms.service;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.List;

import com.bdms.dao.DonorProfileDAO;
import com.bdms.model.DonorProfile;
import com.bdms.model.User;
import com.bdms.util.DatabaseUtil;

public class BloodDonorService {

    private final DonorProfileDAO donorDAO = new DonorProfileDAO();

    /**
     * Admin toggles donor availability on/off.
     */
    public void setDonorAvailability(int userId, boolean available) {
        donorDAO.updateAvailability(userId, available);
    }

    /**
     * Search available donors by blood type and/or location (both optional).
     */
    public List<User> findDonors(String bloodType, String location) {
        return donorDAO.searchDonors(bloodType, location);
    }

    /**
     * Record a completed donation: increment total_donations, set
     * last_donation_date to today, set is_available = false (90-day cooldown
     * enforced in TODO 02).
     */
    public void recordDonation(int userId) throws SQLException {
        String sql = "UPDATE donor_profiles SET total_donations = total_donations + 1, "
                + "last_donation_date = ?, is_available = FALSE, updated_at = CURRENT_TIMESTAMP "
                + "WHERE user_id = ?";

        try (Connection conn = DatabaseUtil.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setDate(1, Date.valueOf(LocalDate.now()));
            ps.setInt(2, userId);
            int updated = ps.executeUpdate();
            if (updated == 0) {
                throw new SQLException("No donor profile found for user ID: " + userId);
            }
        }
    }

    /**
     * Returns the donor profile for a user, or null if they have no profile.
     */
    public DonorProfile getDonorProfile(int userId) {
        return donorDAO.getProfileByUserId(userId);
    }

    public List<DonorProfile> getAllDonorsWithUsers() {
        return donorDAO.getAllDonorsWithUsers();
    }

    public void createDonor(int userId) {
        donorDAO.createProfile(userId);
    }

    public void deleteDonor(int userId) {
        String sql = "DELETE FROM donor_profiles WHERE user_id = ?";
        try (Connection conn = DatabaseUtil.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ps.executeUpdate();
        } catch (SQLException e) {
            throw new IllegalStateException("Failed to delete donor profile", e);
        }
    }
}
