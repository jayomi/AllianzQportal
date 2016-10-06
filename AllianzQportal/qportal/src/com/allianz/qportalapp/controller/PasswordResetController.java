package com.allianz.qportalapp.controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONException;
import org.json.JSONObject;

import com.allianz.qportalapp.listner.ServletContextListner;
import com.allianz.qportalapp.model.User;


@WebServlet("/PasswordResetController")
public class PasswordResetController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	public static String path;
	
    
    public PasswordResetController() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
		
		HttpSession session = request.getSession(true);		
		path = ServletContextListner.getApplicationContext().getRealPath("/");	
		
		PrintWriter writer=response.getWriter();
		
		String userName=null;String password = null;
		UserImpl userImpl = new UserImpl();
		
	/*	if(request.getParameter("resetPasswdBtn")!=null){
			
			if(request.getParameter("userName")!=null)				
				userName = request.getParameter("userName");
			
			//chech user name
			UserImpl userImpl = new UserImpl();
			int index = userImpl.checkUser(userName);
			if(index!=0){
				//valid user
				String password1 = request.getParameter("password1");
				String password2 = request.getParameter("password2");
				
				//comparing password
				if(!password1.equals(password2)){
					response.sendRedirect("resetPassword.jsp?errorMessage=Your passwords are mismatched.");
				}
				if(password1.equals(password2)){
					password = password1 = password2;
				}
				
				if(password!=null){
					//update password
					userImpl.updateUserByIndex(index,userName,password);
					response.sendRedirect("login.jsp?successMessage=You are successfully reset password. Please login to continue.");
				}
				
				
			}else{
				
				//invalid user
				response.sendRedirect("resetPassword.jsp?errorMessage=The entered username is invalid. Please enter another user name.");
			}
		}*/
		
		try{
			
			if(request.getParameter("resetUserName")!=null){
				
				userName = request.getParameter("resetUserName");
				
				//chech user name				
				int index = userImpl.checkUser(userName);
				if(index!=0){
					
					String securityQuestion = userImpl.getSecurityQuestionByUserName(userName);
					
					try{
						JSONObject jobject=new JSONObject();
						jobject.put("securityQuestion",securityQuestion);	
						jobject.put("errorMessage","");
						String json=jobject.toString();					
						writer.write(json);
						
					}catch(JSONException e){
						e.printStackTrace();
					}
				}else{
						//invalid user
					try{
						JSONObject jobject=new JSONObject();
						jobject.put("errorMessage","The entered username is invalid. Please enter another user name.");				
						String json=jobject.toString();					
						writer.write(json);
						
					}catch(JSONException e){
						e.printStackTrace();
					}
						//response.sendRedirect("resetPassword.jsp?errorMessage=The entered username is invalid. Please enter another user name.");
					
				}
				
				
				
			}
			
			if(request.getParameter("testUserName")!=null ){
				
				userName = request.getParameter("testUserName");
				String question = request.getParameter("question");
				String userAnswer = request.getParameter("userAnswer");
				
				String answer = userImpl.getSecurityQuestionAnswerByUserName(userName);
				
				if(answer.equals(userAnswer)){
					try{
						JSONObject jobject=new JSONObject();
						jobject.put("securityQuestionAnswer",answer);				
						String json=jobject.toString();					
						writer.write(json);
						
						//sending email
						//emailHandlerImpl emailHandlerImpl = new emailHandlerImpl();
						//emailHandlerImpl.sendEmail(userName, userName);
						
					}catch(JSONException e){
						e.printStackTrace();
					}
				}else{
					JSONObject jobject=new JSONObject();
					jobject.put("msg","Invalid answer. please try again.");				
					String json=jobject.toString();					
					writer.write(json);
				}
				
			}
			
			
		if(request.getParameter("userName")!=null)	{
				
			
			userName = request.getParameter("userName");			
			String url=null;
				//valid user
				String password1 = request.getParameter("password1");
				String password2 = request.getParameter("password2");
				JSONObject jobject=new JSONObject();
				//comparing password
				if(!password1.equals(password2)){
					jobject.put("message","Your passwords are mismatched");
					url = "resetPassword.jsp";
					//jobject.put("url", "resetPassword.jsp");
					//response.sendRedirect("resetPassword.jsp?errorMessage=.");
				}
				if(password1.equals(password2)){
					password = password1 = password2;
				}
				
				if(password!=null){
					//update password
					int index = userImpl.checkUser(userName);
					userImpl.updateUserByIndex(index,userName,password);
					jobject.put("message","You are successfully reset password. Please login to continue.");
					//jobject.put("url", "login.jsp");
					url = "login.jsp";
					//response.sendRedirect("login.jsp?successMessage=You are successfully reset password. Please login to continue.");
				}
				
				jobject.put("url", url);
				String json=jobject.toString();					
				writer.write(json);
		}
		
		}catch(Exception e){
			e.printStackTrace();
		}
	}
	
}
