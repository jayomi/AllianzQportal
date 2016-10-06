package com.allianz.qportalapp.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONException;
import org.json.JSONObject;

import com.allianz.qportalapp.model.DepartmentForm;
import com.allianz.qportalapp.model.FormSegment;
import com.allianz.qportalapp.model.FormType;


@WebServlet("/UpdateModalFormContoller")
public class UpdateModalFormContoller extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
   
    public UpdateModalFormContoller() {
        super();
        
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		response.setContentType("application/json, charset=UTF-8");
		PrintWriter writer=response.getWriter();
		
		int formId=0;int rowIndex = 0;
		
		if(request.getParameter("formId")!=null){
			formId=Integer.parseInt(request.getParameter("formId"));
			
		}
		if(request.getParameter("rowIndex")!=null)
			rowIndex = Integer.parseInt(request.getParameter("rowIndex"));
		
		if(formId!=0 && rowIndex!=0){
			
			FormTypeImpl formTypeImpl=new FormTypeImpl();
			FormType form=formTypeImpl.getFormByFormId(formId);
			
			FormAssginToDepartmentImpl departmentImpl = new FormAssginToDepartmentImpl();
			DepartmentForm departmentForm = departmentImpl.getFormAssignedToDepatmentByIndex(rowIndex);
			
			String formName=form.getFormName();
			String formDescription=form.getFormDescription();
			String formAcessType = form.getFormAccessType();
			String formType = form.getFormType();
			Date start = departmentForm.getStartDate(); 
			Date end = departmentForm.getEndDate();
			String department = departmentForm.getDepartment();
			
			JSONObject jobject=new JSONObject();
			
			try{
				
				jobject.put("formName", formName);
				jobject.put("formDescription", formDescription);
				jobject.put("formType", formType);
				jobject.put("formAcessType", formAcessType);
				jobject.put("department",department);
				jobject.put("startDate",start);
				jobject.put("endDate",end);
				
				
				String json=jobject.toString();
				writer.write(json);
				
			}catch(JSONException e){
				e.printStackTrace();
			}
			
		}
		
	}

	

}
