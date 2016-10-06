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

import com.allianz.qportalapp.model.Department;
import com.allianz.qportalapp.model.DepartmentForm;
import com.allianz.qportalapp.model.FormType;

public class FormAssginToDepartmentImpl {
	
	FormDBService dbservice=new FormDBService(); 
	Connection conn = null;
	
	public void addFormToDepartment(int formId,String formName,String department,String startDate,String endDate){
	
		try {	
		 	
			conn=dbservice.setConnection();	
			
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
				
			} catch (ParseException e) {
				e.printStackTrace();
			}
		
			
			
			String selectQuery = "select id from form_assign_to_department where form_id='"+formId+"' and department='"+department+"'";
			Statement selectStmt=conn.createStatement();
			ResultSet rs = selectStmt.executeQuery(selectQuery);
			int index = 0;
			while(rs.next()){
				index = rs.getInt("id");
			}
			if(index == 0){
				//insert
				String query ="";
				if(start_dateDB !=null && end_dateDB!=null)
				query="INSERT INTO form_assign_to_department(form_id,form_name,department,exam_start_date,exam_end_date) VALUES ('"+formId+"','"+formName+"','"+department+"','"+start_dateDB+"','"+end_dateDB+"')";			
				
				if(start_dateDB==null || end_dateDB==null )
					query="INSERT INTO form_assign_to_department(form_id,form_name,department) VALUES ('"+formId+"','"+formName+"','"+department+"')";
				
				
				Statement stmt=conn.createStatement();
				stmt.executeUpdate(query);	
			}
			else if(index !=0){
				//update
				String updateQuery = "update form_assign_to_department set department='"+department+"',exam_start_date='"+start_dateDB+"',exam_end_date='"+end_dateDB+"' where id='"+index+"'";
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
	
	public void deleteFormAssignedToDepatment(int index){
		
		try {	
		 	
			conn=dbservice.setConnection();	
			
				//delete
				String deleteQuery = "delete from form_assign_to_department where id = '"+index+"'";
				Statement deleteStmt=conn.createStatement();
				deleteStmt.executeUpdate(deleteQuery);
			
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
	
	public List<DepartmentForm> getFormsAssignedToDepatment(){
		
		List<DepartmentForm> formList = new ArrayList<DepartmentForm>();
		try {	
		 	
			conn=dbservice.setConnection();	
			
			String selectQuery = "select * from form_assign_to_department";
			Statement selectStmt=conn.createStatement();
			ResultSet rs = selectStmt.executeQuery(selectQuery);
			
			while(rs.next()){
				int id = rs.getInt("id");
				int formId = rs.getInt("form_id");
				String formName = rs.getString("form_name");
				String department = rs.getString("department");
				Date startDate = rs.getDate("exam_start_date");
				Date endDate = rs.getDate("exam_end_date");
				
				DepartmentForm departmentForm = new DepartmentForm(id,formId, formName, department,startDate,endDate);
				formList.add(departmentForm);
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
		return formList;
		

	}
	
	//-------------------------------------------------------------
	
public DepartmentForm getFormAssignedToDepatmentByIndex(int index){
		
	
	int formId =0; String formName = ""; String department=""; Date start=null; Date end=null;
		
		try {	
		 	
			conn=dbservice.setConnection();	
			
			String selectQuery = "select * from form_assign_to_department where id='"+index+"'";
			Statement selectStmt=conn.createStatement();
			ResultSet rs = selectStmt.executeQuery(selectQuery);
			
			while(rs.next()){
				
				formId = rs.getInt("form_id");
				formName = rs.getString("form_name");
				department = rs.getString("department");		
				start = rs.getDate("exam_start_date");
				end = rs.getDate("exam_end_date");
				
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
		DepartmentForm departmentForm = new DepartmentForm(index, formId, formName, department,start,end);
		return departmentForm;
		

	}

// update form Assign to department

	public void updateFormAssignToDepartment(int rowIndex,String formName,String department,Date startDate,Date endDate){
		
		
		
		try {	
		 	
			conn=dbservice.setConnection();	
			String updateQuery="";
			
			System.out.println("rowIndex: "+ rowIndex);
			System.out.println("department: "+ department);
			
			
			//update
			if(startDate!=null && endDate!=null){
				updateQuery = "update form_assign_to_department set form_name='"+formName+"' , department='"+department+"', exam_start_date='"+startDate+"',exam_end_date='"+endDate+"' where id='"+rowIndex+"'";
			}else{
				updateQuery = "update form_assign_to_department set form_name='"+formName+"' , department='"+department+"' where id='"+rowIndex+"'";
				
			}
			
				 
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
	
	//---------------------------------------------------------------------------------
	
	public List<DepartmentForm> getFormsAssignedToDepatmentByDepartmentName(String departmentName){
		
		List<DepartmentForm> formList = new ArrayList<DepartmentForm>();
		try {	
		 	
			conn=dbservice.setConnection();	
			
			String selectQuery = "select * from form_assign_to_department where department='"+departmentName+"'";
			Statement selectStmt=conn.createStatement();
			ResultSet rs = selectStmt.executeQuery(selectQuery);
			
			while(rs.next()){
				int id = rs.getInt("id");
				int formId = rs.getInt("form_id");
				String formName = rs.getString("form_name");
				String department = rs.getString("department");
				Date start = rs.getDate("exam_start_date");
				Date end = rs.getDate("exam_end_date");
				
				DepartmentForm departmentForm = new DepartmentForm(id,formId, formName, department,start,end);
				formList.add(departmentForm);
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
		return formList;
		

	}
	//---------------------------------------------------------------------------------------------
	 public List<FormType> getAllFormListByDepartment(String depatment){		
			
		 	
			List<FormType> formList=new ArrayList<FormType>();
			try {
				
				conn=dbservice.setConnection();
				Statement stmt=conn.createStatement();
				//String query="select form_id,form_name,form_description,department from main_form";
				String query="SELECT b.*,a.id,a.exam_start_date, a.exam_end_date FROM (select id,form_id,exam_start_date,exam_end_date from form_assign_to_department where department = '"+depatment+"') a, main_form b WHERE a.form_id = b.form_id";
				ResultSet rs=stmt.executeQuery(query);
				
				
				while(rs.next()){
					
					int id=rs.getInt("form_id");
					String name=rs.getString("form_name");
					String description=rs.getString("form_description");
					String type=rs.getString("form_type");
					String formAccessType=rs.getString("form_access_type");
					String duration=rs.getString("duration");
					int passMark=rs.getInt("pass_mark");
					int deptRowIndex = rs.getInt("id");
					Date start = rs.getDate("exam_start_date");
					Date end = rs.getDate("exam_end_date");
					
					//FormType formType=new FormType(id,name, description,passMark,duration);
					FormType formType=new FormType(id, name, description,type,formAccessType,passMark, duration,deptRowIndex,start,end);
					
					//FormType formType=new FormType(id, name, description,department);
					formList.add(formType);					
					
				}
				
			} catch (SQLException e) {
				
				e.printStackTrace(); 
			     
			}			
			return formList;				
		
	}
	//---------------------------------------------------------------------------------------------
	// get form strated date
	 public Date getStartDateByFormIdAndDepartment(int formId,String department){
			Date startDate=null;
			try {	
			 	
				conn=dbservice.setConnection();			
				
				String query="SELECT exam_start_date from form_assign_to_department where form_id='"+formId+"' and department='"+department+"'";			
				Statement stmt=conn.createStatement();				
				ResultSet rs=stmt.executeQuery(query);
				
				while(rs.next()){					
					startDate=rs.getDate("exam_start_date");					
				}
				
				stmt.close();
				conn.close();
				
				}catch (SQLException e) {				
					e.printStackTrace();
					
				}
			return startDate;
			
		}
	//---------------------------------------------------------------------------------------------
	// get exam end date
		public Date getEndDateByFormIdAndDepartment(int formId,String department) throws SQLException{
			
			Date endDate=null;
			try {	
			 	
				conn=dbservice.setConnection();			
				
				String query="SELECT exam_end_date from form_assign_to_department where form_id='"+formId+"' and department='"+department+"'";			
				Statement stmt=conn.createStatement();				
				ResultSet rs=stmt.executeQuery(query);
				
				while(rs.next()){
					
					endDate=rs.getDate("exam_end_date");
					
				}
				
				stmt.close();
				
				
				}catch (SQLException e) {				
					e.printStackTrace();
					
				}finally{
					conn.close();
				}
			return endDate;
			
		}
	 //----------------------------------------------------------------------------------------------
		
public List<FormType> getAllFormList(){		
			
		 	
			List<FormType> formList=new ArrayList<FormType>();
			try {
				
				conn=dbservice.setConnection();
				Statement stmt=conn.createStatement();
				//String query="select form_id,form_name,form_description,department from main_form";
				String query="SELECT b.*,a.* FROM (select * from form_assign_to_department) a, main_form b WHERE a.form_id = b.form_id";
				ResultSet rs=stmt.executeQuery(query);
				
				
				while(rs.next()){
					
					int id=rs.getInt("form_id");
					String name=rs.getString("form_name");
					String description=rs.getString("form_description");
					String type=rs.getString("form_type");
					String formAccessType=rs.getString("form_access_type");
					String duration=rs.getString("duration");
					int passMark=rs.getInt("pass_mark");
					int deptRowIndex = rs.getInt("id");
					String department = rs.getString("department");
					Date start = rs.getDate("exam_start_date");
					Date end = rs.getDate("exam_end_date");
					
					//FormType formType=new FormType(id,name, description,passMark,duration);
					FormType formType=new FormType(id, name, description,type,formAccessType,passMark, duration,deptRowIndex,department,start,end);
					
					//FormType formType=new FormType(id, name, description,department);
					formList.add(formType);					
					
				}
				
			} catch (SQLException e) {
				
				e.printStackTrace(); 
			     
			}			
			return formList;				
		
	}
//--------------------------------------------------------------------------------------------------------

}
