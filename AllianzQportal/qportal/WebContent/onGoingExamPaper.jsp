

<%@page import="com.allianz.qportalapp.model.ResultForm"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="java.io.Writer"%>
<%@page import="com.allianz.qportalapp.model.Question"%>
<%@page import="com.allianz.qportalapp.controller.FormQuestionImpl"%>
<%@page import="com.allianz.qportalapp.model.FormSegment"%>
<%@page import="com.allianz.qportalapp.controller.FormSegmentImple"%>
<%@page import="com.allianz.qportalapp.model.FormType"%>
<%@page import="com.allianz.qportalapp.controller.FormTypeImpl"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en" class="no-ie">
   <!--<![endif]-->
   <head>
      <%@ include file="pages/mainHeader.jsp" %>
      <title>Online Test</title>
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
   </head>
   <body>
      <%
         FormTypeImpl formTypeImpl=new FormTypeImpl(); 
         FormQuestionImpl questionImpl=new FormQuestionImpl();
         
         String fId = request.getParameter("formId");
         int formId = Integer.parseInt(fId);
         FormType form= formTypeImpl.getFormByFormId(formId);
            String formName = form.getFormName();
            String form_type = form.getFormType();
            
         
         String userAccess_Type=session.getAttribute("user_access_Type").toString();
         String userName = null;
         if(userAccess_Type.equalsIgnoreCase("public")){
         	userName = session.getAttribute("public_userName").toString();
         }else if(userAccess_Type.equalsIgnoreCase("special")){
         	
         	userName=session.getAttribute("userName").toString();
         }
         
         
         int turn=Integer.parseInt(request.getParameter("turn"));
         
         ResultForm resultForm=questionImpl.getResultByUser_TurnAndFormId(userName, formId,turn);
         int numberOfQuestion= resultForm.getNoOfQuestions();
         int correctAnswers = resultForm.getNoOfcorrectAnswer();
         int unAnsered=resultForm.getNoOfunAnswer();
         int passMark=resultForm.getPassMark();
              
            List<Integer> qidList=new ArrayList();  
          %> 
      <div class="wrapper">
         <!-- START Top Navbar-->
         <%@include file="pages/navigationBar.jsp" %> 
         <!-- END Top Navbar-->
         <!-- START aside-->
         <%@include file="pages/aside.jsp" %>	
         <!-- End aside-->
         <!-- START Main section-->
         <section>
            <!-- START Page content-->
            <div class="content-wrapper">
               <h3>
                  <%=formName %><small>View details</small>
               </h3>
               <ol class="breadcrumb">
                  <%@include file="pages/breadcrumb.jsp" %> 
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
                              <div class="col-lg-12">
                                 <div class="well well-sm">
                                    <h4 class="text-primary">Description</h4>
                                    <p class="text-primary"><%=form.getFormDescription() %></p>
                                 </div>
                              </div>
                           </div>
                           <div class="row">
                              <div class="col-sm-3">
                                 <div class="panel widget">
                                    <div class="panel-body bg-primary text-center">
                                       <div class="text-lg m0"><%=numberOfQuestion%></div>
                                       <p>Number of Questions</p>
                                    </div>
                                 </div>
                              </div>
                              <div class="col-sm-3">
                                 <div class="panel widget">
                                    <div class="panel-body bg-primary text-center">
                                       <div class="text-lg m0"><%=correctAnswers%></div>
                                       <p>Number of Correct Answers</p>
                                    </div>
                                 </div>
                              </div>
                              <div class="col-sm-3">
                                 <div class="panel widget">
                                    <div class="panel-body bg-primary text-center">
                                       <div class="text-lg m0"><%=unAnsered%></div>
                                       <p>Number of Unanswered</p>
                                    </div>
                                 </div>
                              </div>
                              <div class="col-sm-3">
                                 <div class="panel widget">
                                    <div class="panel-body bg-primary text-center">
                                       <div class="text-lg m0"><%=passMark %></div>
                                       <p>Pass Mark</p>
                                    </div>
                                 </div>
                              </div>
                           </div>
                        </div>
                     </div>
                     <!-- END panel-->
                  </div>
               </div>
               <%} %>
               <form action="examController" role="form" method="post">
                  <input type="hidden" value="<%=formId%>" name="formId"/>
                  <input type="hidden" value="<%=formName%>" name="formName"/>
                  <input type="hidden" value="<%=passMark%>" name="passMark"/>  
                  <input type="hidden" value="<%=form.getFormType()%>" name="formType"/>               
                  <div class="row">
                     <div class="col-lg-12">
                        <!-- START panel-->
                        <div class="panel panel-default">
                           <div class="panel-heading"></div>
                           <div class="panel-body">
                              <div id="accordion" class="panel-group">
                                 <!-- START panel-->		
                                 <% FormSegmentImple formSegmentImple=new FormSegmentImple();                          
                                    for(FormSegment segment:formSegmentImple.getFormSegmentByFormId(formId)){
                                    String segmentName=segment.getSegmentName();
                                    String segmentDescription=segment.getSegmentDescription();
                                    int SegmentId=segment.getSegmentId();
                                    if(segmentDescription==null){
                                    segmentDescription="";
                                    }
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
                                                                          String givenAnswer=formQuestionImpl.getGivenAnswerByQId(formId, questionId,userName,turn,userAccess_Type);
                                                                          
                                                                          %>
                                          <fieldset>
                                             <legend><span class="text-primary"><%=i+" . " %></span><%=question.getQuestionName()%></legend>
                                             <div class="col-sm-10">
                                                <% 
                                                   String qType=question.getQuestionType();								
                                                   if(qType.equalsIgnoreCase("textFeild")){
                                                   String textFieldValue=question.getPreAnswers().replaceAll("\\]|\\[|\"", "");
                                                   String textFieldValues[]=textFieldValue.split("\"?(:|,)(?![^\\{]*\\})\"?");
                                                   for(int r=0;r<textFieldValues.length;r++){%>
                                                <label><input type="text" name="textFieldValues<%=questionId%>" size="100" value="<%=givenAnswer%>"></label>
                                                <%}%>
                                                <%}%>
                                                <%if(qType.equalsIgnoreCase("radioButton")){
                                                   String radioBtnValues=question.getPreAnswers();
                                                   String radioBtnArray[]=radioBtnValues.replaceAll("\\]|\\[|\"", "").split("\"?(:|,)(?![^\\{]*\\})\"?");
                                                   for(int r=0;r<radioBtnArray.length;r++){%>
                                                <div class="radio c-radio">																
                                                   <%												
                                                      if((givenAnswer.trim()).equalsIgnoreCase(radioBtnArray[r].trim())){%>
                                                   <label style="background-color: #ff9999;"><input type="radio"
                                                      name="radioBtn<%=questionId%>"
                                                      value="<%=radioBtnArray[r] %>"> <span
                                                      class="fa fa-circle"></span><%=radioBtnArray[r] %></label></label>
                                                   <%}else{%>
                                                   <label><input type="radio"
                                                      name="radioBtn<%=questionId%>"
                                                      value="<%=radioBtnArray[r] %>"> <span
                                                      class="fa fa-circle"></span><%=radioBtnArray[r] %></label>
                                                   <%}%>		
                                                </div>
                                                <%} %>
                                                <%} %>
                                                <%if(qType.equalsIgnoreCase("dropDown")){
                                                   String dropDownValues=question.getPreAnswers();
                                                   String dropDownArray[]=dropDownValues.replaceAll("\\]|\\[|\"", "").split("\"?(:|,)(?![^\\{]*\\})\"?");%>
                                                <select name="dropDownList" name="dropDownList<%=questionId%>">
                                                   <%for(int d=0;d<dropDownArray.length;d++){%>
                                                   <option value="<%=dropDownArray[d]%>"><%=dropDownArray[d]%></option>
                                                   <%} %>
                                                </select>
                                                <% } %>	
                                                <%if(qType.equalsIgnoreCase("checkBox")){%>										
                                                <%String checkBoxValues=question.getPreAnswers();
                                                   String checkBoxArray[]=checkBoxValues.replaceAll("\\]|\\[|\"", "").split("\"?(:|,)(?![^\\{]*\\})\"?");
                                                   
                                                   String checkAnswers = givenAnswer;
                                                   if(checkAnswers!=null){
                                                   	
                                                   	String checked[] = checkAnswers.replaceAll("\\]|\\[|\"", "").split("\"?(:|,)(?![^\\{]*\\})\"?");
                                                   
                                                   	if(checked!=null){
                                                   		for(String value: checkBoxArray){
                                                   			boolean test=true;
                                                   			for(String check : checked){																
                                                   				
                                                   				if((value.trim()).equalsIgnoreCase(check.trim())){%>
                                                <input checked type="checkbox" value="<%=value %>" name="checkBoxBtn<%=questionId%>"><%=value %><br>
                                                <%
                                                   test=false;
                                                   }
                                                   }
                                                   if(test){%>
                                                <input type="checkbox" value="<%=value %>" name="checkBoxBtn<%=questionId%>"><%=value %><br>
                                                <%}
                                                   }
                                                   }
                                                   
                                                   }
                                                   
                                                   %>	
                                                <%} %>	
                                                <%if (qType.equalsIgnoreCase("textArea")){
                                                   String textAreaValue=question.getPreAnswers();
                                                   String textArea[]=textAreaValue.replaceAll("\\]|\\[|\"", "").split("\"?(:|,)(?![^\\{]*\\})\"?");%>
                                                <textarea rows="3" cols="20" name="textArea<%=questionId%>"><%= textArea[0]%></textarea>
                                                <%} %>	
                                                <%
                                                   if(qType.equalsIgnoreCase("table")){
                                                   													
                                                   	out.print(givenAnswer);
                                                   }
                                                   
                                                   if(qType.equalsIgnoreCase("signature")){%>
                                                <% 
                                                   String signature =formQuestionImpl.getUserSignatureByQId(formId, questionId,userName,turn,userAccess_Type);
                                                   
                                                   %>
                                                <!-- 				<div style="width:350px;height:auto;margin:50px auto;padding: 20px 0;background-color:#2a2a2a;color:#FFF;">
                                                   <form method="post" action="capture_signature.php" class="sigPad">
                                                     <p class="drawItDesc">Click and drag to draw your signature in the box below.</p>
                                                     <div class="sig sigWrapper sigPad">
                                                   	<canvas class="pad" width="275" height="90" id='canvas'></canvas>
                                                   	
                                                     </div>
                                                     		<button name="clear"  class="clearButton" onclick="captureSig()">Capture Signature</button>									
                                                   		<button name="clear" type="clear" class="clearButton" onclick="clearSig()">Clear Signature</button>
                                                   	
                                                     <div style="clear:both;"></div>
                                                   </form>
                                                   
                                                   </div> -->
                                                <img src="<%=signature%>" style="background-color: rgb(42, 42, 42);" width="275" height="90"/>
                                                <%}%>
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
                  <input type="hidden" value="<%=qidList%>" name="qidList"/>
                  <%String formType=form.getFormType();
                     if(formType.equalsIgnoreCase("mcq")){%>
                  <div class="form-group">
                     <button type="submit" name="submit_exam" class="btn btn-primary" onclick="return confirm('Are you sure you want to save and finished?')">Submit</button>
                  </div>
                  <%} else{%>
                  <div class="form-group">
                     <button type="submit" name="save_and_update" class="btn btn-primary" onclick="return confirm('Are you sure you want to save and update latter ?')">Save</button>
                     <button type="submit" name="submit_exam" class="btn btn-primary" onclick="return confirm('Are you sure you want to save and finished?')">Save & Finish</button>
                  </div>
                  <%}%>
               </form>
            </div>
            <!-- END DATATABLE 1 -->
            <!-- END -->
     <!--  </div> -->
      <!-- END Page content--> 
      </section>
      <!-- END Main section-->
       <%@include file="pages/footer.jsp" %>
      </div>
      <!-- END Main wrapper-->
     
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
      <!-- END Scripts-->
   </body>
</html>

