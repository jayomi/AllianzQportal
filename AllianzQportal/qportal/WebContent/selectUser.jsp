

<%@page import="com.allianz.qportalapp.controller.DepartmentImpl"%>
<%@page import="com.allianz.qportalapp.controller.FormAssignToUserImple"%>
<%@page import="com.allianz.qportalapp.model.FormType"%>
<%@page import="com.allianz.qportalapp.controller.FormTypeImpl"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="com.allianz.qportalapp.model.Department"%>
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
                  <title>QPortal - Questionnaires</title>
               </head>
               <body>
                  <!-- START Main wrapper-->
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
                           <%--  <h2><%=userName %></h2>  --%>
                           <h3>Questionnaires
                              <small>View all Users</small>
                              <%@ include file="pages/allianzLogo.jsp" %>
                           </h3>
                           <ol class="breadcrumb">
                              <%@include file="pages/breadcrumb.jsp" %> 
                              <li class="active">Users</li>
                           </ol>
                           <!-- START DATATABLE 1 -->
                           <div class="row">
                              <div class="col-lg-12">
                                 <div class="panel panel-primary">
                                    <div class="panel-heading">Users</div>
                                    <div class="panel-body">
                                       <table id="datatable1" class="table table-striped table-hover">
                                          <thead>
                                             <tr>
                                                <th>First Name</th>
                                                <th>Last Name</th>
                                                <th>User Name</th>
                                                <!--   <th>Password</th> -->
                                                <th>Email</th>
                                                <th>Role</th>
                                                <th>Department</th>
                                                <th></th>
                                                <th></th>
                                             </tr>
                                          </thead>
                                          <tbody>
                                             <%								
                                                UserImpl userImpl = new UserImpl();
                                                List <User> userList = userImpl.getUserList();
                                                	
                                                	
                                                	//FormAssignToUserImple formAssignToUserImple=new FormAssignToUserImple();
                                                	
                                                	for(User user:userList){%>						
                                             <tr class="gradeC">
                                                <td><%=user.getFirstName() %></td>
                                                <td><%=user.getLastName()%></td>
                                                <td><%=user.getUserName() %></td>
                                                <%--  <td><%=user.getPassword()%></td> --%>
                                                <td><%=user.getEmail()%></td>
                                                <td><%=user.getRole() %></td>
                                                <td><%=user.getDepartment()%></td>
                                                <th>
                                                   <button type="button" userId="<%=user.getId()%>" data-toggle="modal" data-target="#userModal" class="editUserBtn btn btn-info btn-sm">
                                                   <em class="fa fa-hand-o-right"></em>
                                                   <span>Edit</span>
                                                   </button>												
                                                </th>
                                                <th>
                                                   <button id="deleteUser" type="button" userId="<%=user.getId()%>" class="pull-right btn-danger btn-sm" title="Delete User">
                                                      <em class="fa fa-times"></em>
                                                      <!-- <span>Delete</span> -->
                                                   </button>
                                                </th>
                                             </tr>
                                             <%}%>
                                          </tbody>
                                       </table>
                                    </div>
                                 </div>
                              </div>
                           </div>
                           <!-- END DATATABLE 1 -->         
                        </div>
                        <!-- END Page content-->
                     </section>
                     <!-- END Main section-->
                      <%@include file="pages/footer.jsp" %>
                  </div>
                  
                  <!-- END Main wrapper-->
                  
                  <!--  start form modal   -->  
                  <div id="userModal" tabindex="-1" role="dialog"
                     aria-labelledby="myModalLabel" aria-hidden="true" class="modal fade">
                     <form action="UserController" method="post" class="form-horizontal">
                        <div class="modal-dialog">
                           <div class="modal-content panel-primary">
                              <div class="modal-header panel-heading">
                                 <button id="" type="button" data-dismiss="modal" aria-hidden="true"
                                    class="close">×</button>
                                 <h4 id="myModalLabel" class="modal-title">Edit Form
                                    <%-- <input type="hidden" value="<%=request.getParameter("selected_formName")%>" name="formName"> --%>
                                 </h4>
                              </div>
                              <div class="modal-body">
                                 <div class="row">
                                 <div class="col-lg-12">
                                 	
                                    <div class="col-lg-12">
                                       <input type="hidden" id="modal_userId" name="modal_userId" value="" >
                                    </div>
                                    <div class="form-group">
                                       <label class="col-lg-4 control-label">First Name :</label>
                                       <div class="col-lg-8">
                                          <input id="modal_firstName" name="modal_firstName" type="text" placeholder="first name"
                                             class="form-control">
                                       </div>
                                    </div>
                                    <div class="form-group">
                                       <label class="col-lg-4 control-label">Last Name :</label>
                                       <div class="col-lg-8">
                                          <input id="modal_lastName" name="modal_lastName" type="text" placeholder="last name"
                                             class="form-control">
                                       </div>
                                    </div>
                                    <div class="form-group">
                                       <label class="col-lg-4 control-label">Username :</label>
                                       <div class="col-lg-8">
                                          <input id="modal_userName" name="modal_userName" type="text" placeholder="username"
                                             class="form-control">
                                       </div>
                                    </div>
                                    <div class="form-group">
                                       <label class="col-lg-4 control-label">password :</label>
                                       <div class="col-lg-8">
                                          <input id="modal_password" name="modal_password" type="password" placeholder="password"
                                             class="form-control">
                                       </div>
                                    </div>
                                    <div class="form-group">
                                       <label class="col-lg-4 control-label">Email :</label>
                                       <div class="col-lg-8">
                                          <input id="modal_email" name="modal_email" type="email" placeholder="email"
                                             class="form-control">
                                       </div>
                                    </div>
                                    <div class="form-group">
                                       <label class="col-lg-4 control-label">Role :</label>
                                       <div class="col-lg-8">
                                          <select id="modal_role" name="modal_role" class="form-control">
                                             <option value="admin">Admin</option>
                                             <option value="modarator">Modarator</option>
                                             <option value="user">User</option>
                                          </select>
                                       </div>
                                    </div>
                                    <div class="form-group">
                                       <%
                                          DepartmentImpl departmentImpl = new DepartmentImpl();
                                          List<Department> departmentList =	departmentImpl.getAllDepartments();									 
                                          %>
                                       <label class="col-lg-4 control-label">Department :</label>
                                       <div class="col-lg-8">
                                          <select id="modal_department" name="modal_department" class="form-control">
                                             <option value="">Select</option>
                                             <%for(Department depertment : departmentList){%>										
                                             <option value="<%=depertment.getDepartmentName() %>"><%=depertment.getDepartmentName() %></option>
                                             <%} %>
                                          </select>
                                       </div>
                                    </div>
                                 </div>
                                 </div>
                              </div>
                              <div class="modal-footer">
                                 <button type="button" data-dismiss="modal" class="btn btn-default">Close</button>
                                 <button type="submit" class="btn btn-primary" id="modal_saveUserBtn" name="modal_saveUserBtn">Save changes</button>
                              </div>
                           </div>
                        </div>
                     </form>
                  </div>
                  <!-- end form modal -->
                  <!-- START Scripts-->
                  <%@ include file="pages/script.jsp" %>
                  <!-- END Scripts-->
                  <script type="text/javascript">
                     $(document).ready(function(){  
                      
                      $(document).on('click', '.editUserBtn', function() {	    		
                       		
                       	var userId=$(this).attr("userId");
                       	  $("#modal_userId").val(userId);
                       	//alert(formid);   		
                       		
                       		$.ajax({
                                  	type: 'POST',
                                  	url: 'UserController',	             
                                  	dataType: 'json',
                                  	data: {userId : userId},            	
                                  	cache:false,              
                                     
                                  	success: function(data){           		
                                  		
                                  		var firstName=data.firstName;
                                  		var lastName=data.lastName; 
                                  		var userName = data.userName;
                                  		var password = data.password;
                                  		var email = data.email;
                                  		var role = data.role;
                                  		var department = data.department;
                                  		
                                  	  	//$('#modal_segmentId').val(sid);
                                      	$('#modal_firstName').val(firstName);
                                       $('#modal_lastName').val(lastName); 
                                       $('#modal_userName').val(userName);
                                       $('#modal_password').val(password); 
                                       $('#modal_email').val(email); 
                                       $('#modal_role').val(role);
                                       $('#modal_department').val(department); 
                                  		
                                  	},
                                  	 error:function(){
                                           alert('error');
                                       }
                                  	
                                  });
                       		
                       	});
                      
                      
                     $(document).on('click', '#deleteUser', function() {
                     
                     var delete_userId=$(this).attr("userId");
                     if (confirm('Are you sure you want to delete?')) {
                     	$.ajax({
                                  	type: 'POST',
                                  	url: 'UserController',	             
                                  	dataType: 'json',
                                  	data: {deleteUser : delete_userId},            	
                                  	cache:false,              
                                     
                                  	success: function(data){           		
                                  		
                                  		alert("successfully deleted.");
                                  		var result = JSON.stringify(data.rowId);//return formID	               		
                                  	 	//alert(result);
                                  		//location.href =  "selectDepartment.jsp";
                                  		location.href =  data.url;
                                  		
                                  	},
                                  	 error:function(){
                                           alert('error');
                                       }
                                  	
                                  });
                     } else {
                       	    // Do nothing!
                       	    alert("cancel deleting.");
                       	}
                     	
                     }); 
                     
                     });
                     
                  </script>  
               </body>
            </html>

