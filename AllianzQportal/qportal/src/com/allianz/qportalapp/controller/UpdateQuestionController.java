package com.allianz.qportalapp.controller;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONArray;
import org.json.JSONException;

import com.allianz.qportalapp.model.FormSegment;
import com.allianz.qportalapp.model.Question;

@WebServlet("/UpdateController")
public class UpdateQuestionController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	RequestDispatcher requestDispatcher=null;
	private static final String SAVE_DIR = "qportal_img";
       
    
    public UpdateQuestionController() {
        super();
        
    }

	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		
	}
	

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		
		response.setContentType("text/html");
		PrintWriter writer=response.getWriter();	
		
		String updateQBtn=request.getParameter("modal_saveQuestionBtn");
		
		String addQuestionBtn=request.getParameter("modal_save_addQuestionBtn");
		
		//String arrangeQorderBtn=request.getParameter("arrangeQorder");
		//String formName=request.getAttribute("formName").toString();
		String formName=request.getParameter("formName").toString();
		FormQuestionImpl formQuestionImpl=new FormQuestionImpl();
		
		JSONArray jarray;
		
		if(updateQBtn!=null){
		
		try {
			
			String formId=request.getParameter("modal_question_formId");
			String segmentId=request.getParameter("modal_question_segmentId");
			String questionId=request.getParameter("modal_questionId");
			String questionOrder = request.getParameter("modal_questionOrder");
			String qestion=request.getParameter("modal_question");
			String questionType=request.getParameter("modal_questionType");			
			
			String answerArray="";
			
			if(!questionType.equalsIgnoreCase("image") && !questionType.equalsIgnoreCase("textFeild") && !questionType.equalsIgnoreCase("textArea") && !questionType.equalsIgnoreCase("datePicker")&&!questionType.equalsIgnoreCase("signature") ){
				String[] answerSet=request.getParameter("modal_answerSet").split("\n");
				jarray = new JSONArray(answerSet);
				answerArray=jarray.toString();
			}
		
			String correctAnswer=request.getParameter("modal_correctAnswer");
			
			int qOrder=0,qId=0;
			
			if(questionId!=null && questionId!=""){
				qId = Integer.parseInt(questionId);
			}
			
			if(questionOrder!=null && questionOrder!=""){
				 qOrder=Integer.parseInt(questionOrder);
			}	
			
			
				writer.write("formName: "+formName);
				writer.write("update save btn clicked.....");
				writer.write("qid: "+questionId);
				writer.write("qorder: "+questionOrder);
				writer.write("qname: "+qestion);
				writer.write("qtype: "+questionType);
				
				if(questionType.equalsIgnoreCase("image")){
					UpdateImageImpl updateImageImpl=new UpdateImageImpl();
					
					// gets absolute path of the web application
					 String appPath = getServletContext().getRealPath("");
					// constructs path of the directory to save uploaded file
					 String filePath = appPath + SAVE_DIR;
					
					File folder = new File( filePath+"\\"+formId+"_"+segmentId+"_"+questionId) ;
					answerArray=updateImageImpl.setImagePath(folder,formId,segmentId,questionId);
				}
				
				
				formQuestionImpl.updateFieldByFieldId(qId, qOrder,qestion, questionType, answerArray, correctAnswer);
				//requestDispatcher=request.getRequestDispatcher("viewForm.jsp?selected_formName="+formName);
				//requestDispatcher.forward(request, response);
				response.sendRedirect("update.jsp?selected_formName="+formName);
				
			
		
		} catch (JSONException e) {
			
			e.printStackTrace();
		}
		
		}//end  updateQBtn if
		
		if(addQuestionBtn!=null){
			
			try {
				
				int formId = 0,segmentId = 0;
				String fId=request.getParameter("addQuestionModal_fId");			
				String segId=request.getParameter("addQuestionModal_sid");
				if(fId!=null && segId!=null){
					formId=Integer.parseInt(fId);
					segmentId=Integer.parseInt(segId);
				}
				String question=request.getParameter("modal_addQuestion");
				
				int maxOrderId=formQuestionImpl.getField_maxOrderId_ByFormIdAndSegmentId(formId, segmentId);
				
				String questionType=request.getParameter("modal_addQuestionType");
				String preAnswer = request.getParameter("modal_addQuestion_answerSet");
				String[] answerSet;String answerArray="";
				if(preAnswer!=null){
					answerSet=preAnswer.split("\n");
					
					jarray = new JSONArray(answerSet);
					
					answerArray=jarray.toString();
				}
				
				
				String correctAnswer=request.getParameter("modal_addQuestion_correctAnswer");
				
				maxOrderId=maxOrderId+1;
				formQuestionImpl.addField(formId, segmentId, question, questionType, maxOrderId,answerArray,correctAnswer);			
				
				
				//requestDispatcher=request.getRequestDispatcher("viewForm.jsp?selected_formName="+formName);
				//requestDispatcher.forward(request, response);
				response.sendRedirect("update.jsp?selected_formName="+formName);
				
			} catch (JSONException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
		}
	}

}
