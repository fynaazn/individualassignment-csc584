<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    String errorMessage = (String) request.getAttribute("errorMessage");
%>

<!DOCTYPE html>
<html>
    <head>
        <title>Error</title>
        <meta charset="UTF-8">
        <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
        <style>
            * { box-sizing: border-box; margin: 0; padding: 0; font-family: 'Poppins', sans-serif; }
            body {
                background: linear-gradient(135deg, #f5a8a8 0%, #d47b7b 100%); min-height: 100vh;
                display: flex; align-items: center; justify-content: center; padding: 20px;
            }
            .card {
                background: white; border-radius: 20px; box-shadow: 0 20px 60px rgba(212,123,123,0.3);
                padding: 40px; max-width: 500px; text-align: center;
            }
            .card i { font-size: 3rem; color: #d9534f; margin-bottom: 15px; }
            .card h2 { color: #a83232; margin-bottom: 10px; }
            .card p { color: #666; margin-bottom: 25px; }
            .btn-back {
                display: inline-block; background: linear-gradient(135deg,#f5a8a8,#d47b7b);
                color: white; border-radius: 12px; font-weight: 600; padding: 10px 30px; text-decoration: none;
            }
        </style>
    </head>
    <body>
        <div class="card">
            <i class="fas fa-exclamation-triangle"></i>
            <h2>Something Went Wrong</h2>
            <p><%= errorMessage != null ? errorMessage : "An unexpected error occurred." %></p>
            <a href="ViewProfileServlet" class="btn-back"><i class="fas fa-arrow-left"></i> Back to Home</a>
        </div>
    </body>
</html>