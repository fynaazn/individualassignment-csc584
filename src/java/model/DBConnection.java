/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 *
 * @author fy
 */
public class DBConnection {

    private static final String DRIVER   = "org.apache.derby.jdbc.ClientDriver";
    private static final String URL      = "jdbc:derby://localhost:1527/StudentProfilesDB";
    private static final String USER     = "app";
    private static final String PASSWORD = "app";

    public static Connection getConnection() throws SQLException {
        try {
            Class.forName(DRIVER);
        } catch (ClassNotFoundException e) {
            throw new SQLException("Derby Client driver not found.", e);
        }
        return DriverManager.getConnection(URL, USER, PASSWORD);
    }
}