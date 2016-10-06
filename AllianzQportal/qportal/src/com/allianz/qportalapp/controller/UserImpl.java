package com.allianz.qportalapp.controller;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.allianz.qportalapp.model.Department;
import com.allianz.qportalapp.model.FormType;
import com.allianz.qportalapp.model.User;

public class UserImpl {
	
	FormDBService dbservice=new FormDBService(); 
	Connection conn = null;
	
	 public List<User> getUserList(){		
			
		 	
			List<User> userList=new ArrayList<User>();
			try {
				
				conn=dbservice.setConnection();
				Statement stmt=conn.createStatement();
				//String query="select form_id,form_name,form_description,department from main_form";
				String query="SELECT * FROM user";
				ResultSet rs=stmt.executeQuery(query);
				
				
				while(rs.next()){
					
					int id=rs.getInt("id");
					String userName=rs.getString("user_name");
					String password=rs.getString("password");
					String role = rs.getString("role");
					String firstName = rs.getString("first_name");
					String lastName = rs.getString("last_name");
					String email =rs.getString("email");
					String department = rs.getString("department");
					
					User user=new User(id,userName, password,firstName,lastName,email,role,department);
					
					//FormType formType=new FormType(id, name, description,department);
					userList.add(user);					
					
				}
				
			} catch (SQLException e) {
				
				e.printStackTrace(); 
			     
			}			
			return userList;				
		
	}
	 
	 public User getUserId(String userName,String password){
		 
		 int id=0;
		
		 User user=new User(id, userName, password);
		 
		 try {
				
				conn=dbservice.setConnection();
				Statement stmt=conn.createStatement();
				
				String query="SELECT * FROM user where user_name='"+userName+"' and password='"+password+"'";
				ResultSet rs=stmt.executeQuery(query);
				
				while(rs.next()){
					id=rs.getInt("id");
					//fieldType=rs.getString("user_name");
					//question.rs.getString(password);
					//question.setQuestionType(fieldType);
					
				}
				
				user=new User(id, userName, password);
				
				
		 } catch (SQLException e) {
				
				e.printStackTrace(); 
			     
			}
		return user;	
	 }
	 
	//add user
	 public void addUser(String userName,String password,String firstName,String lastName,String email, String department,String role,String securityQuestin,String answer) throws SQLException{
		 int id=0;
			try {	
			 	
				conn=dbservice.setConnection();	
				String query="select count(id) as id from user where user_name='"+userName+"'";
				
				Statement stmt=conn.createStatement();				
				ResultSet rs=stmt.executeQuery(query);
				
				while(rs.next()){
					id=rs.getInt("id");
					
				}
				
				if(id==0){
					String insertUserQuery="";
					if(role==null){
						
						insertUserQuery="insert into user(user_name, password,role,first_name,last_name,email,department,security_question,security_question_answer) values ('"+email+"','"+password+"', 'user' , '"+firstName+"','"+lastName+"','"+email+"','"+department+"','"+securityQuestin+"','"+answer+"')";
					}else if(role!=null){
						insertUserQuery="insert into user(user_name, password,role,first_name,last_name,email,department,security_question,security_question_answer) values ('"+email+"','"+password+"', '"+role+"' , '"+firstName+"','"+lastName+"','"+email+"','"+department+"','"+securityQuestin+"','"+answer+"')";
					}
					
					Statement stmt2=conn.createStatement();	
					stmt2.executeUpdate(insertUserQuery);
					
				}
				
				stmt.close();
				
				
				}catch (SQLException e) {				
					e.printStackTrace();
					
				}finally{
					if(conn!=null){
						conn.close();
					}
				}
		}
	 
	 public int checkUser(String userName){
		 int id=0;
		
		 try {
				
				conn=dbservice.setConnection();
				Statement stmt=conn.createStatement();
				
				String query="SELECT id FROM user where user_name='"+userName+"'";
				ResultSet rs=stmt.executeQuery(query);
				
				while(rs.next()){
					id=rs.getInt("id");					
				}
				
		 } catch (SQLException e) {
				
				e.printStackTrace(); 
			     
			}
		return id;	
	 }
	 
	 // get all user according to user role
	 public List<User> getUserListByRole(String userRole){		
			
		 	
			List<User> userList=new ArrayList<User>();
			try {
				
				conn=dbservice.setConnection();
				Statement stmt=conn.createStatement();
				//String query="select form_id,form_name,form_description,department from main_form";
				String query="SELECT * FROM user where role='"+userRole+"'";
				ResultSet rs=stmt.executeQuery(query);
				
				
				while(rs.next()){
					
				 	int id=rs.getInt("id");
					String name=rs.getString("user_name");
					String password=rs.getString("password");
					
					User user=new User(name,password);
					
					//FormType formType=new FormType(id, name, description,department);
					userList.add(user);					
					
				}
				
			} catch (SQLException e) {
				
				e.printStackTrace(); 
			     
			}			
			return userList;				
		
	}
	 
	//--------------------------------------------------------------------------------
	 public String getUserDepartmentByUserName(String userName){
		 
		 String departmentName=null;
		 
		 try {
				
				conn=dbservice.setConnection();
				Statement stmt=conn.createStatement();
				
				String querySelect="SELECT department FROM user where user_name ='"+userName+"'";
				ResultSet rs=stmt.executeQuery(querySelect);			
				while(rs.next()){
					
					departmentName = rs.getString("department");					
				}
				
			} catch (SQLException e) {
				
				e.printStackTrace(); 
			     
			}
		return departmentName;			
	 }
	 //-------------------------------------------------------------------------------
	 
 public String getUserRoleByUserName(String userName){
		 
		 String userRole=null;
		 
		 try {
				
				conn=dbservice.setConnection();
				Statement stmt=conn.createStatement();
				
				String querySelect="SELECT role FROM user where user_name ='"+userName+"'";
				ResultSet rs=stmt.executeQuery(querySelect);			
				while(rs.next()){
					
					userRole = rs.getString("role");					
				}
				
			} catch (SQLException e) {
				
				e.printStackTrace(); 
			     
			}
		return userRole;			
	 }
 //-----------------------------------------------------------------------------------------
 //get user by row index
 
 public User getUserByIndex(int index){
	 
	 int id = 0;String firstName=null;String lastName=null;String userName=null;String password=null;
	 String role=null;String department=null;String email=null;
	 
	User user =new User(id, userName, password, firstName, lastName, email, role, department);
	 
		try {	
		 	
			conn=dbservice.setConnection();	
			
			String selectQuery = "select * from user where id='"+index+"'";
			Statement selectStmt=conn.createStatement();
			ResultSet rs = selectStmt.executeQuery(selectQuery);
			
			while(rs.next()){
				
				id = rs.getInt("id");
				userName = rs.getString("user_name");
				password = rs.getString("password");
				firstName = rs.getString("first_name");
				lastName = rs.getString("last_name");
				email = rs.getString("email");
				role = rs.getString("role");
				department = rs.getString("department");
				
				user = new User(id, userName, password, firstName, lastName, email, role, department);
				
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
		return user;
		
 }
 //---------------------------------------------------------------------------------------
 //update user
public void updateUserByIndex(int index,String userName,String password,String firstName,String lastName,String email,String role,String department){
	 
	 try {	
		 	
			conn=dbservice.setConnection();	
			//update
				String updateQuery = "update user set user_name='"+email+"' , password='"+password+"',role='"+role+"',first_name='"+firstName+"', last_name='"+lastName+"',email='"+email+"',department='"+department+"' where id='"+index+"'";
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

//get all users of department
public List<User> getUserListByDepartment(String departmet){		
	
 	
	List<User> userList=new ArrayList<User>();
	try {
		
		conn=dbservice.setConnection();
		Statement stmt=conn.createStatement();
		
		String query="SELECT * FROM user where department='"+departmet+"'";
		ResultSet rs=stmt.executeQuery(query);
		
		
		while(rs.next()){
			
			int id=rs.getInt("id");
			String userName=rs.getString("user_name");
			String password=rs.getString("password");
			String role = rs.getString("role");
			String firstName = rs.getString("first_name");
			String lastName = rs.getString("last_name");
			String email =rs.getString("email");
			String department = rs.getString("department");
			
			User user=new User(id,userName, password,firstName,lastName,email,role,department);
			
			//FormType formType=new FormType(id, name, description,department);
			userList.add(user);					
			
		}
		
	} catch (SQLException e) {
		
		e.printStackTrace(); 
	     
	}			
	return userList;				

}
//delete user by index

public void deleteUser(int index){
	
	try {	
	 	
		conn=dbservice.setConnection();	
		//delete
			String deleteQuery = "delete from user where id='"+index+"'";			
			
			Statement deleteStmt=conn.createStatement();
			deleteStmt.executeUpdate(deleteQuery);
		
		
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
 
 //reset password

public void updateUserByIndex(int index,String userName,String password){
	 
	 try {	
		 	
			conn=dbservice.setConnection();	
			//update
				String updateQuery = "update user set password='"+password+"' where id='"+index+"'";
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

//---------------------------------------------------------------------------------------
// get sequery question by user name
public String getSecurityQuestionByUserName(String userName){
	 
	 String question=null;
	 
	 try {
			
			conn=dbservice.setConnection();
			Statement stmt=conn.createStatement();
			
			String querySelect="SELECT security_question FROM user where user_name ='"+userName+"'";
			ResultSet rs=stmt.executeQuery(querySelect);			
			while(rs.next()){
				
				question = rs.getString("security_question");					
			}
			
		} catch (SQLException e) {
			
			e.printStackTrace(); 
		     
		}
	return question;			
}

//-----------------------------------------------------------------------------------------
// get security question answer by user name

public String getSecurityQuestionAnswerByUserName(String userName){
	 
	 String answer=null;
	 
	 try {
			
			conn=dbservice.setConnection();
			Statement stmt=conn.createStatement();
			
			String querySelect="SELECT security_question_answer FROM user where user_name ='"+userName+"'";
			ResultSet rs=stmt.executeQuery(querySelect);			
			while(rs.next()){
				
				answer = rs.getString("security_question_answer");					
			}
			
		} catch (SQLException e) {
			
			e.printStackTrace(); 
		     
		}
	return answer;			
}

//---------------------------------------------------------------------------------------------------------

}
