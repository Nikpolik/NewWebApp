package gr.athtech;

import java.sql.*;
import java.util.Random;
import java.io.*;

public class ShapeStatistics {

  private static Connection getConnection() throws  Exception {
			// obtain a connection to the DB, use DB driver, URL, credentials
      String pass = System.getenv("MYSQL_PASSWORD");
			String connURL = "jdbc:mysql://172.17.0.1:3306/PAGE_VISITS";
			Class.forName("com.mysql.jdbc.Driver").newInstance();
			Connection conn = DriverManager.getConnection(connURL, "root", pass);
      return conn;
  }

  public static void resetPageVisits() throws Exception {
    Connection conn = getConnection();
    Statement stmt = conn.createStatement();
    stmt.executeUpdate("TRUNCATE PAGE_VISITS");
    stmt.close();
  }

  public static void addPageVisit(String shape) throws Exception {
      Connection conn = getConnection(); 
			Statement stmt = conn.createStatement();
      stmt.executeUpdate("INSERT INTO PAGE_VISITS (SHAPE, TS) VALUES ('" + shape + "', NOW())");
      stmt.close();
  } 

  public static String getTotalVisits() throws Exception {
    String output = "";
    Connection conn = getConnection();
    Statement stmt1 = conn.createStatement();
    // calculate number of visits per shape
    ResultSet rs1 = stmt1
        .executeQuery("SELECT SHAPE, COUNT(*) NUM FROM PAGE_VISITS GROUP BY SHAPE ORDER BY SHAPE ASC");
    
    Statement stmt2 = conn.createStatement();
    // calculate visit timestamps per shape
    ResultSet rs2 = stmt2.executeQuery("SELECT SHAPE, TS FROM PAGE_VISITS ORDER BY SHAPE ASC, TS ASC");
    
    // for each shape print its name and number of visits, followed by the list of visit timestamps
    while (rs1.next()) {
      int num = rs1.getInt("NUM");
      output += rs1.getString("SHAPE") + ": " + num + " visit(s)." + "<br/>";
      for (int idx = 0; idx < num; idx++) {
        rs2.next();
        output += "        " + rs2.getTimestamp("TS") + "<br/>";
      }
    }
    stmt1.close();
    rs1.close();
    stmt2.close();
    rs2.close();
    conn.close();
    return output;
  }
}