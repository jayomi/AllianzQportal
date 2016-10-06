<%@page import="com.allianz.qportalapp.controller.FormAssginToDepartmentImpl"%>
<%@page import="com.allianz.qportalapp.model.SubmitForm"%>
<%@page import="com.allianz.qportalapp.controller.FormAssignToUserImple"%>
<%@page import="com.allianz.qportalapp.model.FormType"%>
<%@page import="com.allianz.qportalapp.controller.FormTypeImpl"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="com.allianz.qportalapp.controller.UserImpl"%>
<%@ page import="com.allianz.qportalapp.model.DepartmentForm"%>

<%@ page import="java.util.Calendar"%>

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
    <title>Select exam status</title>
    
</head>

<body>
	<%String departmentName = request.getParameter("departmentName").toString(); %>
 
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
            	<%-- <h2><%=userName%></h2> --%>
                <h3>Questionnaires
               <small>View all Questionnaires
               </small> 
                <%@ include file="pages/allianzLogo.jsp" %>              
            </h3>
                  <ol class="breadcrumb">
               <%@include file="pages/breadcrumb.jsp" %> 
               <li class="active"><%=departmentName %></li>
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
                              	<th>Form Id</th>
                                 <th>Form Name</th>
                                 <th>Form Type</th>
                                 <th>Access Type</th>
                                 <th>Start</th>
                                 <th>End</th>
                                 <th></th>
                                 <th></th>
                              </tr>
                           </thead>
                           <tbody>
                                                
								<%
								String userAccess_Type=session.getAttribute("user_access_Type").toString();
								if(userAccess_Type.equalsIgnoreCase("special")){									
								
								String user_Name=session.getAttribute("userName").toString();
								
								FormAssginToDepartmentImpl departmentImpl = new FormAssginToDepartmentImpl();
								List<DepartmentForm> departmentFormList = departmentImpl.getFormsAssignedToDepatmentByDepartmentName(departmentName);
														
    							
    							for(DepartmentForm form : departmentFormList){
								//for(int i=0;i<formList.size();i++){
									int formId = form.getFormId();																	
									String formName = form.getFormName();
									
									Date start=null;
	    							Date end=null;
	    							
	    							FormAssignToUserImple formAssignToUserImple=new FormAssignToUserImple();
									//start=formAssignToUserImple.getStartDateByFormId(formId);
									//end=formAssignToUserImple.getEndDateByFormId(formId);
									
									FormTypeImpl formTypeImpl=new FormTypeImpl();
									FormType formType=formTypeImpl.getFormByFormId(formId);	
									start = form.getStartDate();
									end = form.getEndDate();
									
									if(start==null | end ==null){
										start=Calendar.getInstance().getTime();
										end=Calendar.getInstance().getTime();
										SimpleDateFormat sdf = new SimpleDateFormat("MM/dd/yyyy");
										sdf.format(start);
										sdf.format(end);
									}
								%>								
									
									<tr class="gradeC">
									<td><%=formId %></td>
									 <td><%=formName%></td>
									<td><%=formType.getFormType()%></td>
    								<td><%=formType.getFormAccessType()%></td>
    								<td><%=start %></td>
    								<td><%=end %></td>
									 
									<th>
    										<a href="viewForm.jsp?selected_formName=<%=formName%>" class="btn btn-info btn-sm">
    											<em class="fa fa-hand-o-right"></em>
    											<span>View Form</span>
    										</a>
    										
    								</th>
    								<th>
    										<a href="summary.jsp?formId=<%=formId%>&department=<%=departmentName %>" class="btn btn-info btn-sm">
    											<em class="fa fa-hand-o-right"></em>
    											<span>View Summary</span>
    										</a>
    										
    								</th>
								</tr>
							<% }%>	 
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
    <!-- START Scripts-->
		<%@ include file="pages/script.jsp" %>
    <!-- END Scripts-->
</body>

</html>