package com.bdms.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.bdms.model.BloodInventory;
import com.bdms.util.DatabaseUtil;

public class BloodInventoryDAO {

    public List<BloodInventory> getAllInventory() {
        List<BloodInventory> list = new ArrayList<>();
        String sql = "SELECT * FROM blood_inventory ORDER BY blood_type";
        try (Connection conn = DatabaseUtil.getConnection(); PreparedStatement ps = conn.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                BloodInventory inv = new BloodInventory();
                inv.setInventoryId(rs.getInt("inventory_id"));
                inv.setBloodType(rs.getString("blood_type"));
                inv.setUnitsAvailable(rs.getDouble("units_available"));
                inv.setLastUpdated(rs.getTimestamp("last_updated"));
                list.add(inv);
            }
        } catch (SQLException e) {
            System.err.println("Failed to load blood inventory: " + e.getMessage());
        }
        return list;
    }

    public void decrementInventory(String bloodType, double units, Connection conn) throws SQLException {
        String sql = "UPDATE blood_inventory SET units_available = units_available - ? WHERE blood_type = ? AND units_available >= ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setDouble(1, units);
            ps.setString(2, bloodType);
            ps.setDouble(3, units);
            int updated = ps.executeUpdate();
            if (updated == 0) {
                throw new SQLException("Insufficient inventory for blood type: " + bloodType);
            }
        }
    }

    public void decrementInventory(String bloodType, double units) throws SQLException {
        try (Connection conn = DatabaseUtil.getConnection()) {
            decrementInventory(bloodType, units, conn);
        }
    }

    public void restockInventory(String bloodType, double units) throws SQLException {
        String sql = "UPDATE blood_inventory SET units_available = units_available + ? WHERE blood_type = ?";
        try (Connection conn = DatabaseUtil.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setDouble(1, units);
            ps.setString(2, bloodType);
            int updated = ps.executeUpdate();
            if (updated == 0) {
                throw new SQLException("Unknown blood type: " + bloodType);
            }
        }
    }
}
