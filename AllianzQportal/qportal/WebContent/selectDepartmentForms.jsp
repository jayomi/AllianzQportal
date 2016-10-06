

<%@page import="com.allianz.qportalapp.controller.DepartmentImpl"%>
<%@page import="com.allianz.qportalapp.model.Department"%>
<%@page import="com.allianz.qportalapp.controller.FormAssginToDepartmentImpl"%>
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
                           <h3>Questionnaires of the Departments
                              <small>View all Questionnaires of the departments</small>                                 
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
                                                <th>Department</th>
                                                <th></th>
                                             </tr>
                                          </thead>
                                          <tbody>
                                             <%
                                                String userAccess_Type=session.getAttribute("user_access_Type").toString();
                                                if(userAccess_Type.equalsIgnoreCase("special")){									
                                                
                                                String user_Name=session.getAttribute("userName").toString();
                                                //FormAssginToDepartmentImpl departmentImpl = new FormAssginToDepartmentImpl();
                                                DepartmentImpl departmentImpl = new DepartmentImpl();
                                                List<Department> departmentList =  departmentImpl.getAllDepartments();
                                                
                                                for(Department dep : departmentList){%>	
                                             <tr class="gradeC">
                                                <td><%=dep.getDepartmentName() %></td>
                                                <th>
                                                   <a href="DepartmentForms.jsp?departmentName=<%=dep.getDepartmentName()%>" class="btn btn-info btn-sm">
                                                   <em class="fa fa-hand-o-right"></em>
                                                   <span>View Forms</span>
                                                   </a>
                                                </th>
                                             </tr>
                                             <%}
                                                %>								
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

