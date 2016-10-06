<%@page import="com.allianz.qportalapp.model.DepartmentForm"%>
<%@page import="com.allianz.qportalapp.controller.FormAssginToDepartmentImpl"%>
<%@page import="com.allianz.qportalapp.controller.FormAssignToUserImple"%>
<%@page import="com.allianz.qportalapp.model.FormType"%>
<%@page import="com.allianz.qportalapp.controller.FormTypeImpl"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.util.ArrayList"%>
<%@page import="com.allianz.qportalapp.controller.DepartmentImpl"%>
<%@page import="com.allianz.qportalapp.model.Department"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<!--[if lt IE 7]> <html class="ie ie6 lt-ie9 lt-ie8 lt-ie7" lang="en"> <![endif]-->
<!--[if IE 7]>    <html class="ie ie7 lt-ie9 lt-ie8"        lang="en"> <![endif]-->
<!--[if IE 8]>    <html class="ie ie8 lt-ie9"               lang="en"> <![endif]-->
<!--[if IE 9]>    <html class="ie ie9"                      lang="en"> <![endif]-->
<!--[if !IE]><!-->
<html lang="en" class="no-ie">
<!--<![endif]-->

<head>
    
   
    <%@ include file="pages/mainHeader.jsp" %>    
    <title>QPortal - Forms</title>
   
</head>

<%
	String loggedUserName=session.getAttribute("userName").toString();
	UserImpl userImple = new UserImpl();
	String loggedUserRole = userImple.getUserRoleByUserName(loggedUserName);
	String loggedUserDepartment =  userImple.getUserDepartmentByUserName(loggedUserName);
%>

<body>
   
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
               <small>View all Questionnaires</small>
                <%@ include file="pages/allianzLogo.jsp" %>
            </h3>
                <ol class="breadcrumb">
                 <%@include file="pages/breadcrumb.jsp" %> 
               <li class="active">Questionnaires</li>
            </ol>
              
            <!-- START DATATABLE 1 -->
            <div class="row">
               <div class="col-lg-12">
                  <div class="panel panel-primary">
                      <div class="panel-heading">Froms</div>
                     <div class="panel-body">
                        <table id="datatable1" class="table table-striped table-hover">
                           <thead>
                              <tr>
                              	 <th></th>
                                 <th>Form ID</th>
                                 <th>Form Name</th>                                
                                 <th>Department</th>
                                 <th>Start Date</th>
                                 <th>End Date</th>
                                
                                 <th></th>                              
                              </tr>
                           </thead>
                           <tbody>
								<%
									
    								FormAssginToDepartmentImpl departmentImpl = new FormAssginToDepartmentImpl();
									//List<DepartmentForm> formList = departmentImpl.getFormsAssignedToDepatment();						
									List<DepartmentForm> formList = departmentImpl.getFormsAssignedToDepatmentByDepartmentName(loggedUserDepartment);
									
									//FormAssignToUserImple formAssignToUserImple=new FormAssignToUserImple();
									
									for(DepartmentForm form:formList){%>						
										
										<tr class="gradeC">
										<td><div id="tableRowId" hidden="hidden"><%=form.getId()%></div></td>
											 <td><%=form.getFormId() %></td>
											 <td name="selected_formName"><%=form.getFormName() %></td>											
											 <td><%=form.getDepartment()%></td>
											  <td><%=form.getStartDate()%></td>
											   <td><%=form.getEndDate()%></td>
											<th>
												<a href="viewForm.jsp?selected_formName=<%=form.getFormName()%>" class="btn btn-info btn-sm">
													<em class="fa fa-hand-o-right"></em>
													<span>View</span>
												</a>
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
        <%@ include file="pages/footer.jsp" %>
    </div>
    <!-- END Main wrapper-->


 <!--  start form modal   -->  
       
	<div id="departmentModal" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel" aria-hidden="true" class="modal fade">
		<form action="FormAssignToDeptmntController" method="post">
		<div class="modal-dialog">
			<div class="modal-content panel-primary">
				<div class="modal-header panel-heading">
					<button id="" type="button" data-dismiss="modal" aria-hidden="true"
						class="close">×</button>
					<h4 id="myModalLabel" class="modal-title">Edit Assigned Form to Department
					<%-- <input type="hidden" value="<%=request.getParameter("selected_formName")%>" name="formName"> --%>
					
					</h4>
				</div>
				<div class="modal-body">
					<div class="row">
											
							<div class="col-lg-12">
								<input type="hidden" id="modal_rowIndex" name="modal_rowIndex" value="" >
							</div>
							<br><br>					
							<div class="col-lg-12">
								<input id="modal_formName" name="modal_formName" type="text" placeholder="form name"
									class="form-control" readonly="readonly">
							</div>
							<br><br>
							<%
							DepartmentImpl department = new DepartmentImpl();
							List<Department> departmentList =  department.getAllDepartments();
							%>
							<div class="col-lg-12">
								<label class="col-lg-3 col-sm-2 control-label">Department: </label>
									<select id="modal_department" name="modal_department" required>
										<option value="">Select</option>
										<option value="public">Public</option>
										
									<% for(Department dept : departmentList){%>
										 <option value="<%=dept.getDepartmentName() %>" ><%=dept.getDepartmentName() %></option>
									<%}%>											
									</select>     
                                
							</div>
							<div class="col-lg-12">
								<label class="col-lg-3 col-sm-2 control-label">Start Date: </label>									 
                                <input id="modal_startDate" name="modal_startDate" class="datepicker" />
							</div>
							<div class="col-lg-12">
								<label class="col-lg-3 col-sm-2 control-label">End Date: </label>									 
                                <input id="modal_endDate" name="modal_endDate" class="datepicker" />
							</div>
							
							
						<!-- </div> -->
					</div>
				</div>
				<div class="modal-footer">
					<button type="button" data-dismiss="modal" class="btn btn-default">Close</button>
					<input type="submit" class="btn btn-primary" value="Save changes" id="modal_saveUpdateDeptBtn" name="modal_saveUpdateDeptBtn"/>
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
		  
		  $(".datepicker").datepicker();
		  
		  $(document).on('click', '.editDepartmentBtn', function() {	    		
	    	
			 
	    	var row=$(this).attr("rowIndex");
	    	  $("#modal_rowIndex").val(row);
	    	
	    	//alert(formid);
	    	
	    		var formName='';
	    		var department='';
	    		var startDate='';
	    		var endDate='';
	    		
	    		$.ajax({
	               	type: 'POST',
	               	url: 'FormAssignToDeptmntController',	             
	               	dataType: 'json',
	               	data: {updatedRow : row},            	
	               	cache:false,              
	                  
	               	success: function(data){           		
	               		
	               		formName=data.formName;
	               		department=data.department;  
	               		startDate = data.startDate;
	               		endDate = data.endDate;
	               		
	               	  	//$('#modal_segmentId').val(sid);
	                   	$('#modal_formName').val(formName);
	                    $('#modal_department').val(department); 
	                    $('#modal_startDate').val(startDate);
	                    $('#modal_endDate').val(endDate); 
	                    
	               		
	               	},
	               	 error:function(){
	                        alert('error');
	                    }
	               	
	               });
	    		
	    	});
		  
		  
		  //delete form assign to department
		  $(document).on('click', '#deleteFormAssignedToDept', function() {
				
				var row=$(this).attr("rowIndex");
					if (confirm('Are you sure you want todelete?')) {
						$.ajax({
			               	type: 'POST',
			               	url: 'FormAssignToDeptmntController',	             
			               	dataType: 'json',
			               	data: {deleteRow : row},            	
			               	cache:false,              
			                  
			               	success: function(data){           		
			               		
			               		alert("successfully deleted.");
			               		var result = JSON.stringify(data.rowIndex);//return formID	               		
			               	 	//alert(result);
			               		location.href =  "ListForms_DepartmentWise.jsp";
			               		
			               	},
			               	 error:function(){
			                        alert('error deleting.');
			                    }
			               	
			               });
					} else {
			    	    // Do nothing!
			    	    alert("cancel deleting.");
			    	}
						
					}); 
			// end of delete form assign to department
 	});
	  
	  </script>     
  
</body>

</html>