package com.allianz.qportalapp.controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


@WebServlet("/QFormController")
public class FormController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	RequestDispatcher requestDispatcher=null;
  
    public FormController() {
        super();
      
    }

	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		response.setContentType("text/html");
		PrintWriter writer=response.getWriter();
		
		
		String saveForm=request.getParameter("saveForm");
	
		
		if(saveForm!=null){				
			
			FormTypeImpl formTypeImpl=new FormTypeImpl();
			formTypeImpl.addformType();	
			
			TempFormTypeImpl tempFormTypeImpl=new TempFormTypeImpl();
			tempFormTypeImpl.deleteAllTempData();
			
			requestDispatcher=request.getRequestDispatcher("selectForm.jsp");
			requestDispatcher.forward(request, response);
			
			
		}
		
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		doGet(request, response);
	}

}
