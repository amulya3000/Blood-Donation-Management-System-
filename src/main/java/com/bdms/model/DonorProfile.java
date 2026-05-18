package com.bdms.model;

import java.io.Serializable;
import java.sql.Date;
import java.sql.Timestamp;

public class DonorProfile implements Serializable {

    private static final long serialVersionUID = 1L;

    private int profileId;
    private int userId;
    private boolean isAvailable;
    private Date lastDonationDate;
    private int totalDonations;
    private Timestamp updatedAt;

    // Transient attributes for JOIN purposes
    private User user;

    public DonorProfile() {
    }

    public int getProfileId() {
        return profileId;
    }

    public void setProfileId(int profileId) {
        this.profileId = profileId;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public boolean isAvailable() {
        return isAvailable;
    }

    public boolean getAvailableForDonation() {
        return isAvailable;
    }

    public void setAvailable(boolean available) {
        isAvailable = available;
    }

    public Date getLastDonationDate() {
        return lastDonationDate;
    }

    public void setLastDonationDate(Date lastDonationDate) {
        this.lastDonationDate = lastDonationDate;
    }

    public int getTotalDonations() {
        return totalDonations;
    }

    public void setTotalDonations(int totalDonations) {
        this.totalDonations = totalDonations;
    }

    public Timestamp getUpdatedAt() {
        return updatedAt;
    }

    public void setUpdatedAt(Timestamp updatedAt) {
        this.updatedAt = updatedAt;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

}
