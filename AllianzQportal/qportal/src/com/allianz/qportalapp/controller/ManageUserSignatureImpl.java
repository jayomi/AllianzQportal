package com.allianz.qportalapp.controller;

import java.net.InetAddress;
import java.net.UnknownHostException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Calendar;
import java.util.Date;

public class ManageUserSignatureImpl {
	
	FormDBService dbservice=new FormDBService(); 
	Connection conn = null; 
	//Statement stmt=null;
	
	public int addUserSignature(String userAccessType,String userName,int formId,int qId,String signature){
		int times=1;
		FormQuestionImpl questionImpl=new FormQuestionImpl();
		Date currentDate=(Date) questionImpl.getCurrentDate();
		Calendar calendar = Calendar.getInstance();
		java.util.Date now = calendar.getTime();
		java.sql.Timestamp currentTimestamp = new java.sql.Timestamp(now.getTime());
		
		
		try{
			
			InetAddress IP=InetAddress.getLocalHost();
			//System.out.println("IP of my system is := "+IP.getHostAddress());
			String ipAddress = IP.getHostAddress();
			conn=dbservice.setConnection();
			Statement stmt=conn.createStatement();	
			int id=0;String answer="";int turn=0;
			
			if(userAccessType.equalsIgnoreCase("public")){
				
				
				String checkAnswerquery="select id,user_signature,turn from user_signature where user_name='"+userName+"' and form_id='"+formId+"' and question_id='"+qId+"'";
			
				Statement stmt1=conn.createStatement();
				ResultSet rs=stmt1.executeQuery(checkAnswerquery);
				while(rs.next()){
					id=rs.getInt("id");
					answer=rs.getString("user_signature");
					turn=rs.getInt("turn");
				}		
				
				if(id==0 && answer=="" && turn==0){
					int tempturn=1;		
					
					/// ------------end edit-----------------------
					
					String insertQuery="INSERT INTO user_signature (user_name,form_id,question_id,user_signature,turn,done_date,ip_address,time) VALUES ('"+userName+"','"+formId+"','"+qId+"','"+signature+"','"+tempturn+"','"+currentDate+"','"+ipAddress+"','"+new java.sql.Timestamp(now.getTime())+"')";
					Statement stmt3=conn.createStatement();
					stmt3.executeUpdate(insertQuery);
					
					
				}
				
				
				
				if(id!=0 && turn!=0){
					
					//when save & submit, update late....
					String selectUpdatequery="select turn from form_assignment_users where user_name='"+userName+"' and form_id='"+formId+"' and update_status=1";
					Statement selectTurn=conn.createStatement();			
					ResultSet update_turn_rs=selectTurn.executeQuery(selectUpdatequery);
					int update_turn=0;
					
					while(update_turn_rs.next()){
						update_turn=update_turn_rs.getInt("turn");
						times=update_turn;
						
						String select_turnQuery="select id,user_signature from user_signature where user_name='"+userName+"' and form_id='"+formId+"' and question_id='"+qId+"' and turn='"+update_turn+"'";
						
						Statement st2=conn.createStatement();
						ResultSet rs2=st2.executeQuery(select_turnQuery);
						int updateId=0;
						String updateUnswer="";
						while(rs2.next()){
							updateId=rs2.getInt("id");				
							String updateQuery="UPDATE user_signature SET user_signature='"+signature+"', done_date='"+currentDate+"', time='"+new java.sql.Timestamp(now.getTime())+"' where id='"+updateId+"'";				
							Statement stmt2=conn.createStatement();
							stmt2.executeUpdate(updateQuery);
							
							
						}
						if(updateId==0){
							String insert_new="INSERT INTO user_signature (user_name,form_id,question_id,user_signature,turn,done_date,ip_address,time) VALUES ('"+userName+"','"+formId+"','"+qId+"','"+signature+"','"+update_turn+"','"+currentDate+"','"+ipAddress+"','"+new java.sql.Timestamp(now.getTime())+"')";
							Statement stmt_new=conn.createStatement();
							stmt_new.executeUpdate(insert_new);
						}
						
						
					}
					
					if(update_turn==0){
						
						String getTurnQuery="select max(turn) as turn from user_signature where user_name='"+userName+"' and form_id='"+formId+"' and question_id='"+qId+"'";
						Statement turn_stmt=conn.createStatement();
						ResultSet turn_rs=turn_stmt.executeQuery(getTurnQuery);
						
						while(turn_rs.next()){
							times=turn_rs.getInt("turn");
						}
						//if(times>=1){
							
							times++;
							
							String insertQuery="INSERT INTO user_signature(user_name,form_id,turn,question_id,user_signature,done_date,ip_address,time) VALUES ('"+userName+"','"+formId+"','"+times+"','"+qId+"','"+signature+"','"+currentDate+"','"+ipAddress+"','"+new java.sql.Timestamp(now.getTime())+"')";
							Statement insertMeny=conn.createStatement();
							insertMeny.executeUpdate(insertQuery);
						//}
						
						
					}		
				}
				
	//-----------------------------------------------------------------------------------------------------------			
				
			}else if(userAccessType.equalsIgnoreCase("special")){
				
				
				String checkAnswerquery="select id,user_signature,turn from user_signature where user_name='"+userName+"' and form_id='"+formId+"' and question_id='"+qId+"'";
			
				Statement stmt1=conn.createStatement();
				ResultSet rs=stmt1.executeQuery(checkAnswerquery);
				while(rs.next()){
					id=rs.getInt("id");
					answer=rs.getString("user_signature");
					turn=rs.getInt("turn");
				}		
				
				if(id==0 && answer=="" && turn==0){
					int tempturn=1;		
					
					/// ------------end edit-----------------------
					
					String insertQuery="INSERT INTO user_signature(user_name,form_id,question_id,user_signature,turn,done_date) VALUES ('"+userName+"','"+formId+"','"+qId+"','"+signature+"','"+tempturn+"','"+currentDate+"')";
					Statement stmt3=conn.createStatement();
					stmt3.executeUpdate(insertQuery);
					
					
				}
				
				
				
				if(id!=0 && turn!=0){
					
					//when save & submit, update late....
					String selectUpdatequery="select turn from form_assignment_users where user_name='"+userName+"' and form_id='"+formId+"' and update_status=1";
					Statement selectTurn=conn.createStatement();			
					ResultSet update_turn_rs=selectTurn.executeQuery(selectUpdatequery);
					int update_turn=0;
					
					while(update_turn_rs.next()){
						update_turn=update_turn_rs.getInt("turn");
						times=update_turn;
						
						String select_turnQuery="select id,user_signature from user_signature where user_name='"+userName+"' and form_id='"+formId+"' and question_id='"+qId+"' and turn='"+update_turn+"'";
						
						Statement st2=conn.createStatement();
						ResultSet rs2=st2.executeQuery(select_turnQuery);
						int updateId=0;
						String updateUnswer="";
						while(rs2.next()){
							updateId=rs2.getInt("id");				
							String updateQuery="UPDATE user_signature SET user_signature='"+signature+"', done_date='"+currentDate+"' where id='"+updateId+"'";				
							Statement stmt2=conn.createStatement();
							stmt2.executeUpdate(updateQuery);
							
							
						}
						if(updateId==0){
							String insert_new="INSERT INTO user_signature(user_name,form_id,question_id,user_signature,turn,done_date) VALUES ('"+userName+"','"+formId+"','"+qId+"','"+signature+"','"+update_turn+"','"+currentDate+"')";
							Statement stmt_new=conn.createStatement();
							stmt_new.executeUpdate(insert_new);
						}
						
						
					}
					
					if(update_turn==0){
						
						String getTurnQuery="select max(turn) as turn from user_signature where user_name='"+userName+"' and form_id='"+formId+"' and question_id='"+qId+"'";
						Statement turn_stmt=conn.createStatement();
						ResultSet turn_rs=turn_stmt.executeQuery(getTurnQuery);
						
						while(turn_rs.next()){
							times=turn_rs.getInt("turn");
						}
						//if(times>=1){
							
							times++;
							
							String insertQuery="INSERT INTO user_signature(user_name,form_id,turn,question_id,user_signature,done_date) VALUES ('"+userName+"','"+formId+"','"+times+"','"+qId+"','"+signature+"','"+currentDate+"')";
							Statement insertMeny=conn.createStatement();
							insertMeny.executeUpdate(insertQuery);
						//}
						
						
					}		
				}
				
			}
			

			
			
			
			
	}catch(SQLException e){
		e.printStackTrace();
		
	} catch (UnknownHostException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}finally{
		if(conn !=null){
			try {
				conn.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	}
		return times;
		
	}

	//----------------------------------------------------------------------------------------


}
