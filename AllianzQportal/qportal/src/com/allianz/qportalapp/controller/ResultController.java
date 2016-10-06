package com.allianz.qportalapp.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONException;
import org.json.JSONObject;

import com.allianz.qportalapp.listner.ServletContextListner;

@WebServlet("/ResultController")
public class ResultController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	public static String path; 
	
    public ResultController() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession(true);	
		
		path = ServletContextListner.getApplicationContext().getRealPath("/");
		
		
		String formId =null; String formName = null; int correctAnswers=0;	int turn=0;	
		FormQuestionImpl formQuestionImpl = new FormQuestionImpl();		
		PrintWriter writer=response.getWriter();
		
		response.setContentType("application/json");
	    response.setCharacterEncoding("UTF-8");
		
		//-------------------------------------------------------------
		if(request.getParameter("formId")!=null){
			formId = request.getParameter("formId").toString();
			//System.out.println("refId: "+refId);
		}
		if(request.getParameter("formName")!=null){
			formName = request.getParameter("formName").toString();
			//System.out.println("nic: "+nicNo);
		}
		
		if(request.getParameter("correctAnswers")!=null){
			correctAnswers = Integer.parseInt(request.getParameter("correctAnswers"));
			//System.out.println("nic: "+nicNo);
		}
		if(request.getParameter("turn")!=null){
			turn = Integer.parseInt(request.getParameter("turn"));
			//System.out.println("nic: "+nicNo);
		}
		
		
		
		JSONObject obj = new JSONObject();
			    try {
					obj.put("formId", formId);
					obj.put("formName", formName);
					obj.put("correctAnswers", correctAnswers);
					obj.put("turn", turn);
					 
					String json = obj.toString();
					writer.write(json);
				      
				} catch (JSONException e) {
					
					e.printStackTrace();
				}
			     
			
					
		
		//-------------------------------------------------------------
		
	}
	

}
