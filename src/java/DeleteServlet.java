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

import model.DBConnection;

/**
 *
 * @author fy
 */
public class DeleteServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String studentID = request.getParameter("studentID");
        String sql = "DELETE FROM Profile WHERE studentID = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, studentID);
            ps.executeUpdate();

        } catch (SQLException e) {
            request.setAttribute("errorMessage", "Failed to delete profile: " + e.getMessage());
            request.getRequestDispatcher("error.jsp").forward(request, response);
            return;
        }

        response.sendRedirect("ViewProfileServlet");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Deletes a student profile from the database";
    }
}