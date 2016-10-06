<%@page import="com.allianz.qportalapp.model.Department"%>
<%@page import="com.allianz.qportalapp.controller.DepartmentImpl"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en" class="no-ie">

<head>
<%@ include file="pages/mainHeader.jsp" %>
<title>QPortal - Create User</title>
<style type="text/css">
input[type="number"]::-webkit-outer-spin-button,
input[type="number"]::-webkit-inner-spin-button {
    -webkit-appearance: none;
    margin: 0;
}
input[type="number"] {
    -moz-appearance: textfield;
}
     
</style>
</head>

<%
	String loggedUserName=session.getAttribute("userName").toString();
	UserImpl userImple = new UserImpl();
	String loggedUserRole = userImple.getUserRoleByUserName(loggedUserName);
	String loggedUserDepartment =  userImple.getUserDepartmentByUserName(loggedUserName);
%>

<body>
    <!-- START Main wrapper-->
    <div class="wrapper">
        <!-- START Top Navbar-->
     		<%@include file="pages/navigationBar.jsp" %>      		
       
        <!-- END Top Navbar-->
        <!-- START aside-->
        <aside class="aside">
      
			<%@include file="pages/aside.jsp" %> 
			
        </aside>
        <!-- End aside-->
        <!-- START Main section-->
        <section>
            <!-- START Page content-->
            <div class="content-wrapper">
                <h3>Create a User
               <small>Q-portal user creation ... </small>
               <%@ include file="pages/allianzLogo.jsp" %>
            </h3>
                 <ol class="breadcrumb">
                <%@include file="pages/breadcrumb.jsp" %> 
               <li class="active">Create a USer</li>
            </ol>
          
            <!-- START DATATABLE 1 -->
            <div class="row">
               <div class="col-lg-12">
                  <div class="panel panel-primary">
                      <div class="panel-heading">User</div>
                     <div class="panel-body">
                        
						 <form action="UserController" role="form" method="post" class="form-horizontal">
					
							<div class="form-group">
								<label class="col-lg-2 col-sm-2 control-label">First name * </label>
								<div class="col-lg-6">
									<input type="text" placeholder="first name" name="firstName" required="required"  class="form-control">								
	                       		 </div>
	                        </div> 
	                        
	                        <div class="form-group">
								<label class="col-lg-2 col-sm-2 control-label">Last name * </label>
								<div class="col-lg-6">
									<input type="text" placeholder="last name" name="lastName" required="required" class="form-control">	
								</div>
															
	                        </div> 
                            
                             <div class="form-group">
								<label class="col-lg-2 col-sm-2 control-label">E-mail * </label>
								<div class="col-lg-6">
								 	<input type="email" placeholder="email" name="email" required="required" class="form-control">	
								</div>
															
	                        </div>
	                        
	                         <div class="form-group">																
									
									<%
									  DepartmentImpl departmentImpl = new DepartmentImpl();
									  List<Department> departmentList =	departmentImpl.getAllDepartments();									 
									%>
									<label class="col-lg-2 col-sm-2 control-label">Department * </label>
									
									<% if(loggedUserRole.equalsIgnoreCase("admin")){%>
										<div class="col-lg-6">
	                               		<select name="department" required class="form-control" >
											<option value="">Select</option>
										<%for(Department depertment : departmentList){%>										
											<option value="<%=depertment.getDepartmentName() %>"><%=depertment.getDepartmentName() %></option>
										
										<%} %>
										</select>
										</div>
	                               <%}  else if(loggedUserRole.equalsIgnoreCase("modarator")){%> 	                            		
	                            			<div class="col-lg-6">
			                            		<select name="department" required class="form-control">
				                            		<option value="">Select</option>
				                            		<!-- <option value="public">public</option> -->
				                            		<option value="<%=loggedUserDepartment %>"><%=loggedUserDepartment%></option>
		                            			</select>
	                            			</div>
	                            <%}%>
									
							</div> 
							
							<div class="form-group">																
									
									<label class="col-lg-2 col-sm-2 control-label">Password * </label>
									<div class="col-lg-6">
									 	<input type="password" placeholder="password" name="password1" required="required" class="form-control">	   
                                	</div>
                            </div>
	                        <div class="form-group">																
									
									<label class="col-lg-2 col-sm-2 control-label">Verify Password * </label>
									<div class="col-lg-6">
									  <input type="password" placeholder="password" name="password2" required="required" class="form-control">	
									 </div>   
                                	<label>Plese input your password again.</label>
                            </div>
                            
                             <div class="form-group">																
									
									<label class="col-lg-2 col-sm-2 control-label">Role * </label>
									<% if(loggedUserRole.equalsIgnoreCase("admin")){%>
									<div class="col-lg-6">
										<select name="role">
										<option value="user">User</option>
										<option value="admin">Admin</option>
										<option value="modarator">Modarator</option>
									</select>	
									</div>
									<%} else if(loggedUserRole.equalsIgnoreCase("modarator")){%>                     		
	                            	
	                            	<div class="col-lg-6">
		                            	<select name="role">
											<option value="user">User</option>										
											<option value="modarator">Modarator</option>
										</select>	
									</div>
	                            <%}%>
									   
                                	
                            </div>
                            
                             <div class="form-group">																
									
									<label class="col-lg-2 col-sm-2 control-label">Security Question * </label>
									<div class="col-lg-6">
									<select name="securityQuestion" required="required" class="form-control">
										<option value="Who is your favorite actor, musician, or artist?">Who is your favorite actor, musician, or artist?</option>
										<option value="What is the name of your favorite pet?">What is the name of your favorite pet?</option>
										<option value="What is your favorite movie?">What is your favorite movie?</option>
										<option value="What is your mother's maiden name?">What is your mother's maiden name?</option>
										<option value="What is your favorite color?">What is your favorite color?</option>
										<option value="What is your father's middle name?">What is your father's middle name?</option>
										<option value="What is the name of your first grade teacher?">What is the name of your first grade teacher?</option>
										<option value="What was your favorite place to visit as a child?">What was your favorite place to visit as a child?</option>				
									</select>
									<br>
									<input type="text" placeholder="Please answer here" required="required" name="securityQuestionAnswer" class="form-control">
									</div>
                            </div>
                            
                            
                           
                            <div class="required">* Required fields</div>
                            
                            <div class="pull-right">
                            	<%String errorMsg = request.getParameter("errorMessage");
                            		if(errorMsg !=null){%>
                            			 <div style="color: red;"><%=errorMsg %></div>
                            	<%}%>
                            	
								<button type="submit" class="btn btn-primary" name="userRegister">Register</button>		
								 					 
							</div>
							
						</form>
						
                     </div>
                  </div>
               </div>
            </div>
            <!-- END DATATABLE 1 -->


            </div>
            <!-- END Page content-->
        </section>
        <!-- END Main section-->
        <%@ include file="pages/footer.jsp" %>
    </div>
    <!-- END Main wrapper-->
    
	 <!-- Start script-->
	<%@ include file="pages/script.jsp" %>
	 <!-- End script-->
	<script type="text/javascript">
	$(window).load(function() {
		
		<%
		String successMsg = request.getParameter("successMessage");
		if(successMsg != null){%>
		 alert("<%=successMsg%>");
		 successMsg=null;
		<% }%>
	     
	});
	</script> 
	 
	
</body>

</html>