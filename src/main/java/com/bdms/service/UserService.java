package com.bdms.service;

import com.bdms.dao.DonorProfileDAO;
import com.bdms.dao.UserDAO;
import com.bdms.model.User;
import com.bdms.util.PasswordUtil;
import com.bdms.util.ValidationUtil;

public class UserService {

    private final UserDAO userDAO = new UserDAO();
    private final DonorProfileDAO donorProfileDAO = new DonorProfileDAO();

    public String registerUser(User user, String confirmPassword) {
        if (ValidationUtil.isEmpty(user.getFullName()) || ValidationUtil.isEmpty(user.getEmail())
                || ValidationUtil.isEmpty(user.getPhone()) || ValidationUtil.isEmpty(user.getPassword())
                || ValidationUtil.isEmpty(user.getBloodType()) || user.getDob() == null) {
            return "All fields are required.";
        }

        if (!ValidationUtil.isValidEmail(user.getEmail())) {
            return "Please enter a valid email address.";
        }

        if (!ValidationUtil.isValidPhone(user.getPhone())) {
            return "Phone number must be a valid 10-digit Nepali number starting with 97 or 98.";
        }

        if (!ValidationUtil.isValidName(user.getFullName())) {
            return "Name must contain only letters and spaces.";
        }

        if (!ValidationUtil.isStrongPassword(user.getPassword())) {
            return "Password must be at least 8 characters and contain uppercase, digit, and symbol.";
        }

        if (!user.getPassword().equals(confirmPassword)) {
            return "Passwords do not match.";
        }

        if (userDAO.emailExists(user.getEmail())) {
            return "This email is already registered.";
        }

        if (userDAO.phoneExists(user.getPhone())) {
            return "This phone number is already registered.";
        }

        user.setPassword(PasswordUtil.hashPassword(user.getPassword()));
        int userId = userDAO.createUser(user, false);
        if (userId > 0) {
            donorProfileDAO.createProfile(userId);
            return "SUCCESS";
        }
        return "Registration failed due to a system error.";
    }

    public User loginUser(String email, String password) throws Exception {
        User user = userDAO.getUserByEmail(email);
        if (user == null) {
            return null; // Keep invalid credentials opaque
        }

        if ("pending".equals(user.getStatus())) {
            throw new Exception("Your account is still pending admin approval.");
        } else if ("rejected".equals(user.getStatus())) {
            throw new Exception("Your account has been rejected.");
        }

        if (PasswordUtil.verifyPassword(password, user.getPassword())) {
            return user;
        }
        return null;
    }

    // Administrative and utility wrappers so controllers can use services instead of DAOs
    public java.util.List<User> getAllUsers() {
        return userDAO.getAllUsers();
    }

    public java.util.List<User> getPendingUsers() {
        return userDAO.getPendingUsers();
    }

    public User getUserById(int userId) {
        return userDAO.getUserById(userId);
    }

    public void updateStatus(int userId, String status) {
        userDAO.updateStatus(userId, status);
    }

    public boolean deleteUser(int userId) {
        return userDAO.deleteUser(userId);
    }

    public int createUser(User user, boolean approved) {
        return userDAO.createUser(user, approved);
    }

    public void updateProfile(User user) {
        userDAO.updateProfile(user);
    }
}
