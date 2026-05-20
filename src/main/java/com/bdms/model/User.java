package com.bdms.model;

import java.io.Serializable;
import java.sql.Date;
import java.sql.Timestamp;

public class User implements Serializable {
    private static final long serialVersionUID = 1L;

    private int userId;
    private String fullName;
    private String email;
    private String phone;
    private Date dob;
    private String bloodType;
    private String address;
    private String location;
    private String password;
    private String role;
    private String status;
    private Timestamp createdAt;

    public User() {}

    public User(String fullName, String email, String phone, Date dob, String bloodType, String address, String location, String password, String role, String status) {
        this.fullName = fullName;
        this.email = email;
        this.phone = phone;
        this.dob = dob;
        this.bloodType = bloodType;
        this.address = address;
        this.location = location;
        this.password = password;
        this.role = role;
        this.status = status;
    }

    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }
    public String getFullName() { return fullName; }
    public void setFullName(String fullName) { this.fullName = fullName; }
    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }
    public String getPhone() { return phone; }
    public void setPhone(String phone) { this.phone = phone; }
    public Date getDob() { return dob; }
    public void setDob(Date dob) { this.dob = dob; }
    public String getBloodType() { return bloodType; }
    public void setBloodType(String bloodType) { this.bloodType = bloodType; }
    public String getAddress() { return address; }
    public void setAddress(String address) { this.address = address; }
    public String getLocation() { return location; }
    public void setLocation(String location) { this.location = location; }
    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }
    public String getRole() { return role; }
    public void setRole(String role) { this.role = role; }
    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
    public Timestamp getCreatedAt() { return createdAt; }
    public void setCreatedAt(Timestamp createdAt) { this.createdAt = createdAt; }
}
