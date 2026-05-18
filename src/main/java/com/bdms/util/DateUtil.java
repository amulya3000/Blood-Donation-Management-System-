package com.bdms.util;

import java.sql.Date;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.Period;

public class DateUtil {

    private static final SimpleDateFormat DISPLAY_FORMAT = new SimpleDateFormat("dd-MMM-yyyy");

    /**
     * Formats a java.sql.Date into "dd-MMM-yyyy" format.
     */
    public static String formatDate(Date date) {
        if (date == null) return "";
        return DISPLAY_FORMAT.format(date);
    }

    /**
     * Formats a java.sql.Timestamp (which extends util.Date) into "dd-MMM-yyyy".
     */
    public static String formatTimestamp(java.sql.Timestamp timestamp) {
        if (timestamp == null) return "";
        return DISPLAY_FORMAT.format(new java.util.Date(timestamp.getTime()));
    }

    /**
     * Parses a yyyy-MM-dd string and returns true if it is strictly after today.
     */
    public static boolean isFutureDate(String dateStr) {
        try {
            LocalDate date = LocalDate.parse(dateStr);
            return date.isAfter(LocalDate.now());
        } catch (Exception e) {
            return false;
        }
    }

    /**
     * Calculates age in years from given Date of Birth.
     */
    public static int calculateAge(Date dob) {
        if (dob == null) return 0;
        LocalDate birthDate = dob.toLocalDate();
        return Period.between(birthDate, LocalDate.now()).getYears();
    }
}
