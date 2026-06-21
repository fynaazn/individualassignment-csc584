<%@page import="model.ProfileBean"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    List<ProfileBean> profileList = (List<ProfileBean>) request.getAttribute("profileList");
    String searchType  = (String) request.getAttribute("searchType");
    String searchValue = (String) request.getAttribute("searchValue");
    if (searchValue == null) {
        searchValue = "";
    }
%>

<!DOCTYPE html>
<html>
    <head>
        <title>Student Profile</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">

        <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
        <style>
            * { box-sizing: border-box; margin: 0; padding: 0; font-family: 'Poppins', sans-serif; }
            body { background: linear-gradient(135deg, #a8c8f0 0%, #7bafd4 100%); min-height: 100vh; padding: 40px 15px; }
            .wrapper { max-width: 1000px; margin: 0 auto; }
            .card { background: white; border-radius: 20px; box-shadow: 0 20px 60px rgba(91,155,213,0.3); overflow: hidden; }
            .card-header { background: linear-gradient(135deg, #a8c8f0 0%, #7bafd4 100%); padding: 30px; text-align: center; }
            .card-header h1 { color: white; font-weight: 700; font-size: 1.8rem; }
            .card-header p { color: rgba(255,255,255,0.9); margin-top: 6px; font-size: 0.95rem; }
            .card-body { padding: 30px 35px; }

            /* --- Add Profile toggle --- */
            .btn-toggle-add {
                display: flex; align-items: center; justify-content: center; gap: 8px;
                width: 100%; background: linear-gradient(135deg, #a8c8f0, #7bafd4); border: none;
                border-radius: 12px; color: white; font-weight: 600; font-size: 0.95rem;
                font-family: 'Poppins', sans-serif; padding: 13px; cursor: pointer;
                transition: opacity 0.3s;
            }
            .btn-toggle-add:hover { opacity: 0.9; }
            .btn-toggle-add i.fa-chevron-down, .btn-toggle-add i.fa-chevron-up { margin-left: 4px; }

            .add-form-panel {
                border: 2px dashed #d0e8f7; border-radius: 14px; padding: 25px 28px;
                margin-top: 16px; background: #f8fbfe;
            }

            .form-group { margin-bottom: 18px; }
            .form-group label { display: block; font-weight: 600; color: #3a5a7a; font-size: 0.9rem; margin-bottom: 6px; }
            .form-group label i { color: #7bafd4; margin-right: 6px; }
            .form-group input[type="text"], .form-group input[type="email"],
            .form-group select, .form-group textarea {
                width: 100%; border: 2px solid #d0e8f7; border-radius: 10px; padding: 10px 15px;
                font-size: 0.95rem; font-family: 'Poppins', sans-serif; color: #333;
                background: #fff; transition: border-color 0.3s, box-shadow 0.3s;
            }
            .form-group input:focus, .form-group select:focus, .form-group textarea:focus {
                border-color: #7bafd4; box-shadow: 0 0 0 3px rgba(123, 175, 212, 0.2); outline: none;
            }
            .form-group textarea { resize: vertical; min-height: 90px; }

            .hobby-grid { display: grid; grid-template-columns: repeat(auto-fill, minmax(150px, 1fr)); gap: 10px; margin-top: 5px; }
            .hobby-item { display: flex; align-items: center; background: #fff; border: 2px solid #d0e8f7;
                border-radius: 10px; padding: 8px 12px; cursor: pointer; transition: all 0.2s; }
            .hobby-item:hover { border-color: #7bafd4; background: #daeef9; }
            .hobby-item input[type="checkbox"] { accent-color: #7bafd4; width: 16px; height: 16px; margin-right: 8px; cursor: pointer; flex-shrink: 0; }
            .hobby-item label { cursor: pointer; font-size: 0.86rem; color: #3a5a7a; margin: 0; }
            .hobby-item label i { margin-right: 5px; color: #7bafd4; font-size: 0.82rem; }

            .btn-submit {
                background: linear-gradient(135deg, #a8c8f0 0%, #7bafd4 100%); border: none; border-radius: 12px;
                color: white; font-weight: 600; font-size: 1rem; font-family: 'Poppins', sans-serif;
                padding: 12px 40px; width: 100%; cursor: pointer; transition: opacity 0.3s, transform 0.2s; margin-top: 6px;
            }
            .btn-submit:hover { opacity: 0.88; transform: translateY(-2px); }
            .btn-submit i { margin-right: 8px; }

            .section-divider { border: none; border-top: 2px dashed #d0e8f7; margin: 26px 0; }

            /* --- Search & table --- */
            .search-bar { display: flex; flex-wrap: wrap; gap: 10px; margin-bottom: 25px; align-items: center; }
            .search-bar select, .search-bar input[type="text"] {
                border: 2px solid #d0e8f7; border-radius: 10px; padding: 9px 14px;
                font-size: 0.9rem; font-family: 'Poppins', sans-serif; background: #f5faff; color: #333;
            }
            .search-bar input[type="text"] { flex: 1; min-width: 180px; }
            .search-bar select:focus, .search-bar input:focus {
                border-color: #7bafd4; outline: none; box-shadow: 0 0 0 3px rgba(123,175,212,0.2); background: #fff;
            }
            .btn-search {
                background: linear-gradient(135deg, #a8c8f0, #7bafd4); border: none; border-radius: 10px;
                color: white; font-weight: 600; padding: 9px 22px; cursor: pointer; font-family: 'Poppins', sans-serif;
            }
            .btn-search:hover { opacity: 0.88; }
            .link-reset { color: #7bafd4; font-size: 0.85rem; text-decoration: none; font-weight: 500; }
            .link-reset:hover { text-decoration: underline; }

            table { width: 100%; border-collapse: collapse; }
            thead th {
                text-align: left; font-size: 0.78rem; text-transform: uppercase; letter-spacing: 0.5px;
                color: #7bafd4; padding: 10px 14px; border-bottom: 2px solid #d0e8f7;
            }
            tbody td { padding: 14px; border-bottom: 1px solid #eef5fb; font-size: 0.9rem; color: #333; vertical-align: top; }
            tbody tr:hover { background: #f5faff; }
            .hobby-chip {
                display: inline-block; background: #f0f7fd; color: #3a5a7a; border-radius: 12px;
                padding: 2px 10px; font-size: 0.78rem; margin: 2px 2px 0 0;
            }
            .actions {
                display: flex;
                align-items: center;
                gap: 8px;
                white-space: nowrap;
            }
            .actions a {
                display: inline-flex; align-items: center; justify-content: center; width: 32px; height: 32px;
                border-radius: 8px; text-decoration: none; font-size: 0.85rem; flex-shrink: 0;
            }
            .btn-edit { background: #e3f0fb; color: #3a7bbf; }
            .btn-edit:hover { background: #3a7bbf; color: white; }
            .btn-delete { background: #fdecea; color: #d9534f; }
            .btn-delete:hover { background: #d9534f; color: white; }

            .empty-state { text-align: center; padding: 40px 10px; color: #999; }
            .empty-state i { font-size: 2.5rem; color: #cfe4f5; margin-bottom: 12px; display: block; }

            @media (max-width: 700px) {
                table, thead, tbody, th, td, tr { display: block; }
                thead { display: none; }
                tbody tr { margin-bottom: 16px; border: 1px solid #eef5fb; border-radius: 12px; padding: 12px; }
                tbody td { border: none; padding: 6px 4px; }
                tbody td::before {
                    content: attr(data-label); display: block; font-size: 0.72rem; color: #999;
                    text-transform: uppercase; font-weight: 600; margin-bottom: 2px;
                }
                .hobby-grid { grid-template-columns: repeat(2, 1fr); }
            }
        </style>
    </head>
    <body>
        <div class="wrapper">
            <div class="card">
                <div class="card-header">
                    <h1><i class="fas fa-id-badge"></i> Student Profiles</h1>
                    <p>Add, search, edit and manage student profile records</p>
                </div>
                <div class="card-body">

                    <button type="button" class="btn-toggle-add" id="toggleBtn" onclick="toggleAddForm()">
                        <i class="fas fa-user-plus"></i> <span id="toggleLabel">Add New Profile</span>
                        <i class="fas fa-chevron-down" id="toggleIcon"></i>
                    </button>

                    <div class="add-form-panel" id="addFormPanel" style="display:none;">
                        <form action="ProfileServlet" method="post">

                            <!-- name -->
                            <div class="form-group">
                                <label><i class="fas fa-user"></i>Full Name</label>
                                <input type="text" name="name" placeholder="e.g. Nur Afrina binti Che Zaini" required>
                            </div>

                            <!-- student ID -->
                            <div class="form-group">
                                <label><i class="fas fa-id-card"></i>Student ID</label>
                                <input type="text" name="studentID" placeholder="e.g. 2024276904" required>
                            </div>

                            <!-- programme -->
                            <div class="form-group">
                                <label><i class="fas fa-graduation-cap"></i>Programme</label>
                                <select name="programme" required>
                                    <option value="" disabled selected>-- Select your programme --</option>
                                    <option value="Bachelor of Computer Science">Bachelor of Computer Science</option>
                                    <option value="Bachelor of Information Technology">Bachelor of Information Technology</option>
                                    <option value="Bachelor of Information Systems">Bachelor of Information Systems</option>
                                </select>
                            </div>

                            <!-- email -->
                            <div class="form-group">
                                <label><i class="fas fa-envelope"></i>Email Address</label>
                                <input type="email" name="email" placeholder="e.g. afrina@student.edu.my" required>
                            </div>

                            <!-- hobbies -->
                            <div class="form-group">
                                <label>
                                    <i class="fas fa-heart"></i>Hobbies
                                    <span style="font-weight:400; color:#999;">(select all that apply)</span>
                                </label>
                                <div class="hobby-grid">
                                    <div class="hobby-item">
                                        <input type="checkbox" name="hobbies" value="Reading" id="h1">
                                        <label for="h1"><i class="fas fa-book"></i>Reading</label>
                                    </div>
                                    <div class="hobby-item">
                                        <input type="checkbox" name="hobbies" value="Gaming" id="h2">
                                        <label for="h2"><i class="fas fa-gamepad"></i>Gaming</label>
                                    </div>
                                    <div class="hobby-item">
                                        <input type="checkbox" name="hobbies" value="Travelling" id="h3">
                                        <label for="h3"><i class="fas fa-plane"></i>Travelling</label>
                                    </div>
                                    <div class="hobby-item">
                                        <input type="checkbox" name="hobbies" value="Cooking" id="h4">
                                        <label for="h4"><i class="fas fa-utensils"></i>Cooking</label>
                                    </div>
                                    <div class="hobby-item">
                                        <input type="checkbox" name="hobbies" value="Photography" id="h5">
                                        <label for="h5"><i class="fas fa-camera"></i>Photography</label>
                                    </div>
                                    <div class="hobby-item">
                                        <input type="checkbox" name="hobbies" value="Music" id="h6">
                                        <label for="h6"><i class="fas fa-music"></i>Music</label>
                                    </div>
                                    <div class="hobby-item">
                                        <input type="checkbox" name="hobbies" value="Sports" id="h7">
                                        <label for="h7"><i class="fas fa-futbol"></i>Sports</label>
                                    </div>
                                    <div class="hobby-item">
                                        <input type="checkbox" name="hobbies" value="Drawing" id="h8">
                                        <label for="h8"><i class="fas fa-paint-brush"></i>Drawing</label>
                                    </div>
                                </div>
                            </div>

                            <!-- self introduction -->
                            <div class="form-group">
                                <label><i class="fas fa-comment-dots"></i>Short Self-Introduction</label>
                                <textarea name="introduction" maxlength="500" placeholder="Tell a little about yourself..." required></textarea>
                            </div>

                            <button type="submit" class="btn-submit"><i class="fas fa-save"></i> Save Profile</button>

                        </form>
                    </div>

                    <hr class="section-divider">

                    <!-- ===== Search ===== -->
                    <form class="search-bar" action="ViewProfileServlet" method="get">
                        <select name="searchType">
                            <option value="studentID" <%= "studentID".equals(searchType) ? "selected" : "" %>>Student ID</option>
                            <option value="name" <%= "name".equals(searchType) ? "selected" : "" %>>Name</option>
                        </select>
                        <input type="text" name="searchValue" value="<%= searchValue %>" placeholder="Enter Student ID or Name...">
                        <button type="submit" class="btn-search"><i class="fas fa-search"></i> Search</button>
                        <a href="ViewProfileServlet" class="link-reset">Reset</a>
                    </form>

                    <!-- ===== Profile list ===== -->
                    <% if (profileList == null || profileList.isEmpty()) { %>
                        <div class="empty-state">
                            <i class="fas fa-folder-open"></i>
                            No profiles found.
                        </div>
                    <% } else { %>
                        <table>
                            <thead>
                                <tr>
                                    <th>Student ID</th>
                                    <th>Name</th>
                                    <th>Programme</th>
                                    <th>Email</th>
                                    <th>Hobbies</th>
                                    <th>Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <% for (ProfileBean profile : profileList) { %>
                                <tr>
                                    <td data-label="Student ID"><%= profile.getStudentID() %></td>
                                    <td data-label="Name"><%= profile.getName() %></td>
                                    <td data-label="Programme"><%= profile.getProgramme() %></td>
                                    <td data-label="Email"><%= profile.getEmail() %></td>
                                    <td data-label="Hobbies">
                                        <%
                                            String hb = profile.getHobbies();
                                            if (hb != null && !hb.trim().isEmpty()) {
                                                for (String h : hb.split(",")) {
                                        %>
                                                    <span class="hobby-chip"><%= h.trim() %></span>
                                        <%
                                                }
                                            } else {
                                        %>
                                                <span style="color:#bbb;font-style:italic;">None</span>
                                        <%
                                            }
                                        %>
                                    </td>
                                    <td data-label="Actions">
                                        <div class="actions">
                                            <a href="EditServlet?studentID=<%= profile.getStudentID() %>" class="btn-edit" title="Edit">
                                                <i class="fas fa-pen"></i>
                                            </a>
                                            <a href="DeleteServlet?studentID=<%= profile.getStudentID() %>" class="btn-delete"
                                               title="Delete" onclick="return confirm('Delete profile for <%= profile.getName() %>?');">
                                                <i class="fas fa-trash"></i>
                                            </a>
                                        </div>
                                    </td>
                                </tr>
                                <% } %>
                            </tbody>
                        </table>
                    <% } %>

                </div>
            </div>
        </div>

        <script>
            function toggleAddForm() {
                var panel = document.getElementById('addFormPanel');
                var icon = document.getElementById('toggleIcon');
                var label = document.getElementById('toggleLabel');
                if (panel.style.display === 'none') {
                    panel.style.display = 'block';
                    icon.classList.remove('fa-chevron-down');
                    icon.classList.add('fa-chevron-up');
                    label.textContent = 'Hide Add Profile Form';
                } else {
                    panel.style.display = 'none';
                    icon.classList.remove('fa-chevron-up');
                    icon.classList.add('fa-chevron-down');
                    label.textContent = 'Add New Profile';
                }
            }
        </script>
    </body>
</html>