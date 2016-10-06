package com.allianz.qportalapp.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.Date;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.allianz.qportalapp.listner.ServletContextListner;

//public user register controller
@WebServlet("/RegisterContoller")
public class RegisterContoller extends HttpServlet {
	private static final long serialVersionUID = 1L;
   RequestDispatcher requestDispatcher;    
   public static String path; 
   
    public RegisterContoller() {
        super();
       
    }

	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
		response.setContentType("text/html");
		PrintWriter writer=response.getWriter();
		HttpSession session=request.getSession();
		path = ServletContextListner.getApplicationContext().getRealPath("/");
		
		
		FormQuestionImpl questionImpl=new FormQuestionImpl();		
		
		String public_userName=null;
		if( session.getAttribute("public_userName")!=null){    			
    			
			public_userName=session.getAttribute("public_userName").toString();			
			
		} 
		
		
		String firstName=request.getParameter("firstName");
		String lastName=request.getParameter("lastName");
		String email=request.getParameter("email");
		String department=request.getParameter("department");	
		String role = request.getParameter("role");
		
		String password1=request.getParameter("password1");
		String password2=request.getParameter("password2");
		String securityQuestion = request.getParameter("securityQuestion");
		String securityQuestionAnswer = request.getParameter("securityQuestionAnswer");
		
		Date start=null;
		Date end=null;
		String password=null;
		String hashedPassword = null;
		
		//comparing password
		if(!password1.equals(password2)){
			response.sendRedirect("register.jsp?errorMessage=Your passwords are mismatched.");
		}
		if(password1.equals(password2)){
			password = password1 = password2;
			SHAHashingImpl hasingImpl = new SHAHashingImpl();
			hashedPassword = hasingImpl.hashingString(password);
		}
		
			
		if(firstName!=null && lastName!=null && email!=null && hashedPassword!=null){
			
			UserImpl userImpl=new UserImpl();		
			//checkwhether user is already exist	
			int userId=userImpl.checkUser(email);
				
				
				if(userId==0){
					
					try {
						
						session.setAttribute("user_access_Type", "special");
						session.setAttribute("userName", email);
						userImpl.addUser(email, hashedPassword,firstName,lastName,email,department,role,securityQuestion,securityQuestionAnswer);
						
						if(public_userName!=null){
							questionImpl.changeUserName(public_userName,email);							
							FormAssignToUserImple formAssignToUserImple=new FormAssignToUserImple();
							formAssignToUserImple.changeUserName(public_userName, email);
						}
						
						response.sendRedirect("registerSucess.jsp?successMessage=You are successfully registered. Please login to continue.");
						
					} catch (SQLException e) {
						
						e.printStackTrace();
					}
					
					
				}else if(userId>0){
					
					session.setAttribute("user_access_Type", "public");
					response.sendRedirect("register.jsp?errorMessage=There are already exist a user with user name. Please enter another user name.");
				}
				
			}
			
			
		//}	
		
		
	}

}
