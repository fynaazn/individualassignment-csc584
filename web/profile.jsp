<%@page import="model.ProfileBean"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    ProfileBean profile = (ProfileBean) request.getAttribute("profile");
    String mode = (String) request.getAttribute("mode");
    if (mode == null) {
        mode = "insert";
    }
    String[] hobbies = (profile.getHobbies() != null && !profile.getHobbies().trim().isEmpty())
            ? profile.getHobbies().split(",")
            : new String[0];
%>

<!DOCTYPE html>
<html>
    <head>
        <title>Profile - <%= profile.getName() %></title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">

        <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
        <style>
            * {
                box-sizing: border-box;
                margin: 0;
                padding: 0;
                font-family: 'Poppins', sans-serif;
            }

            body {
                background: linear-gradient(135deg, #a8c8f0 0%, #7bafd4 100%);
                min-height: 100vh;
                padding: 40px 15px;
            }

            .wrapper {
                max-width: 620px;
                margin: 0 auto;
            }

            .profile-card {
                border-radius: 20px;
                box-shadow: 0 20px 60px rgba(91, 155, 213, 0.3);
                overflow: hidden;
            }

            .profile-banner {
                background: linear-gradient(135deg, #a8c8f0 0%, #7bafd4 100%);
                padding: 40px 30px 50px 30px;
                text-align: center;
            }

            .profile-banner .avatar {
                width: 100px;
                height: 100px;
                background: rgba(255, 255, 255, 0.3);
                border-radius: 50%;
                display: flex;
                align-items: center;
                justify-content: center;
                margin: 0 auto 15px auto;
                font-size: 3rem;
                color: white;
                border: 4px solid rgba(255, 255, 255, 0.5);
            }

            .profile-banner h2 {
                color: white;
                font-weight: 700;
                font-size: 1.7rem;
                margin-bottom: 8px;
            }

            .profile-banner .badge-program {
                background: rgba(255, 255, 255, 0.3);
                color: white;
                border-radius: 20px;
                padding: 4px 16px;
                font-size: 0.85rem;
                font-weight: 500;
            }

            .profile-body {
                background: white;
                padding: 35px 40px;
            }

            .success-banner {
                background: #e0f4ec;
                color: #1a6640;
                border-radius: 10px;
                padding: 10px 18px;
                display: flex;
                align-items: center;
                margin-bottom: 22px;
                font-size: 0.9rem;
                font-weight: 500;
            }

            .success-banner i {
                margin-right: 10px;
                font-size: 1.1rem;
                color: #28a745;
            }

            .info-item {
                display: flex;
                align-items: flex-start;
                background: #f0f7fd;
                border-radius: 12px;
                padding: 14px 18px;
                margin-bottom: 14px;
                border-left: 4px solid #7bafd4;
            }

            .info-icon {
                width: 36px;
                height: 36px;
                background: linear-gradient(135deg, #a8c8f0, #7bafd4);
                border-radius: 8px;
                display: flex;
                align-items: center;
                justify-content: center;
                color: white;
                font-size: 0.9rem;
                flex-shrink: 0;
                margin-right: 15px;
            }

            .info-label {
                font-size: 0.78rem;
                color: #999;
                font-weight: 600;
                text-transform: uppercase;
                letter-spacing: 0.5px;
                margin-bottom: 2px;
            }

            .info-value {
                font-size: 1rem;
                color: #333;
                font-weight: 500;
            }

            .section-title {
                font-size: 0.85rem;
                font-weight: 700;
                color: #7bafd4;
                text-transform: uppercase;
                letter-spacing: 1px;
                margin-bottom: 12px;
            }

            .section-title i {
                margin-right: 6px;
            }

            .hobby-badge {
                display: inline-flex;
                align-items: center;
                background: linear-gradient(135deg, #a8c8f0, #7bafd4);
                color: white;
                border-radius: 20px;
                padding: 5px 14px;
                font-size: 0.85rem;
                font-weight: 500;
                margin: 4px;
            }

            .hobby-badge i {
                margin-right: 6px;
                font-size: 0.8rem;
            }

            .no-hobbies {
                color: #aaa;
                font-size: 0.9rem;
                font-style: italic;
            }

            .intro-box {
                background: #f0f7fd;
                border-radius: 12px;
                padding: 18px 20px;
                border-left: 4px solid #a8c8f0;
                color: #444;
                font-size: 0.95rem;
                line-height: 1.7;
            }

            .intro-box .quote-icon {
                color: #7bafd4;
                font-size: 1.2rem;
                margin-right: 6px;
            }

            .section-divider {
                border: none;
                border-top: 2px dashed #d0e8f7;
                margin: 22px 0;
            }

            .btn-back-wrapper {
                text-align: center;
                margin-top: 10px;
                display: flex;
                gap: 10px;
                justify-content: center;
                flex-wrap: wrap;
            }

            .btn-back {
                display: inline-block;
                background: white;
                border: 2px solid #7bafd4;
                color: #7bafd4;
                border-radius: 12px;
                font-weight: 600;
                font-size: 0.95rem;
                font-family: 'Poppins', sans-serif;
                padding: 10px 30px;
                text-decoration: none;
                transition: all 0.3s;
            }

            .btn-back:hover {
                background: linear-gradient(135deg, #a8c8f0, #7bafd4);
                border-color: transparent;
                color: white;
            }

            .btn-back i {
                margin-right: 8px;
            }

            .section-block {
                margin-bottom: 18px;
            }

            @media (max-width: 576px) {
                .profile-body {
                    padding: 25px 20px;
                }
            }
        </style>
    </head>
    <body>
        <div class="wrapper">
            <div class="profile-card">

                <div class="profile-banner">
                    <div class="avatar">
                        <i class="fas fa-user"></i>
                    </div>
                    <h2><%= profile.getName() %></h2>
                    <span class="badge-program"><%= profile.getProgramme() %></span>
                </div>

                <div class="profile-body">

                    <div class="success-banner">
                        <i class="fas fa-check-circle"></i>
                        <%= "update".equals(mode) ? "Profile updated successfully!" : "Profile submitted successfully!" %>
                    </div>

                    <!-- student ID -->
                    <div class="info-item">
                        <div class="info-icon"><i class="fas fa-id-card"></i></div>
                        <div>
                            <p class="info-label">Student ID</p>
                            <p class="info-value"><%= profile.getStudentID() %></p>
                        </div>
                    </div>

                    <!-- programme -->
                    <div class="info-item">
                        <div class="info-icon"><i class="fas fa-graduation-cap"></i></div>
                        <div>
                            <p class="info-label">Programme</p>
                            <p class="info-value"><%= profile.getProgramme() %></p>
                        </div>
                    </div>

                    <!-- email -->
                    <div class="info-item">
                        <div class="info-icon"><i class="fas fa-envelope"></i></div>
                        <div>
                            <p class="info-label">Email Address</p>
                            <p class="info-value"><%= profile.getEmail() %></p>
                        </div>
                    </div>

                    <hr class="section-divider">

                    <!-- hobbies -->
                    <div class="section-block">
                        <p class="section-title"><i class="fas fa-heart"></i>Hobbies &amp; Interests</p>
                        <%
                            if (hobbies.length > 0) {
                                for (String hobbyRaw : hobbies) {
                                    String hobby = hobbyRaw.trim();
                                    String icon = "fas fa-star";
                                    if (hobby.equals("Reading"))     icon = "fas fa-book";
                                    if (hobby.equals("Gaming"))      icon = "fas fa-gamepad";
                                    if (hobby.equals("Travelling"))  icon = "fas fa-plane";
                                    if (hobby.equals("Cooking"))     icon = "fas fa-utensils";
                                    if (hobby.equals("Photography")) icon = "fas fa-camera";
                                    if (hobby.equals("Music"))       icon = "fas fa-music";
                                    if (hobby.equals("Sports"))      icon = "fas fa-futbol";
                                    if (hobby.equals("Drawing"))     icon = "fas fa-paint-brush";
                        %>
                                    <span class="hobby-badge">
                                        <i class="<%= icon %>"></i><%= hobby %>
                                    </span>
                        <%
                                }
                            } else {
                        %>
                                <span class="no-hobbies">No hobbies selected.</span>
                        <%
                            }
                        %>
                    </div>

                    <hr class="section-divider">

                    <!-- self introduction -->
                    <div class="section-block">
                        <p class="section-title"><i class="fas fa-comment-dots"></i>About Me</p>
                        <div class="intro-box">
                            <i class="fas fa-quote-left quote-icon"></i><%= profile.getIntroduction() %>
                        </div>
                    </div>

                    <div class="btn-back-wrapper">
                        <a href="ViewProfileServlet" class="btn-back">
                            <i class="fas fa-home"></i>Back to Homepage
                        </a>
                    </div>

                </div>
            </div>
        </div>
    </body>
</html>