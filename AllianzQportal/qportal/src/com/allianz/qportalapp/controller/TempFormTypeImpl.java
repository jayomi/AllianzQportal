package com.allianz.qportalapp.controller;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import com.allianz.qportalapp.model.FormSegment;
import com.allianz.qportalapp.model.FormType;
import com.allianz.qportalapp.model.Question;
import com.allianz.qportalapp.model.TempForm;


public class TempFormTypeImpl {
	
	FormDBService dbservice=new FormDBService(); 
	Connection conn = null; 
	Statement stmt=null;
	
	
	public void addformType(String formName,String description,String form_type,String formAccessType,int passMark,String duration,String department){
		
		
		
		 //FormField form=new FormField(fieldID, fieldType, fieldLabel);
		 try {	
			 
			 //int formId = getFormId();
			 FormType formType=new FormType(formName,description,form_type,formAccessType,passMark,duration,department);
			 
				System.out.println("inside form service service.....");				
				conn=dbservice.setConnection();
				stmt=conn.createStatement();			
				
				//formType.setFormId();
				formType.setFormName(formName);					
				formType.setFormDescription(description);
				
				java.sql.Time formduration = java.sql.Time.valueOf(duration);
				
				String query="INSERT INTO temp_form(form_name,form_description,form_type,form_access_type,pass_mark,duration,department) VALUES ('"+formName+"','"+description+"','"+form_type+"','"+formAccessType+"','"+passMark+"','"+formduration+"','"+department+"')";
				
				stmt.execute(query);
			
				
				
			} catch (SQLException e) {
				
				e.printStackTrace();
			}
					
	 } 
	
	
	//count segment
	
	public int countSegmentRows() throws SQLException{
		 int segmentId=0;
		 
		 	conn=dbservice.setConnection();
			stmt=conn.createStatement();			
			
			String getmaxSegmentID="SELECT MAX(segment_id) FROM temp_form";				
			ResultSet maxSegmentID=stmt.executeQuery(getmaxSegmentID);
			int rowCount=0;	
			while(maxSegmentID.next()){
				//rowCount=Integer.parseInt(maxSegmentID.getString(1));
				rowCount=maxSegmentID.getInt(1);
				
			}
			/*if(rowCount==0){
				rowCount++;
			}*/
			return rowCount;				
	}

	public void addSegments(String formName,String formDescription,String form_type,String formAccessType,int passMark,String formDuration,String department,int segmentId, String segmentName,String segmentDescription){
		FormType formType=new FormType(formName, formDescription,form_type,formAccessType,passMark,formDuration,department);
		FormSegment formSegment=new FormSegment(segmentId, segmentName, segmentDescription);
		
		try {			
			
			
			conn=dbservice.setConnection();
			stmt=conn.createStatement();
			
			conn=dbservice.setConnection();
			stmt=conn.createStatement();
			
			formType.setFormName(formName);
			formType.setFormDescription(formDescription);
			formSegment.setSegmentId(segmentId);			
			formSegment.setSegmentName(segmentName);
			formSegment.setSegmentDescription(segmentDescription);
			
			String query="INSERT INTO temp_form(form_name,form_description,form_type,form_access_type,form_duration,pass_mark,department,segment_id,segment_title,segment_description) VALUES ('"+formName+"','"+formDescription+"','"+form_type+"','"+formAccessType+"','"+formDuration+"','"+passMark+"','"+department+"','"+segmentId+"','"+segmentName+"','"+segmentDescription+"')";
			stmt.execute(query);	
			
		} catch (SQLException e) {				
			e.printStackTrace();
		}
		
	}
	
	public void addQuestions(String formName,String formDescription,String formType,String formAccessType,int passMark,String formDuration,String departments,int segmentId,String name,String description,int questionId,int questionOrder,String questionName,String questionType,String preAnswers,String correctAnswer,String startDate, String endDate){
		
		
		//FormType createformType=new FormType(formName, formDescription, formType,formAccessType, passMark, formDuration);
		//int paginateNo
		FormType createformType=new FormType(formName, formDescription, formType,formAccessType, passMark, formDuration,departments);
		Question question=new Question(segmentId, questionId, questionOrder,questionName, questionType,preAnswers,correctAnswer);
		FormSegment formSegment=new FormSegment(segmentId,name,description);
		
		//date convertion
		Date start = null;java.sql.Date start_dateDB =null;
		Date end = null;java.sql.Date end_dateDB = null;					
		SimpleDateFormat sdf = new SimpleDateFormat("MM/dd/yyyy");						
		
		try {
			if(startDate !=null ){
				start = sdf.parse(startDate);
				start_dateDB = new java.sql.Date(start.getTime());
			}
			if(endDate !=null){
				end = sdf.parse(endDate);
				end_dateDB = new java.sql.Date(end.getTime());
			}
			
			conn=dbservice.setConnection();
			stmt=conn.createStatement();			
			String query ="";
			if(start_dateDB!=null && end_dateDB!=null){
				query="INSERT INTO temp_form(form_name,form_description,form_type,form_access_type,form_duration,pass_mark,department,segment_id,segment_title,segment_description,question_id,question_order,question,question_type,preAnswers,correctAnswer,exam_start_date,exam_end_date) VALUES ('"+formName+"','"+formDescription+"','"+formType+"','"+formAccessType+"','"+formDuration+"','"+passMark+"','"+departments+"','"+segmentId+"','"+name+"','"+description+"','"+questionId+"','"+questionOrder+"','"+questionName+"','"+questionType+"','"+preAnswers+"','"+correctAnswer+"','"+start_dateDB+"','"+end_dateDB+"')";
					
			}else if(start_dateDB==null || end_dateDB==null){
				query="INSERT INTO temp_form(form_name,form_description,form_type,form_access_type,form_duration,pass_mark,department,segment_id,segment_title,segment_description,question_id,question_order,question,question_type,preAnswers,correctAnswer) VALUES ('"+formName+"','"+formDescription+"','"+formType+"','"+formAccessType+"','"+formDuration+"','"+passMark+"','"+departments+"','"+segmentId+"','"+name+"','"+description+"','"+questionId+"','"+questionOrder+"','"+questionName+"','"+questionType+"','"+preAnswers+"','"+correctAnswer+"')";
			}
							
			stmt.execute(query);
			
			
		} catch (ParseException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
					
		
	}
	
	public FormType getForm(){
		
		FormType formType=new FormType();
		
		 try {				
				conn=dbservice.setConnection();
				stmt=conn.createStatement();					
				String query="SELECT DISTINCT form_name,form_description,form_type,form_access_type,form_duration,pass_mark,department FROM temp_form";
				ResultSet rs=stmt.executeQuery(query);
				
				
				while(rs.next()){
					
					//int formId=rs.getInt("form_id");					
					String formName=rs.getString("form_name");
					String formDescription=rs.getString("form_description");
					String form_Type=rs.getString("form_type");
					String form_Access_Type=rs.getString("form_access_type");					
					String formDuration=rs.getString("form_duration");
					int passMark=rs.getInt("pass_mark");
					String department = rs.getString("department");
					
					
					
					//formType.setFormName(formName);
					//formType.setFormDescription(formDescription);
					FormType formType2=new FormType(formName, formDescription,form_Type, form_Access_Type,passMark, formDuration,department);
					//tempForm=new TempForm(formName, formDescription, segmentId, segmentTitle, segmentDescription, qid, question, qType, hasPreAnswer, preAnswer);
					formType=formType2;
										
				} 
				
			} catch (SQLException e) {
				
				e.printStackTrace();
				
			}
		return formType;		
		 
	 }
	
public List<FormSegment> getSegment(){
		
		List<FormSegment> formSegmentList=new ArrayList<FormSegment>();
		TempForm tempForm = null;
		 try {				
				conn=dbservice.setConnection();
				stmt=conn.createStatement();
				int countSid=0;
				
				String query1="SELECT count(DISTINCT segment_id) FROM temp_form";
				ResultSet rs1=stmt.executeQuery(query1);
				while(rs1.next()){ countSid=rs1.getInt(1);}
				
				
				int sidArray[]=new int[countSid];
				
				String query2="SELECT DISTINCT segment_id FROM temp_form";
				ResultSet rs2=stmt.executeQuery(query2);
				
				int k=0;
				while(rs2.next()){					
						sidArray[k]=rs2.getInt(1);
						 
						k++;
					 
				}
				
				for(int i=0;i<sidArray.length;i++){System.out.println("sidArray[i]: "+sidArray[i]);}
				
				for(int i=0;i<sidArray.length;i++){
					
					String query3="SELECT DISTINCT segment_title, segment_description FROM temp_form where segment_id="+sidArray[i];
					ResultSet rs3=stmt.executeQuery(query3);
					
					while(rs3.next()){
						
						String segmentTitle=rs3.getString("segment_title");
						String segmentDescription=rs3.getString("segment_description");
						
						FormSegment formSegment=new FormSegment(sidArray[i], segmentTitle, segmentDescription);
						formSegmentList.add(formSegment);
					}
					
					
				}
					
				
			} catch (SQLException e) {
				
				e.printStackTrace();
				
			}
		return formSegmentList;		
		 
	 }

public List<Question> getQuestions(int segmentId){
	
	List<Question> questionList=new ArrayList<Question>();
	TempForm tempForm = null;
	 try {				
			conn=dbservice.setConnection();
			stmt=conn.createStatement();
		
			
			
				String query3="SELECT question_id, question_order,question, question_type,hasPreAnswer,preAnswers FROM temp_form where segment_id="+segmentId;
				ResultSet rs3=stmt.executeQuery(query3);
				
				while(rs3.next()){
					
					int questionid=rs3.getInt("question_id");
					int questionOrderId=rs3.getInt("question_order");
					String question=rs3.getString("question");
					String questionType=rs3.getString("question_type");
					String hasPreAnswer=rs3.getString("hasPreAnswer");
					String preAnswers=rs3.getString("preAnswers");
					
					//FormSegment formSegment=new FormSegment(sidArray[i], segmentTitle, segmentDescription);
					Question question2=new Question(questionid, questionOrderId,question, questionType, hasPreAnswer, preAnswers);
					questionList.add(question2);
				}
				
				
			//}
				
		} catch (SQLException e) {
			
			e.printStackTrace();
			
		}
	return questionList;		
	 
 }

public void deleteFormSegment(int segId){
	 try {				
			conn=dbservice.setConnection();
			stmt=conn.createStatement();
			
			String query="delete from temp_form where segment_id="+segId;
			stmt.executeUpdate(query);
			
			
			
	 } catch (SQLException e) {			
			e.printStackTrace();			
		}
			
}

public void deleteFormQuestion(int sid,int qId){
	 try {				
			conn=dbservice.setConnection();
			stmt=conn.createStatement();
			
			String query="delete from temp_form where segment_id="+sid+" and question_id="+qId;
			stmt.executeUpdate(query);
			
			
			
	 } catch (SQLException e) {			
			e.printStackTrace();			
		}
			
}

public void updateQuestion(int sid,int qid,String qName,String qType,String hasPredefine,String preValues){
	
	 try {				
			conn=dbservice.setConnection();
			stmt=conn.createStatement();
			
			String query="update from temp_form set question="+qName+" and question_type="+qType+" and hasPreAnswer="+hasPredefine+" and preAnswers="+preValues+" where segment_id="+sid+" and question_id="+qid;
			stmt.executeUpdate(query);
			
			
			
	 } catch (SQLException e) {			
			e.printStackTrace();			
		}
}

public void updateSegment(int sid,String segmentTitle,String segmentDescription){
	 try {				
			conn=dbservice.setConnection();
			stmt=conn.createStatement();
			
			String query="update from temp_form set segment_title="+segmentTitle+" and segment_description="+segmentDescription+" where segment_id="+sid;
			stmt.executeUpdate(query);
			
			
			
	 } catch (SQLException e) {			
			e.printStackTrace();			
	}
}

public void deleteAllTempData(){
	 try {				
			conn=dbservice.setConnection();
			stmt=conn.createStatement();
			
			String query="TRUNCATE TABLE temp_form";
			stmt.executeUpdate(query);
			
			
			
	 } catch (SQLException e) {			
			e.printStackTrace();			
	}
}


}
