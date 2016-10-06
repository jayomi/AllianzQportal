package com.allianz.qportalapp.controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONException;
import org.json.JSONObject;

@WebServlet("/deleteQuestionController")
public class deleteQuestionController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    
    public deleteQuestionController() {
        super();
        
    }

	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		response.setContentType("text/html");
		PrintWriter writer=response.getWriter();
		
					
		int questionId=Integer.parseInt(request.getParameter("questionId"));
		
		JSONObject jobject=new JSONObject();			
		try{
			
			jobject.put("questionId", questionId);				
			String json=jobject.toString();			
			writer.write(json);
			FormQuestionImpl formQuestionImpl=new FormQuestionImpl();
			formQuestionImpl.deleteQuestionByQid(questionId);	
			
		}catch(JSONException e){
			e.printStackTrace();
		}
		
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		doGet(request, response);
	}

}
