package com.studentprofile.db;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import com.studentprofile.model.ProfileBean;

/**
 * DBHelper - JDBC utility class
 * Handles all database operations: connect, insert, retrieve, search, update, delete
 */
public class DBHelper {

    // ===================== CONNECTION SETTINGS =====================
    // Change these values to match your MySQL setup
    private static final String DB_URL      = "jdbc:mysql://localhost:3306/studentprofilesdb?useSSL=false&serverTimezone=UTC";
    private static final String DB_USER     = "root";
    private static final String DB_PASSWORD = "";   // Set your MySQL root password here

    // ===================== GET CONNECTION =====================
    public static Connection getConnection() throws SQLException {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            throw new SQLException("MySQL JDBC Driver not found: " + e.getMessage());
        }
        return DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
    }

    // ===================== INSERT PROFILE =====================
    public static boolean insertProfile(ProfileBean profile) {
        String sql = "INSERT INTO Profile (studentID, name, programme, email, hobbies, introduction) VALUES (?, ?, ?, ?, ?, ?)";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, profile.getStudentID());
            ps.setString(2, profile.getName());
            ps.setString(3, profile.getProgramme());
            ps.setString(4, profile.getEmail());
            ps.setString(5, profile.getHobbies());
            ps.setString(6, profile.getIntroduction());
            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            System.err.println("insertProfile error: " + e.getMessage());
            return false;
        }
    }

    // ===================== GET ALL PROFILES =====================
    public static List<ProfileBean> getAllProfiles() {
        List<ProfileBean> list = new ArrayList<>();
        String sql = "SELECT * FROM Profile ORDER BY name ASC";
        try (Connection conn = getConnection();
             Statement st = conn.createStatement();
             ResultSet rs = st.executeQuery(sql)) {

            while (rs.next()) {
                list.add(mapRow(rs));
            }
        } catch (SQLException e) {
            System.err.println("getAllProfiles error: " + e.getMessage());
        }
        return list;
    }

    // ===================== GET PROFILE BY ID =====================
    public static ProfileBean getProfileByID(String studentID) {
        String sql = "SELECT * FROM Profile WHERE studentID = ?";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, studentID);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return mapRow(rs);
            }
        } catch (SQLException e) {
            System.err.println("getProfileByID error: " + e.getMessage());
        }
        return null;
    }

    // ===================== SEARCH PROFILES =====================
    public static List<ProfileBean> searchProfiles(String keyword) {
        List<ProfileBean> list = new ArrayList<>();
        String sql = "SELECT * FROM Profile WHERE studentID LIKE ? OR name LIKE ? ORDER BY name ASC";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            String pattern = "%" + keyword + "%";
            ps.setString(1, pattern);
            ps.setString(2, pattern);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) list.add(mapRow(rs));
            }
        } catch (SQLException e) {
            System.err.println("searchProfiles error: " + e.getMessage());
        }
        return list;
    }

    // ===================== UPDATE PROFILE =====================
    public static boolean updateProfile(ProfileBean profile) {
        String sql = "UPDATE Profile SET name=?, programme=?, email=?, hobbies=?, introduction=? WHERE studentID=?";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, profile.getName());
            ps.setString(2, profile.getProgramme());
            ps.setString(3, profile.getEmail());
            ps.setString(4, profile.getHobbies());
            ps.setString(5, profile.getIntroduction());
            ps.setString(6, profile.getStudentID());
            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            System.err.println("updateProfile error: " + e.getMessage());
            return false;
        }
    }

    // ===================== DELETE PROFILE =====================
    public static boolean deleteProfile(String studentID) {
        String sql = "DELETE FROM Profile WHERE studentID = ?";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, studentID);
            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            System.err.println("deleteProfile error: " + e.getMessage());
            return false;
        }
    }

    // ===================== CHECK DUPLICATE ID =====================
    public static boolean studentIDExists(String studentID) {
        String sql = "SELECT COUNT(*) FROM Profile WHERE studentID = ?";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, studentID);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return rs.getInt(1) > 0;
            }
        } catch (SQLException e) {
            System.err.println("studentIDExists error: " + e.getMessage());
        }
        return false;
    }

    // ===================== MAP ROW TO BEAN =====================
    private static ProfileBean mapRow(ResultSet rs) throws SQLException {
        return new ProfileBean(
            rs.getString("studentID"),
            rs.getString("name"),
            rs.getString("programme"),
            rs.getString("email"),
            rs.getString("hobbies"),
            rs.getString("introduction")
        );
    }
}
