/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.ProfileBean;
import model.DBConnection;

/**
 *
 * @author fy
 */
public class EditServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        String studentID = request.getParameter("studentID");
        String sql = "SELECT * FROM Profile WHERE studentID = ?";

        ProfileBean profile = null;

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, studentID);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    profile = new ProfileBean();
                    profile.setStudentID(rs.getString("studentID"));
                    profile.setName(rs.getString("name"));
                    profile.setProgramme(rs.getString("programme"));
                    profile.setEmail(rs.getString("email"));
                    profile.setHobbies(rs.getString("hobbies"));
                    profile.setIntroduction(rs.getString("introduction"));
                }
            }

        } catch (SQLException e) {
            request.setAttribute("errorMessage", "Failed to load profile: " + e.getMessage());
            request.getRequestDispatcher("error.jsp").forward(request, response);
            return;
        }

        if (profile == null) {
            request.setAttribute("errorMessage", "No profile found for Student ID: " + studentID);
            request.getRequestDispatcher("error.jsp").forward(request, response);
            return;
        }

        request.setAttribute("profile", profile);
        request.getRequestDispatcher("editProfile.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        String studentID    = request.getParameter("studentID");
        String name          = request.getParameter("name");
        String programme     = request.getParameter("programme");
        String email          = request.getParameter("email");
        String introduction = request.getParameter("introduction");
        String[] hobbiesArr  = request.getParameterValues("hobbies");

        String hobbies = (hobbiesArr != null) ? String.join(", ", hobbiesArr) : "";

        ProfileBean profile = new ProfileBean();
        profile.setStudentID(studentID);
        profile.setName(name);
        profile.setProgramme(programme);
        profile.setEmail(email);
        profile.setHobbies(hobbies);
        profile.setIntroduction(introduction);

        String sql = "UPDATE Profile SET name = ?, programme = ?, email = ?, hobbies = ?, introduction = ? "
                   + "WHERE studentID = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, profile.getName());
            ps.setString(2, profile.getProgramme());
            ps.setString(3, profile.getEmail());
            ps.setString(4, profile.getHobbies());
            ps.setString(5, profile.getIntroduction());
            ps.setString(6, profile.getStudentID());

            ps.executeUpdate();

        } catch (SQLException e) {
            request.setAttribute("errorMessage", "Failed to update profile: " + e.getMessage());
            request.getRequestDispatcher("error.jsp").forward(request, response);
            return;
        }

        request.setAttribute("profile", profile);
        request.setAttribute("mode", "update");
        request.getRequestDispatcher("profile.jsp").forward(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Loads a profile for editing and saves changes back to the database";
    }
}