/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
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
public class ProfileServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        // 1. Read form data
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

        // save to the database
        String sql = "INSERT INTO Profile (studentID, name, programme, email, hobbies, introduction) "
                   + "VALUES (?, ?, ?, ?, ?, ?)";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, profile.getStudentID());
            ps.setString(2, profile.getName());
            ps.setString(3, profile.getProgramme());
            ps.setString(4, profile.getEmail());
            ps.setString(5, profile.getHobbies());
            ps.setString(6, profile.getIntroduction());

            ps.executeUpdate();

        } catch (SQLException e) {
            request.setAttribute("errorMessage", "Failed to save profile: " + e.getMessage());
            request.getRequestDispatcher("error.jsp").forward(request, response);
            return;
        }

        // forward to profile.jsp to display the saved profile
        request.setAttribute("profile", profile);
        request.getRequestDispatcher("profile.jsp").forward(request, response);
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Handles creation of a new student profile";
    }// </editor-fold>

}