package com.allianz.qportalapp.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONException;
import org.json.JSONObject;

import com.allianz.qportalapp.model.Department;
import com.allianz.qportalapp.model.User;


@WebServlet("/UserController")
public class UserController extends HttpServlet {
	private static final long serialVersionUID = 1L;
    
    public UserController() {
        super();
        // TODO Auto-generated constructor stub
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		PrintWriter writer=response.getWriter();
		UserImpl userImpl = new UserImpl();
		HttpSession session = request.getSession(true);
		
		String loggedUserName=session.getAttribute("userName").toString();
		UserImpl userImple = new UserImpl();
		String loggedUserRole = userImple.getUserRoleByUserName(loggedUserName);
		//String loggedUserDepartment =  userImple.getUserDepartmentByUserName(loggedUserName);
		
		if(request.getParameter("userId")!=null){
			
			int rowIndex = Integer.parseInt(request.getParameter("userId"));
			
			User user = userImpl.getUserByIndex(rowIndex);
			String userName = user.getUserName();
			String password = user.getPassword();			
			String firstName = user.getFirstName();
			String lastName = user.getLastName();
			String email = user.getEmail();
			String role = user.getRole();
			String department = user.getDepartment();
			
			JSONObject jobject=new JSONObject();
			
			try{
				
				jobject.put("userName", userName);
				jobject.put("password", password);
				jobject.put("firstName", firstName);
				jobject.put("lastName", lastName);
				jobject.put("email", email);
				jobject.put("role", role);
				jobject.put("department", department);
				
				String json=jobject.toString();
				writer.write(json);
				
			}catch(JSONException e){
				e.printStackTrace();
			}
		}
		
		//modal_saveUserBtn clicked
		if(request.getParameter("modal_saveUserBtn")!=null){
			
			int index = Integer.parseInt(request.getParameter("modal_userId"));
			String userName = request.getParameter("modal_userName");
			String password = request.getParameter("modal_password");
			String firstName = request.getParameter("modal_firstName");
			String lastName = request.getParameter("modal_lastName");
			String role = request.getParameter("modal_role");
			String department = request.getParameter("modal_department");
			String email = request.getParameter("modal_email");
			
			//password hashing
			SHAHashingImpl hashingImpl = new SHAHashingImpl();
			String hashPassword = hashingImpl.hashingString(password);
			
			
			userImpl.updateUserByIndex(index, userName, hashPassword, firstName, lastName, email, role, department);
			
			if(loggedUserRole.equalsIgnoreCase("admin"))
				response.sendRedirect("selectUser.jsp");
				if(loggedUserRole.equalsIgnoreCase("modarator"))
					response.sendRedirect("modarator_selectUser.jsp");
		}
		
		if(request.getParameter("userRegister")!=null){
			
			String firstName=request.getParameter("firstName");
			String lastName=request.getParameter("lastName");
			String email=request.getParameter("email");
			String department=request.getParameter("department");	
			String role = request.getParameter("role");			
			String password1=request.getParameter("password1");
			String password2=request.getParameter("password2");
			String securityQuestion = request.getParameter("securityQuestion");
			String securityQuestionAnswer = request.getParameter("securityQuestionAnswer");			
			
			
			String password=null;
			String hashPassword=null;
			
			//comparing password
			if(!password1.equals(password2)){
				response.sendRedirect("register.jsp?errorMessage=Your passwords are mismatched.");
			}
			if(password1.equals(password2)){
				password = password1 = password2;
				SHAHashingImpl hashingImpl = new SHAHashingImpl();
				hashPassword = hashingImpl.hashingString(password);
			}
			
				
			if(firstName!=null && lastName!=null && email!=null && hashPassword!=null){
				
				
				//checkwhether user is already exist	
				int userId=userImpl.checkUser(email);
					
					
					if(userId==0){
						
						try {
							
							userImpl.addUser(email, hashPassword,firstName,lastName,email,department,role,securityQuestion,securityQuestionAnswer);						
							response.sendRedirect("createUser.jsp?successMessage=Successfully created user.");
							
						} catch (SQLException e) {
							
							e.printStackTrace();
						}
						
						
					}else if(userId>0){						
					
						response.sendRedirect("createUser.jsp?errorMessage=There are already exist a user with user name. Please enter another user name.");
					}
					
				}
			
		}
		
		//delete user
		
		if(request.getParameter("deleteUser")!=null){
			
			int rowIndex = Integer.parseInt(request.getParameter("deleteUser"));			
			userImpl.deleteUser(rowIndex);			
			JSONObject jobject=new JSONObject();
			
			try{
				
				if(loggedUserRole.equalsIgnoreCase("admin"))
					jobject.put("url", "selectUser.jsp");	
					if(loggedUserRole.equalsIgnoreCase("modarator"))
						jobject.put("url", "modarator_selectUser.jsp");	
				
								
				String json=jobject.toString();
				writer.write(json);				
				
				
			}catch(JSONException e){
				e.printStackTrace();
			}
			
		}
		
	}

}
