package xyz.hitpy.seproject.mysqlcon;

import java.sql.*;

public class SqlCon {
    Connection con =null;
    Statement stat=null;
    ResultSet rs=null;
    
    public SqlCon()
    {
        try
        {
            Class.forName("com.mysql.jdbc.Driver");
            con=DriverManager.getConnection("jdbc:mysql://localhost:3306/sedb?useUnicode=true&characterEncoding=UTF-8","root","password");
            stat=con.createStatement();
            
        }
        
        catch(Exception e)
        {
            System.out.println("error in method 'SqlCon' of class 'SqlCon'");
            con=null;
        }
    
    }
    
    public ResultSet executeQuery(String sql)
    {
        try
        {
            rs=stat.executeQuery(sql);
        }
        
        catch(Exception e)
        {
            System.out.println("error in method 'executeQuery' of class 'SqlCon'");
            rs=null;
        }
        return rs;
    }
    
    public void executeUpdate(String del)
    {
        try {
            stat.executeUpdate(del);
        } catch (SQLException e) {
            System.out.println("error in method 'executeUpdate' of class 'SqlCon'");
            e.printStackTrace();
        }
    }
}
