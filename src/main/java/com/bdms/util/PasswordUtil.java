package com.bdms.util;

import org.mindrot.jbcrypt.BCrypt;

public class PasswordUtil {

    /**
     * Hashes a plaintext password using BCrypt with a work factor of 12.
     * @param plainText the plain text password
     * @return the hashed password
     */
    public static String hashPassword(String plainText) {
        return BCrypt.hashpw(plainText, BCrypt.gensalt(12));
    }

    /**
     * Verifies a plain text password against a stored BCrypt hash.
     * @param plainText the plain text password attempt
     * @param storedHash the stored BCrypt hash
     * @return true if the passwords match, false otherwise
     */
    public static boolean verifyPassword(String plainText, String storedHash) {
        if (plainText == null || storedHash == null) {
            return false;
        }
        try {
            return BCrypt.checkpw(plainText, storedHash);
        } catch (IllegalArgumentException e) {
            System.err.println("Invalid salt version/hash format: " + e.getMessage());
            return false;
        }
    }
}
