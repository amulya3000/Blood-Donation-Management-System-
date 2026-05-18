package com.bdms.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.bdms.model.ContactMessage;
import com.bdms.util.DatabaseUtil;

/**
 * Data Access Object for contact_messages table. Handles CRUD operations for
 * user inquiries and admin reading status.
 */
public class ContactMessageDAO {

    /**
     * Creates a new contact message.
     *
     * @param msg the contact message to save
     * @return the generated message ID
     */
    public int createMessage(ContactMessage msg) {
        String sql = "INSERT INTO contact_messages (name, email, subject, message) VALUES (?, ?, ?, ?)";
        try (Connection conn = DatabaseUtil.getConnection(); PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setString(1, msg.getName());
            ps.setString(2, msg.getEmail());
            ps.setString(3, msg.getSubject());
            ps.setString(4, msg.getMessage());
            ps.executeUpdate();

            try (ResultSet rs = ps.getGeneratedKeys()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        } catch (SQLException e) {
            System.err.println("Failed to save contact message: " + e.getMessage());
        }
        return 0;
    }

    /**
     * Retrieves all unread contact messages.
     *
     * @return list of unread messages
     */
    public List<ContactMessage> getUnreadMessages() {
        List<ContactMessage> messages = new ArrayList<>();
        String sql = "SELECT * FROM contact_messages WHERE is_read = FALSE ORDER BY submitted_at DESC";
        try (Connection conn = DatabaseUtil.getConnection(); PreparedStatement ps = conn.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                messages.add(mapRow(rs));
            }
        } catch (SQLException e) {
            System.err.println("Failed to load unread messages: " + e.getMessage());
        }
        return messages;
    }

    /**
     * Retrieves all contact messages (read and unread).
     *
     * @return list of all messages
     */
    public List<ContactMessage> getAllMessages() {
        List<ContactMessage> messages = new ArrayList<>();
        String sql = "SELECT * FROM contact_messages ORDER BY submitted_at DESC";
        try (Connection conn = DatabaseUtil.getConnection(); PreparedStatement ps = conn.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                messages.add(mapRow(rs));
            }
        } catch (SQLException e) {
            System.err.println("Failed to load all messages: " + e.getMessage());
        }
        return messages;
    }

    /**
     * Marks a message as read.
     *
     * @param messageId the ID of the message to mark as read
     */
    public void markAsRead(int messageId) {
        String sql = "UPDATE contact_messages SET is_read = TRUE WHERE message_id = ?";
        try (Connection conn = DatabaseUtil.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, messageId);
            ps.executeUpdate();
        } catch (SQLException e) {
            System.err.println("Failed to mark message as read: " + e.getMessage());
        }
    }

    /**
     * Deletes a contact message.
     *
     * @param messageId the ID of the message to delete
     */
    public boolean deleteMessage(int messageId) {
        String sql = "DELETE FROM contact_messages WHERE message_id = ?";
        try (Connection conn = DatabaseUtil.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, messageId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Failed to delete message: " + e.getMessage());
        }
        return false;
    }

    private ContactMessage mapRow(ResultSet rs) throws SQLException {
        ContactMessage msg = new ContactMessage();
        msg.setMessageId(rs.getInt("message_id"));
        msg.setName(rs.getString("name"));
        msg.setEmail(rs.getString("email"));
        msg.setSubject(rs.getString("subject"));
        msg.setMessage(rs.getString("message"));
        msg.setSubmittedAt(rs.getTimestamp("submitted_at"));
        msg.setRead(rs.getBoolean("is_read"));
        return msg;
    }
}
