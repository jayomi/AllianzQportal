

<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
   <head>
      <%@ include file="pages/mainHeader.jsp" %>
      <link rel="stylesheet" href="app/css/common.css">
      <link rel="stylesheet" href="app/css/firstPage.css">
      <title>QPortal - Login</title>
   </head>
   <body>
      <div class="row row-table page-wrapper">
         <nav role="navigation" class="navbar  navbar-top navbar-fixed-top">
            <div class="nav-wrapper">
               <ul class="nav navbar-nav navbar-right">
                  <li>
                     <form role="form" class="mb-lg" action="login.jsp" method="post">
                        <button type="submit" class="btn btn-labeled btn-primary">
                        <span class="btn-label"><i class="fa fa-user"></i>
                        </span>Sign In</button>                         
                     </form>
                  </li>
                  <!--   <li>
                     <form role="form" class="mb-lg" action="publicList.jsp" method="post" >
                        
                         <button type="submit" class="btn btn-labeled btn-primary">
                           <span class="btn-label"><i class="fa fa-list"></i>
                           </span>View Forms</button>                           
                           
                         </form> 
                           
                     </li> -->
               </ul>
            </div>
         </nav>
         <div class="mainstripoutside col-lg-12 col-md-6 col-sm-8 col-xs-12 align-middle text-center">
            <div data-toggle="play-animation" data-play="fadeIn" data-offset="0" class="mainstrip">
               <div  class="text-center loginlogo"><img src="app/img/qportal-loginlogo.jpg" alt="App Logo" class="img-responsive center-block" ></div>
               <%--  <form  role="form" class="mb-lg" action="First" method="post">
                  <!-- <input class="form-control search" type="text"> -->
                  <input class="form-control search" type="number" name="formId" required  oninvalid="this.setCustomValidity('Enter Form Id Here')"
                  oninput="setCustomValidity('')" />
                  
                          <div style="color: red;">${errorMessage}</div>
                          <input type="submit" class="btn btn-success btn-xs" value="Search"/>
                  </form>
                   --%>
               <div>
                  <div>
                     <p style="color: #ffffff;">You are successfully registered. Please login to continue</p>
                  </div>
                  <a href="login.jsp" class="btn-labeled btn-primary">
                     <h3>Login</h3>
                  </a>
               </div>
            </div>
         </div>
      </div>
      <%@include file="pages/footer.jsp" %>
     
      <%@ include file="pages/script.jsp" %>
      <script src="app/js/pages.js"></script>
   </body>
</html>

