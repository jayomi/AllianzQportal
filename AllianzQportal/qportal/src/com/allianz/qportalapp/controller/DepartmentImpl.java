package com.allianz.qportalapp.controller;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.allianz.qportalapp.model.Department;

public class DepartmentImpl {

	FormDBService dbservice=new FormDBService(); 
	Connection conn = null; 
	
	public void addDepartment(String departmentName, String description){
		
		try {	
		 	
			conn=dbservice.setConnection();	
			
			String selectQuery = "select id from department where department_name='"+departmentName+"'";
			Statement selectStmt=conn.createStatement();
			ResultSet rs = selectStmt.executeQuery(selectQuery);
			int index = 0;
			while(rs.next()){
				index = rs.getInt("id");
			}
			if(index == 0){
				//insert
				String query="INSERT INTO department(department_name,description) VALUES ('"+departmentName+"','"+description+"')";			
				
				Statement stmt=conn.createStatement();
				stmt.executeUpdate(query);	
			}
			else if(index !=0){
				//update
				String updateQuery = "update department set department_name='"+departmentName+"',description='"+description+"' where id='"+index+"'";
				Statement updateStmt=conn.createStatement();
				updateStmt.executeUpdate(updateQuery);
			}
			
			}catch (SQLException e) {				
				e.printStackTrace();
			}finally{
				try {
					conn.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
		
	}
	
//get all departments
 public List<Department> getAllDepartments(){
		 
		 List<Department> departmentList = new ArrayList<Department>();
			try {	
			 	
				conn=dbservice.setConnection();	
				
				String selectQuery = "select * from department";
				Statement selectStmt=conn.createStatement();
				ResultSet rs = selectStmt.executeQuery(selectQuery);
				
				while(rs.next()){
					
					int id = rs.getInt("id");
					String departmentName = rs.getString("department_name");
					String deascription = rs.getString("description");
					
					Department department = new Department(id,departmentName,deascription);
					departmentList.add(department);
				}
				
				}catch (SQLException e) {				
					e.printStackTrace();
				}finally{
					try {
						conn.close();
					} catch (SQLException e) {
						e.printStackTrace();
					}
				}
			return departmentList;
			
	 }
 
 //get Department by table row index
 
 public Department getDepartmentByIndex(int index){
	 
	 int id = 0;String departmentName=null;String deascription=null;
	 Department department =new Department(id,departmentName,deascription);
	 
		try {	
		 	
			conn=dbservice.setConnection();	
			
			String selectQuery = "select * from department where id='"+index+"'";
			Statement selectStmt=conn.createStatement();
			ResultSet rs = selectStmt.executeQuery(selectQuery);
			
			while(rs.next()){
				
				id = rs.getInt("id");
				departmentName = rs.getString("department_name");
				deascription = rs.getString("description");
				
				department = new Department(id,departmentName,deascription);
				
			}
			
			}catch (SQLException e) {				
				e.printStackTrace();
			}finally{
				try {
					conn.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
		return department;
		
 }

 //update department by table row index
 
 public void updateDepartmentByIndex(int index,String department,String description){
	 
	 try {	
		 	
			conn=dbservice.setConnection();	
			//update
				String updateQuery = "update department set department_name='"+department+"' , description='"+description+"' where id='"+index+"'";
				Statement updateStmt=conn.createStatement();
				updateStmt.executeUpdate(updateQuery);
			
			
			}catch (SQLException e) {				
				e.printStackTrace();
			}finally{
				try {
					conn.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
 }
 
 //delete department
public void deleteDepartmentByIndex(int index){
	 
	try {		
 		conn=dbservice.setConnection();		
 		
 		
 		String query1="DELETE from department where id='"+index+"'";
 		Statement stmt1=conn.createStatement();
 		stmt1.executeUpdate(query1);
			
			
			}catch (SQLException e) {				
				e.printStackTrace();
			}finally{
				try {
					conn.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
 }
 
}
