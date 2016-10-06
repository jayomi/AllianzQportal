

<%@page import="com.allianz.qportalapp.controller.FormAssignToUserImple"%>
<%@page import="com.allianz.qportalapp.controller.FormAssignToUserController"%>
<%@page import="com.allianz.qportalapp.model.FormType"%>
<%@page import="com.allianz.qportalapp.controller.FormTypeImpl"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.util.Calendar"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@page import="com.allianz.qportalapp.model.Department"%>
<%@page import="com.allianz.qportalapp.controller.DepartmentImpl"%>
<%@ page import="java.util.ArrayList"%>
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
                  <title>QPortal -Questionnaires</title>
               </head>
               <body>
                  <!-- START Main wrapper-->
                  <div class="wrapper">
                     <!-- START Top Navbar-->
                     <%@include file="pages/navigationBar.jsp" %>      
                     <% if(session.getAttribute("user_access_Type")==null && session.getAttribute("public_userName")==null){ 
                        request.setAttribute("user_access_Type", "public");
                         request.setAttribute("public_userName", "");
                         
                        }%> 
                     <!-- END Top Navbar-->
                     <!-- START aside-->
                     <%@include file="pages/aside.jsp" %>   
                     <!-- End aside-->
                     <!-- START Main section-->
                     <section>
                        <!-- class="sidehidden" -->
                        <!-- START Page content-->
                        <div class="content-wrapper">
                           <%-- <h2><%=userName%></h2> --%>
                           <h3>Questionnaires Registration
                           </h3>
                           <ol class="breadcrumb">
                              <%@include file="pages/breadcrumb.jsp" %> 
                              <li class="active">Register</li>
                           </ol>
                           <!-- START DATATABLE 1 -->
                           <div class="row">
                              <div class="col-lg-8">
                                 <div class="panel panel-primary">
                                    <div class="panel-heading">Qportal Register</div>
                                    <div class="panel-body">
                                       <%String publicUserName=""; %>
                                       <form role="form" class="mb-lg" action="RegisterContoller" method="post">
                                          <%
                                             if( session.getAttribute("public_userName")!=null){
                                             
                                             
                                             	publicUserName=session.getAttribute("public_userName").toString();
                                             
                                             
                                             } 
                                             
                                             %>
                                          <div class="form-group">
                                             <label class="col-lg-2 col-sm-2 control-label">First name * </label>
                                             <input type="text" placeholder="first name" name="firstName" required="required">								
                                          </div>
                                          <div class="form-group">
                                             <label class="col-lg-2 col-sm-2 control-label">Last name * </label>
                                             <input type="text" placeholder="last name" name="lastName" required="required">								
                                          </div>
                                          <div class="form-group">
                                             <label class="col-lg-2 col-sm-2 control-label">E-mail * </label>
                                             <input type="email" placeholder="email" name="email" required="required">								
                                          </div>
                                          <div class="form-group">
                                             <label class="col-lg-2 col-sm-2 control-label">Department * </label>
                                             <%
                                                DepartmentImpl departmentImpl = new DepartmentImpl();
                                                List<Department> departmentList =	departmentImpl.getAllDepartments();									 
                                                %>
                                             <select name="department" required>
                                                <option value="">Select</option>
                                                <%for(Department depertment : departmentList){%>										
                                                <option value="<%=depertment.getDepartmentName() %>"><%=depertment.getDepartmentName() %></option>
                                                <%} %>
                                             </select>
                                          </div>
                                          <div class="form-group">																
                                             <label class="col-lg-2 col-sm-2 control-label">Password * </label>
                                             <input type="password" placeholder="password" name="password1" required="required">	   
                                          </div>
                                          <div class="form-group">																
                                             <label class="col-lg-2 col-sm-2 control-label">Verify Password * </label>
                                             <input type="password" placeholder="password" name="password2" required="required">	   
                                             <label>Plese input your password again.</label>
                                          </div>
                                          <div class="form-group">
                                             <label class="col-lg-2 col-sm-2 control-label">Security Question * </label>
                                             <select name="securityQuestion" required="required">
                                                <option value="Who is your favorite actor, musician, or artist?">Who is your favorite actor, musician, or artist?</option>
                                                <option value="What is the name of your favorite pet?">What is the name of your favorite pet?</option>
                                                <option value="What is your favorite movie?">What is your favorite movie?</option>
                                                <option value="What is your mother's maiden name?">What is your mother's maiden name?</option>
                                                <option value="What is your favorite color?">What is your favorite color?</option>
                                                <option value="What is your father's middle name?">What is your father's middle name?</option>
                                                <option value="What is the name of your first grade teacher?">What is the name of your first grade teacher?</option>
                                                <option value="What was your favorite place to visit as a child?">What was your favorite place to visit as a child?</option>
                                             </select>
                                             <input type="text" placeholder="Please answer here" required="required" name="securityQuestionAnswer">
                                          </div>
                                          <div class="required">* Required fields</div>
                                          <div class="pull-right">
                                             <%String errorMsg = request.getParameter("errorMessage");
                                                if(errorMsg !=null){%>
                                             <div style="color: red;"><%=errorMsg %></div>
                                             <%}%>
                                             <button type="submit" class="btn btn-primary">Register</button>		
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
                  <!-- START Scripts-->
                  <%@ include file="pages/script.jsp" %>
                  <script type="text/javascript">
                     <%
                        String userAccess_Type=session.getAttribute("user_access_Type").toString();
                        if(userAccess_Type.equalsIgnoreCase("public")){%>
                     	
                     $('section').addClass("sidehidden");
                     $('aside').removeClass("aside");
                     
                     <%}%>
                       
                  </script>
                  <!-- END Scripts-->
               </body>
            </html>

