package com.allianz.qportalapp.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONException;
import org.json.JSONObject;


@WebServlet("/FormController")
public class TempFormController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	RequestDispatcher requestDispatcher=null;
       
    
    public TempFormController() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		
		
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html");
		PrintWriter writer=response.getWriter();
		
		TempFormTypeImpl formTypeImpl=new TempFormTypeImpl();
		
		int formId;	//int passMark =0;
		String formName="";
		String description="";
		String formType="";
		String formAccessType="";
		String duration="";
		String hour="", minutes="",seconds="";
		int passMark=0;
				
		String submit_formType=request.getParameter("submit_formType");
		//String nextBtn=request.getParameter("next");
		
		
		/*
		request.setAttribute("formName", formName);
		request.setAttribute("description", description);
		request.setAttribute("formType", formType);
		request.setAttribute("formAccessType", formAccessType);
		request.setAttribute("duration", duration);
		request.setAttribute("passMark", passMark);*/
		
	       
		if(submit_formType!=null){	
			
			formName=request.getParameter("formName");		
			description=request.getParameter("description");
			formType=request.getParameter("formType");
			formAccessType=request.getParameter("formAccessType");
			hour=request.getParameter("hour");
			minutes=request.getParameter("minutes");
			seconds=request.getParameter("seconds");
			duration=hour+":"+minutes+":"+seconds;
			
			ArrayList<String> departmentList = new ArrayList<String>();
			
			String departments[] = request.getParameterValues("department");
			for(String department : departments){
				departmentList.add(department);
			}
			JSONObject jobject = new JSONObject();
			
			
				try {
					
						jobject.put("department",departmentList.toString() );
					
				} catch (JSONException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
		
			
			
			String tempPassMark = request.getParameter("passMark");
			
		       if(tempPassMark!=null && tempPassMark!=""){
		    	   passMark=Integer.parseInt(tempPassMark);
		    	   
		       }else if(tempPassMark==null){
		    	   passMark=0;
		       }
		      
		     String stratDate = request.getParameter("startDate");
		     String endDate = request.getParameter("endDate");
			
			//formTypeImpl.addformType(formName, description);
			//requestDispatcher=request.getRequestDispatcher("designForm.jsp");
			//requestDispatcher.forward(request, response);
			response.sendRedirect("designForm.jsp?formName="+formName+"&description="+description+"&formType="+formType+"&formAccessType="+formAccessType+"&duration="+duration+"&passMark="+passMark+"&departments="+jobject.toString()+"&stratDate="+stratDate+"&endDate="+endDate);
		}
		
	}

}
