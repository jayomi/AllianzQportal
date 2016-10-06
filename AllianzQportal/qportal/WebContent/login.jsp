

<%@page import="com.allianz.qportalapp.controller.FormAssignToUserImple"%>
<%@page import="com.allianz.qportalapp.controller.FormAssignToUserController"%>
<%@page import="com.allianz.qportalapp.model.FormType"%>
<%@page import="com.allianz.qportalapp.controller.FormTypeImpl"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.util.Calendar"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%-- <%@ page import="java.sql.Date"%> --%>
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
                     <nav role="navigation" class="navbar navbar-default navbar-top navbar-fixed-top">
                        <!-- START navbar header-->
                        <div class="navbar-header">
                           <a href="login.jsp" class="navbar-brand">
                              <div class="brand-logo">
                                 <img src="app/img/logo.png" alt="App Logo" class="img-responsive">
                              </div>
                              <div class="brand-logo-collapsed">
                                 <img src="app/img/logo-single.png" alt="App Logo" class="img-responsive">
                              </div>
                           </a>
                        </div>
                        <!-- END navbar header-->
                        <!-- START Nav wrapper-->
                        <!-- START Nav wrapper-->
                        <div class="nav-wrapper">
                           <!-- START Left navbar-->
                           <ul class="nav navbar-nav">
                              <li>
                                 <!-- Button used to collapse the left sidebar. Only visible on tablet and desktops-->
                                 <a href="#" data-toggle-state="aside-collapsed" class="hidden-xs">
                                 <em class="fa fa-navicon"></em>
                                 </a> <!-- Button to show/hide the sidebar on mobile. Visible on mobile only.-->
                                 <a href="#" data-toggle-state="aside-toggled" class="visible-xs">
                                 <em class="fa fa-navicon"></em>
                                 </a>
                              </li>
                           </ul>
                           <!-- END Left navbar-->
                           <!-- START Right Navbar-->
                           <ul class="nav navbar-nav navbar-right">
                              <li><a href="#" data-toggle="fullscreen"> <em
                                 class="fa fa-expand"></em>
                                 </a>
                              </li>
                              <li>
                                 <a href="firstPage.jsp"><i class="fa fa-home" aria-hidden="true"></i>
                                 Home</a>	
                              </li>
                              <li>
                                 <a>
                                    <form action="register.jsp" method="post">
                                       <button type="submit" class="register btn btn-primary btn-sm"><i class="fa fa-user-plus" aria-hidden="true"></i> Register</button>
                                    </form>
                                 </a>
                              </li>
                           </ul>
                           <!-- END Right Navbar-->
                        </div>
                        <!-- END Nav wrapper-->
                        <!-- END Nav wrapper-->
                        <!-- START Search form-->
                        <form role="search" action="" class="navbar-form">
                           <div class="form-group has-feedback">
                              <input type="text" placeholder="Type and hit Enter.." class="form-control">
                              <div data-toggle="navbar-search-dismiss" class="fa fa-times form-control-feedback"></div>
                           </div>
                           <button type="submit" class="hidden btn btn-default">Submit</button>
                        </form>
                        <!-- END Search form-->
                     </nav>
                     <!-- END Top Navbar-->
                     <!-- START aside-->
                     <!-- End aside-->
                     <!-- START Main section-->
                     <!-- START wrapper-->
                     <div class="row row-table page-wrapper">
                        <div class="col-lg-3 col-md-6 col-sm-8 col-xs-12 align-middle">
                           <!-- START panel-->
                           <div data-toggle="play-animation" data-play="fadeIn" data-offset="0" class="panel panel-dark panel-flat">
                              <div class="panel-heading text-center">
                                 <a href="#">
                                 <img src="app/img/logo.png" alt="Image" class="block-center img-rounded">
                                 </a>
                                 <p class="text-center mt-lg">
                                    <strong>SIGN IN TO CONTINUE.</strong>
                                 </p>
                              </div>
                              <div class="panel-body">
                                 <form role="form" class="mb-lg" action="LoginController" method="post">
                                    <% String successMsg = request.getParameter("successMessage");
                                       if(successMsg != null){%>
                                    <div style="color: yello;"><%=successMsg %></div>
                                    <% }%>
                                    <div class="form-group has-feedback">
                                       <input id="userName" type="text" placeholder="Enter user name" class="form-control" name="userName">
                                       <span class="fa fa-envelope form-control-feedback text-muted"></span>
                                    </div>
                                    <div class="form-group has-feedback">
                                       <input id="password" type="password" placeholder="Password" class="form-control" name="password">
                                       <span class="fa fa-lock form-control-feedback text-muted"></span>
                                    </div>
                                    <div class="clearfix">
                                       <div class="pull-right"><a href="resetPassword.jsp" class="text-muted">Forgot your password?</a>
                                       </div>
                                    </div>
                                    <div form-group>
                                       <button type="submit" class="btn btn-block btn-primary">Login</button>
                                    </div>
                                    <%String errorMsg = request.getParameter("errorMessage"); 
                                       if(errorMsg !=null){ %>
                                    <div style="color: red;"><%=errorMsg%></div>
                                    <%}
                                       %>
                                 </form>
                              </div>
                           </div>
                           <!-- END panel-->
                        </div>
                     </div>
                     <%@ include file="pages/footer.jsp" %>
                  </div>
                  <!-- END DATATABLE 1 -->
                  <!-- START Scripts-->
                  <%@ include file="pages/script.jsp" %>
                  <script type="text/javascript">
                     $('.register').on('click',function(){
                     	<% session.setAttribute("user_access_Type","public");%>
                     });
                     
                     
                  </script>
                  <!-- END Scripts-->
               </body>
            </html>

