/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

/**
 *
 * @author jayomir
 */
public class hrUserInfo {
    
    public Connection setConnection() {

		
        final String dburl = "jdbc:mysql://192.168.128.170:3306/allianz_hrlayer";
        String dbname="allianz_hrlayer";
        final String user = "HRToQportal";
        final String password = "1234";
        Connection conn = null;        

        try{
            Class.forName("com.mysql.jdbc.Driver");
            conn=DriverManager.getConnection(dburl, user, password);            

        }catch(Exception e){
                e.printStackTrace();
        }
        return conn;
	
	}
    
    public String getEPFNo(String callingName,String surname) throws SQLException{
        String epf="unknown";
        Connection con=null;
        try{
                con = setConnection();
                Statement stmt = con.createStatement();
                String query = "select EPF from existing_emp_list where Calling_Name = '"+callingName+"' and Surname = '"+surname+"'";
                ResultSet rs = stmt.executeQuery(query);                 
                while(rs.next()){
                   epf = rs.getString("EPF");
                }
                
        }catch(Exception e){
            e.printStackTrace();
        }finally{
           con.close();
        }
        return epf;
    }
    
}
