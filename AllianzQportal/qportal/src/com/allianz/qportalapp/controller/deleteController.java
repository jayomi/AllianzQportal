package com.allianz.qportalapp.controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONException;
import org.json.JSONObject;

import com.allianz.qportalapp.model.FormSegment;


@WebServlet("/deleteController")
public class deleteController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	RequestDispatcher requestDispatcher=null;
	
    public deleteController() {
        super();
      
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		response.setContentType("text/html");
		PrintWriter writer=response.getWriter();
		System.out.println("inside delete method.......");	
		String segId=request.getParameter("segmentid");
		if(segId!=null && segId!=""){
			
			int segmentId=Integer.parseInt(request.getParameter("segmentid"));
			
			JSONObject jobject=new JSONObject();			
			try{
				
				jobject.put("segmentId", segmentId);				
				String json=jobject.toString();				
				writer.write(json);
				FormSegmentImple formSegmentImple=new FormSegmentImple();
				formSegmentImple.deleteSegmentBysegmentId(segmentId);
				
			}catch(JSONException e){
				e.printStackTrace();
			}
			
		}
		
		String formId=request.getParameter("formId");
		if(formId!=null && formId!=""){
			int form_id=Integer.parseInt(request.getParameter("formId"));
			int row_index=Integer.parseInt(request.getParameter("rowIndex"));
			
			JSONObject jobject=new JSONObject();			
			try{
				
				jobject.put("formId", form_id);				
				String json=jobject.toString();				
				writer.write(json);
				
				//delete from main form
				FormTypeImpl formTypeImpl=new FormTypeImpl();
				formTypeImpl.deleteFormByFormId(form_id);	
				
				//delete from form assign to department
				FormAssginToDepartmentImpl departmentImpl = new FormAssginToDepartmentImpl();
				departmentImpl.deleteFormAssignedToDepatment(row_index);
				
			}catch(JSONException e){
				e.printStackTrace();
			}
			
			
		}
		
		
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		doGet(request, response);		
		
		
	}

}
