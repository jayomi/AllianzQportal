package com.allianz.qportalapp.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONException;
import org.json.JSONObject;

import com.allianz.qportalapp.model.DepartmentForm;
import com.allianz.qportalapp.model.FormType;


@WebServlet("/FormAssignToDeptmntController")
public class FormAssignToDeptmntController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
   
    public FormAssignToDeptmntController() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		PrintWriter writer=response.getWriter();
		FormAssginToDepartmentImpl departmentImpl = new FormAssginToDepartmentImpl();
		 
		if(request.getParameter("assignDepartmntBtn")!=null){
			
			String formName = request.getParameter("formName");
			String department = request.getParameter("department");
			
			FormTypeImpl formTypeImpl = new FormTypeImpl();
			int formId = formTypeImpl.getFormIdByFormName(formName);			
			
			
			
			String startDate=null; String endDate=null;
			
			if(request.getParameter("startDate")!=null)
				startDate = request.getParameter("startDate");
				if(request.getParameter("endDate")!=null)
					endDate = request.getParameter("endDate");
			
				
				departmentImpl.addFormToDepartment(formId, formName, department,startDate,endDate);			
				response.sendRedirect("FormAssignToDepartment.jsp");
				
			//System.out.println("formName: "+formName);
			//System.out.println("department: "+department);
			
		}
		
		//update form assign to department 
		//
		if(request.getParameter("updatedRow")!=null){
			
			int rowIndex=Integer.parseInt(request.getParameter("updatedRow"));
			if(rowIndex!=0){
				
				DepartmentForm updateForm = departmentImpl.getFormAssignedToDepatmentByIndex(rowIndex);
				
				String formName=updateForm.getFormName();
				String department=updateForm.getDepartment();
				Date startDate = updateForm.getStartDate();
				Date endDate = updateForm.getEndDate();
				
				String start = null;
				String end = null;
				if(startDate !=null && endDate !=null){
					
					start = new SimpleDateFormat("MM/dd/yyyy").format(startDate);
				 	end = new SimpleDateFormat("MM/dd/yyyy").format(endDate);
				}
					
				
				JSONObject jobject=new JSONObject();
				
				try{
					
					jobject.put("formName", formName);
					jobject.put("department", department);
					jobject.put("startDate", start);
					jobject.put("endDate", end);
					String json=jobject.toString();
					writer.write(json);
					
				}catch(JSONException e){
					e.printStackTrace();
				}
				
			}
		}
		
		//when submit btn clicked on edit modal of list_form_departmentWise.jsp
		//
		if(request.getParameter("modal_saveUpdateDeptBtn")!=null){
			
			int row=0; String formName="";String department = "";String startDate=null;String endDate=null;
			
			if(request.getParameter("modal_rowIndex")!=null)
				row = Integer.parseInt(request.getParameter("modal_rowIndex"));
				if(request.getParameter("modal_formName")!=null)
					formName = request.getParameter("modal_formName");
					if(request.getParameter("modal_department")!=null)
						department = request.getParameter("modal_department");
						if(request.getParameter("modal_startDate")!=null)
							startDate = request.getParameter("modal_startDate");
							if(request.getParameter("modal_endDate")!=null)
								endDate = request.getParameter("modal_endDate");
						
							//date convertion
							Date start = null;java.sql.Date start_dateDB =null;
							Date end = null;java.sql.Date end_dateDB = null;					
							SimpleDateFormat sdf = new SimpleDateFormat("MM/dd/yyyy");	
							//SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
							//2016-05-10
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
							
							
				departmentImpl.updateFormAssignToDepartment(row, formName, department,start_dateDB,end_dateDB);
				response.sendRedirect("ListForms_DepartmentWise.jsp");
			
		}
		
		//delete row
		
		if(request.getParameter("deleteRow")!=null){
			
			int rowIndex=Integer.parseInt(request.getParameter("deleteRow"));
			if(rowIndex!=0){
				
				departmentImpl.deleteFormAssignedToDepatment(rowIndex);				
				
				JSONObject jobject=new JSONObject();
				
				try{
					
					jobject.put("rowIndex", rowIndex);					
					String json=jobject.toString();
					writer.write(json);
					
				}catch(JSONException e){
					e.printStackTrace();
				}
				
			}
		}
	}

}
