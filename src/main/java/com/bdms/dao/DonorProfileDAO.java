package com.bdms.dao;

import com.bdms.model.DonorProfile;
import com.bdms.model.User;
import com.bdms.util.DatabaseUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class DonorProfileDAO {

    public void createProfile(int userId) {
        String sql = "INSERT INTO donor_profiles (user_id) VALUES (?)";
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public DonorProfile getProfileByUserId(int userId) {
        String sql = "SELECT * FROM donor_profiles WHERE user_id = ?";
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapRow(rs);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public void updateAvailability(int userId, boolean available) {
        String sql = "UPDATE donor_profiles SET is_available = ? WHERE user_id = ?";
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setBoolean(1, available);
            ps.setInt(2, userId);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public List<User> searchDonors(String bloodType, String location) {
        List<User> donors = new ArrayList<>();
        StringBuilder sql = new StringBuilder(
                "SELECT u.* FROM users u INNER JOIN donor_profiles dp ON u.user_id = dp.user_id " +
                "WHERE u.status = 'approved' AND u.role = 'user' AND dp.is_available = TRUE");
        
        List<Object> params = new ArrayList<>();
        
        if (bloodType != null && !bloodType.isEmpty()) {
            sql.append(" AND u.blood_type = ?");
            params.add(bloodType);
        }
        if (location != null && !location.trim().isEmpty()) {
            sql.append(" AND u.location LIKE ?");
            params.add("%" + location.trim() + "%");
        }
        
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql.toString())) {
            
            for (int i = 0; i < params.size(); i++) {
                ps.setObject(i + 1, params.get(i));
            }
            
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    // Manual mapping since inner join just requests u.*
                    User u = new User();
                    u.setUserId(rs.getInt("user_id"));
                    u.setFullName(rs.getString("full_name"));
                    u.setEmail(rs.getString("email"));
                    u.setPhone(rs.getString("phone"));
                    u.setBloodType(rs.getString("blood_type"));
                    u.setLocation(rs.getString("location"));
                    donors.add(u);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return donors;
    }

    /**
     * Retrieves all donor profiles with their associated user information.
     * Used by the admin panel to display and manage donors.
     * @return list of DonorProfile objects with User objects attached
     */
    public List<DonorProfile> getAllDonorsWithUsers() {
        List<DonorProfile> donors = new ArrayList<>();
        String sql = "SELECT dp.*, u.full_name, u.email, u.phone, u.blood_type, u.location, u.status " +
                     "FROM donor_profiles dp JOIN users u ON dp.user_id = u.user_id " +
                     "WHERE u.status = 'approved' ORDER BY dp.updated_at DESC";
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                DonorProfile profile = mapRow(rs);
                User user = new User();
                user.setUserId(rs.getInt("user_id"));
                user.setFullName(rs.getString("full_name"));
                user.setEmail(rs.getString("email"));
                user.setPhone(rs.getString("phone"));
                user.setBloodType(rs.getString("blood_type"));
                user.setLocation(rs.getString("location"));
                user.setStatus(rs.getString("status"));
                profile.setUser(user);
                donors.add(profile);
            }
        } catch (SQLException e) {
            System.err.println("Failed to load donors with users: " + e.getMessage());
        }
        return donors;
    }

    private DonorProfile mapRow(ResultSet rs) throws SQLException {
        DonorProfile profile = new DonorProfile();
        profile.setProfileId(rs.getInt("profile_id"));
        profile.setUserId(rs.getInt("user_id"));
        profile.setAvailable(rs.getBoolean("is_available"));
        profile.setLastDonationDate(rs.getDate("last_donation_date"));
        profile.setTotalDonations(rs.getInt("total_donations"));
        profile.setUpdatedAt(rs.getTimestamp("updated_at"));
        return profile;
    }
}
