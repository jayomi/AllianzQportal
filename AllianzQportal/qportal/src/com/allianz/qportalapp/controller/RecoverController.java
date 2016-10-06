package com.allianz.qportalapp.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONException;
import org.json.JSONObject;

import com.allianz.qportalapp.listner.ServletContextListner;

@WebServlet("/Recover")
public class RecoverController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	public static String path; 
    
    public RecoverController() {
        super();
        
    }

	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		HttpSession session = request.getSession(true);	
		ServletContext context = session.getServletContext();	
		path = ServletContextListner.getApplicationContext().getRealPath("/");
		
		
		String refId =null; String nicNo = null;
		
		FormQuestionImpl formQuestionImpl = new FormQuestionImpl();
		List<String> userList=new ArrayList<String>();
		PrintWriter writer=response.getWriter();
		
		response.setContentType("application/json");
	    response.setCharacterEncoding("UTF-8");
		
		
		//-------------------------------------------------------------
		if(request.getParameter("userName")!=null){
			refId = request.getParameter("userName").toString();
			//System.out.println("refId: "+refId);
		}
		if(request.getParameter("nic")!=null){
			nicNo = request.getParameter("nic").toString();
			//System.out.println("nic: "+nicNo);
		}
		
		if(nicNo!=null && refId!=null){
			List<Integer> formList =formQuestionImpl.getFormListByUserNameAndNIC(refId, nicNo);
			if(formList.size()>0){
				
				session.setAttribute("user_access_Type","public");
				session.setAttribute("public_userName",refId);
				session.setAttribute("userName",refId);
				
				context.setAttribute("public_userName", refId);
				
				JSONObject obj = new JSONObject();
			    try {
					obj.put("nicNo", nicNo);
					 obj.put("refId", refId);
					 
					 String json = obj.toString();
					 writer.write(json);
				      
				} catch (JSONException e) {
					
					e.printStackTrace();
				}
			     
			}
		}			
		
		//-------------------------------------------------------------
		
	}
	

}
