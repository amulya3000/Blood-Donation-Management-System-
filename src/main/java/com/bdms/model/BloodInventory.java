package com.bdms.model;

import java.io.Serializable;
import java.sql.Timestamp;

public class BloodInventory implements Serializable {
    private static final long serialVersionUID = 1L;

    private int inventoryId;
    private String bloodType;
    private double unitsAvailable;
    private Timestamp lastUpdated;

    public BloodInventory() {}

    public int getInventoryId() { return inventoryId; }
    public void setInventoryId(int inventoryId) { this.inventoryId = inventoryId; }
    public String getBloodType() { return bloodType; }
    public void setBloodType(String bloodType) { this.bloodType = bloodType; }
    public double getUnitsAvailable() { return unitsAvailable; }
    public void setUnitsAvailable(double unitsAvailable) { this.unitsAvailable = unitsAvailable; }
    public Timestamp getLastUpdated() { return lastUpdated; }
    public void setLastUpdated(Timestamp lastUpdated) { this.lastUpdated = lastUpdated; }
}
