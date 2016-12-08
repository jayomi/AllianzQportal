<%-- 
    Document   : index
    Created on : Feb 23, 2015, 12:18:17 PM
    Author     : AKILAK
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    
      <%
        User user = null;
        if (session.getAttribute("uid") == null) {
            response.sendRedirect("login.jsp");

        } else {

            user = (User) session.getAttribute("uid");
        }
    %>

    <%@include  file="header.jsp" %>
 
    <body>
        <div id="theme-wrapper">
            <%@include  file="top_nav.jsp" %>
            <div id="page-wrapper" class="container">
                <div class="row">
                    <div id="nav-col">
                        <section id="col-left" class="col-left-nano">
                            <div id="col-left-inner" class="col-left-nano-content">
                                <div id="user-left-box" class="clearfix hidden-sm hidden-xs">
                                    <img alt="" src="img/samples/scarlet-159.png"/>
                                    <%@include  file="userbox.jsp" %>
                                </div>
                                <%@include  file="sidebar.jsp" %>
                            </div>
                        </section>
                    </div>
                    <div id="content-wrapper">
                        <div class="row">
                            <div class="col-lg-12">
                                <div class="row">
                                    <div class="col-lg-12">
                                        <ol class="breadcrumb">
                                            <li><a href="#">Home</a></li>
                                            <li class="active"><span>Dashboard</span></li>
                                        </ol>                                       
                                    </div>
                                </div>
                                <div class="row">
                                   
                                </div>
                            </div>
                        </div>
                        
                        
                        
                        <%@include file="coprights.jsp" %>
                    </div>
                </div>
            </div>
        </div>
   
  <%@include file="footer.jsp" %>

      
    </body>


</html>
