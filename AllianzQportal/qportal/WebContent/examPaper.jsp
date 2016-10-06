

<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="java.io.Writer"%>
<%@page import="com.allianz.qportalapp.model.Question"%>
<%@page import="com.allianz.qportalapp.controller.FormQuestionImpl"%>
<%@page import="com.allianz.qportalapp.model.FormSegment"%>
<%@page import="com.allianz.qportalapp.controller.FormSegmentImple"%>
<%@page import="com.allianz.qportalapp.model.FormType"%>
<%@page import="com.allianz.qportalapp.controller.FormTypeImpl"%>
<%-- <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> --%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en" class="no-ie">
   <!--<![endif]-->
   <head>
      <%@ include file="pages/mainHeader.jsp" %>
      <title>Online Test</title>
      <link rel="stylesheet" type="text/css" href="app/css/jquery.countdownTimer.css" />
      <script src="vendor/datatables/media/js/jquery.dataTables.min.js" 
         type="text/javascript"></script>
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
      <!-- START Main wrapper-->
      <%            
         FormTypeImpl formTypeImpl=new FormTypeImpl();                                                                                      
         //String formName=request.getParameter("selected_formName");
         String formId=request.getParameter("formId");
         int fId=Integer.parseInt(formId);
         FormType form= formTypeImpl.getFormByFormId(fId);
         String formName = form.getFormName();
         String form_type = form.getFormType();
         String duration=form.getDuration();
         //int fId=formTypeImpl.getFormIdByFormName(formName); 
         
         ServletContext context = session.getServletContext();
         
         
         FormQuestionImpl questionImpl=new FormQuestionImpl();
         int numberOfQuestion=questionImpl.getNoOfFieldByFormId(fId);     
         
         if(form_type.equalsIgnoreCase("mcq")){
         
          if(duration!=null && duration!=""){
           String timeArray[]=duration.split(":"); 
         %>
      <div hidden id="hour"><%=timeArray[0] %></div>
      <div hidden id="munites"><%=timeArray[1] %></div>
      <div hidden id="seconds"><%=timeArray[2] %></div>
      <% } else{%>
      <script type="text/javascript">
         $(function(){
           $('#future_date').countdowntimer({
           	currentTime : true,
                     size : "lg"
           });
         });
      </script>
      <% }
         }   
         
         int PassMark=form.getPassMark();   
         
         List<Integer> qidList=new ArrayList();%>
      <div class="wrapper">
         <!-- START Top Navbar-->
         <%@include file="pages/navigationBar.jsp" %>  
         <!-- END Top Navbar-->
         <!-- START aside-->
         <aside class="aside">
            <!-- START Sidebar (left)--> 
            <%
               String userAccess_Type = null;
               if(session.getAttribute("user_access_Type")!=null){
               	
               	userAccess_Type=session.getAttribute("user_access_Type").toString();
               	
               	if(userAccess_Type.equalsIgnoreCase("public")){
               		context.setAttribute("public_form_id", fId);
               		session.setAttribute("public_form_id",fId);
               		  %>
            <%@ include file="pages/sidebar.jsp" %>
            <%}else if(userAccess_Type.equalsIgnoreCase("special")){
               String userName=session.getAttribute("userName").toString();
               
               context.setAttribute("public_form_id", fId);
               session.setAttribute("public_form_id",fId);
               
                     if(userName.equalsIgnoreCase("admin@allianz.lk")){%>
            <%@ include file="pages/sidebarAdmin.jsp" %>
            <% }else{%>
            <%@ include file="pages/sidebar.jsp" %>
            <%} %>
            <%}
               } %>
            <% if(session.getAttribute("user_access_Type")==null){
               context.setAttribute("user_access_Type", "public");
               session.setAttribute("user_access_Type","public");
               }%>
            <!-- END Sidebar (left)-->
         </aside>
         <!-- End aside-->
         <!-- START Main section-->
         <section>
            <!-- START Page content  / sidehidden -->
            <div class="content-wrapper">
               <h3>
                  <%=formName %><small><%=form.getFormDescription() %></small>
                  <!-- <img src="app/img/allianzLogo.png" alt="Image" class="img-rounded  pull-right img-responsive allianzLogo"> -->
                   <%@ include file="pages/allianzLogo.jsp" %>
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
                              <div class="col-sm-1">
                              </div>
                              <div class="col-sm-2">
                                 <div class="panel widget">
                                    <div class="panel-body bg-primary text-center">
                                       <div class="text-md m0"><%=fId %></div>
                                       <p>Form ID</p>
                                    </div>
                                 </div>
                              </div>
                              <div class="col-sm-2">
                                 <div class="panel widget">
                                    <div class="panel-body bg-primary text-center">
                                       <div class="text-md m0"><%=numberOfQuestion %></div>
                                       <p>Number of Questions</p>
                                    </div>
                                 </div>
                              </div>
                              <div class="col-sm-2">
                                 <div class="panel widget">
                                    <div class="panel-body bg-primary text-center">
                                       <div class="text-md m0">
                                          <div id="countdowntimer"><span id="future_date"></span></div>
                                          <script type="text/javascript">
                                             var h=document.getElementById('hour').innerHTML;
                                             var m=document.getElementById('munites').innerHTML;
                                             var s=document.getElementById('seconds').innerHTML;
                                               $(function(){
                                                 $('#future_date').countdowntimer({
                                                 	 hours : h,
                                              		 minutes : m,
                                                      seconds : s,												                 
                                             	     size : "lg"
                                                 });
                                               });
                                          </script>
                                       </div>
                                       <p>Allocated Time</p>
                                    </div>
                                 </div>
                              </div>
                              <div class="col-sm-2">
                                 <div class="panel widget">
                                    <div class="panel-body bg-primary text-center">
                                       <div class="text-md m0"><%=PassMark %></div>
                                       <p>Pass Mark</p>
                                    </div>
                                 </div>
                              </div>
                              <!-- <div class="col-sm-2">
                                 <div class="panel widget">
                                 	<div class="panel-body bg-primary text-center">
                                 		<div class="text-md m0">06/05/2016</div>
                                 		<p>Date Created</p>
                                 	</div>
                                 </div>
                                 </div> -->
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
               <%}else {%>
               <div class="row">
                  <div class="col-lg-12">
                     <!-- START panel-->
                     <% if(userAccess_Type.equalsIgnoreCase("public")){%>
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
                                       <div class="text-md m0"><%=fId %></div>
                                       <p>Form ID</p>
                                    </div>
                                 </div>
                              </div>
                              <div class="col-sm-2">
                                 <div class="panel widget">
                                    <div class="panel-body bg-success text-center">
                                       <div class="text-md m0"><%=(String) session.getAttribute("public_userName") %></div>
                                       <p style="color: #1c75bf">Your Reference ID</p>
                                    </div>
                                 </div>
                              </div>
                              
                             <!--  <img src="app/img/allianzLogo.png" alt="Image" class="img-rounded  pull-right img-responsive allianzLogo"> -->
                           </div>
                        </div>
                     </div>
                     <%} %>
                  </div>
               </div>
               <%} %>
               <style>
               </style>
               <form action="examController" role="form" method="post">
                  <input type="hidden" value="<%=fId%>" name="formId"/>
                  <input type="hidden" value="<%=formName%>" name="formName"/>
                  <input type="hidden" value="<%=PassMark%>" name="passMark"/>
                  <input type="hidden" value="<%=form.getFormType()%>" name="formType"/>
                  <div class="row">
                     <div class="col-lg-12">
                        <!-- START panel-->
                        <div class="panel panel-default">
                           <div class="panel-heading"></div>
                           <div class="panel-body">
                              <div id="accordion" class="panel-group">
                                 <!-- START panel-->
                                 <%int editQuestionId=0;%>
                                 <% 
                                    FormSegmentImple formSegmentImple=new FormSegmentImple();                          
                                    for(FormSegment segment:formSegmentImple.getFormSegmentByFormId(fId)){
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
                                             
                                                                  for(Question question : formQuestionImpl.getFieldByFormIdAndSegmentId(fId, segment.getSegmentId())){                            
                                                                  int questionId=question.getQuestionId(); 
                                                                  qidList.add(questionId);%>                       
                                          <fieldset>
                                             <legend><span class="text-primary"><%=i+" . " %></span><%=question.getQuestionName()%></legend>
                                             <div class="col-sm-10">
                                                <% 
                                                   String qType=question.getQuestionType(); %>                                        
                                                <%if(qType.equalsIgnoreCase("textFeild")){
                                                   String textFieldValue=question.getPreAnswers().replaceAll("\\]|\\[|\"", "");
                                                   String textFieldValues[]=textFieldValue.split("\"?(:|,)(?![^\\{]*\\})\"?");
                                                    for(int r=0;r<textFieldValues.length;r++){%>
                                                <label><input type="text" name="textFieldValues<%=questionId%>" ></label>
                                                <%}
                                                   }if(qType.equalsIgnoreCase("datePicker")){%>
                                                <input type="text" class="bdate" name="textFieldValues<%=questionId%>" size="100">
                                                <%}
                                                   if(qType.equalsIgnoreCase("radioButton")){
                                                      String radioBtnValues=question.getPreAnswers();
                                                      String radioBtnArray[]=radioBtnValues.replaceAll("\\]|\\[|\"", "").split("\"?(:|,)(?![^\\{]*\\})\"?");
                                                      for(int r=0;r<radioBtnArray.length;r++){%>
                                                <div class="radio c-radio">
                                                   <label><input type="radio"
                                                      name="radioBtn<%=questionId%>"
                                                      value="<%=radioBtnArray[r] %>"> <span
                                                      class="fa fa-circle"></span><%=radioBtnArray[r] %></label>
                                                </div>
                                                <%}%>
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
                                                <%if(qType.equalsIgnoreCase("checkBox")){
                                                   String checkBoxValues=question.getPreAnswers();
                                                   String checkBoxArray[]=checkBoxValues.replaceAll("\\]|\\[|\"", "").split("\"?(:|,)(?![^\\{]*\\})\"?");%>
                                                <% for(int c=0;c<checkBoxArray.length;c++){%> 
                                                <input type="checkbox" value="<%=checkBoxArray[c] %>" name="checkBoxBtn<%=questionId%>"><%=checkBoxArray[c] %><br>
                                                <%}	%> 
                                                <% } %>			
                                                <%if (qType.equalsIgnoreCase("textArea")){
                                                   String textAreaValue=question.getPreAnswers();
                                                   String textArea[]=textAreaValue.replaceAll("\\]|\\[|\"", "").split("\"?(:|,)(?![^\\{]*\\})\"?");%>
                                                <textarea rows="2" cols="100" name="textArea<%=questionId%>"></textarea>
                                                <%} %>		
                                                <%
                                                   if(qType.equalsIgnoreCase("table")){%>
                                                <div class="table-responsive">
                                                   <%
                                                      String tableData=question.getPreAnswers();													
                                                       out.print(tableData);
                                                       %>
                                                </div>
                                                <% }
                                                   %>
                                                <%
                                                   if(qType.equalsIgnoreCase("image")){
                                                   		String imageFiles=question.getPreAnswers();
                                                   		 String fileArray[]=imageFiles.replaceAll("\\[", "").replaceAll("\\]","").split(",");
                                                   			int ch=65;
                                                   		 for(int img=0;img<fileArray.length;img++){
                                                   			String path=fileArray[img];
                                                   			System.out.println("image path: ////"+path);
                                                   			char value=(char)ch;
                                                   			%>
                                                <img src="<%=path%>" width="160" height="160" />
                                                <label class="radio c-radio"><input type="radio"
                                                   name="image<%=questionId%>"
                                                   value="<%=value%>"> <span
                                                   class="fa fa-circle"></span><%=value%></label>
                                                <%
                                                   ch++;
                                                    %>
                                                <%}
                                                   }
                                                   
                                                   
                                                   if(qType.equalsIgnoreCase("signature")){%>
                                                <div style="width:350px;height:auto;margin:50px auto;padding: 20px 0;background-color:#2a2a2a;color:#FFF;">
                                                   <!-- <form method="post" action="capture_signature.php" class="sigPad"> -->
                                                   <p class="drawItDesc">Click and drag to draw your signature in the box below.</p>
                                                   <div class="sig sigWrapper sigPad">
                                                      <canvas class="pad" width="275" height="90" id='canvas'></canvas>
                                                   </div>
                                                   <button id="captureSignature" name="capture"  class="captureButton" capture="no">Capture Signature</button>									
                                                   <button name="clear" class="clearButton" >Clear Signature</button>
                                                   <div style="clear:both;"></div>
                                                   <!-- </form> -->
                                                   <input type="hidden" value="" name="sigImage<%=questionId%>" class="sigImage">
                                                </div>
                                                <%}%>
                                                <%-- <%}%> --%> <!-- end of getFieldByFormIdAndSegmentId -->
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
                     if(formType.equalsIgnoreCase("mcq")){
                     	
                     	
                     	%>
                  <div class="form-group">
                     <button id="submitExam" type="submit" name="submit_exam" class="submitExam btn btn-primary" onclick="return confirm('Are you sure you want to save and finished?')">Save & Finished</button> 
                     <!--  <input type="button" value="Submit" id="dataForm" class="dataForm"> -->
                  </div>
                  <%} else{%>
                  <script type="text/javascript">	
                     //signature capturing validation befor submit
                        $(document).on('click', '#canvas', function() {	    
                        	var checkCapture =$('#captureSignature').attr('capture');	
                     	
                     	if(new String(checkCapture).valueOf() == new String("no").valueOf()){		
                      	    
                     		$('#captureSignature').focus();
                     		return false;
                     	}else{
                     		return false;
                     	}
                     });
                  </script> 
                  <div class="form-group">
                     <button type="submit" name="save_and_update" class="btn btn-primary" onclick="return confirm('Are you sure you want to save and update latter ?')">Save</button>
                     <button type="submit" name="submit_exam" class="btn btn-primary" onclick="return confirm('Are you sure you want to save and finished?If you are clicked yes, you can not update form latter.')">Save & Finished</button>
                  </div>
                  <%}%>
               </form>
            </div>
            <!-- END DATATABLE 1 -->
            
      <!-- </div> -->
      
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
         
          $('.panel-collapse').first().addClass("in");
          
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
           
         $(document).on('click', '.captureButton', function() {
         var canvas = document.getElementById("canvas");
         var img    = canvas.toDataURL("image/png");
         //document.write('<img src="'+img+'"/>');
         alert('<img src="'+img+'"/>');			
         $(".sigImage").val(img);
         return false;
         });
         
         $(document).on('click', '.clearButton', function() {
         var canvas = document.getElementById('canvas'),
               ctx = canvas.getContext("2d");
             	ctx.clearRect(0, 0, canvas.width, canvas.height);
             	return false;
         
         });
         
         
         //signature capturing ..................................
         
         /* $('#captureSignature').on('click', function() {
         
         $(this).attr('capture',"yes");
            $(this).prop('disabled', 'disabled');
                
         
         }); */
         
         //end signature capturing..............................
         
           
         }); 
         
         
      </script>
      <!-- END Scripts-->
   </body>
</html>

