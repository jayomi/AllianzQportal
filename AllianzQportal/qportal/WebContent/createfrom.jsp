<%@page import="com.allianz.qportalapp.controller.DepartmentImpl"%>
<%@page import="com.allianz.qportalapp.model.Department"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en" class="no-ie">

<head>
<%@ include file="pages/mainHeader.jsp" %>
<title>QPortal - Create Forms</title>
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
                <h3>Create a Form
               <small>Q-portal form creation.</small>
                <%@ include file="pages/allianzLogo.jsp" %>
            </h3>
               <ol class="breadcrumb">
               <%@include file="pages/breadcrumb.jsp" %> 
               <li class="active">Create a Form</li>
            </ol>
          
            <!-- START DATATABLE 1 -->
            <div class="row">
               <div class="col-lg-12">
                  <div class="panel panel-primary">
                      <div class="panel-heading">Froms</div>
                     <div class="panel-body">
                        
						 <form action="FormController" role="form" method="post" class="form-horizontal">
					
							<div class="form-group">
                               <label class="col-lg-2 col-sm-2 control-label">Form Name *</label>
                                <div class="col-lg-6">
							    	<input type="text" class="form-control" name="formName" placeholder="Form Name" required />
							   </div>                             
	                        </div>  
	                        
	                     
                                                   

                            <div class="form-group">
                                <label class="col-lg-2 col-sm-2 control-label">Description *</label>
                                <div class="col-lg-6">
									<input type="text" name="description" class="form-control" placeholder="Description" required>
                                </div>  
                            </div>
                            <div class="form-group">
                                <label class="col-lg-2 col-sm-2 control-label">Form Type *</label>
                                <div class="col-lg-6">
									<select class="form-control" name="formType" required>
									<option value="">None</option>
									<option value="mcq">MCQ</option>
									<option value="Analysis Structure">Analysis Structure</option>
									</select>
                                </div>
                            </div>
                             <div class="form-group">
                                <label class="col-lg-2 col-sm-2 control-label">User Acess Type *</label>
                                <div class="col-lg-6">
									<select class="form-control" name="formAccessType" required>
									<option value="">None</option>
									<option value="public">Public</option>
									<option value="special">Special</option>
									</select>
                               </div>
                            </div>
                            
                            <div class="form-group">
                                <label class="col-lg-2 col-sm-2 control-label">Pass Mark: </label>
                                <div class="col-lg-6">
									<input type="number" name="passMark" class="form-control" placeholder="pass mark" value="" />
                                </div>
                            </div>
                           <div class="row">
                           	
                           	  <div class="row">
                                <label class="col-lg-4 control-label">Form Assign to Department/Departments: </label>
                               </div>  
                               
                                <%
    							DepartmentImpl department = new DepartmentImpl();
    							List<Department> departmentList =  department.getAllDepartments();
    							%>
    							
    							<% if(loggedUserRole.equalsIgnoreCase("admin")){%>
	                               
	                                <%for(int i=0;i<7;i++){%>
	                               
	                                <div class="col-lg-3" style="white-space: pre-line;">
		                                <input type="checkbox" name="department" value="<%=departmentList.get(i).getDepartmentName()%>"><%=departmentList.get(i).getDepartmentName()%>
		 								
	                                </div>
	                               
	                                <% }%>
	                                 <%for(int i=7;i<14;i++){%>
	                                 
	                                <div class="col-lg-3" style="white-space: pre-line;">
	                                	<input type="checkbox" name="department" value="<%=departmentList.get(i).getDepartmentName()%>"  ><%=departmentList.get(i).getDepartmentName()%>
										
	                                </div>
	                                
	                                  <% }%>
	                                  <%for(int i=14;i<21;i++){%>
	                                  
	                                 <div class="col-lg-3" style="white-space: pre-line;">
	                                	<input type="checkbox" name="department" value="<%=departmentList.get(i).getDepartmentName()%>"  ><%=departmentList.get(i).getDepartmentName()%>
										
	                                </div>
	                              
	                                <% }%>
	                                 <%for(int i=21;i<departmentList.size();i++){%>
	                                 
	                                 <div class="col-lg-3" style="white-space: pre-line;">
	                                	<input type="checkbox" name="department" value="<%=departmentList.get(i).getDepartmentName()%>" ><%=departmentList.get(i).getDepartmentName()%>
										
	                                </div>
	                                
	                                  <% }%>
	                             
	                              
	                              
	                            <% }  else if(loggedUserRole.equalsIgnoreCase("modarator")){%>
	                           
	                              
	                             	                          		
	                            		<div class="col-lg-8">
		                            		<!-- <input type="checkbox" name="department" value="public" >public -->
		                            		<input type="checkbox" name="department" value="<%=loggedUserDepartment%>"><%=loggedUserDepartment%>
	                            		</div> 
	                            
	                            <%}%>
	                            
	                            
                           
                           </div>  
                            <br>
                            
                            <div class="form-inline">
                                <label class="col-lg-2 col-sm-2 control-label">Duration: </label>
								
								 <div class="col-lg-10">
								 
								hh: <select class="form-control" name="hour">
								<%for(int h=0;h<5;h++){%>
									<option><%=h %></option>
								<%} %>									
								</select>
								mm: <select class="form-control" name="minutes">
								<%for(int m=60;m>0;m--){%>
									<option><%=m %></option>
								<%} %>									
								</select>
								ss:<select class="form-control" name="seconds">
								<%for(int s=60;s>0;s--){%>
									<option><%=s %></option>
								<%} %>									
								</select>
								
                                </div>
                            </div>
                           <br><br>
                             <div class="form-group">
								<label class="col-lg-2 col-sm-2 control-label">Start Date: </label>	
								 <div class="col-lg-6">								 
                                	<input id="startDate" name="startDate" class="datepicker form-control" placeholder="start date" />
                                </div>
							</div>
							
							<div class="form-group">
								<label class="col-lg-2 col-sm-2 control-label">End Date: </label>	
								<div class="col-lg-6">									 
                                <input id="endDate" name="endDate" class="datepicker form-control" placeholder="end date"/>
                                </div>
							</div>
							
                            
                              <div class="required">* Required fields</div>
	                         
	                          <div class="pull-right">
								<button type="submit"  name="submit_formType" class="btn btn-primary">Save Form</button>		
								 					 
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
 
   $(document).ready(function() {
	    $(".datepicker").datepicker();
	  });
   
   </script>
   
	
</body>

</html>