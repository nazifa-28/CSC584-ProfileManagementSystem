package com.studentprofile.controller;

import java.io.IOException;
import java.util.List;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.studentprofile.db.DBHelper;
import com.studentprofile.model.ProfileBean;

/**
 * ProfileServlet - Controller class for MVC
 * Handles: Add, View All, Search, Edit, Delete profile actions
 *
 * URL Mappings:
 *   POST /ProfileServlet?action=add      → add new profile
 *   GET  /ProfileServlet?action=view     → view all profiles
 *   GET  /ProfileServlet?action=search   → search profiles
 *   GET  /ProfileServlet?action=edit     → show edit form
 *   POST /ProfileServlet?action=update   → save edited profile
 *   GET  /ProfileServlet?action=delete   → delete profile
 */
@WebServlet(name = "ProfileServlet", urlPatterns = {"/ProfileServlet"})
public class ProfileServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    // ==================== GET REQUESTS ====================
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        if (action == null) action = "view";

        switch (action) {

            case "view":
                // Load all profiles → viewProfiles.jsp
                List<ProfileBean> allProfiles = DBHelper.getAllProfiles();
                request.setAttribute("profileList", allProfiles);
                forward(request, response, "viewProfiles.jsp");
                break;

            case "search":
                // Search by Student ID or Name → viewProfiles.jsp
                String keyword = request.getParameter("keyword");
                if (keyword == null) keyword = "";
                List<ProfileBean> results = DBHelper.searchProfiles(keyword.trim());
                request.setAttribute("profileList", results);
                request.setAttribute("searchKeyword", keyword);
                forward(request, response, "viewProfiles.jsp");
                break;

            case "edit":
                // Load single profile for editing → editProfile.jsp
                String editID = request.getParameter("studentID");
                ProfileBean editProfile = DBHelper.getProfileByID(editID);
                if (editProfile != null) {
                    request.setAttribute("profile", editProfile);
                    forward(request, response, "editProfile.jsp");
                } else {
                    request.setAttribute("errorMsg", "Profile not found.");
                    forward(request, response, "error.jsp");
                }
                break;

            case "delete":
                // Delete profile → redirect to view
                String deleteID = request.getParameter("studentID");
                boolean deleted = DBHelper.deleteProfile(deleteID);
                if (deleted) {
                    response.sendRedirect(request.getContextPath() + "/ProfileServlet?action=view&msg=deleted");
                } else {
                    request.setAttribute("errorMsg", "Failed to delete profile.");
                    forward(request, response, "error.jsp");
                }
                break;

            default:
                response.sendRedirect(request.getContextPath() + "/index.html");
        }
    }

    // ==================== POST REQUESTS ====================
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        String action = request.getParameter("action");
        if (action == null) action = "add";

        switch (action) {

            case "add":
                handleAdd(request, response);
                break;

            case "update":
                handleUpdate(request, response);
                break;

            default:
                response.sendRedirect(request.getContextPath() + "/index.html");
        }
    }

    // ==================== ADD PROFILE ====================
    private void handleAdd(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Collect form data
        String studentID    = request.getParameter("studentID").trim();
        String name         = request.getParameter("name").trim();
        String programme    = request.getParameter("programme").trim();
        String email        = request.getParameter("email").trim();
        String hobbies      = request.getParameter("hobbies").trim();
        String introduction = request.getParameter("introduction").trim();

        // Basic validation
        if (studentID.isEmpty() || name.isEmpty() || programme.isEmpty() || email.isEmpty()) {
            request.setAttribute("errorMsg", "Please fill in all required fields.");
            forward(request, response, "index.html");
            return;
        }

        // Check duplicate student ID
        if (DBHelper.studentIDExists(studentID)) {
            request.setAttribute("errorMsg", "Student ID already exists. Please use a different ID.");
            forward(request, response, "index.html");
            return;
        }

        // Build bean & save
        ProfileBean profile = new ProfileBean(studentID, name, programme, email, hobbies, introduction);
        boolean saved = DBHelper.insertProfile(profile);

        if (saved) {
            // Pass profile to profile.jsp for display
            request.setAttribute("profile", profile);
            forward(request, response, "profile.jsp");
        } else {
            request.setAttribute("errorMsg", "Failed to save profile. Please try again.");
            forward(request, response, "index.html");
        }
    }

    // ==================== UPDATE PROFILE ====================
    private void handleUpdate(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String studentID    = request.getParameter("studentID").trim();
        String name         = request.getParameter("name").trim();
        String programme    = request.getParameter("programme").trim();
        String email        = request.getParameter("email").trim();
        String hobbies      = request.getParameter("hobbies").trim();
        String introduction = request.getParameter("introduction").trim();

        ProfileBean profile = new ProfileBean(studentID, name, programme, email, hobbies, introduction);
        boolean updated = DBHelper.updateProfile(profile);

        if (updated) {
            response.sendRedirect(request.getContextPath() + "/ProfileServlet?action=view&msg=updated");
        } else {
            request.setAttribute("errorMsg", "Failed to update profile. Please try again.");
            forward(request, response, "editProfile.jsp");
        }
    }

    // ==================== FORWARD HELPER ====================
    private void forward(HttpServletRequest request, HttpServletResponse response, String page)
            throws ServletException, IOException {
        RequestDispatcher rd = request.getRequestDispatcher(page);
        rd.forward(request, response);
    }
}
