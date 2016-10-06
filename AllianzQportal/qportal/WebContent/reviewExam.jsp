

<%@page import="java.io.OutputStream"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="java.io.Writer"%>
<%@page import="com.allianz.qportalapp.model.Question"%>
<%@page import="com.allianz.qportalapp.controller.FormQuestionImpl"%>
<%@page import="com.allianz.qportalapp.model.FormSegment"%>
<%@page import="com.allianz.qportalapp.controller.FormSegmentImple"%>
<%@page import="com.allianz.qportalapp.model.FormType"%>
<%@page import="com.allianz.qportalapp.controller.FormTypeImpl"%>
<%@page import="java.io.InputStream"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en" class="no-ie">
   <!--<![endif]-->
   <head>
      <style type="text/css">
         input[type="number"]::-webkit-outer-spin-button,
         input[type="number"]::-webkit-inner-spin-button {
         -webkit-appearance: none;
         margin: 0;
         }
         input[type="number"] {
         -moz-appearance: textfield;
         }
         .tableinput input{
         width:60px !important;
         }
      </style>
      <%@ include file="pages/mainHeader.jsp" %>
      <title>Online Test</title>
   </head>
   <body>
      <%
         int formId=Integer.parseInt(request.getParameter("formId"));
         String formName=request.getParameter("formName");
         FormTypeImpl formTypeImpl=new FormTypeImpl(); 
         FormType form=formTypeImpl.getFormByFormId(formId); 
         String form_type = form.getFormType();	
         int correctAnswers = 0;int passMark = 0;
         if(form_type.equalsIgnoreCase("mcq")){
         	correctAnswers=Integer.parseInt(request.getParameter("correctAnswers"));
         	passMark=form.getPassMark();		
         }
         
         FormQuestionImpl questionImpl=new FormQuestionImpl();
            int numberOfQuestion=questionImpl.getNoOfFieldByFormId(formId);
         
            String nicNo = request.getParameter("nicNo");
           
            List<Integer> qidList=new ArrayList();  
         %> 
      <div class="wrapper">
         <!-- START Top Navbar-->
         <%@include file="pages/navigationBar.jsp" %>   
         <!-- END Top Navbar-->
         <!-- START aside-->
         <%@include file="pages/aside.jsp" %>  
         <%
            String userAccess_Type=session.getAttribute("user_access_Type").toString();
            String userName="";
            if(userAccess_Type.equalsIgnoreCase("public")){
            	userName=session.getAttribute("public_userName").toString();
            	//String referenceId = questionImpl.getReferenceId(userName, formId);
            	if(nicNo!=null) questionImpl.addReferenceId(userName,nicNo,formId);				
            %>			
         <%}else if(userAccess_Type.equalsIgnoreCase("special")){
            userName=session.getAttribute("userName").toString();		       
            }%>
         <!-- End aside-->
         <!-- START Main section-->
         <section>
            <!-- START Page content-->
            <div class="content-wrapper">
               <h3>
                  <%=formName %><small><%=form.getFormDescription() %></small>
                  <% if(userAccess_Type.equalsIgnoreCase("public")){%>
                  <label style="background-color: #1c75bf; color: #ffffff;">Reference ID : <b><%=userName%></b></label>
                  <%} %>
               </h3>
               <ol class="breadcrumb">
                  <%@include file="pages/breadcrumb.jsp" %> 
                  <li><a href="selectForm.jsp">My Forms</a></li>
                  <li class="active"><%=formName %></li>
               </ol>
               <%if(form_type.equalsIgnoreCase("mcq")){ %>
               <div class="row">
                  <div class="col-lg-12">
                     <!-- START panel-->
                     <div class="panel panel-default">
                        <div class="panel-heading">
                           Details <a href="#" data-perform="panel-collapse"
                              data-toggle="tooltip" title="Collapse Panel" class="pull-right">
                           <em class="fa fa-minus"></em>
                           </a>
                        </div>
                        <div class="panel-body">
                           <div class="row">
                              <div class="col-sm-2">
                                 <div class="panel widget">
                                    <div class="panel-body bg-primary text-center">
                                       <div class="text-md m0"><%=formId %></div>
                                       <p>Form ID</p>
                                    </div>
                                 </div>
                              </div>
                              <div class="col-sm-2">
                                 <div class="panel widget">
                                    <div class="panel-body bg-primary text-center">
                                       <div class="text-md m0"><%=numberOfQuestion%></div>
                                       <p>Number of Questions</p>
                                    </div>
                                 </div>
                              </div>
                              <div class="col-sm-2">
                                 <div class="panel widget">
                                    <div class="panel-body bg-primary text-center">
                                       <div class="text-md m0"><%=correctAnswers%></div>
                                       <p>Correct Answers</p>
                                    </div>
                                 </div>
                              </div>
                              <div class="col-sm-2">
                                 <div class="panel widget">
                                    <div class="panel-body bg-primary text-center">
                                       <div class="text-md m0"><%=passMark %></div>
                                       <p>Pass Mark</p>
                                    </div>
                                 </div>
                              </div>
                              <div class="col-sm-2">
                                 <div class="panel widget">
                                    <div class="panel-body bg-primary text-center">
                                       <div class="text-md m0">06/05/2016</div>
                                       <p>Date Created</p>
                                    </div>
                                 </div>
                              </div>
                              <% if(userAccess_Type.equalsIgnoreCase("public")){%>
                              <div class="col-sm-2">
                                 <div class="panel widget">
                                    <div class="panel-body bg-success text-center">
                                       <div class="text-md m0"><%=(String) session.getAttribute("public_userName") %></div>
                                       <p>Your Reference ID</p>
                                    </div>
                                 </div>
                              </div>
                              <%} %>
                           </div>
                        </div>
                     </div>
                     <!-- END panel-->
                  </div>
               </div>
               <%} %>
               <div class="row" id="content">
                  <div class="col-lg-12">
                     <!-- START panel-->
                     <div class="panel panel-default">
                        <div class="panel-heading"></div>
                        <div class="panel-body">
                           <div id="accordion" class="panel-group">
                              <!-- START panel-->
                              <% 
                                 FormSegmentImple formSegmentImple=new FormSegmentImple();                          
                                 for(FormSegment segment:formSegmentImple.getFormSegmentByFormId(formId)){
                                 String segmentName=segment.getSegmentName();
                                 String segmentDescription=segment.getSegmentDescription();
                                 int SegmentId=segment.getSegmentId();
                                 %>
                              <div class="panel panel-default">
                                 <a data-toggle="collapse" data-parent="#accordion" href="#<%=SegmentId%>">
                                    <div class="panel-heading">
                                       <h4 class="panel-title"><span id="segmentName" name="<%=segmentName%>"><%=segmentName%></span>
                                       </h4>
                                    </div>
                                 </a>
                                 <div id="<%=SegmentId%>" class="panel-collapse collapse">
                                    <div class="panel-body">
                                       <% 	int i=1;
                                          FormQuestionImpl formQuestionImpl=new FormQuestionImpl();
                                                                       for(Question question : formQuestionImpl.getFieldByFormIdAndSegmentId(formId, segment.getSegmentId())){
                                                                       int questionId=question.getQuestionId(); 
                                                                       qidList.add(questionId);
                                                                       //String user_Name=session.getAttribute("userName").toString();
                                                                       int turn=Integer.parseInt(request.getParameter("turn"));
                                                                       String givenAnswer=formQuestionImpl.getGivenAnswerByQId(formId, questionId,userName,turn,userAccess_Type);
                                                                       String correctAnswer=formQuestionImpl.getCorrectAnswerByQId(formId, questionId);                                   
                                                                      
                                                                       
                                                                       %>                           
                                       <fieldset>
                                          <legend><span class="text-primary"><%=i+" . " %></span><%=question.getQuestionName()%></legend>
                                          <div class="col-sm-10">
                                             <%
                                                String qType=question.getQuestionType(); %>                                       
                                             <%if(qType.equalsIgnoreCase("textFeild")){
                                                System.out.println("textfield answer: "+givenAnswer);
                                                	out.write(givenAnswer);
                                                
                                                }%>
                                             <%if(qType.equalsIgnoreCase("signature")){
                                                String signature =formQuestionImpl.getUserSignatureByQId(formId, questionId,userName,turn,userAccess_Type);
                                                
                                                
                                                %>												
                                             <img src="<%=signature%>" style="background-color: rgb(42, 42, 42);" width="275" height="90"/>
                                             <%}%>
                                             <%if(qType.equalsIgnoreCase("radioButton")){
                                                correctAnswer = correctAnswer.trim();
                                                                        givenAnswer = givenAnswer.trim();
                                                                           
                                                                                         String radioBtnValues=question.getPreAnswers();
                                                                                         String radioBtnArray[]=radioBtnValues.replaceAll("\\]|\\[|\"", "").split("\"?(:|,)(?![^\\{]*\\})\"?");
                                                                                         for(int r=0;r<radioBtnArray.length;r++){%>
                                             <div class="radio c-radio">
                                                <!--
                                                   #ffff80=yello
                                                    #ff9999=red 
                                                   #53c653=green -->
                                                <% if(correctAnswer.equalsIgnoreCase(givenAnswer) && correctAnswer.equalsIgnoreCase(radioBtnArray[r].trim())){%>
                                                <label style="background-color: #ffff80;"><input disabled type="radio"
                                                   name="radioBtn<%=questionId%>"
                                                   value="<%=radioBtnArray[r] %>"> 
                                                <span class="fa fa-circle"></span>
                                                <%=radioBtnArray[r] %></label>
                                                <%}else if(!(correctAnswer.equalsIgnoreCase(givenAnswer)) && givenAnswer.equalsIgnoreCase(radioBtnArray[r].trim())){%>
                                                <label style="background-color: #ff9999;margin-bottom: 2px;margin-top: 2px; "><input disabled type="radio"
                                                   name="radioBtn<%=questionId%>"
                                                   value="<%=radioBtnArray[r] %>"> <span
                                                   class="fa fa-circle"></span><%=radioBtnArray[r] %></label>
                                                <%}else if(!correctAnswer.equalsIgnoreCase(givenAnswer) && correctAnswer.equalsIgnoreCase(radioBtnArray[r])){%>
                                                <label style="background-color: #53c653;margin-bottom: 2px;margin-top: 2px;"><input disabled type="radio"
                                                   name="radioBtn<%=questionId%>"
                                                   value="<%=radioBtnArray[r] %>"> 
                                                <span class="fa fa-circle"></span>
                                                <%=radioBtnArray[r] %></label>					
                                                <%}else{%>
                                                <label><input type="radio"
                                                   name="radioBtn<%=questionId%>"
                                                   value="<%=radioBtnArray[r] %>"> <span
                                                   class="fa fa-circle" disabled></span><%=radioBtnArray[r] %></label>
                                                <%}%>		
                                             </div>
                                             <!-- <br/> -->
                                             <%}%>
                                             <%} %>
                                             <%if(qType.equalsIgnoreCase("dropDown")){
                                                String dropDownValues=question.getPreAnswers();
                                                String dropDownArray[]=dropDownValues.replaceAll("\\]|\\[|\"", "").split("\"?(:|,)(?![^\\{]*\\})\"?");%>
                                             <select disabled name="dropDownList" name="dropDownList<%=questionId%>">
                                                <%for(int d=0;d<dropDownArray.length;d++){%>
                                                <option value="<%=dropDownArray[d]%>"><%=dropDownArray[d]%></option>
                                                <%} %>
                                             </select>
                                             <% } %>	
                                             <%if(qType.equalsIgnoreCase("checkBox")){
                                                String checkBoxValues=question.getPreAnswers();
                                                String checkBoxArray[]=checkBoxValues.replaceAll("\\]|\\[|\"", "").split("\"?(:|,)(?![^\\{]*\\})\"?");
                                                
                                                String checkAnswers = givenAnswer;
                                                if(checkAnswers!=null){
                                                	
                                                	String checked[] = checkAnswers.replaceAll("\\]|\\[|\"", "").split("\"?(:|,)(?![^\\{]*\\})\"?");
                                                
                                                	if(checked!=null){
                                                		for(String value: checkBoxArray){
                                                			boolean test=true;
                                                			for(String check : checked){
                                                				
                                                				
                                                				if((value.trim()).equalsIgnoreCase(check.trim())){%>
                                             <input checked disabled type="checkbox" value="<%=value %>" name="checkBoxBtn<%=questionId%>"><%=value %><br>
                                             <%
                                                test=false;
                                                }
                                                }
                                                if(test){%>
                                             <input disabled type="checkbox" value="<%=value %>" name="checkBoxBtn<%=questionId%>"><%=value %><br>
                                             <%}
                                                }
                                                }
                                                
                                                }%>														
                                             <%} %>	
                                             <%if (qType.equalsIgnoreCase("textArea")){
                                                out.write(givenAnswer);
                                                } %>	
                                             <%
                                                if(qType.equalsIgnoreCase("table")){
                                                 	out.print(givenAnswer);
                                                }
                                                %>												
                                             <%++i;%>
                                          </div>
                                       </fieldset>
                                       <%}%>
                                    </div>
                                 </div>
                              </div>
                              <div style="height:10px"></div>
                              <%}%>
                              <!-- END panel-->
                           </div>
                        </div>
                     </div>
                     <!-- END panel-->
                  </div>
               </div>
              
            </div>
            <!-- END DATATABLE 1 -->
            
     <!--  </div> -->
      <!-- END Page content--> </section>
      <!-- END Main section-->
       <%@include file="pages/footer.jsp" %>
      </div>
      <!-- END Main wrapper-->
      <!-- start modal -->
      <!-- end modal -->
      <!-- START Scripts-->
      <%@ include file="pages/script.jsp" %>
      <%if(form_type.equalsIgnoreCase("mcq")){ %>
      <script type="text/javascript" src="vendor/jquery.countdownTimer.js"></script>
      <%} %>
      <script type="text/javascript">
         $(document).ready(function() {
          
          $('.panel-collapse').first().addClass( "in" );
          
           $(".bdate").datepicker({
           	changeMonth: true,
           	changeYear: true,
           	yearRange: "1970:2020"
           	});
           
           <%	    
            if(userAccess_Type.equalsIgnoreCase("public")){%>
         
         $('section').addClass("sidehidden");
         $('aside').removeClass("aside");
         
         <%}%>
          
           
         
         }); 
         
      </script>
      <script src="vendor/jsPDF/dist/jspdf.min.js" type="application/javascript"></script>
      <!-- END Scripts-->
   </body>
</html>

