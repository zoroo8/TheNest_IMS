package com.ims.config;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DbConfig {
    private static final String URL = "jdbc:mysql://localhost:3306/thenest";
    private static final String USER = "root";
    private static final String PASSWORD = "";

    /**
	 *Establish a connection to the database 
	 * @return --Connection object for the database
	 * @throws SQLException		--if the database access error occurs
	 * @throws ClassNotFoundException  -- if the JDBC driver class is not found
	 */
    public static Connection getDBConnection() {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            return DriverManager.getConnection(URL, USER, PASSWORD);
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            return null; 
        }
    }

}
