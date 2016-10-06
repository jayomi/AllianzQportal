

<%@page import="com.allianz.qportalapp.controller.FormAssignToUserImple"%>
<%@page import="com.allianz.qportalapp.model.FormType"%>
<%@page import="com.allianz.qportalapp.controller.FormTypeImpl"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.util.ArrayList"%>
<%@page import="com.allianz.qportalapp.controller.FormAssginToDepartmentImpl"%>
<%@page import="com.allianz.qportalapp.model.DepartmentForm"%>
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
                                                <th>Form Name</th>
                                                <th>Description</th>
                                                <!-- <th>Created Date</th>
                                                   <th>End Date</th> -->
                                                <th>Type</th>
                                                <th>Access Type</th>
                                                <th>Start</th>
                                                <th>End</th>
                                                <th></th>
                                                <th></th>
                                                <th></th>
                                                <th></th>
                                                <th></th>
                                             </tr>
                                          </thead>
                                          <tbody>
                                             <%	
                                                String user_Name=session.getAttribute("userName").toString();
                                                UserImpl userImple = new UserImpl();
                                                			String department = userImple.getUserDepartmentByUserName(user_Name);    							
                                                			FormAssginToDepartmentImpl departmentImpl = new FormAssginToDepartmentImpl();
                                                			List<FormType> formList = departmentImpl.getAllFormListByDepartment(department);
                                                			FormTypeImpl formTypeImpl=new FormTypeImpl();
                                                	
                                                	for(FormType formType:formList){%>						
                                             <tr class="gradeC">
                                                <td name="selected_formName"><%=formType.getFormName() %></td>
                                                <td><%=formType.getFormDescription() %></td>
                                                <td><%=formType.getFormType()%></td>
                                                <td><%=formType.getFormAccessType()%></td>
                                                <td><%=formType.getStart()%></td>
                                                <td><%=formType.getEnd()%></td>
                                                <th>
                                                   <a href="update.jsp?selected_formName=<%=formType.getFormName()%>" class="btn btn-info btn-xs">
                                                   <em class="fa fa-hand-o-right"></em>
                                                   <span>Edit Details</span>
                                                   </a>
                                                </th>
                                                <th>
                                                   <button type="button" formid="<%=formType.getFormId()%>" departmentRowIndex="<%= formType.getDepRowIndex()%>" data-toggle="modal" data-target="#formModal" class="editFormBtn btn btn-info btn-xs">
                                                   <em class="fa fa-hand-o-right"></em>
                                                   <span>Edit Form Header</span>
                                                   </button>												
                                                </th>
                                                <% 
                                                   Boolean formPublishType = formTypeImpl.getFormpublishType(formType.getFormId());
                                                   if(formPublishType == false){	%>
                                                <!-- PUBLISH FORM -->
                                                <th>
                                                   <button type="submit" formId="<%=formType.getFormId()%>"  class="publishForm btn btn-labeled btn-primary pull-right btn-xs" name="publishForm">Publish</button>
                                                </th>
                                                <th>											
                                                   <button  class="unPublishForm btn btn-labeled btn-primary pull-right btn-xs" name="unPublishForm" disabled="disabled">Unpublish</button>
                                                </th>
                                                <%} else if(formPublishType == true){%>
                                                <!-- 	UNPUBLISH FORMS -->
                                                <th><button class="publishForm btn btn-labeled btn-primary pull-right btn-xs" name="publishForm" disabled="disabled"">Publish</button></th>
                                                <th>	
                                                   <button type="submit" formId="<%=formType.getFormId()%>" class="unPublishForm btn btn-labeled btn-primary pull-right btn-xs" name="unPublishForm">Unpublish</button>
                                                </th>
                                                <%}%>
                                                <th>
                                                   <button id="deleteForm" type="button" formid="<%=formType.getFormId()%>" departmentRowIndex="<%= formType.getDepRowIndex()%>" class="pull-right btn-danger btn-xs" title="Delete Form">
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
                  <div id="formModal" tabindex="-1" role="dialog"
                     aria-labelledby="myModalLabel" aria-hidden="true" class="modal fade">
                     <form action="UpdateFormController" method="post" class="form-horizontal">
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
                                       <input type="hidden" id="modal_formId" name="modal_formId" value="" >
                                       <input type="hidden" id="modal_rowIndex" name="modal_rowIndex" value="" > <!-- row index of form assign to department table -->
                                    </div>
                                    <br><br>
                                    <div class="form-group">
                                       <label class="col-lg-2 control-label">Name: </label>
                                       <div class="col-lg-10">
                                          <input id="modal_formName" name="modal_formName" type="text" placeholder="form name"
                                             class="form-control">
                                       </div>
                                    </div>
                                    <br><br>
                                    <div class="form-group">
                                       <label class="col-lg-2 control-label">Description: </label>
                                       <div class="col-lg-10">
                                          <textarea rows="3" cols="50" id="modal_formDesciption" name="modal_formDesciption"
                                             placeholder="form description" class="form-control"></textarea>
                                       </div>
                                    </div>
                                    <div class="form-group">
                                       <label class="col-lg-2 control-label">Form Type: </label>
                                       <div class="col-lg-10">
                                          <select id="modal_formType" name="modal_formType" class="form-control">
                                             <option value="mcq">mcq</option>
                                             <option value="Analysis Structure">Analysis Structure</option>
                                          </select>
                                       </div>
                                    </div>
                                    <div class="form-group">
                                       <label class="col-lg-2 control-label">Access Type: </label>
                                       <div class="col-lg-10">
                                          <select id="modal_formAccessType" name="modal_formAccessType" class="form-control">
                                             <option value="special">special</option>
                                             <option value="public">public</option>
                                          </select>
                                       </div>
                                    </div>
                                    <div class="form-group">
                                       <label class="col-lg-2 control-label">Department: </label>
                                       <div class="col-lg-10">
                                          <select id="modal_department" name="modal_department" class="form-control">
                                             <option value="public">public</option>
                                             <option value="<%=department %>"><%=department %></option>
                                          </select>
                                       </div>
                                    </div>
                                    <div class="form-group">
                                       <label class="col-lg-2 control-label">Start Date: </label>
                                       <div class="col-lg-10">
                                          <input id="modal_startDate" name="modal_startDate" type="text"
                                             class="bdate form-control">
                                       </div>
                                    </div>
                                    <div class="form-group">
                                       <label class="col-lg-2 control-label">End Date: </label>
                                       <div class="col-lg-10">
                                          <input id="modal_endDate" name="modal_endDate" type="text" 
                                             class="bdate form-control">
                                       </div>
                                    </div>
                                   </div>
                                 </div>
                              </div>
                              <div class="modal-footer">
                                 <button type="button" data-dismiss="modal" class="btn btn-default">Close</button>
                                 <button type="submit" class="btn btn-primary" id="modal_saveFormBtn" name="modal_saveFormBtn">Save changes</button>
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
                      
                      $(".bdate").datepicker({
                        	changeMonth: true,
                        	changeYear: true,
                        	yearRange: "1970:2020"
                        	});
                      
                      
                      $(document).on('click', '.editFormBtn', function() {	    		
                       		
                       	var formid=$(this).attr("formid");
                       	var rowIndex = $(this).attr("departmentRowIndex");
                       	
                       	 $("#modal_formId").val(formid);
                       	 $("#modal_rowIndex").val(rowIndex);
                       	//alert(formid);
                       	
                       		var segmentName='';
                       		var segmentDescription='';
                       		
                       		$.ajax({
                                  	type: 'POST',
                                  	url: 'UpdateModalFormContoller',	             
                                  	dataType: 'json',
                                  	data: {formId : formid, rowIndex : rowIndex},            	
                                  	cache:false,              
                                     
                                  	success: function(data){           		
                                  		
                                  		formName=data.formName;
                                  		formDescription=data.formDescription;
                                  		formAcessType = data.formAcessType;
                                  		formType = data.formType;
                                  		startDate = data.startDate;
                                  		endDate = data.endDate;
                                  		department = data.department;
                                  		
                                  	  	//$('#modal_segmentId').val(sid);
                                      	$('#modal_formName').val(formName);
                                       $('#modal_formDesciption').val(formDescription); 
                                       $('#modal_startDate').val(startDate);
                                       $('#modal_endDate').val(endDate);
                                  		$('#modal_formType').val(formType);
                                  		$('#modal_formAccessType').val(formAcessType);
                                  		$('#modal_department').val(department);
                                  	},
                                  	 error:function(){
                                           alert('error');
                                       }
                                  	
                                  });
                       		
                       	});
                      
                      
                     $(document).on('click', '#deleteForm', function() {
                     
                     var formid=$(this).attr("formid");
                     var rowIndex = $(this).attr("departmentRowIndex");
                     
                     if (confirm('Are you sure you want todelete?')) {
                     	$.ajax({
                                  	type: 'POST',
                                  	url: 'deleteController',	             
                                  	dataType: 'json',
                                  	data: {formId : formid,rowIndex : rowIndex},           	
                                  	cache:false,              
                                     
                                  	success: function(data){           		
                                  		
                                  		alert("successfully deleted.");
                                  		var result = JSON.stringify(data.formId);//return formID	               		
                                  	 	//alert(result);
                                  		location.href =  "modarator_selectForm.jsp";
                                  		
                                  	},
                                  	 error:function(){
                                           alert('error');
                                       }
                                  	
                                  });
                     } else {
                       	    // Do nothing!
                       	    alert("canceling.");
                       	}
                     	
                     }); 
                     
                     
                     //publishForm
                     $(document).on('click', '.publishForm', function() {
                     
                     var formId = $(this).attr("formId");
                     
                     
                     if (confirm('Are you sure you want publish form?')) {
                     		 $.ajax({
                                	type: 'POST',
                                	url: 'UpdateSegmentController',	             
                                	dataType: 'json',
                                	data: {publishFormId : formId},            	
                                	cache:false,              
                                   
                                	success: function(data){           		
                                		
                                		alert("successfully publish form..........");
                                		/* var url = JSON.stringify(data.url);	 */
                                		var url = data.url;	
                                		
                                		location.href =  url;
                                			               		
                                	},
                                	 error:function(){
                                		location.href =  "selectForm.jsp";
                                     }
                                	
                                }); 
                     	} else {
                     	    // Do nothing!
                     	    alert("canceling.");
                     	}
                     
                     });
                     
                     //unpublish
                     $(document).on('click', '.unPublishForm', function() {
                     
                     var formId = $(this).attr("formId");
                     
                     
                     if (confirm('Are you sure you want unPublish form?')) {
                     		 $.ajax({
                                	type: 'POST',
                                	url: 'UpdateSegmentController',	             
                                	dataType: 'json',
                                	data: {unPublishForm : formId},            	
                                	cache:false,              
                                   
                                	success: function(data){           		
                                		
                                		alert("successfully unPublish form..........");
                                		/* var url = JSON.stringify(data.url);	 */
                                		var url = data.url;	
                                		
                                		location.href =  url;
                                			               		
                                	},
                                	 error:function(){
                                		location.href =  "selectForm.jsp";
                                     }
                                	
                                }); 
                      	} else {
                      	    // Do nothing!
                      	    alert("canceling.");
                      	}
                     
                     
                     });
                     
                     
                     });
                     
                  </script>  
               </body>
            </html>

