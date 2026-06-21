/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
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
public class ViewProfileServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        String searchType  = request.getParameter("searchType");
        String searchValue = request.getParameter("searchValue");
        boolean isSearch    = (searchValue != null && !searchValue.trim().isEmpty());

        List<ProfileBean> profileList = new ArrayList<>();

        String sql;
        if (isSearch && "studentID".equals(searchType)) {
            sql = "SELECT * FROM Profile WHERE studentID = ?";
        } else if (isSearch && "name".equals(searchType)) {
            sql = "SELECT * FROM Profile WHERE UPPER(name) LIKE ?";
        } else {
            sql = "SELECT * FROM Profile ORDER BY name";
        }

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            if (isSearch && "studentID".equals(searchType)) {
                ps.setString(1, searchValue.trim());
            } else if (isSearch && "name".equals(searchType)) {
                ps.setString(1, "%" + searchValue.trim().toUpperCase() + "%");
            }

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    ProfileBean profile = new ProfileBean();
                    profile.setStudentID(rs.getString("studentID"));
                    profile.setName(rs.getString("name"));
                    profile.setProgramme(rs.getString("programme"));
                    profile.setEmail(rs.getString("email"));
                    profile.setHobbies(rs.getString("hobbies"));
                    profile.setIntroduction(rs.getString("introduction"));
                    profileList.add(profile);
                }
            }

        } catch (SQLException e) {
            request.setAttribute("errorMessage", "Failed to load profiles: " + e.getMessage());
            request.getRequestDispatcher("error.jsp").forward(request, response);
            return;
        }

        request.setAttribute("profileList", profileList);
        request.setAttribute("searchType", searchType);
        request.setAttribute("searchValue", searchValue);
        request.getRequestDispatcher("viewProfile.jsp").forward(request, response);
    }

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
        return "Retrieves and displays all (or searched) student profiles";
    }
}