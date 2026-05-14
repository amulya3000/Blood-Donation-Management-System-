package com.bdms.service;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import com.bdms.dao.BloodInventoryDAO;
import com.bdms.model.BloodInventory;
import com.bdms.util.DatabaseUtil;
import com.bdms.util.ValidationUtil;

public class BloodInventoryService {

    private static final List<String> ORDERED_BLOOD_TYPES = List.of(
            "A+", "A-", "B+", "B-", "AB+", "AB-", "O+", "O-"
    );

    private final BloodInventoryDAO inventoryDAO = new BloodInventoryDAO();

    /**
     * Add units to a blood type (admin restock). Throws if bloodType unknown.
     */
    public void addBlood(String bloodType, double units) throws IllegalArgumentException, SQLException {
        validateMutatingInputs(bloodType, units);
        inventoryDAO.restockInventory(bloodType, units);
    }

    /**
     * Delete units manually (admin correction / wastage write-off).
     */
    public void removeBlood(String bloodType, double units) throws IllegalArgumentException, SQLException {
        validateMutatingInputs(bloodType, units);
        inventoryDAO.decrementInventory(bloodType, units);
    }

    /**
     * Set inventory to an exact amount (admin hard-reset, e.g. after physical
     * count).
     */
    public void setBloodUnits(String bloodType, double units) throws IllegalArgumentException, SQLException {
        validateMutatingInputs(bloodType, units);

        String sql = "UPDATE blood_inventory SET units_available = ?, last_updated = CURRENT_TIMESTAMP WHERE blood_type = ?";
        try (Connection conn = DatabaseUtil.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setDouble(1, units);
            ps.setString(2, bloodType);
            int updated = ps.executeUpdate();
            if (updated == 0) {
                throw new SQLException("Unknown blood type: " + bloodType);
            }
        }
    }

    /**
     * Returns all 8 blood type rows, never null.
     */
    public List<BloodInventory> getBloodStock() {
        Map<String, BloodInventory> inventoryByType = new LinkedHashMap<>();
        for (BloodInventory inventory : inventoryDAO.getAllInventory()) {
            inventoryByType.put(inventory.getBloodType(), inventory);
        }

        List<BloodInventory> stock = new ArrayList<>();
        for (String bloodType : ORDERED_BLOOD_TYPES) {
            BloodInventory inventory = inventoryByType.get(bloodType);
            if (inventory == null) {
                inventory = new BloodInventory();
                inventory.setBloodType(bloodType);
                inventory.setUnitsAvailable(0.0);
            }
            stock.add(inventory);
        }
        return stock;
    }

    /**
     * Returns units available for a single type, or 0.0 if type is unknown.
     */
    public double getUnitsAvailable(String bloodType) {
        if (bloodType == null) {
            return 0.0;
        }

        for (BloodInventory inventory : getBloodStock()) {
            if (bloodType.equals(inventory.getBloodType())) {
                return inventory.getUnitsAvailable();
            }
        }
        return 0.0;
    }

    private void validateMutatingInputs(String bloodType, double units) {
        if (units <= 0) {
            throw new IllegalArgumentException("Units must be greater than zero");
        }
        if (!ValidationUtil.VALID_BLOOD_TYPES.contains(bloodType)) {
            throw new IllegalArgumentException("Unknown blood type: " + bloodType);
        }
    }
}
