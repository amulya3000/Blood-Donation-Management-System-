package com.bdms.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DatabaseUtil {

    private static final String URL = System.getenv().getOrDefault("BDMS_DB_URL", "jdbc:mysql://localhost:3306/bdms_db");
    private static final String USER = System.getenv().getOrDefault("BDMS_DB_USER", "root");
    private static final String PASSWORD = System.getenv().getOrDefault("BDMS_DB_PASSWORD", "1234");

    static {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            throw new IllegalStateException("MySQL JDBC driver not found", e);
        }
    }

    public static Connection getConnection() throws SQLException {
        return DriverManager.getConnection(URL, USER, PASSWORD);
    }

    public static void closeConnection(Connection conn) {
        if (conn != null) {
            try {
                conn.close();
            } catch (SQLException e) {
                System.err.println("Error closing connection: " + e.getMessage());
            }
        }
    }
}
