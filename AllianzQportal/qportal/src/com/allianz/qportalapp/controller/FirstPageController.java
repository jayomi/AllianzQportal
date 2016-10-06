package com.allianz.qportalapp.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Random;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.allianz.qportalapp.listner.ServletContextListner;
import com.allianz.qportalapp.model.FormType;

//@WebServlet(name = "Foo", urlPatterns = {"/First"})
@WebServlet("/First")
public class FirstPageController extends HttpServlet {
	private static final long serialVersionUID = 1L;
    RequestDispatcher requestDispatcher=null; 
    public static String path;
   
    public FirstPageController() {
        super();
       
    }

	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		
		String referenceId = null; String publicForm_Id=null;int publicFormId=0;
				
		response.setContentType("text/html");
		PrintWriter writer=response.getWriter();
		HttpSession session = request.getSession(true);		
		ServletContext context = session.getServletContext();
		path = ServletContextListner.getApplicationContext().getRealPath("/");
		
		
		if(context.getAttribute("public_userName")!=null){
			referenceId =  context.getAttribute("public_userName").toString();
			
			
		}
		
		
		int formId=0;
		
		String form_id=request.getParameter("formId");
		if(form_id !=null && form_id!=""){
			
			formId=Integer.parseInt(form_id);
			FormAssignToUserImple formAssignToUserImple=new FormAssignToUserImple();
			int formId_public=formAssignToUserImple.countIdByFormIdAndFormAccessType(formId, "public");//returned count
			int formId_special=formAssignToUserImple.countIdByFormIdAndFormAccessType(formId, "special");
			String userName="";
			FormQuestionImpl questionImpl=new FormQuestionImpl();
			
			if(formId_public!=0){
				
				session.setAttribute("user_access_Type", "public");	//set user access type
				
				if(referenceId==null){
					
					 final String CHAR_LIST = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890";				 
					 final int RANDOM_STRING_LENGTH = 6;
					 Random randomGenerator = new Random();
					 userName=questionImpl.generateString(randomGenerator, CHAR_LIST, RANDOM_STRING_LENGTH);
					 session.setAttribute("public_userName", userName);
					 session.setAttribute("public_form_id",formId);
					 context.setAttribute("public_userName", userName);
					 context.setAttribute("public_form_id", formId);
					 
				}else if(referenceId!=null){
					
					userName = referenceId;					
					session.setAttribute("public_userName", userName);
					context.setAttribute("public_userName", userName);
					context.setAttribute("public_form_id", publicFormId);
					session.setAttribute("public_form_id", formId);
					
				}
				 
				
				FormTypeImpl formTypeImpl=new FormTypeImpl();
				FormType form= formTypeImpl.getFormByFormId(formId);
				String formName=form.getFormName();
				//String url="examPaper.jsp?selected_formName="+formName;
				String url="examPaper.jsp?formId="+formId;
				System.out.println("url: "+url);
				session.setAttribute("form_ID", form_id);
			
			
			response.sendRedirect(url);
			
			}if(formId_special!=0){
				session.setAttribute("user_access_Type", "special");				
				//requestDispatcher=request.getRequestDispatcher("login.jsp");
				//requestDispatcher.forward(request, response);
				response.sendRedirect("login.jsp");
			}
			if(formId_public==0 && formId_special==0 ){
				request.setAttribute("errorMessage", "Please enter valid Form ID.");
				requestDispatcher=request.getRequestDispatcher("firstPage.jsp");
				requestDispatcher.forward(request, response);
				//response.sendRedirect("firstPage.jsp");
				
			}
			
		}
		
	}

}
