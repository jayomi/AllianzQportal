package com.allianz.qportalapp.controller;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.omg.CORBA.DATA_CONVERSION;

import com.allianz.qportalapp.model.SubmitForm;

public class FormAssignToUserImple {
	
	FormDBService dbservice=new FormDBService(); 
	Connection conn = null;
	
	public void addAssignFormTouser(String userName,int formId,String userAccess){
	//public void addAssignFormTouser(String userName,int formId){
		
		try {	
		 	
			conn=dbservice.setConnection();
			
			String selectTurnQuery="select max(turn) as turn from form_assignment_users where user_name='"+userName+"' and form_id='"+formId+"'";
			Statement selectStamt=conn.createStatement();
			ResultSet select_rs=selectStamt.executeQuery(selectTurnQuery);
			int turn=0;
			while(select_rs.next()){
				turn=select_rs.getInt("turn");
				
			}
			
			turn++;
			String query="INSERT INTO form_assignment_users(user_name,form_id,user_access,form_status,update_status,turn) VALUES ('"+userName+"','"+formId+"','"+userAccess+"','0','0','"+turn+"')";			
			
			Statement stmt=conn.createStatement();
			stmt.executeUpdate(query);			
			
			
			}catch (SQLException e) {				
				e.printStackTrace();
			}
		
	}
	
	//get to do list
	public List<Integer> getFormListbyUser(String userName){
		List<Integer> formIdList=new ArrayList<Integer>();
		try {	
		 	
			conn=dbservice.setConnection();	
			
			String query="select form_id from form_assignment_users where user_name='"+userName+"' and form_status='0' and update_status='0'";
			
			Statement stmt=conn.createStatement();				
			ResultSet rs=stmt.executeQuery(query);
			
			while(rs.next()){
				int id=rs.getInt("form_id");
				formIdList.add(id);
				
			}
			
			stmt.close();
			conn.close();
			
			}catch (SQLException e) {				
				e.printStackTrace();
				
			}
		
		return formIdList;
		
	}
// get finished list
//======================================================================================================
	public List<Integer> getFinishedFormListbyUser(String userName){
		List<Integer> formIdList=new ArrayList<Integer>();
		try {	
		 	
			conn=dbservice.setConnection();	
			
			String query="select form_id from form_assignment_users where user_name='"+userName+"' and form_status=1";
			
			Statement stmt=conn.createStatement();				
			ResultSet rs=stmt.executeQuery(query);
			
			while(rs.next()){
				int id=rs.getInt("form_id");
				formIdList.add(id);
				
			}
			
			stmt.close();
			conn.close();
			
			}catch (SQLException e) {				
				e.printStackTrace();
				
			}
		
		return formIdList;
		
	}
//======================================================================================================
	
	public int checkUser(String userName,String password){
		int id=0;
		try {	
		 	
			conn=dbservice.setConnection();	
			String query="select id from user where user_name='"+userName+"' and password='"+password+"'";
			
			Statement stmt=conn.createStatement();				
			ResultSet rs=stmt.executeQuery(query);
			
			while(rs.next()){
				id=rs.getInt("id");
				
			}
			
			stmt.close();
			conn.close();
			
			}catch (SQLException e) {				
				e.printStackTrace();
				
			}
		return id;
	}
	
	public int countFormListByUser(String userName){
		int formCount=0;
		try {	
		 	
			conn=dbservice.setConnection();			
			
			String query="SELECT count(form_id) as total from form_assignment_users where user_name='"+userName+"'";			
			Statement stmt=conn.createStatement();				
			ResultSet rs=stmt.executeQuery(query);
			
			while(rs.next()){
				
				formCount=rs.getInt("total");
				
				
			}
			
			stmt.close();
			conn.close();
			
			}catch (SQLException e) {				
				e.printStackTrace();
				
			}
		return formCount;
		
	}
	

	
	
	//get exam done date
public Date getDoneDateByFormId(int formId,String userName,int turn) throws SQLException{
		
		Date doneDate=null;
		try {	
		 	
			conn=dbservice.setConnection();			
			
			String query="SELECT exam_done_date from form_assignment_users where form_id='"+formId+"' and user_name='"+userName+"' and turn='"+turn+"'";			
			Statement stmt=conn.createStatement();				
			ResultSet rs=stmt.executeQuery(query);
			
			while(rs.next()){
				
				doneDate=rs.getDate("exam_done_date");
				
			}
			
			stmt.close();
			
			
			}catch (SQLException e) {				
				e.printStackTrace();
				
			}finally{
				conn.close();
			}
		return doneDate;
		
	}

	
	
	//update form status when submit form (mcq type forms)
	public void updateFormStatusByUser(String userName,int formId,String userAccessType){
		
		try {
			
			conn=dbservice.setConnection();	
			int id=0;
			
			String checkIdquery="select id from form_assignment_users where user_name='"+userName+"' and form_id='"+formId+"'";
			
			Statement stmt_checkIdquery=conn.createStatement();
			ResultSet rs_checkIdquery=stmt_checkIdquery.executeQuery(checkIdquery);
			while(rs_checkIdquery.next()){
				id=rs_checkIdquery.getInt("id");				
				
			}	
			
			if(id==0){
				
				//get turn
				String selectTurnQuery="select max(turn) as turn from form_assignment_users where user_name='"+userName+"' and form_id='"+formId+"'";
				Statement selectStamt=conn.createStatement();
				ResultSet select_rs=selectStamt.executeQuery(selectTurnQuery);
				int turn=0;
				while(select_rs.next()){
					turn=select_rs.getInt("turn");
					
				}
				//-------------------
				Date startDate = new Date();
				java.sql.Date start_dateDB = new java.sql.Date(startDate.getTime());
				
				//-------------------
				
				turn++;
				
				//insert row
				String insertQuery="INSERT INTO form_assignment_users(user_name,form_id,user_access,exam_done_date,form_status,turn) VALUES ('"+userName+"','"+formId+"', '"+userAccessType+"', '"+start_dateDB+"','1','"+turn+"')";
				Statement insertQuery_stmt=conn.createStatement();
				insertQuery_stmt.executeUpdate(insertQuery);
				insertQuery_stmt.close();
				
			}
			if(id!=0){
				
				//select turn of update status
				String updateQuery="select id from form_assignment_users where user_name='"+userName+"' and form_id='"+formId+"' and update_status='1'";
				Statement update_stmt=conn.createStatement();
				ResultSet update_rs=update_stmt.executeQuery(updateQuery);
				int update_id=0;
				while(update_rs.next()){
					update_id=update_rs.getInt("id");
				}
				if(update_id==0){					
					
					//check form status
					String checkFormStatus="select id from form_assignment_users where user_name='"+userName+"' and form_id='"+formId+"' and form_status='0' and update_status='0'";
					Statement checkFormStatus_stmt=conn.createStatement();
					ResultSet checkFormStatus_rs=checkFormStatus_stmt.executeQuery(checkFormStatus);
					int checkFormStatusId=0;
					while(checkFormStatus_rs.next()){
						checkFormStatusId=checkFormStatus_rs.getInt("id");
						
					}
					
					if(checkFormStatusId==0){
						
						
						//get max turn
						
						String getTurnQuery="select max(turn) as turn from form_assignment_users where user_name='"+userName+"' and form_id='"+formId+"'";
						Statement turn_stmt=conn.createStatement();
						ResultSet turn_rs=turn_stmt.executeQuery(getTurnQuery);
						int times=0;
						while(turn_rs.next()){
							times=turn_rs.getInt("turn");
						}
						
						String query="select id,user_access from form_assignment_users where user_name='"+userName+"' and form_id='"+formId+"' and turn='"+times+"'";
						
						Statement stmt=conn.createStatement();			
						ResultSet rs=stmt.executeQuery(query);
						int statusId=0;
						String userAccess="";
						Date start=null;
						Date end=null;
						times++;
						
						while(rs.next()){				
							statusId=rs.getInt("id");
							userAccess=rs.getString("user_access");
							
						}
						
						String insertQuery="";
						
							
							end =  new Date();
							java.sql.Date end_dateDB = new java.sql.Date(end.getTime());
						
							insertQuery="INSERT INTO form_assignment_users(user_name,form_id,user_access,exam_done_date,form_status,update_status,turn) VALUES ('"+userName+"','"+formId+"','"+userAccess+"','"+end_dateDB+"',' 1' ,'0','"+times+"')";
						
							Statement insert_stmt=conn.createStatement();
							insert_stmt.executeUpdate(insertQuery);
							insert_stmt.close();
					}
					else{
						Date done = new Date();
						java.sql.Date done_dateDB = new java.sql.Date(done.getTime());
						//update.......
						String doUpdateQuery="UPDATE form_assignment_users SET update_status='0' , form_status='1', exam_done_date='"+done_dateDB+"' WHERE id='"+checkFormStatusId+"'";
						Statement doUpdateQuery_stmt=conn.createStatement();
						doUpdateQuery_stmt.executeUpdate(doUpdateQuery);
						doUpdateQuery_stmt.close();
					}
				}
				else if(update_id!=0){
					
					Date done = new Date();
					java.sql.Date done_dateDB = new java.sql.Date(done.getTime());
					
					String doUpdateQuery="UPDATE form_assignment_users SET update_status='0' , form_status='1' , exam_done_date='"+done_dateDB+"' WHERE id='"+update_id+"'";
					Statement doUpdateQuery_stmt=conn.createStatement();
					doUpdateQuery_stmt.executeUpdate(doUpdateQuery);
					doUpdateQuery_stmt.close();
				}
			}
			
			
		} catch (SQLException e) {
			
			e.printStackTrace();
		}finally{
			try {
				
				conn.close();
				
			} catch (SQLException e) {
				
				e.printStackTrace();
			}
		}
	}
	
	//update form updated status, when save & update clicked
		
	public void updateFormUpdatedStatusByUser(String userName,int formId,int turn,String userAccess){
		
		try {
			
			conn=dbservice.setConnection();		
			
			
			String query="select id from form_assignment_users where user_name='"+userName+"' and form_id='"+formId+"' and turn='"+turn+"'";
			Statement stmt=conn.createStatement();			
			ResultSet rs=stmt.executeQuery(query);
			int statusId=0;
			
			Date doneDate = new Date();
			java.sql.Date done_dateDB = new java.sql.Date(doneDate.getTime());
			
			while(rs.next()){				
				statusId=rs.getInt("id");					
			}	
			
			if(statusId==0){
				
				String getTurnQuery="select max(turn) as turn from form_assignment_users where user_name='"+userName+"' and form_id='"+formId+"'";
				Statement turn_stmt=conn.createStatement();
				ResultSet turn_rs=turn_stmt.executeQuery(getTurnQuery);
				int times=0;
				while(turn_rs.next()){
					times=turn_rs.getInt("turn");
				}
				times++;
				
				String insertQuery="INSERT INTO form_assignment_users(user_name,form_id,user_access,exam_done_date,form_status,update_status,turn) VALUES ('"+userName+"','"+formId+"','"+userAccess+"','"+done_dateDB+"',' 0' ,'1','"+times+"')";
				Statement insert_stmt=conn.createStatement();
				insert_stmt.executeUpdate(insertQuery);
				insert_stmt.close();
				
			}
			
			if(statusId!=0){
				
				
				String query1="UPDATE form_assignment_users SET update_status=1 , exam_done_date='"+done_dateDB+"' where id='"+statusId+"'";
				Statement stmt1=conn.createStatement();
				stmt1.executeUpdate(query1);				
				stmt1.close();
			}
			
			
			
		} catch (SQLException e) {
			
			e.printStackTrace();
		}finally{
			try {
				
				conn.close();
				
			} catch (SQLException e) {
				
				e.printStackTrace();
			}
		}
	}
	//======================================================
	
	//-----------get form list aginst the form status
	
	public List<Integer> getFormListbyFormStatus(String userName){
		List<Integer> formIdList=new ArrayList<Integer>();
		try {	
		 	
			conn=dbservice.setConnection();	
			
			//String query="INSERT INTO form_assignment_users(user_name,form_id,user_access,exam_start_date,exam_end_date) VALUES ('"+userName+"','"+formId+"','"+userAccess+"','"+startDate+"','"+endDate+"')";
			
			String query="select distinct form_id from form_assignment_users where user_name='"+userName+"' and form_status=1";
			
			Statement stmt=conn.createStatement();				
			ResultSet rs=stmt.executeQuery(query);
			
			while(rs.next()){
				int id=rs.getInt("form_id");
				formIdList.add(id);
				
			}
			
			stmt.close();
			conn.close();
			
			}catch (SQLException e) {				
				e.printStackTrace();
				
			}
		
		return formIdList;
		
	}
//---------------------------------------------------------------------------------------------------
	//get turn by user name and form id
	public List<Integer> getTurnListbyFormNameAndUser(String userName,int formId){
		List<Integer> turnList=new ArrayList<Integer>();
		try {	
		 	
			conn=dbservice.setConnection();	
			
			//String query="INSERT INTO form_assignment_users(user_name,form_id,user_access,exam_start_date,exam_end_date) VALUES ('"+userName+"','"+formId+"','"+userAccess+"','"+startDate+"','"+endDate+"')";
			
			String query="select turn from form_assignment_users where user_name='"+userName+"' and form_id='"+formId+"' and form_status='1'";
			
			Statement stmt=conn.createStatement();				
			ResultSet rs=stmt.executeQuery(query);
			
			while(rs.next()){
				int id=rs.getInt("turn");
				turnList.add(id);
				
			}
			
			stmt.close();
			conn.close();
			
			}catch (SQLException e) {				
				e.printStackTrace();
				
			}
		
		return turnList;
		
	}
//===================================================================================================	
//get ongoin turn list
	
		public List<Integer> getOnGoingTurnList(String userName,int formId){
			List<Integer> turnList=new ArrayList<Integer>();
			try {	
			 	
				conn=dbservice.setConnection();				
				
				String selectUpdatequery="select turn from form_assignment_users where user_name='"+userName+"' and form_id='"+formId+"' and update_status=1";
				
				Statement stmt=conn.createStatement();				
				ResultSet rs=stmt.executeQuery(selectUpdatequery);
				
				while(rs.next()){
					int id=rs.getInt("turn");
					turnList.add(id);
					
				}
				
				stmt.close();
				conn.close();
				
				}catch (SQLException e) {				
					e.printStackTrace();
					
				}
			
			return turnList;
			
		}
		
	
// get status of updating form list

	public List<Integer> getUpdatingFormListbyFormStatus(String userName){
		List<Integer> formIdList=new ArrayList<Integer>();
		try {	
		 	
			conn=dbservice.setConnection();	
			
			//String query="INSERT INTO form_assignment_users(user_name,form_id,user_access,exam_start_date,exam_end_date) VALUES ('"+userName+"','"+formId+"','"+userAccess+"','"+startDate+"','"+endDate+"')";
			
			String query="select form_id from form_assignment_users where user_name='"+userName+"' and update_status=1";
			
			Statement stmt=conn.createStatement();				
			ResultSet rs=stmt.executeQuery(query);
			
			while(rs.next()){
				int id=rs.getInt("form_id");
				formIdList.add(id);
				
			}
			
			stmt.close();
			conn.close();
			
			}catch (SQLException e) {				
				e.printStackTrace();
				
			}
		
		return formIdList;
		
	}
//====================================================================================================
	
	//count id according to form id and user_access type
	
	public int countIdByFormIdAndFormAccessType(int formId,String formAccessType){
		int count=0;
		try {	
		 	
			conn=dbservice.setConnection();			
			
			//String query="select count(id) as count from form_assignment_users where form_id='"+formId+"' and user_access='"+accessType+"'";			
			String query="select count(form_id) as count from main_form where form_id='"+formId+"' and form_access_type='"+formAccessType+"' and form_publish_type='1'";	
			Statement stmt=conn.createStatement();				
			ResultSet rs=stmt.executeQuery(query);
			
			while(rs.next()){				
				count=rs.getInt("count");			
			}
			
			stmt.close();
			conn.close();
			
			}catch (SQLException e) {				
				e.printStackTrace();
				
			}
		return count;
		
	}
	
	//get id according to form id and user access Type
	public int getIdByFormIdAndAccessType(int formId,String accessType){
		int id=0;
		try {	
		 	
			conn=dbservice.setConnection();			
			
			String query="select id from form_assignment_users where form_id='"+formId+"' and user_access='"+accessType+"'";			
			Statement stmt=conn.createStatement();				
			ResultSet rs=stmt.executeQuery(query);
			
			while(rs.next()){				
				id=rs.getInt("id");			
			}
			
			stmt.close();
			conn.close();
			
			}catch (SQLException e) {				
				e.printStackTrace();
				
			}
		return id;
		
	}
	
	//get Form List by accessType
	
	public List<Integer> getFormListByAccessType(String formAccessType){
		List<Integer> formIdList=new ArrayList<Integer>();
		
		try {	
			conn=dbservice.setConnection();	
			//String query="INSERT INTO form_assignment_users(user_name,form_id,user_access,exam_start_date,exam_end_date) VALUES ('"+userName+"','"+formId+"','"+userAccess+"','"+startDate+"','"+endDate+"')";
			
			//String query="select distinct form_id from form_assignment_users where user_access='"+accessType+"'";
			String query="select distinct form_id from main_form where form_access_type='"+formAccessType+"' and form_publish_type='1'";
			Statement stmt=conn.createStatement();				
			ResultSet rs=stmt.executeQuery(query);
			
			while(rs.next()){
				int id=rs.getInt("form_id");
				formIdList.add(id);
				
			}
			
			stmt.close();
			
			
			}catch (SQLException e) {				
				e.printStackTrace();
				
			}
		
		
		return formIdList;		
	}
	
	//change user name for registered user
	public void changeUserName(String publicUserName,String newUserName){
		conn=dbservice.setConnection();		
		try {
			
			
			String query="select id from form_assignment_users where user_name='"+publicUserName+"'";
			
			Statement stmt=conn.createStatement();
			ResultSet rs=stmt.executeQuery(query);	
			
			while(rs.next()){
				int id=rs.getInt("id");
				
				String updateQuery="UPDATE form_assignment_users SET user_name='"+newUserName+"' , user_access='special' where id='"+id+"'";
				
				Statement stmt2=conn.createStatement();
				stmt2.executeUpdate(updateQuery);
				
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
		
	}
	//---------------------------------------------------------------------------------------
	
	// get finished list
	//======================================================================================================
		public List<SubmitForm> getAllFinishedFormList(){
			List<SubmitForm> formIdList=new ArrayList<SubmitForm>();
			
			try {	
			 	
				conn=dbservice.setConnection();					
				String query="select * from form_assignment_users where form_status=1";
				
				Statement stmt=conn.createStatement();				
				ResultSet rs=stmt.executeQuery(query);
				
				while(rs.next()){
					String userName = rs.getString("user_name");
					int fid=rs.getInt("form_id");					
					int turn = rs.getInt("turn");
					SubmitForm submitForm = new SubmitForm(fid, userName, turn);
					formIdList.add(submitForm);					
				}
				
				stmt.close();
				conn.close();
				
				}catch (SQLException e) {				
					e.printStackTrace();
					
				}			
			return formIdList;
			
		}
		
	//======================================================================================================
		// get partially compleated list
		//======================================================================================================
				public List<SubmitForm> getAllPartiallyFinishedFormList(){
					List<SubmitForm> formIdList=new ArrayList<SubmitForm>();
					
					try {	
					 	
						conn=dbservice.setConnection();	
						
						String query="select * from form_assignment_users where update_status=1";
						
						Statement stmt=conn.createStatement();				
						ResultSet rs=stmt.executeQuery(query);
						
						while(rs.next()){
							String userName = rs.getString("user_name");
							int fid=rs.getInt("form_id");							
							int turn = rs.getInt("turn");
							SubmitForm submitForm = new SubmitForm(fid, userName,turn);
							formIdList.add(submitForm);
							
						}
						
						stmt.close();
						conn.close();
						
						}catch (SQLException e) {				
							e.printStackTrace();
							
						}
					
					return formIdList;
					
				}
	//======================================================================================================
		// get finished forms list formId wise
				
				public List<SubmitForm> getAllFinishedFormListByFormId(int formId){
					List<SubmitForm> formIdList=new ArrayList<SubmitForm>();
					
					try {	
					 	
						conn=dbservice.setConnection();	
						
						//String query="INSERT INTO form_assignment_users(user_name,form_id,user_access,exam_start_date,exam_end_date) VALUES ('"+userName+"','"+formId+"','"+userAccess+"','"+startDate+"','"+endDate+"')";
						
						//String query="select b.*, a.department from user a,form_assignment_users b where form_status=1 and form_id='"+formId+"' and a.user_name = b.user_name";
						String query = "select * from form_assignment_users where form_status=1 and form_id='"+formId+"'";
						
						Statement stmt=conn.createStatement();				
						ResultSet rs=stmt.executeQuery(query);
						
						while(rs.next()){
							String userName = rs.getString("user_name");
							int fid=rs.getInt("form_id");							
							int turn = rs.getInt("turn");
							Date doneDate = rs.getDate("exam_done_date");
							SubmitForm submitForm = new SubmitForm(fid, userName,doneDate,turn);
							formIdList.add(submitForm);
							
						}
						
						stmt.close();
						conn.close();
						
						}catch (SQLException e) {				
							e.printStackTrace();
							
						}
					
					return formIdList;
					
				}
	//======================================================================================================
		// get all partially finished list, form Id wise
				public List<SubmitForm> getAllPartiallyFinishedFormListByFormId(int formId){
					List<SubmitForm> formIdList=new ArrayList<SubmitForm>();
					
					try {	
					 	
						conn=dbservice.setConnection();	
						
						//String query="INSERT INTO form_assignment_users(user_name,form_id,user_access,exam_start_date,exam_end_date) VALUES ('"+userName+"','"+formId+"','"+userAccess+"','"+startDate+"','"+endDate+"')";
						
						//String query=" select b.*, a.department from user a,form_assignment_users b where update_status=1 and form_id='"+formId+"' and a.user_name = b.user_name";
						String query = "select * from form_assignment_users where update_status=1 and form_id='"+formId+"'";
						
						Statement stmt=conn.createStatement();				
						ResultSet rs=stmt.executeQuery(query);
						
						while(rs.next()){
							String userName = rs.getString("user_name");
							int fid=rs.getInt("form_id");							
							int turn = rs.getInt("turn");							
							SubmitForm submitForm = new SubmitForm(fid, userName,turn);
							formIdList.add(submitForm);
							
						}
						
						stmt.close();
						conn.close();
						
						}catch (SQLException e) {				
							e.printStackTrace();
							
						}
					
					return formIdList;
					
				}
		
	//======================================================================================================
		// get finished forms list department wise
		public List<SubmitForm> getAllFinishedFormListByDepartment(String department){
			List<SubmitForm> formIdList=new ArrayList<SubmitForm>();
			
			try {	
			 	
				conn=dbservice.setConnection();				
				
				String query="SELECT b.* FROM (select user_name from user where department = '"+department+"') a, form_assignment_users b WHERE a.user_name = b.user_name and b.form_status=1";
				
				Statement stmt=conn.createStatement();				
				ResultSet rs=stmt.executeQuery(query);
				
				while(rs.next()){
					String userName = rs.getString("user_name");
					int fid=rs.getInt("form_id");					
					int turn = rs.getInt("turn");
					SubmitForm submitForm = new SubmitForm(fid, userName,turn);
					formIdList.add(submitForm);
					
				}
				
				stmt.close();
				conn.close();
				
				}catch (SQLException e) {				
					e.printStackTrace();
					
				}
			
			return formIdList;
			
		}
		//================================================================
		
		// get all finished users list department and form wise
		
		public List<SubmitForm> getAllFinishedUsersListByDepartmentAndForm(int formId,String department){
					List<SubmitForm> formIdList=new ArrayList<SubmitForm>();
					
					try {	
					 	
						conn=dbservice.setConnection();				
						
						String query="SELECT b.* FROM (select user_name from user where department = '"+department+"') a, form_assignment_users b WHERE a.user_name = b.user_name and form_id='"+formId+"' and b.form_status=1";

						
						Statement stmt=conn.createStatement();				
						ResultSet rs=stmt.executeQuery(query);
						
						while(rs.next()){
							String userName = rs.getString("user_name");
							int fid=rs.getInt("form_id");							
							int turn = rs.getInt("turn");
							SubmitForm submitForm = new SubmitForm(fid, userName,turn);
							formIdList.add(submitForm);							
						}
						
						stmt.close();
						conn.close();
						
						}catch (SQLException e) {				
							e.printStackTrace();
							
						}
					
					return formIdList;
					
				}
				//================================================================
		
		// get partially compleated users list, department and form wise
		
				public List<SubmitForm> getAllPartiallyFinishedUsersListByDepartmentAndForm(int formId,String department){
							List<SubmitForm> formIdList=new ArrayList<SubmitForm>();
							
							try {	
							 	
								conn=dbservice.setConnection();				
								
								String query="SELECT b.* FROM (select user_name from user where department = '"+department+"') a, form_assignment_users b WHERE a.user_name = b.user_name and form_id='"+formId+"' and b.update_status=1";

								
								Statement stmt=conn.createStatement();				
								ResultSet rs=stmt.executeQuery(query);
								
								while(rs.next()){
									String userName = rs.getString("user_name");
									int fid=rs.getInt("form_id");									
									int turn = rs.getInt("turn");
									
									SubmitForm submitForm = new SubmitForm(fid, userName,turn);
									formIdList.add(submitForm);
									
								}
								
								stmt.close();
								conn.close();
								
								}catch (SQLException e) {				
									e.printStackTrace();
									
								}
							
							return formIdList;
							
						}
				//============================================================================
				
}
