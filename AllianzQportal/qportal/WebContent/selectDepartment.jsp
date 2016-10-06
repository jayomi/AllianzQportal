

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
                              <small>View all Departments</small>
                                <%@ include file="pages/allianzLogo.jsp" %>
                           </h3>
                           <ol class="breadcrumb">
                              <%@include file="pages/breadcrumb.jsp" %> 
                              <li class="active">Departmentss</li>
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
                                                <th>Form Name</th>
                                                <th>Description</th>
                                                <th></th>
                                                <th></th>
                                             </tr>
                                          </thead>
                                          <tbody>
                                             <%								
                                                DepartmentImpl departmentImpl = new DepartmentImpl();
                                                List<Department> departmentList = departmentImpl.getAllDepartments();
                                                
                                                //FormAssignToUserImple formAssignToUserImple=new FormAssignToUserImple();
                                                
                                                for(Department department:departmentList){%>						
                                             <tr class="gradeC">
                                                <td name="selected_formName"><%=department.getDepartmentName() %></td>
                                                <td><%=department.getDescription() %></td>
                                                <th>
                                                   <button type="button" departmentId="<%=department.getId()%>" data-toggle="modal" data-target="#departmentModal" class="editDepartmentBtn btn btn-info btn-sm">
                                                   <em class="fa fa-hand-o-right"></em>
                                                   <span>Edit</span>
                                                   </button>												
                                                </th>
                                                <th>
                                                   <button id="deleteDepartment" type="button" departmentId="<%=department.getId()%>" class="btn-danger btn-sm" title="Delete Department">
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
                  <div id="departmentModal" tabindex="-1" role="dialog"
                     aria-labelledby="myModalLabel" aria-hidden="true" class="modal fade">
                     <form action="DepartmentController" method="post">
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
                                       <input type="hidden" id="modal_departmentId" name="modal_departmentId" value="" >
                                    </div>
                                    <br><br>					
                                    <div class="col-lg-12">
                                       <input id="modal_departmentName" name="modal_departmentName" type="text" placeholder="department name"
                                          class="form-control">
                                    </div>
                                    <br><br>
                                    <div class="col-lg-12">
                                       <textarea rows="3" cols="50" id="modal_departmentDesciption" name="modal_departmentDesciption"
                                          placeholder="department description" class="form-control"></textarea>
                                    </div>
                                    <!-- </div> -->
                                 </div>
                              </div>
                              <div class="modal-footer">
                                 <button type="button" data-dismiss="modal" class="btn btn-default">Close</button>
                                 <button type="submit" class="btn btn-primary" id="modal_saveDepartmentBtn" name="modal_saveDepartmentBtn">Save changes</button>
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
                      
                      $(document).on('click', '.editDepartmentBtn', function() {	    		
                       		
                       	var departmentId=$(this).attr("departmentId");
                       	  $("#modal_departmentId").val(departmentId);
                       	//alert(formid);
                       	
                       		var departmentName='';
                       		var description='';
                       		
                       		$.ajax({
                                  	type: 'POST',
                                  	url: 'DepartmentController',	             
                                  	dataType: 'json',
                                  	data: {departmentId : departmentId},            	
                                  	cache:false,              
                                     
                                  	success: function(data){           		
                                  		
                                  		departmentName=data.departmentName;
                                  		description=data.description;              			               		
                                  		
                                  	  	//$('#modal_segmentId').val(sid);
                                      	$('#modal_departmentName').val(departmentName);
                                       $('#modal_departmentDesciption').val(description); 
                                  		
                                  	},
                                  	 error:function(){
                                           alert('error');
                                       }
                                  	
                                  });
                       		
                       	});
                      
                      
                     $(document).on('click', '#deleteDepartment', function() {
                     
                     var departmentId=$(this).attr("departmentId");
                     if (confirm('Are you sure you want to delete?')) {
                     	$.ajax({
                                  	type: 'POST',
                                  	url: 'DepartmentController',	             
                                  	dataType: 'json',
                                  	data: {deleteRowId : departmentId},            	
                                  	cache:false,              
                                     
                                  	success: function(data){           		
                                  		
                                  		alert("successfully deleted.");
                                  		var result = JSON.stringify(data.rowId);//return formID	               		
                                  	 	//alert(result);
                                  		location.href =  "selectDepartment.jsp";
                                  		
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

