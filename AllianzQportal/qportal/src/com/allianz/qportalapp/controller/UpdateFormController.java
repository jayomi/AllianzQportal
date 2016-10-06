package com.allianz.qportalapp.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


@WebServlet("/UpdateFormController")
public class UpdateFormController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	RequestDispatcher requestDispatcher=null;
    
    public UpdateFormController() {
        super();        
    }

	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		//doPost(request,response);
		//requestDispatcher=request.getRequestDispatcher("/"+"selectForm.jsp");
		//requestDispatcher.forward(request, response);
		
		
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		response.setContentType("text/html");
		PrintWriter writer=response.getWriter();
		HttpSession session=request.getSession(true);
		
		String formName=null;String formDescription=null;int formId=0;String formAccessType=null;		
		int rowIndex=0;	String startDate=null; String endDate=null; String department=null;String formType=null;
	
		if(request.getParameter("modal_saveFormBtn")!=null){
			
			if(request.getParameter("modal_formName")!=null)
				formName = request.getParameter("modal_formName");
				
			if(request.getParameter("modal_formDesciption")!=null)
				formDescription = request.getParameter("modal_formDesciption");
			
			if(request.getParameter("modal_formId")!=null)
				formId=Integer.parseInt(request.getParameter("modal_formId"));
			//modal_rowIndex
			if(request.getParameter("modal_rowIndex")!=null)
				rowIndex=Integer.parseInt(request.getParameter("modal_rowIndex"));
			//modal_formAccessType
			
			if(request.getParameter("modal_formAccessType")!=null)
				formAccessType = request.getParameter("modal_formAccessType");
			
			if(request.getParameter("modal_formType")!=null)
				formType = request.getParameter("modal_formType");
			//
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
				if(startDate !=null && !startDate.isEmpty() ){
					start = sdf.parse(startDate);
					start_dateDB = new java.sql.Date(start.getTime());
				}
				if(endDate !=null && !endDate.isEmpty()){
					end = sdf.parse(endDate);
					end_dateDB = new java.sql.Date(end.getTime());
				}
				
			} catch (ParseException e) {
				e.printStackTrace();
			}
			
			
			
			FormTypeImpl formTypeImpl=new FormTypeImpl();
			formTypeImpl.updateFormByFormId(formId, formName, formDescription,formAccessType,formType);
			
			FormAssginToDepartmentImpl departmentImpl = new FormAssginToDepartmentImpl();
			departmentImpl.updateFormAssignToDepartment(rowIndex, formName, department, start_dateDB, end_dateDB);
			
			String loggedUserName=session.getAttribute("userName").toString();
			UserImpl userImple = new UserImpl();
			String loggedUserRole = userImple.getUserRoleByUserName(loggedUserName);
			if(loggedUserRole.equalsIgnoreCase("admin")){
				response.sendRedirect("selectForm.jsp");
			}else if(loggedUserRole.equalsIgnoreCase("modarator")){
				response.sendRedirect("modarator_selectForm.jsp");
			}
			
			
			//requestDispatcher=request.getRequestDispatcher("selectForm.jsp");
			//requestDispatcher.forward(request, response);
			
		}
		
	}

}
