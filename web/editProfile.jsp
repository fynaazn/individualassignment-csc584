<%@page import="model.ProfileBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    ProfileBean profile = (ProfileBean) request.getAttribute("profile");
    List<String> hobbyList = new ArrayList<String>();
    if (profile.getHobbies() != null && !profile.getHobbies().trim().isEmpty()) {
        for (String h : profile.getHobbies().split(",")) {
            hobbyList.add(h.trim());
        }
    }
%>

<!DOCTYPE html>
<html>
    <head>
        <title>Edit Profile - <%= profile.getName() %></title>
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

            .card {
                border-radius: 20px;
                box-shadow: 0 20px 60px rgba(91, 155, 213, 0.3);
                overflow: hidden;
            }

            .card-header {
                background: linear-gradient(135deg, #a8c8f0 0%, #7bafd4 100%);
                padding: 30px;
                text-align: center;
            }

            .card-header .avatar-icon {
                font-size: 3.5rem;
                color: white;
                margin-bottom: 10px;
            }

            .card-header h1 {
                color: white;
                font-weight: 700;
                font-size: 1.8rem;
            }

            .card-header p {
                color: rgba(255, 255, 255, 0.9);
                margin-top: 6px;
                font-size: 0.95rem;
            }

            .card-body {
                background: #ffffff;
                padding: 35px 40px;
            }

            .form-group {
                margin-bottom: 18px;
            }

            .form-group label {
                display: block;
                font-weight: 600;
                color: #3a5a7a;
                font-size: 0.9rem;
                margin-bottom: 6px;
            }

            .form-group label i {
                color: #7bafd4;
                margin-right: 6px;
            }

            .form-group input[type="text"],
            .form-group input[type="email"],
            .form-group select,
            .form-group textarea {
                width: 100%;
                border: 2px solid #d0e8f7;
                border-radius: 10px;
                padding: 10px 15px;
                font-size: 0.95rem;
                font-family: 'Poppins', sans-serif;
                color: #333;
                background: #f5faff;
                transition: border-color 0.3s, box-shadow 0.3s;
            }

            .form-group input[type="text"]:focus,
            .form-group input[type="email"]:focus,
            .form-group select:focus,
            .form-group textarea:focus {
                border-color: #7bafd4;
                box-shadow: 0 0 0 3px rgba(123, 175, 212, 0.2);
                outline: none;
                background: #fff;
            }

            .form-group textarea {
                resize: vertical;
                min-height: 100px;
            }

            .hobby-grid {
                display: grid;
                grid-template-columns: repeat(auto-fill, minmax(155px, 1fr));
                gap: 10px;
                margin-top: 5px;
            }

            .hobby-item {
                display: flex;
                align-items: center;
                background: #f0f7fd;
                border: 2px solid #d0e8f7;
                border-radius: 10px;
                padding: 8px 12px;
                cursor: pointer;
                transition: all 0.2s;
            }

            .hobby-item:hover {
                border-color: #7bafd4;
                background: #daeef9;
            }

            .hobby-item input[type="checkbox"] {
                accent-color: #7bafd4;
                width: 16px;
                height: 16px;
                margin-right: 8px;
                cursor: pointer;
                flex-shrink: 0;
            }

            .hobby-item label {
                cursor: pointer;
                font-size: 0.88rem;
                color: #3a5a7a;
                margin: 0;
            }

            .hobby-item label i {
                margin-right: 5px;
                color: #7bafd4;
                font-size: 0.85rem;
            }

            .section-divider {
                border: none;
                border-top: 2px dashed #d0e8f7;
                margin: 22px 0;
            }

            .btn-submit {
                background: linear-gradient(135deg, #a8c8f0 0%, #7bafd4 100%);
                border: none;
                border-radius: 12px;
                color: white;
                font-weight: 600;
                font-size: 1rem;
                font-family: 'Poppins', sans-serif;
                padding: 12px 40px;
                width: 100%;
                cursor: pointer;
                transition: opacity 0.3s, transform 0.2s;
            }

            .btn-submit:hover {
                opacity: 0.88;
                transform: translateY(-2px);
            }

            .btn-submit i {
                margin-right: 8px;
            }

            @media (max-width: 576px) {
                .card-body {
                    padding: 25px 20px;
                }
                .hobby-grid {
                    grid-template-columns: repeat(2, 1fr);
                }
            }
        </style>
    </head>
    <body>
        <div class="wrapper">
            <div class="card">

                <div class="card-header">
                    <div class="avatar-icon">
                        <i class="fas fa-user-edit"></i>
                    </div>
                    <h1>Edit Profile</h1>
                    <p>Update the details below and save your changes</p>
                </div>

                <div class="card-body">
                    <form action="EditServlet" method="post">

                        <!-- student ID -->
                        <div class="form-group">
                            <label><i class="fas fa-id-card"></i>Student ID</label>
                            <input type="text" name="studentID" value="<%= profile.getStudentID() %>"
                                   readonly style="background:#eef5fb; color:#777;">
                        </div>

                        <!-- name -->
                        <div class="form-group">
                            <label><i class="fas fa-user"></i>Full Name</label>
                            <input type="text" name="name" value="<%= profile.getName() %>" required>
                        </div>

                        <!-- programme -->
                        <div class="form-group">
                            <label><i class="fas fa-graduation-cap"></i>Programme</label>
                            <select name="programme" required>
                                <option value="Bachelor of Computer Science"
                                        <%= "Bachelor of Computer Science".equals(profile.getProgramme()) ? "selected" : "" %>>
                                        Bachelor of Computer Science</option>
                                <option value="Bachelor of Information Technology"
                                        <%= "Bachelor of Information Technology".equals(profile.getProgramme()) ? "selected" : "" %>>
                                        Bachelor of Information Technology</option>
                                <option value="Bachelor of Information Systems"
                                        <%= "Bachelor of Information Systems".equals(profile.getProgramme()) ? "selected" : "" %>>
                                        Bachelor of Information Systems</option>
                            </select>
                        </div>

                        <!-- email -->
                        <div class="form-group">
                            <label><i class="fas fa-envelope"></i>Email Address</label>
                            <input type="email" name="email" value="<%= profile.getEmail() %>" required>
                        </div>

                        <hr class="section-divider">

                        <!-- hobbies -->
                        <div class="form-group">
                            <label><i class="fas fa-heart"></i>Hobbies</label>
                            <div class="hobby-grid">
                                <%
                                    String[][] hobbyOptions = {
                                        {"Reading", "fas fa-book"}, {"Gaming", "fas fa-gamepad"},
                                        {"Travelling", "fas fa-plane"}, {"Cooking", "fas fa-utensils"},
                                        {"Photography", "fas fa-camera"}, {"Music", "fas fa-music"},
                                        {"Sports", "fas fa-futbol"}, {"Drawing", "fas fa-paint-brush"}
                                    };
                                    for (int i = 0; i < hobbyOptions.length; i++) {
                                        String hobbyName = hobbyOptions[i][0];
                                        String icon = hobbyOptions[i][1];
                                        String checked = hobbyList.contains(hobbyName) ? "checked" : "";
                                %>
                                <div class="hobby-item">
                                    <input type="checkbox" name="hobbies" value="<%= hobbyName %>" id="h<%= i %>" <%= checked %>>
                                    <label for="h<%= i %>"><i class="<%= icon %>"></i><%= hobbyName %></label>
                                </div>
                                <% } %>
                            </div>
                        </div>

                        <hr class="section-divider">

                        <!-- self introduction -->
                        <div class="form-group">
                            <label><i class="fas fa-comment-dots"></i>Short Self-Introduction</label>
                            <textarea name="introduction" maxlength="500" required><%= profile.getIntroduction() %></textarea>
                        </div>

                        <button type="submit" class="btn-submit"><i class="fas fa-save"></i> Save Changes</button>

                    </form>
                    <div style="text-align:center; margin-top:14px;">
                        <a href="ViewProfileServlet" style="color:#7bafd4; font-size:0.85rem; text-decoration:none; font-weight:500;">
                            <i class="fas fa-times"></i> Cancel and go back
                        </a>
                    </div>
                </div>

            </div>
        </div>
    </body>
</html>