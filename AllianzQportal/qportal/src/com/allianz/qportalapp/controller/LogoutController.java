package com.allianz.qportalapp.controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class LogoutController
 */
@WebServlet("/LogoutController")
public class LogoutController extends HttpServlet {
	private static final long serialVersionUID = 1L;
    RequestDispatcher requestDispatcher=null;  
    
    public LogoutController() {
        super();
       
    }

	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		response.setContentType("text/html");
		PrintWriter out = response.getWriter();
		//System.out.println("thanq you!!, Your session was destroyed successfully!!");
		HttpSession session = request.getSession(false);
		 if (session != null) 
		    {
			 session.invalidate();
			
		    }
		//request.getSession().invalidate();
		
		
		//requestDispatcher=request.getRequestDispatcher("firstPage.jsp");
		//requestDispatcher.forward(request, response);
		 response.sendRedirect("firstPage.jsp");
		
	}

}
