<%@page import="com.allianz.qportalapp.model.SubmitForm"%>
<%@page import="com.allianz.qportalapp.controller.FormAssignToUserImple"%>
<%@page import="com.allianz.qportalapp.model.FormType"%>
<%@page import="com.allianz.qportalapp.controller.FormTypeImpl"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.Date"%>
<%@ page import="com.allianz.qportalapp.controller.UserImpl"%>

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
                              	<th>Name</th>
                                 <th>Form Name</th>
                                 <th>Description</th>                                 
                               <!--   <th>Start Date</th> -->
                                 <th>End Date</th>
                                  <th>Done Date</th>
                                 <th>Type</th>
                                 <th>Turn</th>
                                 <th></th>
                              </tr>
                           </thead>
                           <tbody>
                           

                           		                       
								<%
								String userAccess_Type=session.getAttribute("user_access_Type").toString();
								if(userAccess_Type.equalsIgnoreCase("special")){									
								
								String user_Name=session.getAttribute("userName").toString();
								FormAssignToUserImple formAssignToUserImple=new FormAssignToUserImple();    							
    							//List<SubmitForm> formList=formAssignToUserImple.getAllFinishedFormList();
    							FormTypeImpl formTypeImpl=new FormTypeImpl();
    							UserImpl userImpl = new UserImpl();
    							String department = userImpl.getUserDepartmentByUserName(user_Name);    							
    							
    							for(SubmitForm form : formAssignToUserImple.getAllFinishedFormListByDepartment(department)){
								//for(int i=0;i<formList.size();i++){
									String userName = form.getUserName();																	
									int formId = form.getFormId();
									Date start=form.getStartDate();
									Date end=form.getEndDate();
									int turn = form.getTurn();
									FormType formType = formTypeImpl.getFormByFormId(formId);
									String formName = formType.getFormName();
									
								%>								
									
									<tr class="gradeC">
									<td><%=userName %></td>
									 <td name="selected_formName"><%=formName%></td>
									 <td><%=formType.getFormDescription() %></td>
									 <td><%=start %></td>
									 <td><%=end %></td>
									 <td>MCQ</td>
									 <td><%=turn%></td>
									<th>
										<a href="All_Submitted_examStatus.jsp?formId=<%=formId%>&formName=<%=formName%>&userName=<%=userName%>&turn=<%=turn%>" class="btn btn-info btn-sm">
											<em class="fa fa-hand-o-right"></em>
											<span>View</span>
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
         <%@include file="pages/footer.jsp" %>
    </div>
    <!-- END Main wrapper-->
    <!-- START Scripts-->
		<%@ include file="pages/script.jsp" %>
    <!-- END Scripts-->
</body>

</html>