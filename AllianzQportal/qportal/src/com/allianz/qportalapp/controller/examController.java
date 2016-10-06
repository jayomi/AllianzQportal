package com.allianz.qportalapp.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Date;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.List;
import java.util.Random;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.websocket.Session;

import org.json.JSONException;
import org.json.JSONObject;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.parser.Parser;
import org.jsoup.select.Elements;
import org.jsoup.select.Evaluator.IsEmpty;

@WebServlet("/examController")
public class examController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	RequestDispatcher requestDispatcher=null;
	
    public examController() {
        super();
       
    }

	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
			try{
				
				response.setContentType("text/html");
				PrintWriter writer=response.getWriter();
				
				HttpSession session=request.getSession();
				ServletContext context = session.getServletContext();
				
				FormQuestionImpl questionImpl=new FormQuestionImpl();
				
				
				String user_access_Type=session.getAttribute("user_access_Type").toString();
				
				String userName="";
				int turn=0;	
				

				String submitExam=request.getParameter("submit_exam");
				String saveAndUpdateExam=request.getParameter("save_and_update");
				int formId=Integer.parseInt(request.getParameter("formId"));
				String formName=request.getParameter("formName");
				
				
				String answeringQid=request.getParameter("qidList");		
				
				String[] answeringQidArray=answeringQid.replaceAll("\\[|\\]", "").replaceAll("\\s","").split(",");
				
				int[] intQid=new int[answeringQidArray.length];
				
				for(int i=0;i<answeringQidArray.length;i++){			
					intQid[i]=Integer.parseInt(answeringQidArray[i]);			
				}		
				
				
				if(user_access_Type.equalsIgnoreCase("public")){			
					userName = context.getAttribute("public_userName").toString();			
					
				}
				else if(user_access_Type.equalsIgnoreCase("special")){
					
					userName = session.getAttribute("userName").toString();			
				}			
					
				
				//check submited Exam
				if(submitExam!=null || saveAndUpdateExam!=null){					
					
					for(int i=0;i<intQid.length;i++){						   
						
						String textFieldValue=request.getParameter("textFieldValues"+intQid[i]);			
						String radioButtonValue=request.getParameter("radioBtn"+intQid[i]);					
						String dropDownListValue=request.getParameter("dropDownList"+intQid[i]);
						//String checkBoxBtnValue=request.getParameter("checkBoxBtn"+intQid[i]);
						String checkBoxBtnValues[] = request.getParameterValues("checkBoxBtn"+intQid[i]);
						ArrayList<String> checkBoxValueList = new ArrayList<String>();
						String checkBoxBtnValue=null;
						if(checkBoxBtnValues!=null){
							
							for(String value : checkBoxBtnValues){
								checkBoxValueList.add(value);
							}
							 
							checkBoxBtnValue = checkBoxValueList.toString();			
						}
						
						
						String textAreaValue=request.getParameter("textArea"+intQid[i]);
						String sigImage=request.getParameter("sigImage"+intQid[i]);
						//================================================================================================
						
						String answer="";			
						int q_id=intQid[i];
						
						if((textFieldValue)!=null){
							
							answer=textFieldValue;
							turn=questionImpl.addUserGivenAnswer(user_access_Type,userName,formId, q_id, answer);
							
						}else if(radioButtonValue!=null){
							
							answer=radioButtonValue;
							turn=questionImpl.addUserGivenAnswer(user_access_Type,userName,formId, q_id, answer);
							
						}else if(dropDownListValue!=null){
							
							answer=dropDownListValue;
							turn=questionImpl.addUserGivenAnswer(user_access_Type,userName,formId, q_id, answer);
							
							
						}else if(checkBoxBtnValue!=null){
							
							answer=checkBoxBtnValue;
							turn=questionImpl.addUserGivenAnswer(user_access_Type,userName,formId, q_id, answer);
							
							
						}else if(textAreaValue!=null){ 
							
							answer=textAreaValue;
							turn=questionImpl.addUserGivenAnswer(user_access_Type,userName,formId, q_id, answer);	
							
						}else if(sigImage !=null){
							
							answer=sigImage;
							ManageUserSignatureImpl manageSignature = new ManageUserSignatureImpl();
							turn=manageSignature.addUserSignature(user_access_Type, userName, formId, q_id, answer);
							
							
						}else{//if table
							
							
							
							String predefineAnswerHtml=questionImpl.getPredefineAnswerByQId(q_id);
							Document doc = Jsoup.parse(predefineAnswerHtml);
							Elements tableElements = doc.select("table");				
							
							Elements tableRowElements = tableElements.select("tr");
							int count=0;
							 Elements table= tableElements.select("table");
								for(int a=0;a<table.size();a++){
								  Element row = table.get(a);						 
								  String table_Id= row.attr("id");	
								  
								  //========== Stating FNA form tables ================================
								  //client info
								  
									if(table_Id.equalsIgnoreCase("clientinfo")){
										for (int tr = 0; tr < tableRowElements.size(); tr++) {
											 
											 Element r = tableRowElements.get(tr);
											 Elements inputElements = r.getElementsByTag("input");
											 List<String> paramList = new ArrayList<String>();
												for (Element inputElement : inputElements) {
													
													String value = inputElement.attr("value");
													String temp=request.getParameter("clientinfo_"+count);
													if(temp!=null){
														inputElement.attr("value", temp);
													}else{
														inputElement.attr("value", value);
													}											
												
													count++;
												}
												 
										 }								
										count=0;
										
										answer = doc.getElementsByTag("table").toString();
										//answer=doc.toString();
										//answer=doc.body().toString();
										
										
										answer=answer.replace("'", "\\'").replaceAll("\n ", "");
										turn=questionImpl.addUserGivenAnswer(user_access_Type,userName,formId, q_id, answer);
										
									}
								  //=========================================
										//children info
									if(table_Id.equalsIgnoreCase("childrenInfo")){
										for (int tr = 0; tr < tableRowElements.size(); tr++) {
											 
											 Element r = tableRowElements.get(tr);
											 Elements inputElements = r.getElementsByTag("input");
											 List<String> paramList = new ArrayList<String>();
												for (Element inputElement : inputElements) {
													
													String value = inputElement.attr("value");											
													String temp=request.getParameter("childrenInfo"+count);
													if(temp!=null){
														inputElement.attr("value", temp);
													}else{
														inputElement.attr("value", value);
													}
													
													count++;
												}
												 
										 }								
										count=0;	
										
										//answer=doc.toString();
										answer = doc.getElementsByTag("table").toString();
										answer=answer.replace("'", "\\'").replaceAll("\n ", "");
										turn=questionImpl.addUserGivenAnswer(user_access_Type,userName,formId, q_id, answer);
										
										
									}
									
									//======================================================================
									
									
									if(table_Id.equalsIgnoreCase("insuranceInfo")){
										for (int tr = 0; tr < tableRowElements.size(); tr++) {
											 
											 Element r = tableRowElements.get(tr);
											 Elements inputElements = r.getElementsByTag("input");
											 List<String> paramList = new ArrayList<String>();
												for (Element inputElement : inputElements) {
													
													String value = inputElement.attr("value");					
													
													String temp=request.getParameter("insuranceInfo"+count);
													if(temp!=null){
														inputElement.attr("value", temp);
													}else{
														inputElement.attr("value", value);
													}
													
													count++;
												}
												 
										 }								
										count=0;	
										
										answer = doc.getElementsByTag("table").toString();
										//answer=doc.toString();
										answer=answer.replace("'", "\\'").replaceAll("\n ", "");
										turn=questionImpl.addUserGivenAnswer(user_access_Type,userName,formId, q_id, answer);
										
										
									}
									//============================================================================
									
									if(table_Id.equalsIgnoreCase("asset")){
										/*int sumClientA=0;int sumClientB=0;*/
										Double sumClientA=0.00;Double sumClientB=0.00;
										for (int tr = 0; tr < tableRowElements.size(); tr++) {
											 
											 Element r = tableRowElements.get(tr);
											 Elements inputElements = r.getElementsByTag("input");
											 List<String> paramList = new ArrayList<String>();
											
												for (Element inputElement : inputElements) {
													
													String value = inputElement.attr("value");					
													String name = inputElement.attr("name");										
													
													String clientValue=request.getParameter("client_"+count);										
													
													if(clientValue!=null){
														
														inputElement.attr("value", clientValue);	
														
													}else{
														inputElement.attr("value", "0.0");
														clientValue="";
													}
													
													if( count % 2 == 0 && !clientValue.isEmpty() ){
														//int clientA_Value=Integer.parseInt(clientValue);
														Double clientA_Value=Double.parseDouble(clientValue);
														sumClientA=sumClientA+clientA_Value;
													}else if( count % 2 != 0 && !clientValue.isEmpty()){
														Double clientB_Value=Double.parseDouble(clientValue);
														sumClientB=sumClientB+clientB_Value;
													}
													
													 //Integer.toString(sumClientA);
													String totala = inputElement.attr("totalA");
													String totalb = inputElement.attr("totalB");
													
													if( totala!=null && totala!="" ){
														
														inputElement.attr("value",Double.toString(sumClientA));
													}
													
													if( totalb!=null && totalb!="" ){
														
														inputElement.attr("value",Double.toString(sumClientB));
													}
													
													count++;
												}
												 
										 }								
										count=0;	
										request.setAttribute("sumClientA", sumClientA);
										request.setAttribute("sumClientB", sumClientB);
										
										answer = doc.getElementsByTag("table").toString();
										//answer=doc.toString();
										answer=answer.replace("'", "\\'").replaceAll("\n ", "");
										turn=questionImpl.addUserGivenAnswer(user_access_Type,userName,formId, q_id, answer);
										
									}						
									
									//...............................................................................
									
									
									if(table_Id.equalsIgnoreCase("liabilities")){
										//int sumClientA=0;int sumClientB=0;
										Double sumClientA=0.00;Double sumClientB=0.00;
										
										for (int tr = 0; tr < tableRowElements.size(); tr++) {
											 
											 Element r = tableRowElements.get(tr);
											 Elements inputElements = r.getElementsByTag("input");
											 List<String> paramList = new ArrayList<String>();
												for (Element inputElement : inputElements) {								
													
													String clientValue=request.getParameter("liability_"+count);										
													
													if(clientValue!=null){
														inputElement.attr("value", clientValue);
													}else{
														clientValue="";
														inputElement.attr("value", "0.0");
													}										
													
													if( count % 2 == 0 && !clientValue.isEmpty() ){
														Double clientA_Value=Double.parseDouble(clientValue);
														sumClientA=sumClientA+clientA_Value;
													}else if( count % 2 != 0 && !clientValue.isEmpty()){
														Double clientB_Value=Double.parseDouble(clientValue);
														sumClientB=sumClientB+clientB_Value;
													}											
													
													String totala = inputElement.attr("totalA");
													String totalb = inputElement.attr("totalB");
													
													if( totala!=null && totala!="" ){
														
														inputElement.attr("value",Double.toString(sumClientA));
													}
													
													if( totalb!=null && totalb!="" ){
														
														inputElement.attr("value",Double.toString(sumClientB));
													}
													
													count++;
												}
												 
										 }								
										count=0;	
										
										//answer=doc.toString();
										answer = doc.getElementsByTag("table").toString();
										answer=answer.replace("'", "\\'").replaceAll("\n ", "");
										turn=questionImpl.addUserGivenAnswer(user_access_Type,userName,formId, q_id, answer);
										
									}					
									//================================================================================
										//-----------------cash needs-------------------------------------------------
									
									if(table_Id.equalsIgnoreCase("cashNeeds")){
										Double sumClientA=0.00;//you
										Double sumClientB=0.00;//spouse
										for (int tr = 0; tr < tableRowElements.size(); tr++) {
											 
											 Element r = tableRowElements.get(tr);
											 Elements inputElements = r.getElementsByTag("input");
											 List<String> paramList = new ArrayList<String>();
											
												for (Element inputElement : inputElements) {
													
													String value = inputElement.attr("value");					
													String name = inputElement.attr("name");										
													
													String clientValue=request.getParameter("cashNeeds_"+count);										
													
													if(clientValue!=null){
														
														inputElement.attr("value", clientValue);	
														
													}else{
														clientValue="";
														inputElement.attr("value", "0.0");	
													}
													
													if( count % 2 == 0 && !clientValue.isEmpty()  ){
														Double clientA_Value=Double.parseDouble(clientValue);
														sumClientA=sumClientA+clientA_Value;
													}else if( count % 2 != 0 && !clientValue.isEmpty()){
														Double clientB_Value=Double.parseDouble(clientValue);
														sumClientB=sumClientB+clientB_Value;
													}
													
													 //Integer.toString(sumClientA);
													String totala = inputElement.attr("cashNeedsTotalA");
													String totalb = inputElement.attr("cashNeedsTotalB");
													
													if( totala!=null && totala!="" ){
														
														inputElement.attr("value",Double.toString(sumClientA));
													}
													
													if( totalb!=null && totalb!="" ){
														
														inputElement.attr("value",Double.toString(sumClientB));
													}
													
													count++;
												}
												 
										 }								
										count=0;	
										request.setAttribute("sumClientA", sumClientA);
										request.setAttribute("sumClientB", sumClientB);
										
										answer = doc.getElementsByTag("table").toString();
										//answer=doc.toString();
										answer=answer.replace("'", "\\'").replaceAll("\n ", "");
										turn=questionImpl.addUserGivenAnswer(user_access_Type,userName,formId, q_id, answer);
										
									}						
									
									//...........................end cash needs....................................................
									
									//==============================================================================
									
									if(table_Id.equalsIgnoreCase("expensess")){
										for (int tr = 0; tr < tableRowElements.size(); tr++) {
											 
											 Element r = tableRowElements.get(tr);
											 Elements inputElements = r.getElementsByTag("input");
											 List<String> paramList = new ArrayList<String>();
												for (Element inputElement : inputElements) {
													
													String value = inputElement.attr("value");					
													
													String expensessValue=request.getParameter("expensess_"+count);
													
													
													if(expensessValue!=null){
														inputElement.attr("value", expensessValue);
													}										
													
													count++;
												}
												 
										 }								
										count=0;	
										
										//answer=doc.toString();
										answer = doc.getElementsByTag("table").toString();
										answer=answer.replace("'", "\\'").replaceAll("\n ", "");
										turn=questionImpl.addUserGivenAnswer(user_access_Type,userName,formId, q_id, answer);
										
									}					
									
									//===============================================================================
									if(table_Id.equalsIgnoreCase("income")){//0-4
										int sum=0;
										for (int tr = 0; tr < tableRowElements.size(); tr++) {
											 
											 Element r = tableRowElements.get(tr);
											 Elements inputElements = r.getElementsByTag("input");
											 List<String> paramList = new ArrayList<String>();
												for (Element inputElement : inputElements) {
													
													String value = inputElement.attr("value");					
													
													String incomeValue=request.getParameter("income_"+count);											
													
													if(incomeValue!=null){
														inputElement.attr("value", incomeValue);
													}										
													count++;
												}
												 
										 }								
										count=0;	
										
										//answer=doc.toString();
										answer = doc.getElementsByTag("table").toString();
										answer=answer.replace("'", "\\'").replaceAll("\n ", "");
										turn=questionImpl.addUserGivenAnswer(user_access_Type,userName,formId, q_id, answer);
										
									}					
									
									
									//===============================================================================
									//===============================================================================
									if(table_Id.equalsIgnoreCase("incomeNeeds")){
										for (int tr = 0; tr < tableRowElements.size(); tr++) {
											 
											 Element r = tableRowElements.get(tr);
											 Elements inputElements = r.getElementsByTag("input");
											 List<String> paramList = new ArrayList<String>();
												for (Element inputElement : inputElements) {
													
													String value = inputElement.attr("value");					
													
													String incomeNeedsValue=request.getParameter("incomeNeeds_"+count);
													
													
													if(incomeNeedsValue!=null){
														inputElement.attr("value", incomeNeedsValue);
													}											
													
													count++;
												}
												 
										 }								
										count=0;	
										
										//answer=doc.toString();
										answer = doc.getElementsByTag("table").toString();
										answer=answer.replace("'", "\\'").replaceAll("\n ", "");
										turn=questionImpl.addUserGivenAnswer(user_access_Type,userName,formId, q_id, answer);
										
									}	//end of finantial need analysis				
									
									//===========Start claimants statement E=====================================================================
									
									if(table_Id.equalsIgnoreCase("Claimants_statement_E_table1")){
										
											for (int tr = 0; tr < tableRowElements.size(); tr++) {
												 
												 Element r = tableRowElements.get(tr);
												 Elements inputElements = r.getElementsByTag("input");
												 List<String> paramList = new ArrayList<String>();
													for (Element inputElement : inputElements) {
														
														String value = inputElement.attr("value");											
														String temp=request.getParameter("claimants_statement_E1_"+count);
														
														if(temp!=null){
															inputElement.attr("value", temp);
														}else{
															inputElement.attr("value", value);
														}
														
														count++;
													}
													 
											 }								
											count=0;	
											
											//answer=doc.toString();
											answer = doc.getElementsByTag("table").toString();
											answer=answer.replace("'", "\\'").replaceAll("\n ", "");
											turn=questionImpl.addUserGivenAnswer(user_access_Type,userName,formId, q_id, answer);
											
											
										}
									
									//================================================================================
									
									
									if(table_Id.equalsIgnoreCase("Claimants_statement_E_table2")){
										
										for (int tr = 0; tr < tableRowElements.size(); tr++) {
											 
											 Element r = tableRowElements.get(tr);
											 Elements inputElements = r.getElementsByTag("input");
											 List<String> paramList = new ArrayList<String>();
												for (Element inputElement : inputElements) {
													
													String value = inputElement.attr("value");											
													String temp=request.getParameter("claimants_statement_E2_"+count);
													
													if(temp!=null){
														inputElement.attr("value", temp);
													}else{
														inputElement.attr("value", value);
													}
													
													count++;
												}
												 
										 }								
										count=0;	
										
										//answer=doc.toString();
										answer = doc.getElementsByTag("table").toString();
										answer=answer.replace("'", "\\'").replaceAll("\n ", "");
										turn=questionImpl.addUserGivenAnswer(user_access_Type,userName,formId, q_id, answer);
										
										
									}
									
									//================================================================================
									//===========End claimants statement E=====================================================================
									
									//===========Start Financial_Quest_Self_Employed_proposer=====================================================================
									
									if(table_Id.equalsIgnoreCase("Financial_Quest_Self_Employed_proposer")){
										
										for (int tr = 0; tr < tableRowElements.size(); tr++) {
											 
											 Element r = tableRowElements.get(tr);
											 Elements inputElements = r.getElementsByTag("input");
											 List<String> paramList = new ArrayList<String>();
												for (Element inputElement : inputElements) {
													
													String value = inputElement.attr("value");											
													String temp=request.getParameter("Financial_Quest_Self_Employed_proposer_"+count);
													
													if(temp!=null){
														inputElement.attr("value", temp);
													}else{
														inputElement.attr("value", value);
													}
													
													count++;
												}
												 
										 }								
										count=0;	
										
										//answer=doc.toString();
										answer = doc.getElementsByTag("table").toString();
										answer=answer.replace("'", "\\'").replaceAll("\n ", "");
										turn=questionImpl.addUserGivenAnswer(user_access_Type,userName,formId, q_id, answer);
										
										
									}
									
									//===========End Financial_Quest_Self_Employed_proposer=====================================================================
									
									//=================Stating Finantial Quest Regional Manager Report ===============
									//-----Annual Income --------

									if(table_Id.equalsIgnoreCase("Financial_Quest_Regional_Manager_Report_AnnualIncome")){
										
										for (int tr = 0; tr < tableRowElements.size(); tr++) {
											 
											 Element r = tableRowElements.get(tr);
											 Elements inputElements = r.getElementsByTag("input");
											 List<String> paramList = new ArrayList<String>(); 									 	
											
												for (Element inputElement : inputElements) {
													
													String value = inputElement.attr("value");					
													String name = inputElement.attr("name");										
													
													String clientValue=request.getParameter("Financial_Quest_Regional_Manager_Report_AnnualIncome_"+count);										
													
													if(clientValue!=null){												
														inputElement.attr("value", clientValue);																								
													}											
													count++;
												}
												 
										 }								
										count=0;						
										
										//answer=doc.toString();
										answer = doc.getElementsByTag("table").toString();
										answer=answer.replace("'", "\\'").replaceAll("\n ", "");
										turn=questionImpl.addUserGivenAnswer(user_access_Type,userName,formId, q_id, answer);
										
									}						
									
									//...........................end Annual Income...................................................
									//..........start Balances for the year ending 31 st March ...........................
									
									if(table_Id.equalsIgnoreCase("audited_profit_and_loss_account")){
										
										for (int tr = 0; tr < tableRowElements.size(); tr++) {
											 
											 Element r = tableRowElements.get(tr);
											 Elements inputElements = r.getElementsByTag("input");
											 List<String> paramList = new ArrayList<String>(); 									 	
											
												for (Element inputElement : inputElements) {
													
													String value = inputElement.attr("value");					
													String name = inputElement.attr("name");										
													
													String clientValue=request.getParameter("Financial_Quest_Regional_Manager_Report_audited_profit_and_loss_account_"+count);										
													
													if(clientValue!=null){												
														inputElement.attr("value", clientValue);																								
													}											
													count++;
												}
												 
										 }								
										count=0;						
										
										//answer=doc.toString();
										answer = doc.getElementsByTag("table").toString();
										answer=answer.replace("'", "\\'").replaceAll("\n ", "");
										turn=questionImpl.addUserGivenAnswer(user_access_Type,userName,formId, q_id, answer);
										
									}						
									
									//...........end of Balances for the year ending 31 st March .....................
									// .........start Balances as on 31st March ....................
									
									if(table_Id.equalsIgnoreCase("audited_balance_sheets_fqrmr")){
										
										for (int tr = 0; tr < tableRowElements.size(); tr++) {
											 
											 Element r = tableRowElements.get(tr);
											 Elements inputElements = r.getElementsByTag("input");
											 List<String> paramList = new ArrayList<String>(); 									 	
											
												for (Element inputElement : inputElements) {
													
													String value = inputElement.attr("value");					
													String name = inputElement.attr("name");										
													
													String clientValue=request.getParameter("Financial_Quest_Regional_Manager_Report_audited_balance_sheets_"+count);										
													
													if(clientValue!=null){												
														inputElement.attr("value", clientValue);																								
													}											
													count++;
												}
												 
										 }								
										count=0;						
										
										answer = doc.getElementsByTag("table").toString();
										//answer=doc.toString();
										answer=answer.replace("'", "\\'").replaceAll("\n ", "");
										turn=questionImpl.addUserGivenAnswer(user_access_Type,userName,formId, q_id, answer);
										
									}						
									
									//...........end of Balances as on 31st March ................
									//..........start of personal assets .........................
									if(table_Id.equalsIgnoreCase("details_of_personal_assets_fqrmr")){
										
										for (int tr = 0; tr < tableRowElements.size(); tr++) {
											 
											 Element r = tableRowElements.get(tr);
											 Elements inputElements = r.getElementsByTag("input");
											 List<String> paramList = new ArrayList<String>(); 									 	
											
												for (Element inputElement : inputElements) {
													
													String value = inputElement.attr("value");					
													String name = inputElement.attr("name");										
													
													String clientValue=request.getParameter("Financial_Quest_Regional_Manager_Report_details_of_personal_assets_"+count);										
													
													if(clientValue!=null){												
														inputElement.attr("value", clientValue);																								
													}											
													count++;
												}
												 
										 }								
										count=0;						
										
										//answer=doc.toString();
										answer = doc.getElementsByTag("table").toString();
										answer=answer.replace("'", "\\'").replaceAll("\n ", "");
										turn=questionImpl.addUserGivenAnswer(user_access_Type,userName,formId, q_id, answer);
										
									}						
									
									//..........end of personal assets............................
									//..start details_of_personal_liabilities_fqrmr.....................
									if(table_Id.equalsIgnoreCase("details_of_personal_liabilities_fqrmr")){
										
										for (int tr = 0; tr < tableRowElements.size(); tr++) {
											 
											 Element r = tableRowElements.get(tr);
											 Elements inputElements = r.getElementsByTag("input");
											 List<String> paramList = new ArrayList<String>(); 									 	
											
												for (Element inputElement : inputElements) {
													
													String value = inputElement.attr("value");					
													String name = inputElement.attr("name");										
													
													String clientValue=request.getParameter("Financial_Quest_Regional_Manager_Report_details_of_personal_liabilities_"+count);										
													
													if(clientValue!=null){												
														inputElement.attr("value", clientValue);																								
													}											
													count++;
												}
												 
										 }								
										count=0;						
										
										//answer=doc.toString();
										answer = doc.getElementsByTag("table").toString();
										answer=answer.replace("'", "\\'").replaceAll("\n ", "");
										turn=questionImpl.addUserGivenAnswer(user_access_Type,userName,formId, q_id, answer);
										
									}				
									
									//...end of details_of_personal_liabilities_fqrmr ..................
									//...starting residence_and_family_life_style_details_fqrmr .......
									if(table_Id.equalsIgnoreCase("residence_and_family_life_style_details_fqrmr")){
										
										for (int tr = 0; tr < tableRowElements.size(); tr++) {
											 
											 Element r = tableRowElements.get(tr);
											 Elements inputElements = r.getElementsByTag("input");
											 List<String> paramList = new ArrayList<String>(); 									 	
											
												for (Element inputElement : inputElements) {
													
													String value = inputElement.attr("value");					
													String name = inputElement.attr("name");										
													
													String clientValue=request.getParameter("Financial_Quest_Regional_Manager_Report_residence_and_family_life_style_details_"+count);										
													
													if(clientValue!=null){												
														inputElement.attr("value", clientValue);																								
													}											
													count++;
												}
												 
										 }								
										count=0;						
										
										//answer=doc.toString();
										answer = doc.getElementsByTag("table").toString();
										answer=answer.replace("'", "\\'").replaceAll("\n ", "");
										turn=questionImpl.addUserGivenAnswer(user_access_Type,userName,formId, q_id, answer);
										
									}				
									
									//....ending residence_and_family_life_style_details_fqrmr ........
									
									//=================End Finantial Quest Regional Manager Report ==================
									//============start Asthma Form ========================
									//diagnosis_asthma 
									if(table_Id.equalsIgnoreCase("diagnosis_asthma")){
										
										for (int tr = 0; tr < tableRowElements.size(); tr++) {
											 
											 Element r = tableRowElements.get(tr);
											 Elements inputElements = r.getElementsByTag("input");
											 List<String> paramList = new ArrayList<String>(); 									 	
											
												for (Element inputElement : inputElements) {
													
													String value = inputElement.attr("value");					
													String name = inputElement.attr("name");										
													
													String clientValue=request.getParameter("Asthma_Diagnosis_"+count);										
													
													if(clientValue!=null){												
														inputElement.attr("value", clientValue);																								
													}											
													count++;
												}
												 
										 }								
										count=0;						
										
										//answer=doc.toString();
										answer = doc.getElementsByTag("table").toString();
										answer=answer.replace("'", "\\'").replaceAll("\n ", "");
										turn=questionImpl.addUserGivenAnswer(user_access_Type,userName,formId, q_id, answer);
										
									}
									//------------end diagnosis_asthma--------------
									//---earlier_treatments_asthma -------
									if(table_Id.equalsIgnoreCase("earlier_treatments_asthma")){
										
										for (int tr = 0; tr < tableRowElements.size(); tr++) {
											 
											 Element r = tableRowElements.get(tr);
											 Elements inputElements = r.getElementsByTag("input");
											 List<String> paramList = new ArrayList<String>(); 									 	
											
												for (Element inputElement : inputElements) {
													
													String value = inputElement.attr("value");					
													String name = inputElement.attr("name");										
													
													String clientValue=request.getParameter("Asthma_earlier_treatments_"+count);										
													
													if(clientValue!=null){												
														inputElement.attr("value", clientValue);																								
													}											
													count++;
												}
												 
										 }								
										count=0;						
										
										//answer=doc.toString();
										answer = doc.getElementsByTag("table").toString();
										answer=answer.replace("'", "\\'").replaceAll("\n ", "");
										turn=questionImpl.addUserGivenAnswer(user_access_Type,userName,formId, q_id, answer);
										
									}
							
									//end---
									//--- current_treatments_asthma ----
									if(table_Id.equalsIgnoreCase("current_treatments_asthma")){
										
										for (int tr = 0; tr < tableRowElements.size(); tr++) {
											 
											 Element r = tableRowElements.get(tr);
											 Elements inputElements = r.getElementsByTag("input");
											 List<String> paramList = new ArrayList<String>(); 									 	
											
												for (Element inputElement : inputElements) {
													
													String value = inputElement.attr("value");					
													String name = inputElement.attr("name");										
													
													String clientValue=request.getParameter("Asthma_current_treatments_"+count);										
													
													if(clientValue!=null){												
														inputElement.attr("value", clientValue);																								
													}											
													count++;
												}
												 
										 }								
										count=0;						
										
										//answer=doc.toString();
										answer = doc.getElementsByTag("table").toString();
										answer=answer.replace("'", "\\'").replaceAll("\n ", "");
										turn=questionImpl.addUserGivenAnswer(user_access_Type,userName,formId, q_id, answer);
										
									}
									//-- end ----
									//============end Asthma Form ==========================
									
									//=======start EPILEPSY QUESTIONNAIRE ==================
									
									// diagnosis_epilepsy
									if(table_Id.equalsIgnoreCase("diagnosis_epilepsy")){
										
										for (int tr = 0; tr < tableRowElements.size(); tr++) {
											 
											 Element r = tableRowElements.get(tr);
											 Elements inputElements = r.getElementsByTag("input");
											 List<String> paramList = new ArrayList<String>(); 									 	
											
												for (Element inputElement : inputElements) {
													
													String value = inputElement.attr("value");					
													String name = inputElement.attr("name");										
													
													String clientValue=request.getParameter("Epilepsy_Diagnosis_"+count);										
													
													if(clientValue!=null){												
														inputElement.attr("value", clientValue);																								
													}											
													count++;
												}
												 
										 }								
										count=0;						
										
										//answer=doc.toString();
										answer = doc.getElementsByTag("table").toString();
										answer=answer.replace("'", "\\'").replaceAll("\n ", "");
										turn=questionImpl.addUserGivenAnswer(user_access_Type,userName,formId, q_id, answer);
										
									}
									//end diagnosis_epilepsy....
									// start earlier_treatments_epilepsy .....
										
									if(table_Id.equalsIgnoreCase("earlier_treatments_epilepsy")){
										
										for (int tr = 0; tr < tableRowElements.size(); tr++) {
											 
											 Element r = tableRowElements.get(tr);
											 Elements inputElements = r.getElementsByTag("input");
											 List<String> paramList = new ArrayList<String>(); 									 	
											
												for (Element inputElement : inputElements) {
													
													String value = inputElement.attr("value");					
													String name = inputElement.attr("name");										
													
													String clientValue=request.getParameter("Epilepsy_earlier_treatments_"+count);										
													
													if(clientValue!=null){												
														inputElement.attr("value", clientValue);																								
													}											
													count++;
												}
												 
										 }								
										count=0;						
										
										//answer=doc.toString();
										answer = doc.getElementsByTag("table").toString();
										answer=answer.replace("'", "\\'").replaceAll("\n ", "");
										turn=questionImpl.addUserGivenAnswer(user_access_Type,userName,formId, q_id, answer);
										
									}

									//..end earlier_treatments_epilepsy .....
									// start current_treatments_epilepsy ....
									if(table_Id.equalsIgnoreCase("current_treatments_epilepsy")){
										
										for (int tr = 0; tr < tableRowElements.size(); tr++) {
											 
											 Element r = tableRowElements.get(tr);
											 Elements inputElements = r.getElementsByTag("input");
											 List<String> paramList = new ArrayList<String>(); 									 	
											
												for (Element inputElement : inputElements) {
													
													String value = inputElement.attr("value");					
													String name = inputElement.attr("name");										
													
													String clientValue=request.getParameter("Epilepsy_current_treatments_"+count);										
													
													if(clientValue!=null){												
														inputElement.attr("value", clientValue);																								
													}											
													count++;
												}
												 
										 }								
										count=0;						
										
										//answer=doc.toString();
										answer = doc.getElementsByTag("table").toString();
										answer=answer.replace("'", "\\'").replaceAll("\n ", "");
										turn=questionImpl.addUserGivenAnswer(user_access_Type,userName,formId, q_id, answer);
										
									}
									//end current_treatments_epilepsy .......
									
									//========end EPILEPSY QUESTIONNAIRE ===================
									
									// ==== start Aviation supplementary statement ======
									if(table_Id.equalsIgnoreCase("AverageHoursOfFly_aviation_supplementary")){
										
										for (int tr = 0; tr < tableRowElements.size(); tr++) {
											 
											 Element r = tableRowElements.get(tr);
											 Elements inputElements = r.getElementsByTag("input");
											 List<String> paramList = new ArrayList<String>(); 									 	
											
												for (Element inputElement : inputElements) {
													
													String value = inputElement.attr("value");					
													String name = inputElement.attr("name");										
													
													String clientValue=request.getParameter("AverageHoursOfFly_aviation_supplementary_"+count);										
													
													if(clientValue!=null){												
														inputElement.attr("value", clientValue);																								
													}											
													count++;
												}
												 
										 }								
										count=0;						
										
										//answer=doc.toString();
										answer = doc.getElementsByTag("table").toString();
										answer=answer.replace("'", "\\'").replaceAll("\n ", "");
										turn=questionImpl.addUserGivenAnswer(user_access_Type,userName,formId, q_id, answer);
										
									}
									// ==== end Aviation supplementary statement ======
									
									//=== start Travel and Residence Questionnaire =========
									 //--- Country_details_Travel_and_Residence_Questionnaire
									if(table_Id.equalsIgnoreCase("Country_details_Travel_and_Residence_Questionnaire")){
										
										for (int tr = 0; tr < tableRowElements.size(); tr++) {
											 
											 Element r = tableRowElements.get(tr);
											 Elements inputElements = r.getElementsByTag("input");
											 List<String> paramList = new ArrayList<String>(); 									 	
											
												for (Element inputElement : inputElements) {
													
													String value = inputElement.attr("value");					
													String name = inputElement.attr("name");										
													
													String clientValue=request.getParameter("Country_details_Travel_and_Residence_"+count);										
													
													if(clientValue!=null){												
														inputElement.attr("value", clientValue);																								
													}											
													count++;
												}
												 
										 }								
										count=0;						
										
										//answer=doc.toString();
										answer = doc.getElementsByTag("table").toString();
										answer=answer.replace("'", "\\'").replaceAll("\n ", "");
										turn=questionImpl.addUserGivenAnswer(user_access_Type,userName,formId, q_id, answer);
										
									}
									
									//==== end Travel and Residence Questionnaire==========
									
									//===== start Contact_number_Specimen_Signature =====
									if(table_Id.equalsIgnoreCase("Contact_number_Specimen_Signature")){
										
										for (int tr = 0; tr < tableRowElements.size(); tr++) {
											 
											 Element r = tableRowElements.get(tr);
											 Elements inputElements = r.getElementsByTag("input");
											 List<String> paramList = new ArrayList<String>(); 									 	
											
												for (Element inputElement : inputElements) {
													
													String value = inputElement.attr("value");					
													String name = inputElement.attr("name");										
													
													String clientValue=request.getParameter("Contact_number_Specimen_Signature_"+count);										
													
													if(clientValue!=null){												
														inputElement.attr("value", clientValue);																								
													}											
													count++;
												}
												 
										 }								
										count=0;						
										
										//answer=doc.toString();
										answer = doc.getElementsByTag("table").toString();
										answer=answer.replace("'", "\\'").replaceAll("\n ", "");
										turn=questionImpl.addUserGivenAnswer(user_access_Type,userName,formId, q_id, answer);
										
									}
									
									//===== end Contact_number_Specimen_Signature =======
									
									//==== Nomination_Form =================
									//---Beneficiary ----------
									if(table_Id.equalsIgnoreCase("Beneficiary_Nomination_Form")){
										
										for (int tr = 0; tr < tableRowElements.size(); tr++) {
											 
											 Element r = tableRowElements.get(tr);
											 Elements inputElements = r.getElementsByTag("input");
											 List<String> paramList = new ArrayList<String>(); 									 	
											
												for (Element inputElement : inputElements) {
													
													String value = inputElement.attr("value");					
													String name = inputElement.attr("name");										
													
													String clientValue=request.getParameter("Beneficiary_Nomination_Form_"+count);										
													
													if(clientValue!=null){												
														inputElement.attr("value", clientValue);																								
													}											
													count++;
												}
												 
										 }								
										count=0;						
										
										//answer=doc.toString();
										answer = doc.getElementsByTag("table").toString();
										answer=answer.replace("'", "\\'").replaceAll("\n ", "");
										turn=questionImpl.addUserGivenAnswer(user_access_Type,userName,formId, q_id, answer);
										
									}
									
									//====end Nomination Form ============
									
									//=== Declaration_of_Good_Health =====
									if(table_Id.equalsIgnoreCase("Declaration_of_Good_Health")){
										
										for (int tr = 0; tr < tableRowElements.size(); tr++) {
											 
											 Element r = tableRowElements.get(tr);										
											
												 Elements optionElements = r.getElementsByTag("select");
												 Elements inputElements = r.getElementsByTag("input");
													
													for (Element optionElement : optionElements) {										
														
														Element mySelect = doc.getElementsByAttributeValue("name", "Declaration_of_Good_Health_"+count).get(0);
												        String optionValueToBeSelected = request.getParameter("Declaration_of_Good_Health_"+count);	
												        Elements options = mySelect.getElementsByTag("option");
												        for (Element option : options) {
												            if (option.attr("value").equals(optionValueToBeSelected)) {
												                option.attr("selected", "selected");
												            }
												        }	
																						
														count++;
													}
											
													for (Element inputElement : inputElements) {
														
														String clientValue=request.getParameter("Declaration_of_Good_Health_"+count);										
														
														if(clientValue!=null){												
															inputElement.attr("value", clientValue);													
														}											
														count++;
													}
											 
										 }								
										count=0;								
										//answer=doc.toString();
										answer = doc.getElementsByTag("table").toString();
										answer=answer.replace("'", "\\'").replaceAll("\n ", "");
										turn=questionImpl.addUserGivenAnswer(user_access_Type,userName,formId, q_id, answer);
										
									}
									
									//==end of Declaration_of_Good_Health ======
								}
						}			
						
					}
					

					for(int i=0;i<intQid.length;i++){
						questionImpl.updateUsergivenAnswer(user_access_Type,userName,formId, intQid[i],turn);
					}
					
					
					//update user wise test status of the table "form_assignment_users" .
					
					FormAssignToUserImple formImple=new FormAssignToUserImple();
					if(submitExam!=null ){
						
						formImple.updateFormStatusByUser(userName, formId, user_access_Type);
					}else if(saveAndUpdateExam!=null){
						
						formImple.updateFormUpdatedStatusByUser(userName, formId,turn,user_access_Type);
					}
					
					
					
				}//end if submited exam
				
				//end check updated exams
				
				int correctAnswers=0;
				int unAnswered=0;
				
				String formType = request.getParameter("formType");
				if(formType.equalsIgnoreCase("mcq")){
				//if(formId!=15){			
					
					for(int i=0;i<intQid.length;i++){
							
							String qType=questionImpl.getQuestionTypeByQId(intQid[i]);
							if(qType.equalsIgnoreCase("radioButton")|qType.equalsIgnoreCase("checkBox")|qType.equalsIgnoreCase("dropDown")){
								
								String correctAnswer=questionImpl.getCorrectAnswerByQId(formId, intQid[i]);
								String givenAnswer=questionImpl.getGivenAnswerByQId(formId, intQid[i],userName,turn,user_access_Type);
								
								if(correctAnswer.equalsIgnoreCase(givenAnswer)){
									correctAnswers++;
								}if(givenAnswer==null){
									unAnswered++;
								}
								
							}
							
						}
					
					String passMark=request.getParameter("passMark");
					int pass_Mark=Integer.parseInt(passMark);
					
					questionImpl.addResult(userName, formId, intQid.length, correctAnswers, unAnswered, pass_Mark,turn);		
					response.sendRedirect("result.jsp?formId="+formId+"&formName="+formName+"&correctAnswers="+correctAnswers+"&unAnswered="+unAnswered+"&NumberOfQuestions="+intQid.length+"&turn="+turn+"&successMessage=You are successfully submit data.");
					
				}
				else{
					response.sendRedirect("result.jsp?formId="+formId+"&formName="+formName+"&NumberOfQuestions="+intQid.length+"&turn="+turn+"&successMessage=You are successfully submit data.");
				}
			}catch(Exception e){
				e.printStackTrace();
			}
		
		
	}

}
