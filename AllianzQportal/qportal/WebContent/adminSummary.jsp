<%@page import="com.allianz.qportalapp.controller.FormSummaryImpl"%>
<%@page import="com.allianz.qportalapp.controller.FormAssignToUserImple"%>
<%@page import="com.allianz.qportalapp.model.FormType"%>
<%@page import="com.allianz.qportalapp.controller.FormTypeImpl"%>
<%@page import="com.allianz.qportalapp.model.SubmitForm"%>
<%@page import="com.allianz.qportalapp.controller.FormQuestionImpl"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.util.List"%>
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
	
	FormTypeImpl formTypeImpl=new FormTypeImpl();
	FormType form=formTypeImpl.getFormByFormId(formId);
	String form_type = form.getFormType();
	String formName = form.getFormName();
	//String formDescription = form.getFormDescription();
	
	FormSummaryImpl formSummaryImpl = new FormSummaryImpl();
	int noOffinishedUsers = formSummaryImpl.getNoOfFinishedUsersByFormId(formId);
	int noOfPartiallyFinishedUsers = formSummaryImpl.getNoOfPartiallyFinishedUsersByFormId(formId);
	int noOfPassUsers = formSummaryImpl.getNoOfPassUsersByForm(formId);
	int noOfFaildUsers = formSummaryImpl.getNoOfFaildUsersByForm(formId);
%>

	
	<div class="wrapper">
		<!-- START Top Navbar-->		
<%@include file="pages/navigationBar.jsp" %>    
		<!-- END Top Navbar-->
		<!-- START aside-->		
<%@include file="pages/aside.jsp" %>   
		<!-- End aside-->
		<!-- START Main section-->
		
		<section> <!-- START Page content-->
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
											<div class="text-md m0"><%=noOffinishedUsers %></div>
											<p>Number of Users completed</p>
										</div>
									</div>
								</div>
								<div class="col-sm-2">
									<div class="panel widget">
										<div class="panel-body bg-primary text-center">
											<div class="text-md m0"><%=noOfPassUsers%></div>
											<p>Number of Passed Users</p>
										</div>
									</div>
								</div>
								
								<div class="col-sm-2">
									<div class="panel widget">
										<div class="panel-body bg-primary text-center">
											<div class="text-md m0"><%=noOfFaildUsers %></div>
											<p>Number of Faild Users</p>
										</div>
									</div>
								</div>
								
							</div>
						</div>
					</div>
					<!-- END panel-->
				</div>
			</div>
		<%}else{%>
			
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
										<div class="text-md m0"><%=noOffinishedUsers %></div>
										<p>Number of Users completed</p>
									</div>
								</div>
							</div>
							<div class="col-sm-2">
								<div class="panel widget">
									<div class="panel-body bg-primary text-center">
										<div class="text-md m0"><%=noOfPartiallyFinishedUsers %></div>
										<p>Number of Users Partially Compleated</p>
									</div>
								</div>
							</div>
								
						<%-- 	<div class="col-sm-2">
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
							<%} % --%>
						</div>
					</div>
				</div>
				<!-- END panel-->
			</div>
		</div>
			
		<%} %>
			 <!-- START DATATABLE 1 -->
            <div class="row">
               <div class="col-lg-12">
                  <div class="panel panel-primary">
                      <div class="panel-heading">Froms</div>
                     <div class="panel-body">
                        <table id="datatable1" class="table table-striped table-hover">
                           <thead>
                              <tr>
                              	<th>Name</th>
                                  <th>Done Date</th>                                
                                 <th>Turn</th>
                                 <th></th>
                                 <th>Status</th>
                              </tr>
                           </thead>
                           <tbody>
                                        		                       
								<%
								String userAccess_Type=session.getAttribute("user_access_Type").toString();
								if(userAccess_Type.equalsIgnoreCase("special")){									
								
								String user_Name=session.getAttribute("userName").toString();
								FormAssignToUserImple formAssignToUserImple=new FormAssignToUserImple();   							
    							
    												
    							
							//partially compleated users list							
    							
    							for(SubmitForm submit: formAssignToUserImple.getAllPartiallyFinishedFormListByFormId(formId)){
    								
									String userName = submit.getUserName();										
									Date done=submit.getDoneDate();
									int turn = submit.getTurn();
									String department = submit.getDepartment();
									FormType formType = formTypeImpl.getFormByFormId(formId);	
									
								%>								
									
									<tr class="gradeC">
									<td><%=userName %></td>							
									 <td><%=done %></td>									
									 <td><%=turn%></td>
									<td>
										<a href="All_Submitted_examStatus.jsp?formId=<%=formId%>&formName=<%=formName%>&userName=<%=userName%>&turn=<%=turn%>" class="btn btn-info btn-sm">
											<em class="fa fa-hand-o-right"></em>
											<span>View</span>
										</a>
										
									</td>
									<td>
											<span class="label label-primary">Ongoing</span>
										
									</td>
								</tr>
							<% }
							//end partially compleated list
							
    							
    							//fully completed users list
    							
    							for(SubmitForm submit: formAssignToUserImple.getAllFinishedFormListByFormId(formId)){
								
									String userName = submit.getUserName();						
									Date done=submit.getDoneDate();
									
									int turn = submit.getTurn();
									String department = submit.getDepartment();
									FormType formType = formTypeImpl.getFormByFormId(formId);									
								%>								
									
									<tr class="gradeC">
									<td><%=userName %></td>								
									 <td><%=done %></td>									
									 <td><%=turn%></td>
									<td>
										<a href="All_Submitted_examStatus.jsp?formId=<%=formId%>&formName=<%=formName%>&userName=<%=userName%>&turn=<%=turn%>" class="btn btn-info btn-sm">
											<em class="fa fa-hand-o-right"></em>
											<span>View</span>
										</a>
										
									</td>
									<td>
											<span class="label label-primary">Completed</span>
										
									</td>
								</tr>
							<% }	
							

							 
							}%>
							
                           </tbody>
                        </table>
                     </div>
                  </div>
               </div>
            </div>
            <!-- END DATATABLE 1 -->
			
	</div>
		<!-- END Page content--> </section>
		<!-- END Main section-->
		<%@include file="pages/footer.jsp" %>
	</div>
	<!-- END Main wrapper-->
	<!-- START Scripts-->
	
	<%@ include file="pages/script.jsp" %>
	
	
	<!-- END Scripts--> 
</body>

</html>

