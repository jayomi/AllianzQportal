

<%@page import="com.allianz.qportalapp.controller.FormAssignToUserImple"%>
<%@page import="com.allianz.qportalapp.controller.FormAssignToUserController"%>
<%@page import="com.allianz.qportalapp.model.FormType"%>
<%@page import="com.allianz.qportalapp.controller.FormTypeImpl"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.util.Calendar"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%-- <%@ page import="java.sql.Date"%> --%>
<%@ page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<!DOCTYPE html>
<!--[if lt IE 7]> 
<html class="ie ie6 lt-ie9 lt-ie8 lt-ie7" lang="en">
   <![endif]-->
   <!--[if IE 7]>    
   <html class="ie ie7 lt-ie9 lt-ie8"        lang="en">
      <![endif]-->
      <!--[if IE 8]>    
      <html class="ie ie8 lt-ie9"               lang="en">
         <![endif]-->
         <!--[if IE 9]>    
         <html class="ie ie9"                      lang="en">
            <![endif]-->
            <!--[if !IE]><!-->
            <html lang="en" class="no-ie">
               <!--<![endif]-->
               <head>
                  <%@ include file="pages/mainHeader.jsp" %>
                  <title>QPortal -Questionnaires</title>
               </head>
               <body>
                  <!-- START Main wrapper-->
                  <div class="wrapper">
                     <!-- START Top Navbar-->
                     <nav role="navigation" class="navbar navbar-default navbar-top navbar-fixed-top">
                        <!-- START navbar header-->
                        <div class="navbar-header">
                           <a href="login.jsp" class="navbar-brand">
                              <div class="brand-logo">
                                 <img src="app/img/logo.png" alt="App Logo" class="img-responsive">
                              </div>
                              <div class="brand-logo-collapsed">
                                 <img src="app/img/logo-single.png" alt="App Logo" class="img-responsive">
                              </div>
                           </a>
                        </div>
                        <!-- END navbar header-->
                        <!-- START Nav wrapper-->
                        <!-- START Nav wrapper-->
                        <div class="nav-wrapper">
                           <!-- START Left navbar-->
                           <ul class="nav navbar-nav">
                              <li>
                                 <!-- Button used to collapse the left sidebar. Only visible on tablet and desktops-->
                                 <a href="#" data-toggle-state="aside-collapsed" class="hidden-xs">
                                 <em class="fa fa-navicon"></em>
                                 </a> <!-- Button to show/hide the sidebar on mobile. Visible on mobile only.-->
                                 <a href="#" data-toggle-state="aside-toggled" class="visible-xs">
                                 <em class="fa fa-navicon"></em>
                                 </a>
                              </li>
                           </ul>
                           <!-- END Left navbar-->
                           <!-- START Right Navbar-->
                           <ul class="nav navbar-nav navbar-right">
                              <li><a href="#" data-toggle="fullscreen"> <em
                                 class="fa fa-expand"></em>
                                 </a>
                              </li>
                              <li><a href="firstPage.jsp" >Home 
                                 </a>
                              </li>
                              <li>
                                 <a>
                                    <form action="register.jsp" method="post">
                                       <input type="submit" value="Register" class="register btn btn-square btn-primary btn-sm">
                                    </form>
                                 </a>
                              </li>
                           </ul>
                           <!-- END Right Navbar-->
                        </div>
                        <!-- END Nav wrapper-->
                        <!-- END Nav wrapper-->
                        <!-- START Search form-->
                        <form role="search" action="" class="navbar-form">
                           <div class="form-group has-feedback">
                              <input type="text" placeholder="Type and hit Enter.." class="form-control">
                              <div data-toggle="navbar-search-dismiss" class="fa fa-times form-control-feedback"></div>
                           </div>
                           <button type="submit" class="hidden btn btn-default">Submit</button>
                        </form>
                        <!-- END Search form-->
                     </nav>
                     <!-- END Top Navbar-->
                     <!-- START aside-->
                     <!-- End aside-->
                     <!-- START Main section-->
                     <!-- START wrapper-->
                     <div class="row row-table page-wrapper">
                        <div class="col-lg-6 col-md-6 col-sm-8 col-xs-12 align-middle">
                           <!-- START panel-->
                           <div data-toggle="play-animation" data-play="fadeIn" data-offset="0" class="panel panel-dark panel-flat">
                              <div class="panel-heading text-center">
                                 <a href="#">
                                 <img src="app/img/logo.png" alt="Image" class="block-center img-rounded">
                                 </a>
                                 <p class="text-center mt-lg">
                                    <strong>Reset Password.</strong>
                                 </p>
                              </div>
                             
                              <div class="panel-body">
                               <form class="form-horizontal">
                                 <div class="form-group">                              
                                 	 
		                               <label class="col-lg-2 control-label">User name: </label>
		                              <div class="col-lg-10">
		                                 <input id="userName" type="text" placeholder="Enter user name" class="form-control" name="userName" required="required">
		                              </div>
                                 	
                                 </div>                               
                                 <div hidden id="section2">
                                 	
                                 	 <div class="form-group">  
	                                    <label class="col-lg-2 control-label">Security question: </label>
	                                    <div class="col-lg-10" id="question">
	                                    	                       
	                                    </div>
                                     </div>
                                    <div class="form-group">                              
                                 	 
		                              <label class="col-lg-2 control-label">Answer: </label>
		                              <div class="col-lg-10">
		                                 <input type="text" id="userAnswer" class="form-control" placeholder="answer">
		                              </div>                                 	
                                  	</div>
                                  	
                                  	  <div class="form-group">
                                  	   <button class="testAnswerBtn btn btn-block btn-primary" name="testAnswerBtn">Submit</button>
                                  	  </div>  
                                    
                                 </div>
                                 <div hidden id="section3">
                                 
                                 	<div class="form-group">  
	                                    <label class="col-lg-2 control-label">New Password : </label>
	                                    <div class="col-lg-10">
	                                    	 <input id="password1" type="password" placeholder="Password" class="form-control" name="password1" required="required">                      
	                                    </div>
                                    </div>
                                 	
                                 	<div class="form-group">  
	                                    <label class="col-lg-2 control-label">Re-Enter New Password : </label>
	                                    <div class="col-lg-10">
	                                    	 <input id="password2" type="password" placeholder="Type Password Again" class="form-control" name="password2" required="required">                      
	                                    </div>
                                    </div>												
                                     <div class="form-group">
                                      	<button class="reset btn btn-block btn-primary" name="reset">Reset</button>
                                     </div>
                                    
                                    
                                 </div>
                                 <div class="form-group">
                                    <button class="resetPasswdBtn btn btn-block btn-primary" name="resetPasswdBtn">Submit</button>
                                 </div>
                                 
                                 <%String errorMsg = request.getParameter("errorMessage"); 
                                       if(errorMsg !=null){ %>
                                    <div style="color: red;"><%=errorMsg%></div>
                                    <%}
                                       %>
                                
                                </form>       
                              </div>
                             
                             
                           </div>
                           <!-- END panel-->
                        </div>
                     </div>
                      <%@include file="pages/footer.jsp" %>
                  </div>
                  <!-- END DATATABLE 1 -->
                  <!-- START Scripts-->
                  <%@ include file="pages/script.jsp" %>
                  <!-- END Scripts-->
                  <script type="text/javascript">
                     $(document).ready(function(){ 
                      
                     
                      $(document).on('click', '.resetPasswdBtn', function() {
                       		
                       		var userName = document.getElementById("userName").value;
                       		
                       	
                       	
                       		 $.ajax({
                                  	type: 'POST',
                                  	url: 'PasswordResetController',	             
                                  	dataType: 'json',
                                  	data: {resetUserName : userName,errorMessage : null},            	
                                  	cache:false,              
                                     
                                  	success: function(data){           		
                                  		
                                  		
                                  		var securityQuestion = data.securityQuestion;
                                  		var errorMessage = data.errorMessage;
                                  		
                                  		
                                  	   if(securityQuestion!=null){
                                  		 $('#question').text(securityQuestion);                                  	 	
                                   	 	 $("#section2").removeAttr("hidden");
                                   	     $(".resetPasswdBtn").hide();
                                   	 	 $(".testAnswerBtn").show();
                                  	   }else if(errorMessage!=null){
                                  		   alert(errorMessage);
                                  		   location.href =  "resetPassword.jsp";
                                  	   }
                                  	   
                                  			               		 
                                  	},
                                  	 error:function(){
                                  		 
                                  		
                                  		alert(errorMessage);
                                  		
                                       }
                                  	
                                  });
                       		 
                       		
                       });
                      
                      //testAnswerBtn
                      $(document).on('click', '.testAnswerBtn', function() {
                     
                      	
                     var userName = document.getElementById("userName").value;
                     var question = document.getElementById("question").value;
                     var answer = document.getElementById("userAnswer").value;
                     
                     $.ajax({
                             	type: 'POST',
                             	url: 'PasswordResetController',	             
                             	dataType: 'json',
                             	data: {testUserName : userName,question : question ,userAnswer : answer},            	
                             	cache:false,              
                                
                             	success: function(data){           		
                             		
                             		
                             		var securityQuestionAnswer = data.securityQuestionAnswer;	
                             		var message = data.msg;
                             		if(securityQuestionAnswer!=null){
                             		 $("#section2").hide();           		
                             		 $(".resetPasswdBtn").hide();
                             		 $("#section3").removeAttr("hidden");
                             		 
                             		}
                             		if(message!=null){
                             			alert('try again.');
                             		}
                             	   
                             	},
                             	 error:function(){
                             		alert("error...");
                                  }
                             	
                             });
                     
                     });
                      
                      //reset
                     $(document).on('click', '.reset', function() {
                     
                      	
                     var userName = document.getElementById("userName").value;
                     var password1 = document.getElementById("password1").value;
                     var password2 = document.getElementById("password2").value;
                     
                     $.ajax({
                             	type: 'POST',
                             	url: 'PasswordResetController',	             
                             	dataType: 'json',
                             	data: {userName : userName,password1 : password1 ,password2 : password2},            	
                             	cache:false,              
                                
                             	success: function(data){           		
                             		
                             		
                             		var url = data.url;	
                             		var message = data.message;
                             		if(message!=null){
                             			alert(message);
                             		}
                             		if(url!=null){
                             			
                             		location.href =  url;
                             		
                             		}
                             		
                             	   
                             	},
                             	 error:function(){
                             		alert("error...");
                                  }
                             	
                             });
                     
                     });
                     
                      
                      
                     });
                     
                      
                  </script>
               </body>
            </html>

