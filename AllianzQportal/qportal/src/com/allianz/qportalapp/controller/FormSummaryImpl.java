package com.allianz.qportalapp.controller;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.allianz.qportalapp.model.FormSegment;

public class FormSummaryImpl {

	
	FormDBService dbservice=new FormDBService(); 
	Connection conn = null; 
	Statement stmt=null;
	
	// count public user finished 
	 public int getNoOfFinishedUsersByFormId(int formId){
		
		 int finished_public_users=0;
		 
		 try {				
				conn=dbservice.setConnection();
				stmt=conn.createStatement();					
				//String query="select count(distinct (user_name)) as count from public_user_answers where where form_id="+formId;
				String query = "select count(distinct (user_name)) as count from form_assignment_users where form_id = '"+formId+"' and form_status='1'";
				ResultSet rs=stmt.executeQuery(query);
				
				
				while(rs.next()){					
					finished_public_users = rs.getInt("count");									
				}
				
			} catch (SQLException e) {				
				e.printStackTrace();
				
			}finally{
				try {
					stmt.close();
					conn.close();
					
				} catch (SQLException e) {					
					e.printStackTrace();
				}
			}
		return finished_public_users;
			
		 
	 }
	 
	 // get noOfFinished users by formId and department	

	 public int getNoOfFinishedUsersByFormIdAndDepartment(int formId,String Department){
			
		 int finished_public_users=0;
		 
		 try {				
				conn=dbservice.setConnection();
				stmt=conn.createStatement();					
				
				String query = "select count(distinct (b.user_name)) as count from (select user_name from user where department = '"+Department+"') a, form_assignment_users b where a.user_name = b.user_name and form_id = '"+formId+"' and form_status='1'";
				ResultSet rs=stmt.executeQuery(query);				
				
				while(rs.next()){					
					finished_public_users = rs.getInt("count");									
				}
				
			} catch (SQLException e) {				
				e.printStackTrace();
				
			}finally{
				try {
					stmt.close();
					conn.close();
					
				} catch (SQLException e) {					
					e.printStackTrace();
				}
			}
		return finished_public_users;
			
		 
	 }
	 
	 //count public user partially finished (ongoing)
	 
	 public int getNoOfPartiallyFinishedUsersByFormId(int formId){
			
		 int partiallyFinished_users=0;
		 
		 try {				
				conn=dbservice.setConnection();
				stmt=conn.createStatement();					
				//String query="select count(distinct (user_name)) as count from public_user_answers where where form_id="+formId;
				String query = "select count(distinct (user_name)) as count from form_assignment_users where form_id = '"+formId+"' and update_status='1'";
				ResultSet rs=stmt.executeQuery(query);
				
				
				while(rs.next()){					
					partiallyFinished_users = rs.getInt("count");									
				}
				
			} catch (SQLException e) {				
				e.printStackTrace();
				
			}finally{
				try {
					stmt.close();
					conn.close();
					
				} catch (SQLException e) {					
					e.printStackTrace();
				}
			}
		return partiallyFinished_users;
			
		 
	 }
	 
	 //get no of partially finished users by form Id and department
	 
	 
	 public int getNoOfPartiallyFinishedUsersByFormIdAndDepartment(int formId, String department){
			
		 int partiallyFinished_users=0;
		 
		 try {				
				conn=dbservice.setConnection();
				stmt=conn.createStatement();					
				
				String query = "select count(distinct (b.user_name)) as count from (select user_name from user where department = '"+department+"') a, form_assignment_users b where a.user_name = b.user_name and form_id = '"+formId+"' and update_status='1'";
				ResultSet rs=stmt.executeQuery(query);
				
				
				while(rs.next()){					
					partiallyFinished_users = rs.getInt("count");									
				}
				
			} catch (SQLException e) {				
				e.printStackTrace();
				
			}finally{
				try {
					stmt.close();
					conn.close();
					
				} catch (SQLException e) {					
					e.printStackTrace();
				}
			}
		return partiallyFinished_users;
			
		 
	 }
	 
	//==============================================================
	 public int getNoOfPassUsersByForm(int formId){
			
		 int noOfUsers=0;
		 
		 try {				
				conn=dbservice.setConnection();
				stmt=conn.createStatement();					
				
				String query = "select count(id) as count from result_form where number_of_correctAnswers>=pass_mark and form_id='"+formId+"'";
				ResultSet rs=stmt.executeQuery(query);
				
				
				while(rs.next()){					
					noOfUsers = rs.getInt("count");									
				}
				
			} catch (SQLException e) {				
				e.printStackTrace();
				
			}finally{
				try {
					stmt.close();
					conn.close();
					
				} catch (SQLException e) {					
					e.printStackTrace();
				}
			}
		return noOfUsers;
			
		 
	 }
	 //====================================================================================
	 
	 public int getNoOfFaildUsersByForm(int formId){
			
		 int noOfUsers=0;
		 
		 try {				
				conn=dbservice.setConnection();
				stmt=conn.createStatement();					
				
				String query = "select count(id) as count from result_form where number_of_correctAnswers<pass_mark and form_id='"+formId+"'";
				ResultSet rs=stmt.executeQuery(query);
				
				
				while(rs.next()){					
					noOfUsers = rs.getInt("count");									
				}
				
			} catch (SQLException e) {				
				e.printStackTrace();
				
			}finally{
				try {
					stmt.close();
					conn.close();
					
				} catch (SQLException e) {					
					e.printStackTrace();
				}
			}
		return noOfUsers;
			
		 
	 }
	 
	 //====================================================================================
	 
}
