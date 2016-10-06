

<%@page import="com.allianz.qportalapp.controller.DepartmentImpl"%>
<%@page import="com.allianz.qportalapp.model.Department"%>
<%@page import="com.allianz.qportalapp.model.User"%>
<%@page import="com.allianz.qportalapp.controller.UserImpl"%>
<%@page import="com.allianz.qportalapp.model.FormType"%>
<%@page import="com.allianz.qportalapp.controller.FormTypeImpl"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en" class="no-ie">
   <head>
      <%@ include file="pages/mainHeader.jsp" %>
      <title>QPortal - Form Assign To Department</title>
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
               <h3>Create a Form
                  <small>Q-portal form creation ... </small>
                    <%@ include file="pages/allianzLogo.jsp" %>
               </h3>
               <ol class="breadcrumb">
                  <%@include file="pages/breadcrumb.jsp" %> 
                  <li class="active">Form Assign To Department</li>
               </ol>
               <!-- START DATATABLE 1 -->
               <div class="row">
                  <div class="col-lg-12">
                     <div class="panel panel-primary">
                        <div class="panel-heading">Froms</div>
                        <div class="panel-body">
                           <form role="form" class="mb-lg" action="FormAssignToDeptmntController" method="post">
                              <div class="form-group">
                                 <%
                                    FormTypeImpl formTypeImpl=new FormTypeImpl();
                                    List<FormType> formList=formTypeImpl.getPublishFormList();%>
                                 <label class="col-lg-2 col-sm-2 control-label">Select Form: </label>
                                 <select name="formName" class="form-control" required>
                                    <%for(FormType formType:formList){%>
                                    <option><%=formType.getFormName()%></option>
                                    <%} %>
                                 </select>
                              </div>
                              <div class="form-group">
                                 <%
                                    DepartmentImpl department = new DepartmentImpl();
                                    List<Department> departmentList =  department.getAllDepartments();
                                    %>							
                                 <label class="col-lg-2 col-sm-2 control-label">Department: </label>
                                 <select name="department" required>
                                    <option value="">Select</option>                                   
                                    <%for(Department dept : departmentList){ %>
                                    <option value="<%=dept.getDepartmentName()%>" ><%=dept.getDepartmentName()%></option>
                                    <%} %>
                                 </select>
                              </div>
                              <div class="form-group">
                                 <label class="col-lg-2 col-sm-2 control-label">Start Date: </label>									 
                                 <input id="startDate" name="startDate" class="datepicker" />
                              </div>
                              <div class="form-group">
                                 <label class="col-lg-2 col-sm-2 control-label">End Date: </label>									 
                                 <input id="endDate" name="endDate" class="datepicker" />
                              </div>
                              <div class="form-group">
                                 <input type="submit" class="btn btn-labeled btn-primary" name ="assignDepartmntBtn" value="Submit" onclick="return confirm('Are you sure you want to assign department ?')">		
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
          <%@include file="pages/footer.jsp" %>
      </div>
      <!-- END Main wrapper-->
      <!-- Start script-->
      <%@ include file="pages/script.jsp" %>
      <script type="text/javascript">
         $(document).ready(function() {
           $(".datepicker").datepicker();
         });
         
      </script>
      <!-- End script-->
   </body>
</html>

