<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.studentprofile.model.ProfileBean" %>
<%
    ProfileBean profile = (ProfileBean) request.getAttribute("profile");
    if (profile == null) {
        response.sendRedirect("ProfileServlet?action=view");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Profile – <%= profile.getName() %></title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }

        body {
            font-family: 'Poppins', sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            display: flex;
            flex-direction: column;
        }

        .navbar {
            background: rgba(255,255,255,0.15);
            backdrop-filter: blur(10px);
            padding: 15px 40px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            border-bottom: 1px solid rgba(255,255,255,0.2);
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
        .nav-link:hover { background: white; color: #6c5ce7; }

        .main-content {
            flex: 1; display: flex; justify-content: center;
            align-items: center; padding: 40px 20px;
        }

        .form-card {
            background: white;
            width: 100%; max-width: 560px;
            border-radius: 24px;
            box-shadow: 0 25px 60px rgba(0,0,0,0.2);
            overflow: hidden;
        }

        .form-header {
            background: linear-gradient(135deg, #f6ad55, #fc8181);
            padding: 30px 40px;
            color: white;
            display: flex;
            align-items: center;
            gap: 15px;
        }
        .form-header i { font-size: 2.5em; }
        .form-header h2 { font-size: 1.3em; font-weight: 700; }
        .form-header p { font-size: 0.85em; opacity: 0.9; margin-top: 3px; }

        .id-badge {
            display: inline-block;
            background: rgba(255,255,255,0.25);
            padding: 2px 12px;
            border-radius: 20px;
            font-size: 0.82em;
            font-weight: 600;
        }

        .form-body { padding: 30px 40px; }

        .input-group { margin-bottom: 18px; }
        .input-group label {
            display: block;
            color: #4a5568;
            font-size: 0.85em;
            font-weight: 600;
            margin-bottom: 7px;
        }
        .input-group input,
        .input-group textarea {
            width: 100%;
            padding: 12px 16px;
            border: 2px solid #e2e8f0;
            border-radius: 10px;
            outline: none;
            font-family: 'Poppins', sans-serif;
            font-size: 0.9em;
            color: #2d3748;
            background: #f7fafc;
            transition: all 0.3s;
        }
        .input-group input:focus,
        .input-group textarea:focus {
            border-color: #f6ad55;
            background: white;
            box-shadow: 0 0 0 4px rgba(246,173,85,0.15);
        }
        .input-group input[readonly] {
            background: #f0f0f0;
            color: #a0aec0;
            cursor: not-allowed;
        }
        .input-group textarea { resize: vertical; min-height: 90px; }

        .row-2 { display: grid; grid-template-columns: 1fr 1fr; gap: 15px; }

        .btn-row { display: flex; gap: 10px; margin-top: 8px; }

        .btn {
            flex: 1;
            padding: 13px;
            border-radius: 12px;
            font-family: 'Poppins', sans-serif;
            font-size: 0.9em;
            font-weight: 600;
            cursor: pointer;
            text-decoration: none;
            text-align: center;
            border: none;
            transition: all 0.3s;
            display: flex; align-items: center; justify-content: center; gap: 6px;
        }
        .btn-save {
            background: linear-gradient(135deg, #f6ad55, #fc8181);
            color: white;
        }
        .btn-save:hover { transform: translateY(-2px); box-shadow: 0 8px 20px rgba(246,173,85,0.4); }
        .btn-cancel {
            background: white;
            color: #718096;
            border: 2px solid #e2e8f0;
        }
        .btn-cancel:hover { background: #f7fafc; }
    </style>
</head>
<body>

    <nav class="navbar">
        <a href="index.html" class="navbar-brand">
            <i class="fas fa-id-card"></i> Profile Management System
        </a>
        <div class="navbar-nav">
            <a href="index.html" class="nav-link"><i class="fas fa-plus"></i> Add Profile</a>
            <a href="ProfileServlet?action=view" class="nav-link"><i class="fas fa-users"></i> View All</a>
        </div>
    </nav>

    <div class="main-content">
        <div class="form-card">

            <div class="form-header">
                <i class="fas fa-user-edit"></i>
                <div>
                    <h2>Edit Profile</h2>
                    <p>Updating profile for <span class="id-badge"><%= profile.getStudentID() %></span></p>
                </div>
            </div>

            <div class="form-body">
                <form action="ProfileServlet" method="POST">
                    <input type="hidden" name="action" value="update">

                    <div class="row-2">
                        <div class="input-group">
                            <label><i class="fas fa-id-badge" style="color:#a29bfe;"></i> Student ID</label>
                            <!-- Read-only: Student ID is the primary key -->
                            <input type="text" name="studentID"
                                   value="<%= profile.getStudentID() %>" readonly>
                        </div>
                        <div class="input-group">
                            <label><i class="fas fa-user" style="color:#a29bfe;"></i> Full Name *</label>
                            <input type="text" name="name" required
                                   value="<%= profile.getName() %>">
                        </div>
                    </div>

                    <div class="input-group">
                        <label><i class="fas fa-graduation-cap" style="color:#a29bfe;"></i> Programme *</label>
                        <input type="text" name="programme" required
                               value="<%= profile.getProgramme() %>">
                    </div>

                    <div class="input-group">
                        <label><i class="fas fa-envelope" style="color:#a29bfe;"></i> Email Address *</label>
                        <input type="email" name="email" required
                               value="<%= profile.getEmail() %>">
                    </div>

                    <div class="input-group">
                        <label><i class="fas fa-heart" style="color:#a29bfe;"></i> Hobbies</label>
                        <input type="text" name="hobbies"
                               value="<%= (profile.getHobbies() != null) ? profile.getHobbies() : "" %>">
                    </div>

                    <div class="input-group">
                        <label><i class="fas fa-comment" style="color:#a29bfe;"></i> Short Introduction *</label>
                        <textarea name="introduction" required><%= profile.getIntroduction() %></textarea>
                    </div>

                    <div class="btn-row">
                        <a href="ProfileServlet?action=view" class="btn btn-cancel">
                            <i class="fas fa-times"></i> Cancel
                        </a>
                        <button type="submit" class="btn btn-save">
                            <i class="fas fa-save"></i> Save Changes
                        </button>
                    </div>
                </form>
            </div>

        </div>
    </div>

</body>
</html>
