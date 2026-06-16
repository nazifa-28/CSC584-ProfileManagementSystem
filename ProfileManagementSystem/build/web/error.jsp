<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String errorMsg = (String) request.getAttribute("errorMsg");
    if (errorMsg == null) errorMsg = "An unexpected error occurred.";
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Error – Profile Management System</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body {
            font-family: 'Poppins', sans-serif;
            background: linear-gradient(135deg, #667eea, #764ba2);
            min-height: 100vh;
            display: flex; justify-content: center; align-items: center;
        }
        .error-card {
            background: white;
            border-radius: 20px;
            padding: 50px 40px;
            text-align: center;
            max-width: 420px;
            width: 90%;
            box-shadow: 0 20px 50px rgba(0,0,0,0.2);
        }
        .error-card i { font-size: 3.5em; color: #fc8181; margin-bottom: 20px; }
        .error-card h2 { color: #2d3748; font-size: 1.3em; margin-bottom: 12px; }
        .error-card p { color: #718096; font-size: 0.9em; margin-bottom: 25px; }
        .btn-back {
            display: inline-flex; align-items: center; gap: 6px;
            padding: 12px 24px;
            background: linear-gradient(135deg, #6c5ce7, #a29bfe);
            color: white;
            text-decoration: none;
            border-radius: 10px;
            font-weight: 600;
            font-size: 0.9em;
        }
    </style>
</head>
<body>
    <div class="error-card">
        <i class="fas fa-exclamation-circle"></i>
        <h2>Oops! Something went wrong</h2>
        <p><%= errorMsg %></p>
        <a href="ProfileServlet?action=view" class="btn-back">
            <i class="fas fa-arrow-left"></i> Back to Profiles
        </a>
    </div>
</body>
</html>
