package com.allianz.qportalapp.controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.allianz.qportalapp.listner.ServletContextListner;


@WebServlet("/LoginController")
public class LoginController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	RequestDispatcher requestDispatcher=null;  
	public static String path;
   
    public LoginController() {
        super();
       
    }

	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		HttpSession session = request.getSession(true);		
		path = ServletContextListner.getApplicationContext().getRealPath("/");		
	
		
		String userName=request.getParameter("userName");
		String password=request.getParameter("password");
		
		SHAHashingImpl hashingImpl = new SHAHashingImpl();
		String hashPassword = hashingImpl.hashingString(password);
		
		
		
		PrintWriter out = response.getWriter();
		
		ServletContext context = session.getServletContext();
		context.removeAttribute("user_access_Type");context.removeAttribute("public_userName");
		session.removeAttribute("user_access_Type");session.removeAttribute("public_userName");
		
		FormAssignToUserImple formAssignToUserImple=new FormAssignToUserImple();
		int userid=formAssignToUserImple.checkUser(userName, hashPassword);
		
		if(userid!=0){
			
			
			session.setAttribute("userName", userName);
			session.setMaxInactiveInterval(30*60);//30 minituts
			session.setAttribute("user_access_Type", "special");
			
			
			UserImpl userImpl = new UserImpl();
			String userRole = userImpl.getUserRoleByUserName(userName);
			if(userRole.equalsIgnoreCase("user")) response.sendRedirect("dashboard.jsp");
				else if(userRole.equalsIgnoreCase("modarator")) response.sendRedirect("modaratorDashboard.jsp");
				 else if(userRole.equalsIgnoreCase("admin")){ 					 
					
					 response.sendRedirect("adminDashboard.jsp");//path+"/dbconfigs/settings.xml"
					 
				 } 
			
		
		}else if(userid==0){
					
			request.setAttribute("errorMessage", "Either your user name or password is wrong. Please enter correct values.");
			
			String errorMessage="Either your user name or password is wrong. Please enter correct values.";
			response.sendRedirect("login.jsp?errorMessage="+errorMessage);
		}
		
	}

}
