package com.allianz.qportalapp.controller;

import java.io.File;
import java.io.IOException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.ServletContext;

import org.apache.commons.io.FileUtils;

import com.allianz.qportalapp.listner.ServletContextListner;
import com.allianz.qportalapp.model.FormSegment;
import com.allianz.qportalapp.model.FormType;
import com.allianz.qportalapp.model.Question;
import com.allianz.qportalapp.model.SubmitForm;

public class FormTypeImpl {
	
	FormDBService dbservice=new FormDBService(); 
	Connection conn = null; 
	private static final String SAVE_DIR = "qportal_img";
	
	
	 public void addformType(){	
		
		 
		 String formName="";
		 String formDescription="";
		 String formType="";
		 String formAccessType="";
		 String segmentTitle="";
		 String segmentDescription="";
		 String formDuration="";
		 int passMark=0;
		 String department = "";
		 
		 try {	
			 	
				conn=dbservice.setConnection();	
				
				String query1="SELECT DISTINCT form_name,form_description,form_type,form_access_type,form_duration,pass_mark,department FROM temp_form";
				Statement stmt1=conn.createStatement();
				ResultSet rs1=stmt1.executeQuery(query1);				
				
				while(rs1.next()){					
									
					formName=rs1.getString("form_name");
					formDescription=rs1.getString("form_description");
					formType=rs1.getString("form_type");
					formAccessType=rs1.getString("form_access_type");					
					formDuration=rs1.getString("form_duration");
					passMark=rs1.getInt("pass_mark");
					department = rs1.getString("department");
					
					//insert form
					String query2="INSERT INTO main_form(form_name,form_description,form_type,form_access_type,duration,pass_mark) VALUES ('"+formName+"','"+formDescription+"','"+formType+"','"+formAccessType+"','"+formDuration+"','"+passMark+"')";
					Statement stmt2=conn.createStatement();
					stmt2.executeUpdate(query2);					
					
					
					//---Get form ID--
					String query3="SELECT max(form_id) as form_id FROM main_form";
					Statement stmt3=conn.createStatement();
					ResultSet rs3=stmt3.executeQuery(query3);
					int formId=0;
					while(rs3.next()){								
						formId=rs3.getInt("form_id");
					}
					//insert departments
					FormType form = getFormByFormId(formId);
					String formName_department=form.getFormName();
					String selectDepatments ="SELECT DISTINCT department,exam_start_date,exam_end_date from temp_form";
					Statement department_stmt=conn.createStatement();
					ResultSet rs_department=department_stmt.executeQuery(selectDepatments);
					
					while(rs_department.next()){
						
						String departments= rs_department.getString("department");
						Date start = rs_department.getDate("exam_start_date");
						Date end = rs_department.getDate("exam_end_date");
						String departmentArray[] = departments.replaceAll("\\[", "").replaceAll("\\]","").split(",");
						for(String dept : departmentArray){
							String insertDepartment = "INSERT INTO form_assign_to_department(form_id,form_name,department,exam_start_date,exam_end_date) VALUES ('"+formId+"','"+formName_department+"','"+dept+"','"+start+"','"+end+"')";
							Statement insertDepartmentStmt = conn.createStatement();
							insertDepartmentStmt.executeUpdate(insertDepartment);
						}
						
					}
							
					
					//--Get Segments---					
					String query4="SELECT DISTINCT segment_id,segment_title,segment_description FROM temp_form";
					Statement stmt4=conn.createStatement();
					ResultSet rs4=stmt4.executeQuery(query4);
					int sOrder = 1;
					while(rs4.next()){
							
						conn=dbservice.setConnection();
						
							int segid=rs4.getInt("segment_id");
							segmentTitle=rs4.getString("segment_title");
							segmentDescription=rs4.getString("segment_description");
							
							
							String query5="INSERT INTO datasegment(form_id,label,description,segment_order) VALUES ('"+formId+"','"+segmentTitle+"','"+segmentDescription+"','"+sOrder+"')";
							Statement stmt5=conn.createStatement();
							stmt5.executeUpdate(query5);
							sOrder++;
							
							//--Get last insert segment id--
							String querySeg="SELECT max(segment_id) as segment_id FROM datasegment";
							Statement stmtseg=conn.createStatement();
							ResultSet rsSeg=stmtseg.executeQuery(querySeg);
							int segment_id=0;
							while(rsSeg.next()){								
								segment_id=rsSeg.getInt("segment_id");
							}
							
							//--Get fields related to segment--
							String queryfields="select * from temp_form where segment_id='"+segid+"'";
							//System.out.println(queryfields);
							Statement stmtfields=conn.createStatement();
							ResultSet rsfields=stmtfields.executeQuery(queryfields);
							//int orderId=1;
							while(rsfields.next()){
								
								conn=dbservice.setConnection();
								
								int qOrder=0;
								String question="";
								String qType="";
								
								//String hasPreAnswer="";
								String correctAnswer="";
								String preAnswers="";
								qOrder=rsfields.getInt("question_order");
								question=rsfields.getString("question");
								qType=rsfields.getString("question_type");
								/*hasPreAnswer=rsfields.getString("hasPreAnswer");*/
								preAnswers=rsfields.getString("preAnswers");
								correctAnswer=rsfields.getString("correctAnswer");
								
								String query8="INSERT INTO field_form(form_id,segment_id,field_name,field_type,orderId) VALUES ('"+formId+"','"+segment_id+"','"+question+"','"+qType+"','"+qOrder+"')";
								//String query8="INSERT INTO field_form(form_id,segment_id,field_name,field_type) VALUES ('"+formId+"','"+segment_id+"','"+question+"','"+qType+"')";
								
								Statement stmt8=conn.createStatement();
								stmt8.executeUpdate(query8);
								
								String queryQuestion="SELECT max(question_id) as question_id FROM field_form";
								Statement stmtQuestion=conn.createStatement();
								ResultSet rsQuestion=stmtQuestion.executeQuery(queryQuestion);
								int question_id=0;
								while(rsQuestion.next()){
									
									question_id=rsQuestion.getInt("question_id");
									
									//insert image
									//formId,segment_id,question_id
									
								}
								
								String query9="INSERT INTO predifine_answer(question_id,field_type,pre_values,correct_answer) VALUES ('"+question_id+"','"+qType+"','"+preAnswers+"','"+correctAnswer+"')";
								Statement stmt6=conn.createStatement();
								stmt6.executeUpdate(query9);
								
								//insert image
								//formId,segment_id,question_id
								if(qType.equalsIgnoreCase("image")){
									setImagePath(formId, segment_id, question_id, preAnswers);
								}
																
								//orderId++;
								
							
								
							}	//end fields						
							
							
					}//end segment					
					
					
				}	
				
				//stmt1.close();
				
			} catch (SQLException e) {				
				e.printStackTrace();
				try {
					conn.close();
				} catch (SQLException e1) {
					// TODO Auto-generated catch block
					e1.printStackTrace();
				}
			}
	
					
	 } 
	 
	 //-----------------------------------------------
	 public void setImagePath(int formId,int segmentId,int questionId,String preDefineAnswers){
		 
		 //---------------------------------------
		 FormType formType=new FormType();
		 ServletContext context= formType.getContext();
		// gets absolute path of the web application
		 //String appPath = context.getRealPath("/"); //getServletContext().getRealPath("");
		 String appPath = ServletContextListner.getApplicationContext().getRealPath("/");
		 //C:\Users\jayomir\workspace\qportal6\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\qportal\app\temp_qimages
		 
		// constructs path of the directory to save uploaded file
		 String filePath = appPath + "app\\temp_qimages";
		
		 String sourcePath = appPath + "app\\qportal_img";
		 
		 //--------------------------------------------
	 
		//list sub directoty------------
		 
			File file = new File(filePath);
			
			String[] names = file.list();

			for(String name : names)
			{
			    if (new File(filePath +"\\"+ name).isDirectory())
			    {
			        System.out.println("sub directory: "+name);
			        File folder = new File(filePath+"\\"+name);
					
				
			        File source = new File(sourcePath+"\\"+formId+"_"+segmentId+"_"+questionId);
					
					source.mkdirs();
					
					try {
					    FileUtils.copyDirectory(folder, source);
					    FileUtils.deleteDirectory(folder); //delete derecroty after copy
					    break;
					} catch (IOException e) {
					    e.printStackTrace();
					}
					
					//-------end copy file----------
			    }
			}
		//----------------------------------------------------------
		 
		 //change imge path of the predefine_answer table
		 
		 String fileArray[]=preDefineAnswers.replaceAll("\\[", "").replaceAll("\\]","").replaceAll("\\s+","").split(",");
		 List<String> imageList=new ArrayList<String>();
			for(int k=0;k<fileArray.length;k++){
				System.out.println("img: "+fileArray[k]);
				String path="app\\qportal_img\\"+formId+"_"+segmentId+"_"+questionId+"\\"+fileArray[k];
				imageList.add(path);				
				
			}
			preDefineAnswers=imageList.toString();
			preDefineAnswers = preDefineAnswers.replace("\\", "/");
			
			//update predefine answer table
		try {
				
				conn=dbservice.setConnection();		
				Statement stmt=conn.createStatement();
				
				String query="UPDATE predifine_answer SET pre_values='"+preDefineAnswers+"' WHERE question_id='"+questionId+"'";
				stmt.executeUpdate(query);		
				
				stmt.close();
				
				
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
	 
	 //-----------------------------------------------
	 public List<FormType> getAllFormList(){		
			
		 	
			List<FormType> formList=new ArrayList<FormType>();
			try {
				
				conn=dbservice.setConnection();
				Statement stmt=conn.createStatement();
				//String query="select form_id,form_name,form_description,department from main_form";
				String query="SELECT * FROM main_form";
				ResultSet rs=stmt.executeQuery(query);
				
				
				while(rs.next()){
					
					int id=rs.getInt("form_id");
					String name=rs.getString("form_name");
					String description=rs.getString("form_description");
					String type=rs.getString("form_type");
					String formAccessType=rs.getString("form_access_type");
					String duration=rs.getString("duration");
					int passMark=rs.getInt("pass_mark");
					
					//FormType formType=new FormType(id,name, description,passMark,duration);
					FormType formType=new FormType(id, name, description,type,formAccessType,passMark, duration);
					
					//FormType formType=new FormType(id, name, description,department);
					formList.add(formType);					
					
				}
				
			} catch (SQLException e) {
				
				e.printStackTrace(); 
			     
			}			
			return formList;				
		
	}
	 
	 //------------------------------------------------
	 
	 public List<FormType> getPublishFormList(){		
			
		 	
			List<FormType> formList=new ArrayList<FormType>();
			try {
				
				conn=dbservice.setConnection();
				Statement stmt=conn.createStatement();
				//String query="select form_id,form_name,form_description,department from main_form";
				String query="SELECT * FROM main_form where form_publish_type='1'";
				ResultSet rs=stmt.executeQuery(query);
				
				
				while(rs.next()){
					
					int id=rs.getInt("form_id");
					String name=rs.getString("form_name");
					String description=rs.getString("form_description");
					String type=rs.getString("form_type");
					String formAccessType=rs.getString("form_access_type");
					String duration=rs.getString("duration");
					int passMark=rs.getInt("pass_mark");
					
					//FormType formType=new FormType(id,name, description,passMark,duration);
					FormType formType=new FormType(id, name, description,type,formAccessType,passMark, duration);
					
					//FormType formType=new FormType(id, name, description,department);
					formList.add(formType);					
					
				}
				
			} catch (SQLException e) {
				
				e.printStackTrace(); 
			     
			}			
			return formList;				
		
	}
//--------------------------------------------------------------------------------------	 
	 public FormType getFormByFormId(int formId){		 
			
		 int id=0;String name="";String description="";String type="";String formAccessType="";String duration="";int passMark=0;
		
			try {
				
				conn=dbservice.setConnection();
				Statement stmt=conn.createStatement();
				
				String query="SELECT * FROM main_form where form_id='"+formId+"'";
				ResultSet rs=stmt.executeQuery(query);
				while(rs.next()){
					
					id=rs.getInt("form_id");
					name=rs.getString("form_name");
					description=rs.getString("form_description");
					type=rs.getString("form_type");
					formAccessType=rs.getString("form_access_type");
					duration=rs.getString("duration");
					passMark=rs.getInt("pass_mark");
					
				}
				
			} catch (SQLException e) {
				
				e.printStackTrace();
			}
			
			FormType form=new FormType(id,name,description,type,formAccessType,passMark,duration);	
			return form;
			
	 }
	 
	 public int getFormIdByFormName(String formName){
		 int id=0;
		 try {
				
				conn=dbservice.setConnection();
				Statement stmt=conn.createStatement();
				
				String query="SELECT form_id FROM main_form where form_name='"+formName+"'";
				ResultSet rs=stmt.executeQuery(query);
				while(rs.next()){
					
					id=rs.getInt("form_id");
					
				}
				
				stmt.close();
				conn.close();
				
			} catch (SQLException e) {
				
				e.printStackTrace();
			}
		 return id;
	 }
	 
	 public String getDurationByFormName(String formName){
		 
		 String duration="";
		 try {
				
				conn=dbservice.setConnection();
				Statement stmt=conn.createStatement();
				
				String query="SELECT duration FROM main_form where form_name='"+formName+"'";
				ResultSet rs=stmt.executeQuery(query);
				while(rs.next()){
					
					duration=rs.getString("duration");
					
				}
				
				stmt.close();
				conn.close();
				
			} catch (SQLException e) {
				
				e.printStackTrace();
			}
		 return duration;
		 
	 }
	 
	 public void updateFormByFormId(int formId, String formName,String formDescription,String formAccessType,String formType){	
			
			try {
				
				conn=dbservice.setConnection();		
				Statement stmt1=conn.createStatement();
				
				String query1="UPDATE main_form SET form_name='"+formName+"' , form_description='"+formDescription+"',form_access_type='"+formAccessType+"',form_type='"+formType+"' where form_id='"+formId+"'";
				stmt1.executeUpdate(query1);		
				
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
			
		}
	 
	 public void deleteFormByFormId(int fid){
			
		 try {		
		 		conn=dbservice.setConnection();		
		 		
		 		
		 		String query1="DELETE from main_form where form_id='"+fid+"'";
		 		Statement stmt1=conn.createStatement();
		 		stmt1.executeUpdate(query1);
		 		
		 		String selectSegmentsQuery = "select segment_id from datasegment where form_id='"+fid+"'";
		 		Statement selectSegmentStmt = conn.createStatement();
		 		ResultSet segResult = selectSegmentStmt.executeQuery(selectSegmentsQuery);
		 		while(segResult.next()){
		 			int segmentId = segResult.getInt("segment_id");
		 			String deleteSegQuery = "delete from datasegment where segment_id = '"+segmentId+"'";
		 			Statement deleteSegQueryStmt=conn.createStatement();
		 			deleteSegQueryStmt.executeUpdate(deleteSegQuery);
		 		}
		 		
		 		String selectFieldQuery = "select question_id from field_form where form_id = '"+fid+"'";
		 		Statement selectFieldStmt = conn.createStatement();
		 		ResultSet fieldResult = selectFieldStmt.executeQuery(selectFieldQuery);
		 		while(fieldResult.next()){
		 			int fieldId = fieldResult.getInt("question_id");
		 			String deleteFieldQuery = "delete from field_form where question_id = '"+fieldId+"'";
		 			Statement deleteFieldStmt = conn.createStatement();
		 			deleteFieldStmt.executeUpdate(deleteFieldQuery);
		 			
		 			String deletePredefineAnswer = "delete from predifine_answer where question_id='"+fieldId+"'";
		 			Statement deletePredefineAnswerStmt = conn.createStatement();
		 			deletePredefineAnswerStmt.executeUpdate(deletePredefineAnswer);
		 				 			
		 		}		 		
		 		
		 		//stmt1.close();
		 		
		 		
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
	 
//======================================================================================================================
	// --- update colum("form_publish_type") of main form
public void publishForm(int formId){
	 try {
			
			conn=dbservice.setConnection();
			Statement stmt=conn.createStatement();
			
			String query = "update main_form set form_publish_type='1' where form_id='"+formId+"'";
			stmt.executeUpdate(query);
				
			
	 }catch (SQLException e) {
			
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

	
//======================================================================================================================
//--- un publish form -----

public void unPublishForm(int formId){
	
	 try {
			
			conn=dbservice.setConnection();
			Statement stmt=conn.createStatement();
			
			String query = "update main_form set form_publish_type='0' where form_id='"+formId+"'";
			stmt.executeUpdate(query);
			
			
	 }catch (SQLException e) {
			
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
//==================================================================================================
//get for publish type

public Boolean getFormpublishType(int formId){
	 
	 Boolean publishType=false;
	 try {
			
			conn=dbservice.setConnection();
			Statement stmt=conn.createStatement();
			
			String query="SELECT form_publish_type FROM main_form where form_id='"+formId+"'";
			ResultSet rs=stmt.executeQuery(query);
			while(rs.next()){
				
				publishType=rs.getBoolean("form_publish_type");
				
			}
			
			stmt.close();
			conn.close();
			
		} catch (SQLException e) {
			
			e.printStackTrace();
		}
	 return publishType;
	 
}

//get public user answering form List by form id and user

public SubmitForm getFormByFormIdandUser(int formId,String userName){		 
	
	 int id=0;String name="";String description="";String type="";String formAccessType="";String duration="";int passMark=0;
	 Date doneDate=null; String doneTime=null;  int turn=0;
		try {
			
			conn=dbservice.setConnection();
			Statement stmt=conn.createStatement();
			
			String query="SELECT b.*,a.* FROM (select * from public_user_answers where form_id = '"+formId+"' and user_name='"+userName+"') a, main_form b WHERE a.form_id = b.form_id";
			ResultSet rs=stmt.executeQuery(query);
			while(rs.next()){
				
				id=rs.getInt("form_id");
				name=rs.getString("form_name");				
				description=rs.getString("form_description");
				type=rs.getString("form_type");
				formAccessType=rs.getString("form_access_type");
				duration=rs.getString("duration");
				passMark=rs.getInt("pass_mark");
				doneDate = rs.getDate("done_date");
				doneTime = rs.getString("time");
				turn = rs.getInt("turn");
				
				
			}
			
		} catch (SQLException e) {
			
			e.printStackTrace();
		}
		
		SubmitForm form=new SubmitForm(formId, name, description, type, turn, doneDate, doneTime);
		return form;
		
}
//--------------------------------------------------------------------------------------


}
