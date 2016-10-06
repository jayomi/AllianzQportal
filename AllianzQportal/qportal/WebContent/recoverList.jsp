

<%@page import="com.allianz.qportalapp.controller.FormAssignToUserImple"%>
<%@page import="com.allianz.qportalapp.controller.FormAssignToUserController"%>
<%@page import="com.allianz.qportalapp.model.FormType"%>
<%@page import="com.allianz.qportalapp.model.SubmitForm"%>
<%@page import="com.allianz.qportalapp.controller.FormTypeImpl"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.util.Calendar"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@page import="com.allianz.qportalapp.controller.FormAssginToDepartmentImpl"%>
<%@page import="com.allianz.qportalapp.model.DepartmentForm"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en" class="no-ie">
   <!--<![endif]-->
   <head>
      <!-- Meta-->
      <%@include file="pages/mainHeader.jsp" %>
      <title>QPortal - dashboard</title>
   </head>
   <body>
      <!-- START Main wrapper-->
      <div class="wrapper">
         <!-- START Top Navbar-->       
         <%@include file="pages/navigationBar.jsp"%>
         <!-- END Top Navbar-->
         <!-- START aside-->
         <%@include file="pages/aside.jsp" %> 
         <!-- End aside-->
         <!-- START Main section-->
         <section class="sidehidden">
            <!-- START Page content-->
            <div class="content-wrapper">
               <div class="row">
                  <div class="col-lg-4">
                     <label>Reference ID : <%=request.getParameter("refId") %></label>
                  </div>
               </div>
               <div class="row">
                  <div class="col-lg-12">
                     <!-- START panel-->
                     <div class="panel panel-primary">
                        <div class="panel-heading">Survey / Exam Status
                           <a href="#" data-perform="panel-dismiss" data-toggle="tooltip" title="Close Panel" class="pull-right">
                           <em class="fa fa-times"></em>
                           </a>
                           <a href="#" data-perform="panel-collapse" data-toggle="tooltip" title="Collapse Panel" class="pull-right">
                           <em class="fa fa-minus"></em>
                           </a>
                        </div>
                        <!-- START table-responsive-->
                        <div class="table-responsive">
                           <table id="datatable_publicList" class="table table-striped table-hover">
                              <!--   <table id="datatable1" class="table table-striped table-bordered table-hover"> -->
                              <thead>
                                 <tr>
                                    <th></th>
                                    <th>Form Name</th>
                                    <th>Description</th>
                                    <th>Form Type</th>
                                    <th>Turn</th>
                                    <th>Done Date</th>
                                    <th>Time</th>
                                    <th></th>
                                 </tr>
                              </thead>
                              <tbody>
                                 <%
                                    int index = 1;
                                    FormAssginToDepartmentImpl departmentImpl = new FormAssginToDepartmentImpl();
                                    
                                    String userAccess_Type=session.getAttribute("user_access_Type").toString();
                                    if(userAccess_Type.equalsIgnoreCase("public")){
                                    FormAssignToUserImple formAssignToUserImple=new FormAssignToUserImple();    	
                                    
                                    String publicUser = null; List<Integer> onGoingFormList = new ArrayList<Integer>();
                                    List<Integer> doneFormList = new ArrayList<Integer>();
                                    
                                    if(request.getParameter("refId")!=null){
                                    //publicUser = session.getAttribute("public_userName").toString();
                                    publicUser = request.getParameter("refId").toString();
                                    
                                    //ongoing list
                                    onGoingFormList=formAssignToUserImple.getUpdatingFormListbyFormStatus(publicUser);//onGoing list
                                    //done list
                                    doneFormList = formAssignToUserImple.getFinishedFormListbyUser(publicUser);
                                    
                                    }
                                    FormTypeImpl formTypeImpl=new FormTypeImpl();
                                    
                                    //get ongoing form list
                                    
                                    for(int i=0;i<onGoingFormList.size();i++){
                                    int formId=onGoingFormList.get(i);																	
                                    
                                    
                                    SubmitForm formType =formTypeImpl.getFormByFormIdandUser(formId,publicUser);
                                    %>	
                                 <tr class="gradeC">
                                    <td><%=index%></td>
                                    <td name="selected_formName"><%=formType.getFormName() %></td>
                                    <td><%=formType.getDescription()%></td>
                                    <td><%=formType.getFormType()%></td>
                                    <td><%=formType.getTurn() %></td>
                                    <td><%=formType.getDoneDate() %></td>
                                    <td><%=formType.getTime() %></td>
                                    <th>
                                       <a href="onGoingExamPaper.jsp?formId=<%=formId%>&turn=<%=formType.getTurn()%>" class="btn btn-info btn-sm">
                                       <em class="fa fa-hand-o-right"></em>
                                       <span>Ongoing</span>
                                       </a>
                                    </th>
                                 </tr>
                                 <%index++;%>
                                 <%}%>
                                 <!-- //get done list -->
                                 <%
                                    for(int i=0;i<doneFormList.size();i++){
                                    		
                                    		int formId=doneFormList.get(i);	
                                    		
                                    		SubmitForm formType =formTypeImpl.getFormByFormIdandUser(formId,publicUser);
                                    		%>
                                 <tr class="gradeC">
                                    <td><%=index %></td>
                                    <td name="selected_formName"><%=formType.getFormName() %></td>
                                    <td><%=formType.getDescription()%></td>
                                    <td><%=formType.getFormType()%></td>
                                    <td><%=formType.getTurn() %></td>
                                    <td><%=formType.getDoneDate() %></td>
                                    <td><%=formType.getTime() %></td>
                                    <th>    										
                                       <a href="examStatus.jsp?formId=<%=formId%>&turn=<%=formType.getTurn() %>" class="btn btn-info btn-sm">
                                       <em class="fa fa-hand-o-right"></em>
                                       <span>View</span>
                                       </a>
                                    </th>
                                 </tr>
                                 <%index++; %>
                                 <%}%>
                                 <%}%> <!-- end all user type  -->  
                              </tbody>
                           </table>
                        </div>
                        <!-- END table-responsive-->
                        <div class="panel-footer">
                           <div class="row">
                              <div class="col-lg-2">
                                 <div class="input-group">
                                    <input type="text" placeholder="Search" class="input-sm form-control">
                                    <span class="input-group-btn">
                                    <button type="button" class="btn btn-sm btn-default">Search</button>
                                    </span>
                                 </div>
                              </div>
                              <div class="col-lg-8"></div>
                              <div class="col-lg-2">
                                 <div class="input-group pull-right">
                                    <a href="javascript:void(0);"><small>Load more</small></a>
                                 </div>
                              </div>
                           </div>
                        </div>
                     </div>
                     <!-- END panel-->
                  </div>
               </div>
               <!-- END row-->
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

