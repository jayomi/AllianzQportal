package com.allianz.qportalapp.controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONException;
import org.json.JSONObject;

import com.allianz.qportalapp.controller.DepartmentImpl;
import com.allianz.qportalapp.model.Department;
import com.allianz.qportalapp.model.FormType;

@WebServlet("/DepartmentController")
public class DepartmentController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    
    public DepartmentController() {
        super();
    }

	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		PrintWriter writer=response.getWriter();
		DepartmentImpl departmentImpl = new DepartmentImpl();
		//add department when submit_department btn clicked
		if(request.getParameter("submit_department")!=null){
			String departmentName = request.getParameter("departmentName");
			String description = request.getParameter("description");
			
			
			departmentImpl.addDepartment(departmentName, description);
			response.sendRedirect("adminDashboard.jsp");
		}
		
		
		if(request.getParameter("departmentId")!=null){
			
			int rowIndex = Integer.parseInt(request.getParameter("departmentId"));
			
			Department department = departmentImpl.getDepartmentByIndex(rowIndex);
			String departmentName = department.getDepartmentName();
			String description = department.getDescription();
			
			JSONObject jobject=new JSONObject();
			
			try{
				
				jobject.put("departmentName", departmentName);
				jobject.put("description", description);
				String json=jobject.toString();
				writer.write(json);
				
			}catch(JSONException e){
				e.printStackTrace();
			}
		}
		
		if(request.getParameter("modal_saveDepartmentBtn")!=null){
			
			int index = Integer.parseInt(request.getParameter("modal_departmentId"));
			String departmentName = request.getParameter("modal_departmentName");
			String description = request.getParameter("modal_departmentDesciption");
			departmentImpl.updateDepartmentByIndex(index,departmentName,description);
			response.sendRedirect("selectDepartment.jsp");
			
		}
		//delete departmnet 
		if(request.getParameter("deleteRowId")!=null){
			
			int rowId = Integer.parseInt(request.getParameter("deleteRowId"));

			JSONObject jobject=new JSONObject();			
			try{
				
				jobject.put("rowId", rowId);				
				String json=jobject.toString();				
				writer.write(json);
				departmentImpl.deleteDepartmentByIndex(rowId);
				
				
			}catch(JSONException e){
				e.printStackTrace();
			}
			
		}

		
	}

}
