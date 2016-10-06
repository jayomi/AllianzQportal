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

import com.allianz.qportalapp.model.FormSegment;
import com.allianz.qportalapp.model.Question;


@WebServlet("/UpdateModalController")
public class UpdateModalQuestionController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
   
    public UpdateModalQuestionController() {
        super();
        
    }

	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		//doGet(request, response);
		
		/*response.setContentType("text/html");		
		response.setCharacterEncoding("UTF-8"); */
		
		response.setContentType("application/json, charset=UTF-8");
		PrintWriter writer=response.getWriter();
		
		
		
		int qid=Integer.parseInt(request.getParameter("id"));
		
		if(qid!=0){
			
			FormQuestionImpl formQuestionImpl=new FormQuestionImpl();
			  Question question=formQuestionImpl.getFieldByQid(qid);
			
			  int qOrder=question.getQuestionOrder();
			  System.out.println("qOrder..........."+qOrder);
			  String qName=question.getQuestionName();
			  String qType=question.getQuestionType();
			  String qAnswers=question.getPreAnswers();
			  String qcorrectAnswer=question.getCorrectAnswer();
			  
			  JSONObject jobject=new JSONObject();
			  try {
				
				jobject.put("qOrder", qOrder);
				jobject.put("qName", qName);
				jobject.put("qType",qType);
				jobject.put("qAnswers", qAnswers);
				jobject.put("qcorrectAnswer",qcorrectAnswer);
				
				String json=jobject.toString();
				writer.write(json);
				
			  } catch (JSONException e) {
					
					e.printStackTrace();
				}
		}
			

		
	}

}
