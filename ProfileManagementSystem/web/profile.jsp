<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.studentprofile.model.ProfileBean" %>
<%
    ProfileBean profile = (ProfileBean) request.getAttribute("profile");
    if (profile == null) {
        response.sendRedirect("index.html");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Profile Created – <%= profile.getName() %></title>
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

        /* NAVBAR */
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

        /* MAIN */
        .main-content {
            flex: 1; display: flex; justify-content: center;
            align-items: center; padding: 40px 20px;
        }

        .profile-card {
            background: white;
            width: 100%; max-width: 520px;
            border-radius: 24px;
            box-shadow: 0 25px 60px rgba(0,0,0,0.2);
            overflow: hidden;
        }

        /* SUCCESS BANNER */
        .success-banner {
            background: linear-gradient(135deg, #00b894, #00cec9);
            padding: 10px 20px;
            text-align: center;
            color: white;
            font-size: 0.85em;
            font-weight: 600;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
        }

        /* CARD HEADER */
        .card-header {
            background: linear-gradient(135deg, #6c5ce7, #a29bfe);
            padding: 35px 20px;
            text-align: center;
            color: white;
        }
        .avatar {
            width: 90px; height: 90px;
            background: white;
            border-radius: 50%;
            margin: 0 auto 15px;
            display: flex; align-items: center; justify-content: center;
            box-shadow: 0 5px 20px rgba(0,0,0,0.2);
        }
        .avatar i { font-size: 2.5em; color: #6c5ce7; }
        .card-header h2 { font-size: 1.4em; font-weight: 700; }
        .card-header span {
            display: inline-block;
            background: rgba(255,255,255,0.25);
            padding: 3px 14px;
            border-radius: 20px;
            font-size: 0.82em;
            margin-top: 6px;
        }

        /* CARD BODY */
        .card-body { padding: 30px 35px; }

        .info-row {
            display: flex;
            align-items: flex-start;
            padding: 12px 0;
            border-bottom: 1px solid #f0f0f0;
            gap: 15px;
        }
        .info-row:last-child { border-bottom: none; }

        .info-icon {
            width: 36px; height: 36px;
            background: #f3f0ff;
            border-radius: 10px;
            display: flex; align-items: center; justify-content: center;
            flex-shrink: 0;
        }
        .info-icon i { color: #6c5ce7; font-size: 0.9em; }

        .info-label {
            font-size: 0.75em;
            color: #a0aec0;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }
        .info-value {
            font-size: 0.9em;
            color: #2d3748;
            font-weight: 500;
            margin-top: 2px;
        }

        /* INTRODUCTION BOX */
        .intro-section { margin-top: 5px; }
        .intro-box {
            background: #f8f5ff;
            border-left: 4px solid #6c5ce7;
            padding: 14px 16px;
            border-radius: 0 10px 10px 0;
            font-size: 0.88em;
            color: #4a5568;
            font-style: italic;
            line-height: 1.6;
            margin-top: 10px;
        }

        /* ACTIONS */
        .card-actions {
            padding: 20px 35px 30px;
            display: flex;
            gap: 10px;
        }
        .btn {
            flex: 1;
            padding: 12px;
            border-radius: 10px;
            font-family: 'Poppins', sans-serif;
            font-size: 0.88em;
            font-weight: 600;
            text-decoration: none;
            text-align: center;
            cursor: pointer;
            border: none;
            transition: all 0.3s;
            display: flex; align-items: center; justify-content: center; gap: 6px;
        }
        .btn-primary {
            background: linear-gradient(135deg, #6c5ce7, #a29bfe);
            color: white;
        }
        .btn-primary:hover { transform: translateY(-2px); box-shadow: 0 8px 20px rgba(108,92,231,0.4); }
        .btn-outline {
            background: white;
            color: #6c5ce7;
            border: 2px solid #6c5ce7;
        }
        .btn-outline:hover { background: #f3f0ff; }
    </style>
</head>
<body>

    <nav class="navbar">
        <a href="home.html" class="navbar-brand">
            <i class="fas fa-id-card"></i> Profile Management System
        </a>
        <div class="navbar-nav">
            <a href="index.html" class="nav-link"><i class="fas fa-plus"></i> Add Profile</a>
            <a href="ProfileServlet?action=view" class="nav-link"><i class="fas fa-users"></i> View All</a>
        </div>
    </nav>

    <div class="main-content">
        <div class="profile-card">

            <div class="success-banner">
                <i class="fas fa-check-circle"></i>
                Profile saved successfully to database!
            </div>

            <div class="card-header">
                <div class="avatar">
                    <i class="fas fa-user-graduate"></i>
                </div>
                <h2><%= profile.getName() %></h2>
                <span><%= profile.getStudentID() %></span>
            </div>

            <div class="card-body">
                <div class="info-row">
                    <div class="info-icon"><i class="fas fa-graduation-cap"></i></div>
                    <div>
                        <div class="info-label">Programme</div>
                        <div class="info-value"><%= profile.getProgramme() %></div>
                    </div>
                </div>

                <div class="info-row">
                    <div class="info-icon"><i class="fas fa-envelope"></i></div>
                    <div>
                        <div class="info-label">Email</div>
                        <div class="info-value"><%= profile.getEmail() %></div>
                    </div>
                </div>

                <div class="info-row">
                    <div class="info-icon"><i class="fas fa-heart"></i></div>
                    <div>
                        <div class="info-label">Hobbies</div>
                        <div class="info-value">
                            <% String h = profile.getHobbies();
                               out.print((h != null && !h.isEmpty()) ? h : "–"); %>
                        </div>
                    </div>
                </div>

                <div class="intro-section">
                    <div style="font-size:0.75em; color:#a0aec0; font-weight:600; text-transform:uppercase; letter-spacing:0.5px;">
                        About Me
                    </div>
                    <div class="intro-box"><%= profile.getIntroduction() %></div>
                </div>
            </div>

            <div class="card-actions">
                <a href="index.html" class="btn btn-outline">
                    <i class="fas fa-plus"></i> Add Another
                </a>
                <a href="ProfileServlet?action=view" class="btn btn-primary">
                    <i class="fas fa-users"></i> View All Profiles
                </a>
            </div>

        </div>
    </div>

</body>
</html>
