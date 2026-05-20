package com.bdms.util;

import java.util.Set;
import java.util.regex.Pattern;

public class ValidationUtil {

    private static final Pattern EMAIL_PATTERN = Pattern.compile("^[A-Za-z0-9+_.-]+@(.+)$");
    private static final Pattern PHONE_PATTERN = Pattern.compile("^(97|98)[0-9]{8}$");
    private static final Pattern NAME_PATTERN = Pattern.compile("^[A-Za-z ]+$");
    private static final Pattern PASSWORD_PATTERN = Pattern.compile("^(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z])(?=.*[@#$%!^&+=]).{8,}$");

    public static final Set<String> VALID_BLOOD_TYPES = Set.of(
            "A+", "A-", "B+", "B-", "AB+", "AB-", "O+", "O-"
    );

    public static boolean isEmpty(String value) {
        return value == null || value.trim().isEmpty();
    }

    public static boolean isValidEmail(String email) {
        if (isEmpty(email)) {
            return false;
        }
        return EMAIL_PATTERN.matcher(email).matches();
    }

    public static boolean isValidPhone(String phone) {
        if (isEmpty(phone)) {
            return false;
        }
        return PHONE_PATTERN.matcher(phone).matches();
    }

    public static boolean isValidName(String name) {
        if (isEmpty(name)) {
            return false;
        }
        return NAME_PATTERN.matcher(name).matches();
    }

    public static boolean isStrongPassword(String password) {
        if (isEmpty(password)) {
            return false;
        }
        return PASSWORD_PATTERN.matcher(password).matches();
    }

    public static boolean isValidBloodType(String type) {
        return VALID_BLOOD_TYPES.contains(type);
    }
}
