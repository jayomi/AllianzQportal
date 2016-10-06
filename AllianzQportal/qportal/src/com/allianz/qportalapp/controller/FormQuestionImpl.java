package com.allianz.qportalapp.controller;

import java.io.InputStream;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.net.InetAddress;
import java.net.UnknownHostException;
import java.sql.Blob;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Random;

import org.apache.commons.codec.binary.Base64;

import com.allianz.qportalapp.model.Question;
import com.allianz.qportalapp.model.ResultForm;

public class FormQuestionImpl {

FormDBService dbservice=new FormDBService(); 
Connection conn = null; 
//Statement stmt=null;

public List<Question> getFieldByFormIdAndSegmentId(int formId,int segmentId){
		
		List<Question> fieldList=new ArrayList<Question>();
		try{
			
			conn=dbservice.setConnection();
			Statement stmt=conn.createStatement();		
			//String query="SELECT * FROM field_form WHERE form_id='"+formId+"' AND segment_id='"+segmentId+"'";
			String query="SELECT * FROM field_form WHERE form_id='"+formId+"' AND segment_id='"+segmentId+"' ORDER BY orderId";
			ResultSet rs=stmt.executeQuery(query);			
			
			
			
			while(rs.next()){
				
				int fieldOrderId=rs.getInt("orderId");
				int fieldId=rs.getInt("question_id");
				String fieldName=rs.getString("field_name");
				String fieldType=rs.getString("field_type");
				//String ispredefine_data=rs.getString("ispredefine_data");
				//String predefine_value=(String) rs.getString("predefine_value");	
				
				String query2="SELECT pre_values from predifine_answer where question_id="+fieldId;
				Statement stmtquery=conn.createStatement();	
				ResultSet rs2=stmtquery.executeQuery(query2);
				String preAnswers="";
				while(rs2.next()){
					preAnswers=rs2.getString("pre_values");
				}
				
				Question formQuestion=new Question(segmentId,fieldId,fieldOrderId,fieldName, fieldType,preAnswers);				
				fieldList.add(formQuestion);				
				
			}
			
		}catch(SQLException e){
			e.printStackTrace();
		}
		return fieldList;	
		
	}

public int getNoOfFieldByFormId(int formId){
	
	int numberOfQuestions=0;
	
	try{
		
		conn=dbservice.setConnection();
		Statement stmt=conn.createStatement();		
		String query="SELECT COUNT(question_id) AS question_id FROM field_form WHERE form_id='"+formId+"'";
		
		ResultSet rs=stmt.executeQuery(query);	
		
		while(rs.next()){
			numberOfQuestions=rs.getInt("question_id");
		}
		}catch(SQLException e){
			e.printStackTrace();
		}
	
	return numberOfQuestions;
	
	
}
public int getMinFieldIdByFormId(int formId){
	int minQid=0;
	try {
		
		conn=dbservice.setConnection();
		Statement stmt=conn.createStatement();		
		String query="SELECT MIN(question_id) AS qid FROM field_form where form_id='"+formId+"'";
		

		ResultSet rs=stmt.executeQuery(query);	
		
		while(rs.next()){
			minQid=rs.getInt("qid");
		}
	} catch (SQLException e){
		e.printStackTrace();
	}
	return minQid;
	
}

//-------------------------------------------------------------------------
public void updateUsergivenAnswer(String userAccessType,String userName,int formId,int qId,int turn){
	
	try{
			
			conn=dbservice.setConnection();
			Statement stmt=conn.createStatement();
			
			Calendar calendar = Calendar.getInstance();
		    SimpleDateFormat sdf = new SimpleDateFormat("HH:mm:ss");  
			//String timeStampDate = sdf.format(calendar.getTime());
			
			if(userAccessType.equalsIgnoreCase("special")){
				
			
				String selectAll ="select id from user_answer_table where user_name='"+userName+"' and form_id='"+formId+"' and question_id='"+qId+"' and turn='"+turn+"'";
				Statement stmt1=conn.createStatement();
				ResultSet rs=stmt1.executeQuery(selectAll);
				int temp=0;
				while(rs.next()){
					
					temp=rs.getInt("id");
					/*String updateQuery="UPDATE user_answer_table SET user_answer='"+user_given_answer+"' where id='"+temp+"'";				
					Statement stmt2=conn.createStatement();
					stmt2.executeUpdate(updateQuery);*/
					
				}
				if(temp==0){
					
					FormQuestionImpl questionImpl=new FormQuestionImpl();
					Date currentDate=(Date) questionImpl.getCurrentDate();
					String insertQuery="INSERT INTO user_answer_table(user_name,form_id,question_id,turn,done_date) VALUES ('"+userName+"','"+formId+"','"+qId+"','"+turn+"','"+currentDate+"')";
					Statement stmt3=conn.createStatement();
					stmt3.executeUpdate(insertQuery);
					
					
				}
			
			}	
			
			if(userAccessType.equalsIgnoreCase("public")){
				
				
				String selectAll ="select id from public_user_answers where user_name='"+userName+"' and form_id='"+formId+"' and question_id='"+qId+"' and turn='"+turn+"'";
				Statement stmt1=conn.createStatement();
				ResultSet rs=stmt1.executeQuery(selectAll);
				int temp=0;
				while(rs.next()){
					
					temp=rs.getInt("id");					
					
				}
				if(temp==0){
					
					FormQuestionImpl questionImpl=new FormQuestionImpl();
					Date currentDate=(Date) questionImpl.getCurrentDate();
					String insertQuery="INSERT INTO public_user_answers(user_name,form_id,question_id,turn,done_date,time) VALUES ('"+userName+"','"+formId+"','"+qId+"','"+turn+"','"+currentDate+"','"+sdf.format(calendar.getTime())+"')";
					Statement stmt3=conn.createStatement();
					stmt3.executeUpdate(insertQuery);
					
					
				}
			}	
			
	} catch (SQLException e){
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

//--------------------------------------------------------------------------

//--------------user answer------------------------------------------------
public int addUserGivenAnswer(String userAccessType,String userName,int formId,int qId,String user_given_answer) throws ParseException{
	int times=1;
	
	FormQuestionImpl questionImpl=new FormQuestionImpl();
	Date currentDate=(Date) questionImpl.getCurrentDate();
	
	Calendar calendar = Calendar.getInstance();
    SimpleDateFormat sdf = new SimpleDateFormat("HH:mm:ss");  
	String timeStampDate = sdf.format(calendar.getTime());
	
	
	try{
		
		InetAddress IP=InetAddress.getLocalHost();
		//System.out.println("IP of my system is := "+IP.getHostAddress());
		String ipAddress = IP.getHostAddress();
		conn=dbservice.setConnection();
		Statement stmt=conn.createStatement();	
		int id=0;String answer="";int turn=0;
		
		if(userAccessType.equalsIgnoreCase("public")){
			
			
			String checkAnswerquery="select id,user_answer,turn from public_user_answers where user_name='"+userName+"' and form_id='"+formId+"' and question_id='"+qId+"'";
		
			Statement stmt1=conn.createStatement();
			ResultSet rs=stmt1.executeQuery(checkAnswerquery);
			while(rs.next()){
				id=rs.getInt("id");
				answer=rs.getString("user_answer");
				turn=rs.getInt("turn");
			}		
			
			if(id==0 && answer=="" && turn==0){
				int tempturn=1;		
				
				/// ------------end edit-----------------------
				
				//SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
				//String currentTime = sdf.format(now.getTime());
				
				
				String insertQuery="INSERT INTO public_user_answers (user_name,form_id,question_id,user_answer,turn,done_date,ip_address,time) VALUES ('"+userName+"','"+formId+"','"+qId+"','"+user_given_answer+"','"+tempturn+"','"+currentDate+"','"+ipAddress+"','"+timeStampDate+"')";
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
					
					String select_turnQuery="select id,user_answer from public_user_answers where user_name='"+userName+"' and form_id='"+formId+"' and question_id='"+qId+"' and turn='"+update_turn+"'";
					
					Statement st2=conn.createStatement();
					ResultSet rs2=st2.executeQuery(select_turnQuery);
					int updateId=0;
					String updateUnswer="";
					while(rs2.next()){
						updateId=rs2.getInt("id");				
						String updateQuery="UPDATE public_user_answers SET user_answer='"+user_given_answer+"', done_date='"+currentDate+"', time='"+timeStampDate+"' where id='"+updateId+"'";				
						Statement stmt2=conn.createStatement();
						stmt2.executeUpdate(updateQuery);
						
						
					}
					if(updateId==0){
						String insert_new="INSERT INTO public_user_answers (user_name,form_id,question_id,user_answer,turn,done_date,ip_address,time) VALUES ('"+userName+"','"+formId+"','"+qId+"','"+user_given_answer+"','"+update_turn+"','"+currentDate+"','"+ipAddress+"','"+timeStampDate+"')";
						Statement stmt_new=conn.createStatement();
						stmt_new.executeUpdate(insert_new);
					}
					
					
				}
				
				if(update_turn==0){
					
					String getTurnQuery="select max(turn) as turn from public_user_answers where user_name='"+userName+"' and form_id='"+formId+"' and question_id='"+qId+"'";
					Statement turn_stmt=conn.createStatement();
					ResultSet turn_rs=turn_stmt.executeQuery(getTurnQuery);
					
					while(turn_rs.next()){
						times=turn_rs.getInt("turn");
					}
					//if(times>=1){
						
						times++;
						
						String insertQuery="INSERT INTO public_user_answers(user_name,form_id,turn,question_id,user_answer,done_date,ip_address,time) VALUES ('"+userName+"','"+formId+"','"+times+"','"+qId+"','"+user_given_answer+"','"+currentDate+"','"+ipAddress+"','"+timeStampDate+"')";
						Statement insertMeny=conn.createStatement();
						insertMeny.executeUpdate(insertQuery);
					//}
					
					
				}		
			}
			
//-----------------------------------------------------------------------------------------------------------			
			
		}else if(userAccessType.equalsIgnoreCase("special")){
			
			
			String checkAnswerquery="select id,user_answer,turn from user_answer_table where user_name='"+userName+"' and form_id='"+formId+"' and question_id='"+qId+"'";
		
			Statement stmt1=conn.createStatement();
			ResultSet rs=stmt1.executeQuery(checkAnswerquery);
			while(rs.next()){
				id=rs.getInt("id");
				answer=rs.getString("user_answer");
				turn=rs.getInt("turn");
			}		
			
			if(id==0 && answer=="" && turn==0){
				int tempturn=1;		
				
				/// ------------end edit-----------------------
				
				String insertQuery="INSERT INTO user_answer_table(user_name,form_id,question_id,user_answer,turn,done_date) VALUES ('"+userName+"','"+formId+"','"+qId+"','"+user_given_answer+"','"+tempturn+"','"+currentDate+"')";
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
					
					String select_turnQuery="select id,user_answer from user_answer_table where user_name='"+userName+"' and form_id='"+formId+"' and question_id='"+qId+"' and turn='"+update_turn+"'";
					
					Statement st2=conn.createStatement();
					ResultSet rs2=st2.executeQuery(select_turnQuery);
					int updateId=0;
					String updateUnswer="";
					while(rs2.next()){
						updateId=rs2.getInt("id");				
						String updateQuery="UPDATE user_answer_table SET user_answer='"+user_given_answer+"', done_date='"+currentDate+"' where id='"+updateId+"'";				
						Statement stmt2=conn.createStatement();
						stmt2.executeUpdate(updateQuery);
						
						
					}
					if(updateId==0){
						String insert_new="INSERT INTO user_answer_table(user_name,form_id,question_id,user_answer,turn,done_date) VALUES ('"+userName+"','"+formId+"','"+qId+"','"+user_given_answer+"','"+update_turn+"','"+currentDate+"')";
						Statement stmt_new=conn.createStatement();
						stmt_new.executeUpdate(insert_new);
					}
					
					
				}
				
				if(update_turn==0){
					
					String getTurnQuery="select max(turn) as turn from user_answer_table where user_name='"+userName+"' and form_id='"+formId+"' and question_id='"+qId+"'";
					Statement turn_stmt=conn.createStatement();
					ResultSet turn_rs=turn_stmt.executeQuery(getTurnQuery);
					
					while(turn_rs.next()){
						times=turn_rs.getInt("turn");
					}
					//if(times>=1){
						
						times++;
						
						String insertQuery="INSERT INTO user_answer_table(user_name,form_id,turn,question_id,user_answer,done_date) VALUES ('"+userName+"','"+formId+"','"+times+"','"+qId+"','"+user_given_answer+"','"+currentDate+"')";
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

public void addReferenceId(String userName,String referenceId,int formId){
	
	try{
			
			conn=dbservice.setConnection();		
			
			String selectQuery = "select id,reference_id from public_user_answers where user_name='"+userName+"' and form_id='"+formId+"'";
			Statement select_stmt=conn.createStatement();
			ResultSet selectResult = select_stmt.executeQuery(selectQuery);
			String refId=null;
			
			while(selectResult.next()){
				
				 refId = selectResult.getString("reference_id");
				 int id = selectResult.getInt("id");
				 
				 /*if(refId==null){					 
					 
					 String insertQuery = "Insert into public_user_answers (reference_id) values('"+referenceId+"')";
					 Statement insertStmt = conn.createStatement();
					 insertStmt.executeUpdate(insertQuery);
				 }
				 else*/ if(refId==null){
					 String updateQuery = "UPDATE public_user_answers SET reference_id='"+referenceId+"' where id='"+id+"'";
					 Statement updateStmt = conn.createStatement();
					 updateStmt.executeUpdate(updateQuery);
				 }
				 
				
			}
			/*if(refId == null){
				String newQuery = "select id from public_user_answers where user_name='"+userName+"' and form_id='"+formId+"'";
				Statement 
			}
			*/
			
	}catch(SQLException e){
		e.printStackTrace();
		
	}finally{
		if(conn!=null){
			try {
				conn.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	}
	
}

//-----------------------------------------------------------------------------------------
public String getReferenceId(String userName,int formId){
	
	String refId=null;
	
	try{
		
		conn=dbservice.setConnection();		
		
		String selectQuery = "select distinct reference_id from public_user_answers where user_name='"+userName+"' and form_id='"+formId+"'";
		Statement select_stmt=conn.createStatement();
		ResultSet selectResult = select_stmt.executeQuery(selectQuery);
		
		while(selectResult.next()){
			
			 refId = selectResult.getString("reference_id");
		}
		
	}catch(SQLException e){
		e.printStackTrace();
		
	}finally{
		if(conn!=null){
			try {
				conn.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	}
	return refId;
	
}
//------------------------------------------------------------------------------------------
public List<String> getUserNameByreferenceId(String referenceId,int formId){
	List<String> userList=new ArrayList<String>();
	try{
			
			conn=dbservice.setConnection();	
			String selectQuery = "select distinct user_name from public_user_answers where reference_id='"+referenceId+"' and form_id='"+formId+"'";
			Statement select_stmt=conn.createStatement();
			ResultSet selectResult = select_stmt.executeQuery(selectQuery);
			String publicUser;
			
			while(selectResult.next()){
				
				publicUser = selectResult.getString("user_name");
				userList.add(publicUser);
			}
			
	}catch(SQLException e){
		e.printStackTrace();
		
	}finally{
		if(conn!=null){
			try {
				conn.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
}
	return userList;	
		
}
//------------------------------------------------------------------------------------------


public List<Integer> getFormListByUserNameAndNIC(String userName,String nic){//server consider nic as referenceId
	List<Integer> formList=new ArrayList<Integer>();
	try{
			
			conn=dbservice.setConnection();	
			String selectQuery = "select distinct form_id from public_user_answers where user_name='"+userName+"' and reference_id='"+nic+"'";
			//String selectQuery = "select distinct form_id from public_user_answers where reference_id='"+nic+"'";
			
			Statement select_stmt=conn.createStatement();
			ResultSet selectResult = select_stmt.executeQuery(selectQuery);
			int formId;
			
			while(selectResult.next()){
				
				formId = selectResult.getInt("form_id");
				formList.add(formId);
			}
			
	}catch(SQLException e){
		e.printStackTrace();
		
	}finally{
		if(conn!=null){
			try {
				conn.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
}
	return formList;	
		
}

//------------------------------------------------------------------------------------------

public void addResult(String userName,int formId,int noOfQuestions,int noOfcorrectAnswers,int noOfunAnswers,int passMark,int turn ){
	
	try{
		
		conn=dbservice.setConnection();
		Statement stmt=conn.createStatement();		
		String query="INSERT INTO result_form(user_name,form_id,number_of_questions,number_of_correctAnswers,number_of_unAnswers,pass_mark,turn) VALUES ('"+userName+"','"+formId+"','"+noOfQuestions+"','"+noOfcorrectAnswers+"','"+noOfunAnswers+"','"+passMark+"','"+turn+"')";
		//String query="INSERT INTO user_answer_table(form_id,question_id,user_answer) VALUES ('"+formId+"','"+qId+"','"+user_given_answer, REPLACE(@Data.pluginText,\"'\", \"\'\")+"')";
		stmt.executeUpdate(query);
		
		
	}catch(SQLException e){
		e.printStackTrace();
		
	}finally{
		if(conn!=null){
			try {
				conn.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	}
}

public Question getFieldByQid(int qid){
	int fieldOrderId=0;
	String fieldName="";
	String fieldType="";
	String answerSet="";
	String correctAnswer="";
	Question question=new Question(qid,fieldOrderId ,fieldName, fieldType, answerSet, correctAnswer);
	
try {
		
		conn=dbservice.setConnection();
		Statement stmt=conn.createStatement();			
		
		String query="SELECT field_name, field_type,orderId FROM field_form where question_id='"+qid+"'";		
		
		ResultSet rs=stmt.executeQuery(query);	
		
		while(rs.next()){
			fieldOrderId=rs.getInt("orderId");
			fieldName=rs.getString("field_name");
			fieldType=rs.getString("field_type");
			question.setQuestionOrder(fieldOrderId);
			question.setQuestionName(fieldName);
			question.setQuestionType(fieldType);
			
		}
		
		String query2="SELECT pre_values,correct_answer FROM predifine_answer where question_id='"+qid+"'";
		Statement stmt2=conn.createStatement();
		ResultSet rs2=stmt.executeQuery(query2);	
		
		while(rs2.next()){
			
			answerSet=rs2.getString("pre_values");
			correctAnswer=rs2.getString("correct_answer");
			question.setPreAnswers(answerSet);
			question.setCorrectAnswer(correctAnswer);
			
		}
		
	} catch (SQLException e){
		e.printStackTrace();
	}finally{
		try {
			conn.close();
			
		} catch (SQLException e) {
			
			e.printStackTrace();
		}
	}
return question;
}


public void updateFieldByFieldId(int qid, int qOrder,String qName,String qType,String preAnswers,String correctAnswer){
	
	
	try {
		
		conn=dbservice.setConnection();		
		Statement stmt1=conn.createStatement();
		
		String query1="UPDATE field_form SET field_name='"+qName+"' , field_type='"+qType+"' , orderId='"+qOrder+"' where question_id='"+qid+"'";
		stmt1.executeUpdate(query1);
		
		String query2="UPDATE predifine_answer SET field_type='"+qType+"' , pre_values='"+preAnswers+"' , correct_answer='"+correctAnswer+"' where question_id='"+qid+"'";
		Statement stmt2=conn.createStatement();
		stmt2.executeUpdate(query2);
		
		stmt1.close();
		stmt2.close();
		
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

public void deleteQuestionByQid(int qid){

	try {		
		conn=dbservice.setConnection();		
		Statement stmt1=conn.createStatement();
		
		String query1="DELETE from field_form where question_id='"+qid+"'";		
		stmt1.executeUpdate(query1);	
		
		stmt1.close();
		
		String query2="DELETE from predifine_answer where question_id='"+qid+"'";	
		Statement stmt2=conn.createStatement();
		stmt2.executeUpdate(query2);
		stmt2.close();
		
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

public String getCorrectAnswerByQId(int formId,int qId){
	
	String correctAnswer="";
	String givenAnswer="";
	int noOfCorrectAnswer=0;
	try {		
		conn=dbservice.setConnection();		
		Statement stmt1=conn.createStatement();
		
		
		String query1="SELECT correct_answer FROM predifine_answer where question_id='"+qId+"'";		
		
		ResultSet rs1=stmt1.executeQuery(query1);	
		
		while(rs1.next()){
			
			correctAnswer=rs1.getString("correct_answer");			
			
		}
		
		stmt1.close();
		
		
	} catch (SQLException e) {
			
			e.printStackTrace();
		}finally{
			try {
				
				conn.close();
				
			} catch (SQLException e) {
				
				e.printStackTrace();
			}
		}
	return correctAnswer;
}

public String getGivenAnswerByQId(int formId,int qId,String userName,int turn,String userType){
	

	String givenAnswer="";
	int noOfCorrectAnswer=0;
	try {
		
		conn=dbservice.setConnection();		
		Statement stmt1=conn.createStatement();
		String query2="";
		
		if(userType.equals("public")){
			query2="SELECT user_answer FROM public_user_answers where question_id='"+qId+"' and user_name='"+userName+"' and turn='"+turn+"'";
		}
		else if(userType.equals("special")){
			
			query2="SELECT user_answer FROM user_answer_table where question_id='"+qId+"' and user_name='"+userName+"' and turn='"+turn+"'";
		}
		
		Statement stmt2=conn.createStatement();
		ResultSet rs2=stmt2.executeQuery(query2);	
		
		while(rs2.next()){
			
			givenAnswer=rs2.getString("user_answer");			
			
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
	return givenAnswer;
}
//----------------------------------------------------------------------------------------------

//get user signature
public String getUserSignatureByQId(int formId,int qId,String userName,int turn,String userType){
	

	String signature="";
	//InputStream binaryStream = null;
	byte[] imgData = null;
	int noOfCorrectAnswer=0;
	try {
		
		conn=dbservice.setConnection();		
		Statement stmt1=conn.createStatement();
		String query2="";
		
		
		query2="SELECT user_signature FROM user_signature where question_id='"+qId+"' and user_name='"+userName+"' and turn='"+turn+"'";
		
		
		Statement stmt2=conn.createStatement();
		ResultSet rs2=stmt2.executeQuery(query2);	
		
		while(rs2.next()){
			
			signature=rs2.getString("user_signature");	
			/*
			Blob imageBlob = rs2.getBlob("user_signature");			
			imgData = imageBlob.getBytes(1,(int)imageBlob.length());
			System.out.println("imgData: "+imgData);			
			String imgLen = rs2.getString(1);
			System.out.println("imgLen: "+imgLen);*/
           	
			
		}				
			
		stmt2.close();
		
	}catch (SQLException e) {
		
		e.printStackTrace();
	}finally{
		try {
			
			conn.close();
			
		} catch (SQLException e) {
			
			e.printStackTrace();
		}
	}
	//return imgData;
	return signature;
}

//----------------------------------------------------------------------------------------------

public String getQuestionTypeByQId(int qId){

	String qType="";
	try {
		
		conn=dbservice.setConnection();		
		Statement stmt1=conn.createStatement();
		
		String query="SELECT field_type FROM field_form where question_id='"+qId+"'";		
		Statement stmt=conn.createStatement();
		ResultSet rs=stmt.executeQuery(query);	
		while(rs.next()){
			
			qType=rs.getString("field_type");			
			
		}	
		stmt.close();
		
	}catch (SQLException e) {
		
		e.printStackTrace();
	}finally{
		try {
			
			conn.close();
			
		} catch (SQLException e) {
			
			e.printStackTrace();
		}
	}
	return qType;
	
}
//=============================================================================================

public String getPredefineAnswerByQId(int qId){

	String predefineAnswer="";
	
	try {
		
		conn=dbservice.setConnection();		
		Statement stmt1=conn.createStatement();
		
		String query2="SELECT pre_values FROM predifine_answer where question_id='"+qId+"'";
		
		Statement stmt2=conn.createStatement();
		ResultSet rs2=stmt2.executeQuery(query2);	
		
		while(rs2.next()){
			
			predefineAnswer=rs2.getString("pre_values");			
			
		}				
			
		stmt2.close();
		
	}catch (SQLException e) {
		
		e.printStackTrace();
	}finally{
		try {
			
			conn.close();
			
		} catch (SQLException e) {
			
			e.printStackTrace();
		}
	}
	return predefineAnswer;
}
//=====================================.......................................

//get passmark from result table

public ResultForm getResultByUser_TurnAndFormId(String userName,int formId,int turn){
	int noOfQuestions=0;
	int noOfcorrectAnswer=0;
	int noOfunAnswer=0;
	int passMark=0;
	
	
	ResultForm resultForm=new ResultForm(formId, userName, noOfQuestions, noOfcorrectAnswer, noOfunAnswer, passMark,turn);
	
	try {
		
		conn=dbservice.setConnection();		
		Statement stmt1=conn.createStatement();
		
		String query2="select number_of_questions,number_of_correctAnswers,number_of_unAnswers,pass_mark from result_form where user_name='"+userName+"' and form_id='"+formId+"' and turn='"+turn+"'";
		
		Statement stmt2=conn.createStatement();
		ResultSet rs2=stmt2.executeQuery(query2);	
		
		while(rs2.next()){
			
			noOfQuestions=rs2.getInt("number_of_questions");	
			noOfcorrectAnswer=rs2.getInt("number_of_correctAnswers");
			noOfunAnswer=rs2.getInt("number_of_unAnswers");
			passMark=rs2.getInt("pass_mark");
			
		}				
		resultForm.setFormId(formId);
		resultForm.setUserName(userName);
		resultForm.setNoOfQuestions(noOfQuestions);
		resultForm.setNoOfcorrectAnswer(noOfcorrectAnswer);
		resultForm.setNoOfunAnswer(noOfunAnswer);
		resultForm.setPassMark(passMark);
		
		stmt2.close();
		
	}catch (SQLException e) {
		
		e.printStackTrace();
	}finally{
		try {
			
			conn.close();
			
		} catch (SQLException e) {
			
			e.printStackTrace();
		}
	}
	return resultForm;
}

//create Random user name for publicly access users........
public static String generateString(Random rng, String characters, int length)
{
    char[] text = new char[length];
    for (int i = 0; i < length; i++)
    {
        text[i] = characters.charAt(rng.nextInt(characters.length()));
    }
    return new String(text);
}

//change user Name when registration

public void changeUserName(String publicUserName,String newUserName){
	conn=dbservice.setConnection();		
	try {
		
		
		//String query="select id from user_answer_table where user_name='"+publicUserName+"'";
		//public_user_answers
		String query="select id from public_user_answers where user_name='"+publicUserName+"'";
		Statement stmt=conn.createStatement();
		ResultSet rs=stmt.executeQuery(query);	
		
		while(rs.next()){
			int id=rs.getInt("id");
			
			//String updateQuery="UPDATE user_answer_table SET user_name='"+newUserName+"' where id='"+id+"'";
			//update public_user_answers table
			String updateQuery="UPDATE public_user_answers SET user_name='"+newUserName+"' where id='"+id+"'";
			Statement stmt2=conn.createStatement();
			stmt2.executeUpdate(updateQuery);
			stmt2.close();
		}
		
		String resultTableQuery="select id from result_form where user_name='"+publicUserName+"'"; 
		Statement result_stmt=conn.createStatement();
		ResultSet result_rs=result_stmt.executeQuery(resultTableQuery);
		
		
		while(result_rs.next()){
			int result_id=result_rs.getInt("id");
			String updateResultQuery="UPDATE result_form SET user_name='"+newUserName+"' where id='"+result_id+"'";
			Statement result_stmt2=conn.createStatement();
			result_stmt2.executeUpdate(updateResultQuery);
			result_stmt2.close();
		}
		stmt.close();
		result_stmt.close();
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

//get current date
//----------------------------------------------------------------
	public Date getCurrentDate(){
		
		//DateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
		DateFormat currentDate = new SimpleDateFormat("yyyy/MM/dd");
		Date date = new Date();
		String today=currentDate.format(date);
		
		
		java.sql.Date current_dateDB =null;
		try {
			Date tempDate = currentDate.parse(today);
			current_dateDB = new java.sql.Date(tempDate.getTime());
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return current_dateDB;
		
	}
//--------------------------------------------------------------
	
public int getField_maxOrderId_ByFormIdAndSegmentId(int formId,int segmentId){
		
	int fieldMax_OrderId=0;
		try{
			
			conn=dbservice.setConnection();
			Statement stmt=conn.createStatement();		
			//String query="SELECT * FROM field_form WHERE form_id='"+formId+"' AND segment_id='"+segmentId+"'";
			//select max(turn) as turn from user_answer_table where user_name='"+userName+"' and form_id='"+formId+"' and question_id='"+qId+"'";
			String query="SELECT max(orderId)as orderId FROM field_form WHERE form_id='"+formId+"' AND segment_id='"+segmentId+"'";
			ResultSet rs=stmt.executeQuery(query);			
			
			while(rs.next()){
				
				fieldMax_OrderId=rs.getInt("orderId");
					
			}
			
		}catch(SQLException e){
			e.printStackTrace();
		}
		finally{
			try {if(conn!=null)conn.close();				
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return fieldMax_OrderId;	
		
	}
	
//--------------------------------------------------------------------

public void addField(int formId,int segmentId, String question,String qType,int qOrder,String preAnswers,String correctAnswer ){
	
	try{
		
		conn=dbservice.setConnection();		
		
		String query="INSERT INTO field_form(form_id,segment_id,field_name,field_type,orderId) VALUES ('"+formId+"','"+segmentId+"','"+question+"','"+qType+"','"+qOrder+"')";
		//String query8="INSERT INTO field_form(form_id,segment_id,field_name,field_type) VALUES ('"+formId+"','"+segment_id+"','"+question+"','"+qType+"')";
		
		Statement stmt=conn.createStatement();
		stmt.executeUpdate(query);
		
		String queryQuestion="SELECT max(question_id) as question_id FROM field_form";
		Statement stmtQuestion=conn.createStatement();
		ResultSet rsQuestion=stmtQuestion.executeQuery(queryQuestion);
		int question_id=0;
		while(rsQuestion.next()){
			
			question_id=rsQuestion.getInt("question_id");
			
			//insert image
			//formId,segment_id,question_id
			
		}
		
		String queryInsert="INSERT INTO predifine_answer(question_id,field_type,pre_values,correct_answer) VALUES ('"+question_id+"','"+qType+"','"+preAnswers+"','"+correctAnswer+"')";
		Statement stmtInsert=conn.createStatement();
		stmtInsert.executeUpdate(queryInsert);
		
		//insert image
		//formId,segment_id,question_id
		FormTypeImpl formTypeImpl2=new FormTypeImpl();
		
		if(qType.equalsIgnoreCase("image")){
			formTypeImpl2.setImagePath(formId, segmentId, question_id, preAnswers);
		}
		
		
	}catch(SQLException e){
		e.printStackTrace();
	}
	
}
//--------------------------------------------------------------------
// get qid of question in specific segment by order id

public int getQIdByOrder(int formId,int segmentId,int orderId){
	
	int qid=0;
	try{
		
		conn=dbservice.setConnection();
		Statement stmt=conn.createStatement();		
		//String query="SELECT * FROM field_form WHERE form_id='"+formId+"' AND segment_id='"+segmentId+"'";
		//select max(turn) as turn from user_answer_table where user_name='"+userName+"' and form_id='"+formId+"' and question_id='"+qId+"'";
		String query="select question_id from field_form where form_id='"+formId+"' and segment_id='"+segmentId+"' and orderId='"+orderId+"'";
		ResultSet rs=stmt.executeQuery(query);			
		
		while(rs.next()){
			
			qid=rs.getInt("question_id");
				
		}
		
	}catch(SQLException e){
		e.printStackTrace();
	}
	return qid;
}
//----------------------------------------------------------------------

}
