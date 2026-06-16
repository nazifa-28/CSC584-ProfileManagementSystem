<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.studentprofile.model.ProfileBean" %>
<%
    List<ProfileBean> profileList = (List<ProfileBean>) request.getAttribute("profileList");
    String searchKeyword = (String) request.getAttribute("searchKeyword");
    String msg = request.getParameter("msg");
    if (searchKeyword == null) searchKeyword = "";
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>All Profiles – Profile Management System</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }

        body {
            font-family: 'Poppins', sans-serif;
            background: #f0f2f5;
            min-height: 100vh;
        }

        /* NAVBAR */
        .navbar {
            background: linear-gradient(135deg, #6c5ce7, #764ba2);
            padding: 15px 40px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            box-shadow: 0 2px 15px rgba(108,92,231,0.3);
        }
        .navbar-brand {
            color: white; font-size: 1.3em; font-weight: 700;
            text-decoration: none; display: flex; align-items: center; gap: 10px;
        }
        .navbar-nav { display: flex; gap: 10px; }
        .nav-link {
            color: rgba(255,255,255,0.85); text-decoration: none;
            padding: 8px 18px; border-radius: 25px; font-size: 0.9em;
            font-weight: 500; transition: all 0.3s;
        }
        .nav-link:hover, .nav-link.active { background: white; color: #6c5ce7; }

        /* PAGE HEADER */
        .page-header {
            background: white;
            padding: 25px 40px;
            border-bottom: 1px solid #e2e8f0;
            display: flex;
            justify-content: space-between;
            align-items: center;
            flex-wrap: wrap;
            gap: 15px;
        }
        .page-title h1 { font-size: 1.4em; color: #2d3748; font-weight: 700; }
        .page-title p { font-size: 0.85em; color: #718096; margin-top: 3px; }

        /* TOAST NOTIFICATIONS */
        .toast {
            padding: 12px 20px;
            border-radius: 10px;
            font-size: 0.88em;
            font-weight: 500;
            display: flex;
            align-items: center;
            gap: 8px;
            margin: 15px 40px 0;
        }
        .toast-success { background: #f0fff4; border: 1px solid #c6f6d5; color: #276749; }
        .toast-error   { background: #fff5f5; border: 1px solid #fed7d7; color: #c53030; }

        /* SEARCH BAR */
        .search-section {
            padding: 20px 40px;
            display: flex;
            gap: 10px;
            align-items: center;
            flex-wrap: wrap;
        }
        .search-wrapper {
            display: flex;
            flex: 1;
            max-width: 450px;
            background: white;
            border-radius: 12px;
            border: 2px solid #e2e8f0;
            overflow: hidden;
            transition: border-color 0.3s;
        }
        .search-wrapper:focus-within { border-color: #6c5ce7; }
        .search-wrapper input {
            flex: 1;
            padding: 12px 18px;
            border: none;
            outline: none;
            font-family: 'Poppins', sans-serif;
            font-size: 0.9em;
            color: #2d3748;
        }
        .search-wrapper button {
            padding: 12px 20px;
            background: #6c5ce7;
            color: white;
            border: none;
            cursor: pointer;
            font-size: 0.9em;
            transition: background 0.3s;
        }
        .search-wrapper button:hover { background: #5043b8; }

        .btn-clear-search {
            padding: 12px 18px;
            background: white;
            color: #6c5ce7;
            border: 2px solid #6c5ce7;
            border-radius: 12px;
            font-family: 'Poppins', sans-serif;
            font-size: 0.88em;
            font-weight: 600;
            cursor: pointer;
            text-decoration: none;
            transition: all 0.3s;
        }
        .btn-clear-search:hover { background: #f3f0ff; }

        /* STATS BAR */
        .stats-bar {
            padding: 0 40px 15px;
            color: #718096;
            font-size: 0.85em;
        }
        .stats-bar strong { color: #6c5ce7; }

        /* CARDS GRID */
        .cards-grid {
            padding: 0 40px 40px;
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(320px, 1fr));
            gap: 20px;
        }

        .profile-card {
            background: white;
            border-radius: 16px;
            box-shadow: 0 2px 15px rgba(0,0,0,0.06);
            overflow: hidden;
            transition: transform 0.2s, box-shadow 0.2s;
        }
        .profile-card:hover {
            transform: translateY(-4px);
            box-shadow: 0 10px 30px rgba(0,0,0,0.12);
        }

        .card-stripe {
            height: 6px;
            background: linear-gradient(90deg, #6c5ce7, #a29bfe);
        }

        .card-top {
            padding: 20px 22px 15px;
            display: flex;
            align-items: center;
            gap: 15px;
            border-bottom: 1px solid #f0f0f0;
        }

        .card-avatar {
            width: 52px; height: 52px;
            background: linear-gradient(135deg, #6c5ce7, #a29bfe);
            border-radius: 14px;
            display: flex; align-items: center; justify-content: center;
            flex-shrink: 0;
        }
        .card-avatar i { color: white; font-size: 1.3em; }

        .card-name-block { flex: 1; min-width: 0; }
        .card-name {
            font-size: 1em;
            font-weight: 700;
            color: #2d3748;
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
        }
        .card-id {
            font-size: 0.78em;
            color: #a0aec0;
            margin-top: 2px;
        }

        .card-body { padding: 15px 22px; }

        .card-detail {
            display: flex;
            align-items: center;
            gap: 10px;
            padding: 7px 0;
            border-bottom: 1px solid #f7f7f7;
            font-size: 0.84em;
        }
        .card-detail:last-child { border-bottom: none; }
        .card-detail i { width: 16px; color: #a29bfe; text-align: center; }
        .card-detail span { color: #4a5568; }

        .card-intro {
            margin-top: 12px;
            padding: 10px 14px;
            background: #f8f5ff;
            border-radius: 8px;
            font-size: 0.82em;
            color: #4a5568;
            font-style: italic;
            line-height: 1.5;

            /* Clamp to 2 lines */
            display: -webkit-box;
            -webkit-line-clamp: 2;
            -webkit-box-orient: vertical;
            overflow: hidden;
        }

        /* CARD ACTIONS */
        .card-actions {
            padding: 12px 22px 18px;
            display: flex;
            gap: 8px;
        }
        .btn-action {
            flex: 1;
            padding: 9px 12px;
            border-radius: 8px;
            font-family: 'Poppins', sans-serif;
            font-size: 0.82em;
            font-weight: 600;
            border: none;
            cursor: pointer;
            text-decoration: none;
            text-align: center;
            transition: all 0.2s;
            display: flex; align-items: center; justify-content: center; gap: 5px;
        }
        .btn-edit {
            background: #f3f0ff;
            color: #6c5ce7;
        }
        .btn-edit:hover { background: #6c5ce7; color: white; }
        .btn-delete {
            background: #fff5f5;
            color: #e53e3e;
        }
        .btn-delete:hover { background: #e53e3e; color: white; }

        /* EMPTY STATE */
        .empty-state {
            text-align: center;
            padding: 80px 20px;
            color: #a0aec0;
            grid-column: 1 / -1;
        }
        .empty-state i { font-size: 4em; margin-bottom: 20px; display: block; }
        .empty-state h3 { font-size: 1.2em; color: #718096; margin-bottom: 8px; }
        .empty-state p { font-size: 0.9em; }
        .empty-state a {
            display: inline-flex; align-items: center; gap: 6px;
            margin-top: 20px;
            padding: 12px 24px;
            background: linear-gradient(135deg, #6c5ce7, #a29bfe);
            color: white;
            text-decoration: none;
            border-radius: 10px;
            font-weight: 600;
            font-size: 0.9em;
            transition: all 0.3s;
        }
        .empty-state a:hover { transform: translateY(-2px); box-shadow: 0 8px 20px rgba(108,92,231,0.4); }

        /* CONFIRM DELETE MODAL */
        .modal-overlay {
            display: none;
            position: fixed; inset: 0;
            background: rgba(0,0,0,0.5);
            z-index: 1000;
            justify-content: center;
            align-items: center;
        }
        .modal-overlay.active { display: flex; }
        .modal {
            background: white;
            border-radius: 16px;
            padding: 30px;
            max-width: 380px;
            width: 90%;
            text-align: center;
            box-shadow: 0 20px 60px rgba(0,0,0,0.2);
        }
        .modal i { font-size: 2.5em; color: #e53e3e; margin-bottom: 15px; }
        .modal h3 { font-size: 1.1em; color: #2d3748; margin-bottom: 8px; }
        .modal p { font-size: 0.88em; color: #718096; margin-bottom: 20px; }
        .modal-actions { display: flex; gap: 10px; }
        .modal-btn {
            flex: 1; padding: 11px;
            border-radius: 8px;
            font-family: 'Poppins', sans-serif;
            font-size: 0.9em;
            font-weight: 600;
            border: none;
            cursor: pointer;
            transition: all 0.2s;
        }
        .modal-btn-cancel { background: #f7fafc; color: #718096; border: 2px solid #e2e8f0; }
        .modal-btn-delete { background: #e53e3e; color: white; }
        .modal-btn-delete:hover { background: #c53030; }

        @media (max-width: 600px) {
            .navbar, .page-header, .search-section, .stats-bar, .cards-grid { padding-left: 20px; padding-right: 20px; }
        }
    </style>
</head>
<body>

    <!-- NAVBAR -->
    <nav class="navbar">
        <a href="index.html" class="navbar-brand">
            <i class="fas fa-id-card"></i> Profile Management System
        </a>
        <div class="navbar-nav">
            <a href="index.html" class="nav-link"><i class="fas fa-plus"></i> Add Profile</a>
            <a href="ProfileServlet?action=view" class="nav-link active"><i class="fas fa-users"></i> View All</a>
        </div>
    </nav>

    <!-- PAGE HEADER -->
    <div class="page-header">
        <div class="page-title">
            <h1><i class="fas fa-users" style="color:#6c5ce7; margin-right:8px;"></i>Student Profiles</h1>
            <p>Manage and view all registered student profiles</p>
        </div>
        <a href="index.html" style="padding:10px 20px; background:linear-gradient(135deg,#6c5ce7,#a29bfe); color:white; border-radius:10px; text-decoration:none; font-weight:600; font-size:0.9em; display:flex; align-items:center; gap:6px;">
            <i class="fas fa-plus"></i> Add New Profile
        </a>
    </div>

    <!-- TOAST MESSAGES -->
    <%
        if ("deleted".equals(msg)) {
    %>
        <div class="toast toast-success"><i class="fas fa-check-circle"></i> Profile deleted successfully.</div>
    <%
        } else if ("updated".equals(msg)) {
    %>
        <div class="toast toast-success"><i class="fas fa-check-circle"></i> Profile updated successfully.</div>
    <%
        }
    %>

    <!-- SEARCH BAR -->
    <div class="search-section">
        <form action="ProfileServlet" method="GET" style="display:flex; gap:10px; flex:1; max-width:500px;">
            <input type="hidden" name="action" value="search">
            <div class="search-wrapper">
                <input type="text" name="keyword"
                       placeholder="Search by Student ID or Name..."
                       value="<%= searchKeyword %>">
                <button type="submit"><i class="fas fa-search"></i></button>
            </div>
        </form>
        <% if (!searchKeyword.isEmpty()) { %>
            <a href="ProfileServlet?action=view" class="btn-clear-search">
                <i class="fas fa-times"></i> Clear
            </a>
        <% } %>
    </div>

    <!-- STATS -->
    <div class="stats-bar">
        <% if (!searchKeyword.isEmpty()) { %>
            Showing <strong><%= profileList != null ? profileList.size() : 0 %></strong>
            result(s) for "<strong><%= searchKeyword %></strong>"
        <% } else { %>
            Total: <strong><%= profileList != null ? profileList.size() : 0 %></strong> profile(s)
        <% } %>
    </div>

    <!-- CARDS GRID -->
    <div class="cards-grid">
        <%
            if (profileList == null || profileList.isEmpty()) {
        %>
            <div class="empty-state">
                <i class="fas fa-user-slash"></i>
                <h3><%= !searchKeyword.isEmpty() ? "No profiles found" : "No profiles yet" %></h3>
                <p><%= !searchKeyword.isEmpty() ? "Try a different search keyword." : "Click below to add the first student profile." %></p>
                <% if (searchKeyword.isEmpty()) { %>
                    <a href="index.html"><i class="fas fa-plus"></i> Add First Profile</a>
                <% } %>
            </div>
        <%
            } else {
                for (ProfileBean p : profileList) {
                    String hobbies = p.getHobbies();
                    String intro   = p.getIntroduction();
        %>
            <div class="profile-card">
                <div class="card-stripe"></div>
                <div class="card-top">
                    <div class="card-avatar"><i class="fas fa-user-graduate"></i></div>
                    <div class="card-name-block">
                        <div class="card-name"><%= p.getName() %></div>
                        <div class="card-id"><i class="fas fa-id-badge" style="margin-right:4px;"></i><%= p.getStudentID() %></div>
                    </div>
                </div>
                <div class="card-body">
                    <div class="card-detail">
                        <i class="fas fa-graduation-cap"></i>
                        <span><%= p.getProgramme() %></span>
                    </div>
                    <div class="card-detail">
                        <i class="fas fa-envelope"></i>
                        <span><%= p.getEmail() %></span>
                    </div>
                    <div class="card-detail">
                        <i class="fas fa-heart"></i>
                        <span><%= (hobbies != null && !hobbies.isEmpty()) ? hobbies : "–" %></span>
                    </div>
                    <% if (intro != null && !intro.isEmpty()) { %>
                        <div class="card-intro">"<%= intro %>"</div>
                    <% } %>
                </div>
                <div class="card-actions">
                    <a href="ProfileServlet?action=edit&studentID=<%= p.getStudentID() %>" class="btn-action btn-edit">
                        <i class="fas fa-pen"></i> Edit
                    </a>
                    <button onclick="confirmDelete('<%= p.getStudentID() %>', '<%= p.getName() %>')"
                            class="btn-action btn-delete">
                        <i class="fas fa-trash"></i> Delete
                    </button>
                </div>
            </div>
        <%
                }
            }
        %>
    </div>

    <!-- DELETE CONFIRM MODAL -->
    <div class="modal-overlay" id="deleteModal">
        <div class="modal">
            <i class="fas fa-exclamation-triangle"></i>
            <h3>Delete Profile?</h3>
            <p id="deleteMsg">Are you sure you want to delete this profile? This action cannot be undone.</p>
            <div class="modal-actions">
                <button class="modal-btn modal-btn-cancel" onclick="closeModal()">Cancel</button>
                <a id="confirmDeleteBtn" href="#" class="modal-btn modal-btn-delete">
                    <i class="fas fa-trash"></i> Delete
                </a>
            </div>
        </div>
    </div>

    <script>
        function confirmDelete(studentID, name) {
            document.getElementById('deleteMsg').textContent =
                'Are you sure you want to delete the profile of "' + name + '"? This cannot be undone.';
            document.getElementById('confirmDeleteBtn').href =
                'ProfileServlet?action=delete&studentID=' + encodeURIComponent(studentID);
            document.getElementById('deleteModal').classList.add('active');
        }

        function closeModal() {
            document.getElementById('deleteModal').classList.remove('active');
        }

        // Close modal on overlay click
        document.getElementById('deleteModal').addEventListener('click', function(e) {
            if (e.target === this) closeModal();
        });

        // Auto-hide toast after 3 seconds
        const toast = document.querySelector('.toast');
        if (toast) setTimeout(() => toast.style.opacity = '0', 3000);
    </script>

</body>
</html>
