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

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;


@WebServlet("/UpdateSegmentController")
public class UpdateSegmentController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	RequestDispatcher requestDispatcher=null;
       
   
    public UpdateSegmentController() {
        super();
       
    }

	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		
		
		
	}

	


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		response.setContentType("text/html");
		PrintWriter writer=response.getWriter();
		HttpSession session = request.getSession(true);	
		String userName = session.getAttribute("userName").toString();
		UserImpl userImple = new UserImpl();
		String loggedUserRole = userImple.getUserRoleByUserName(userName);
		
		String saveSegmentBtn=request.getParameter("modal_saveSegmentBtn");
		String modal_addSegmentBtn = request.getParameter("modal_save_addSegmentBtn");
		String formName=request.getParameter("formName");
		String publishForm = request.getParameter("publishFormId");
		String unPublishForm = request.getParameter("unPublishForm");
		
		if(saveSegmentBtn!=null){
			int segmentId=0;int segmentOrder = 0;
			
			if(request.getParameter("modal_segmentId")!=null)
				segmentId=Integer.parseInt(request.getParameter("modal_segmentId"));
			
			if(request.getParameter("modal_segmentOrder")!=null)
				segmentOrder = Integer.parseInt(request.getParameter("modal_segmentOrder"));
			
			String segmentName=request.getParameter("modal_segmentName");
			String segmentDescription=request.getParameter("modal_segmentDesciption");
			
			FormSegmentImple formSegmentImple=new FormSegmentImple();
			formSegmentImple.updateSegmentBySegmentId(segmentId, segmentName, segmentDescription,segmentOrder);
			
			//requestDispatcher=request.getRequestDispatcher("viewForm.jsp?selected_formName="+formName);
			//requestDispatcher.forward(request, response);
			//response.sendRedirect("viewForm.jsp?selected_formName="+formName);
			response.sendRedirect("update.jsp?selected_formName="+formName);
		}
		
		if(modal_addSegmentBtn!=null){
			try{
				
				String fId=request.getParameter("addSegmentModal_fId");	
				int formId = 0;
				
				if(fId!=null){
					formId=Integer.parseInt(fId);
				}
				
				String segmentName=request.getParameter("addsegmentModal_name");	
				String segmentDescription=request.getParameter("addsegmentModal_description");
				
				
				
				//add segment
				FormSegmentImple formSegmentImple=new FormSegmentImple();
				
				//get max segment order id
				int maxSegmentOrderId = formSegmentImple.getMaxSegmentOrderIdByFormId(formId);
				maxSegmentOrderId = maxSegmentOrderId+1;	
				formSegmentImple.addSegment(formId, segmentName, segmentDescription,maxSegmentOrderId);
				
				// get max segment id				
				int maxSegmentId = formSegmentImple.getMaxSegmentId();
				
				FormQuestionImpl formQuestionImpl=new FormQuestionImpl();
				
				JSONArray jarray;
				
				int maxOrderId=formQuestionImpl.getField_maxOrderId_ByFormIdAndSegmentId(formId, maxSegmentId);
				
				String question=request.getParameter("modal_addQuestion");
				String questionType=request.getParameter("modal_addQuestionType");
				String preAnswers=request.getParameter("modal_addQuestion_answerSet");
				String[] answerSet;String answerArray="";
				if(preAnswers!=null){
					answerSet=preAnswers.split("\n");
					jarray = new JSONArray(answerSet);	
					answerArray=jarray.toString();
				}
				
							
				
				String correctAnswer=request.getParameter("modal_addQuestion_correctAnswer");
				//maxSegmentId=maxSegmentId+1;
				maxOrderId=maxOrderId+1;
				formQuestionImpl.addField(formId, maxSegmentId, question, questionType, maxOrderId,answerArray,correctAnswer);
				
				
				//requestDispatcher=request.getRequestDispatcher("viewForm.jsp?selected_formName="+formName);
				//requestDispatcher.forward(request, response);
				
				//response.sendRedirect("viewForm.jsp?selected_formName="+formName);
				response.sendRedirect("update.jsp?selected_formName="+formName);
				//update.jsp?selected_formName=Respiratory Disease Questionnaire
				
			}catch(Exception e){
				e.printStackTrace();
			}
		}
		
		//publish form
		
		if(publishForm!=null){
			
			FormTypeImpl formTypeImpl = new FormTypeImpl();
			
			/*if(loggedUserRole.equalsIgnoreCase("admin")){response.sendRedirect("selectForm.jsp");}
			else if(loggedUserRole.equalsIgnoreCase("modarator")){response.sendRedirect("modarator_selectForm.jsp");}
			*/
			
			JSONObject jobject=new JSONObject();
			String url=null;
			try{
				int publishFormId=Integer.parseInt(publishForm);
				formTypeImpl.publishForm(publishFormId);
				
				if(loggedUserRole.equalsIgnoreCase("admin")){
					url = "selectForm.jsp";
				}
				else if(loggedUserRole.equalsIgnoreCase("modarator")){
					url  = "modarator_selectForm.jsp";
				}
				
				url = url.replace("\"", "");
				System.out.println("url: "+url);
				jobject.put("url", url);				
				String json=jobject.toString();			
				writer.write(json);
				
				
			}catch(JSONException e){
				e.printStackTrace();
			}
			
			
		}
		
		if(unPublishForm!=null){
			
			
			FormTypeImpl formTypeImpl = new FormTypeImpl();
			
			/*if(loggedUserRole.equalsIgnoreCase("admin")){response.sendRedirect("selectForm.jsp");}
			else if(loggedUserRole.equalsIgnoreCase("modarator")){response.sendRedirect("modarator_selectForm.jsp");}*/
			
			JSONObject jobject=new JSONObject();
			String url=null;
			try{
				int unPublishFormId=Integer.parseInt(unPublishForm);
				formTypeImpl.unPublishForm(unPublishFormId);
				
				if(loggedUserRole.equalsIgnoreCase("admin")){
					url = "selectForm.jsp";
				}
				else if(loggedUserRole.equalsIgnoreCase("modarator")){
					url  = "modarator_selectForm.jsp";
				}
				
				jobject.put("url", url);				
				String json=jobject.toString();			
				writer.write(json);
				
				
			}catch(JSONException e){
				e.printStackTrace();
			}
			
			
			
		}
		
		
	}
	protected void doPut(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		PrintWriter writer=response.getWriter();
		int segmentid=Integer.parseInt(request.getParameter("segmentid"));
		writer.write(segmentid);			
		System.out.println("segmentid:"+segmentid);	
		
	}

}
