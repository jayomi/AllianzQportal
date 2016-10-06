

<%@page import="com.allianz.qportalapp.model.FormType"%>
<%@page import="com.allianz.qportalapp.controller.FormTypeImpl"%>
<%@page import="com.allianz.qportalapp.controller.FormQuestionImpl"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en" class="no-ie">
   <!--<![endif]-->
   <head>
      <%@ include file="pages/mainHeader.jsp" %>
      <title>Online Test</title>
   </head>
   <body>
    
      <%
         int formId=Integer.parseInt(request.getParameter("formId").toString());
         String formName=request.getParameter("formName").toString();	
         FormTypeImpl formTypeImpl=new FormTypeImpl();
         FormType form=formTypeImpl.getFormByFormId(formId);
         String form_type = form.getFormType();
         FormQuestionImpl questionImpl=new FormQuestionImpl();
            int numberOfQuestion=questionImpl.getNoOfFieldByFormId(formId);     
            String userAccess_Type=session.getAttribute("user_access_Type").toString();
            int correctAnswers = 0;
            
            
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
                  <%=formName %><small><%=form.getFormDescription() %></small>
                 <%@ include file="pages/allianzLogo.jsp" %>
               </h3>
               <ol class="breadcrumb">
                  <%@include file="pages/breadcrumb.jsp" %> 
                  <!-- <li><a href="selectForm.jsp">My Forms</a></li> -->
                  <li class="active"><%=formName %></li>
               </ol>
               <%if(form_type.equalsIgnoreCase("mcq")){
                  correctAnswers = Integer.parseInt(request.getParameter("correctAnswers").toString());
                  int unAnswered=Integer.parseInt(request.getParameter("unAnswered").toString());
                  int numberOfQuestions=Integer.parseInt(request.getParameter("NumberOfQuestions").toString());
                  int incorrectAnswer=numberOfQuestions-(correctAnswers+unAnswered);
                  int passMark=form.getPassMark();
                  
                  %>
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
                                       <div class="text-lg m0"><%=numberOfQuestion %></div>
                                       <p>Number of Questions</p>
                                    </div>
                                 </div>
                              </div>
                              <div class="col-sm-2">
                                 <div class="panel widget">
                                    <div class="panel-body bg-primary text-center">
                                       <div class="text-lg m0"><%=correctAnswers %></div>
                                       <p>Correct Answers</p>
                                    </div>
                                 </div>
                              </div>
                              <div class="col-sm-2">
                                 <div class="panel widget">
                                    <div class="panel-body bg-primary text-center">
                                       <div class="text-lg m0"><%= incorrectAnswer%></div>
                                       <p>Incorrect Answers</p>
                                    </div>
                                 </div>
                              </div>
                              <div class="col-sm-2">
                                 <div class="panel widget">
                                    <div class="panel-body bg-primary text-center">
                                       <div class="text-lg m0"><%=passMark %></div>
                                       <p>Pass Mark</p>
                                    </div>
                                 </div>
                              </div>
                              <%if(userAccess_Type.equalsIgnoreCase("public")){%>
                              <div class="col-sm-2">
                                 <div class="panel widget">
                                    <div class="panel-body bg-success text-center">
                                       <div class="text-lg m0"><%=(String) session.getAttribute("public_userName") %></div>
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
               <form action="reviewExam.jsp">
                  <input type="text" value="<%=formId%>" name="formId" hidden>
                  <input type="text" value="<%=formName%>" name="formName" hidden>
                  <input type="text" value="<%=correctAnswers%>" name="correctAnswers" hidden>
                  <%int turn=Integer.parseInt(request.getParameter("turn"));
                     %>
                  <input type="text" value="<%=turn%>" name="turn" hidden>
                  <% if(userAccess_Type.equalsIgnoreCase("public")){
                     String public_userName=session.getAttribute("public_userName").toString();
                     String s1="<p>Please Enter your NIC No to validate your access later. </p>";
                     out.println(s1);%>			
                  <% String publicUser = session.getAttribute("public_userName").toString();%>
                  <div class="form-group">
                     <label class="col-lg-12 control-label">Your Reference ID: <b style="background-color: #1c75bf;color:#ffffff;"><%=publicUser%></b></label>
                     <label class="col-lg-2 col-sm-2 control-label">Your NIC No: *</label>
                     <%String nic = questionImpl.getReferenceId(publicUser,formId); 
                        if(nic==null){
                        	nic = "NIC No";%>
                     <input type="text" name="nicNo" placeholder="NICn No" id="nic" required>
                     <%} else if(nic!=null){%>
                     <input type="text" name="nicNo" value="<%=nic%>" disabled>
                     <%}%>	  
                  </div>
                  <% }%>
                  <div class="form-group"><input type="submit" value="Review" class="btn btn-labeled btn-primary  btn-xs"></div>
               </form>
            </div>
            <!-- END Page content--> 
         </section>
         <!-- END Main section-->
          <%@include file="pages/footer.jsp" %>
          
      </div>
      <!-- END Main wrapper-->
      <!-- START Scripts-->
      <%@ include file="pages/script.jsp" %>
      <script type="text/javascript">
         $(window).load(function() {
         	
         	<%
            String successMsg = request.getParameter("successMessage");
            if(successMsg != null){%>
         	 alert("<%=successMsg%>");
         	 successMsg=null;
         	<% }%>
              
         });
         
         $(document).ready(function(){
         	<%	
            if(userAccess_Type.equalsIgnoreCase("public")){%>
         	
         	$('section').addClass("sidehidden");
         	$('aside').removeClass("aside");
         	
         <%}%>
         
         });
         
         
         	document.getElementById("nic").onblur = function() {validateNic()};//Write something in the input field, and then click outside the field to lose focus (blur).
         	
         	function validateNic() {
         		var nic = document.getElementById("nic").value;	
         		
         		 var lastChar = nic.charAt(nic.length - 1); // this will be return last charactor	
         		
         		 if (nic.length < 10 || nic.length > 10) {
         	            alert("Invalid length of NIC. Please check again.");
         	        }
         		 else if(nic.length == 10){
         			 if (lastChar >= '0' && lastChar <= '9') {
         			     // it is a number
         				 alert("Invalid Id number. check last character again.");
         			 }  
         			 
         		 }  
         	}
         	
         	
         	
         	
      </script>
      <!-- END Scripts--> 
   </body>
</html>

