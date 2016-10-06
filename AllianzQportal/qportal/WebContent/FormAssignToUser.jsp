

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
      <title>QPortal - Form Assign To User</title>
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
                  <li class="active">Form Assign To User</li>
               </ol>
               <!-- START DATATABLE 1 -->
               <div class="row">
                  <div class="col-lg-12">
                     <div class="panel panel-primary">
                        <div class="panel-heading">Froms</div>
                        <div class="panel-body">
                           <form role="form" class="mb-lg" action="FormAssignToUserController" method="post">
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
                                    UserImpl userImpl=new UserImpl();
                                    List<User> userList=userImpl.getUserList();%>									
                                 <label class="col-lg-2 col-sm-2 control-label">User: </label>
                                 <select name="userName" required>
                                    <%for(User user:userList){%>
                                    <option><%=user.getUserName()%></option>
                                    <%} %>
                                 </select>
                              </div>
                              <div class="form-group">
                                 <label class="col-lg-2 col-sm-2 control-label">User Access Type : </label>
                                 <select name="user_accessType" required>
                                    <option>public</option>
                                    <option>special</option>
                                 </select>
                              </div>
                              <!--  <div class="form-group">
                                 <label class="col-lg-2 col-sm-2 control-label">Strating Date:</label>
                                 <input name="startingDate" class="datepicker" />
                                 
                                 </div>
                                 
                                 <div class="form-group">
                                 <label class="col-lg-2 col-sm-2 control-label">Closing Date:</label>
                                 <input class="datepicker" name="endDate"/> 
                                 
                                 </div> -->
                              <div class="form-group">
                                 <button type="submit" class="btn btn-primary">Submit</button>		
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

