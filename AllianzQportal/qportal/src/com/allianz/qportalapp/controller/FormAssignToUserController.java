package com.allianz.qportalapp.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Locale;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.sun.org.apache.xalan.internal.xsltc.compiler.sym;


@WebServlet("/FormAssignToUserController")
public class FormAssignToUserController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	RequestDispatcher requestDispatcher=null; 
   
    public FormAssignToUserController() {
        super();
        
    }

	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		response.setContentType("text/html");
		PrintWriter writer=response.getWriter();		
		
		
		String userName=request.getParameter("userName");		
		String formName=request.getParameter("formName");
		String accessType=request.getParameter("user_accessType");
		
		
		FormTypeImpl formTypeImpl=new FormTypeImpl();
		int formId=formTypeImpl.getFormIdByFormName(formName);		
		
		String userAccessType=accessType;
		
		FormAssignToUserImple formAssignToUserImple=new FormAssignToUserImple();
		formAssignToUserImple.addAssignFormTouser(userName, formId, userAccessType);
		//formAssignToUserImple.addAssignFormTouser(userName,formId);		
		
		//requestDispatcher=request.getRequestDispatcher("selectExam.jsp");
		//requestDispatcher.forward(request, response);		
		response.sendRedirect("selectExam.jsp");
		
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		doGet(request, response);
	}

}
