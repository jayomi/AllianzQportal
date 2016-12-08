<%-- 
    Document   : index
    Created on : Feb 23, 2015, 12:18:17 PM
    Author     : AKILAK
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

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
                                    <img alt="" src="img/samples/scarlet-1592.png"/>
                                    <div class="user-box">
                                        <span class="name">
                                            Welcome<br/>
                                            Akila Udara
                                        </span>
                                        <span class="status">
                                            <i class="fa fa-circle"></i> Online
                                        </span>
                                    </div>
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
                                   <div class="col-lg-3 col-sm-6 col-xs-12">
                                        <div class="main-box infographic-box">
                                            <i class="fa fa-phone yellow-bg"></i>
                                            <span class="headline">Total Calls</span>
                                            <span class="value">
                                                <span class="timer" data-from="120" data-to="2562" data-speed="1000" data-refresh-interval="50">
                                                    2562
                                                </span>
                                            </span>
                                        </div>
                                    </div>
                                    <div class="col-lg-3 col-sm-6 col-xs-12">
                                        <div class="main-box infographic-box">
                                            <i class="fa fa-phone-square emerald-bg"></i>
                                            <span class="headline">Incoming Calls</span>
                                            <span class="value">
                                                <span class="timer" data-from="30" data-to="658" data-speed="800" data-refresh-interval="30">
                                                    658
                                                </span>
                                            </span>
                                        </div>
                                    </div>
                                    <div class="col-lg-3 col-sm-6 col-xs-12">
                                        <div class="main-box infographic-box">
                                            <i class="fa fa-mail-forward green-bg"></i>
                                            <span class="headline">Outgoing Calls</span>
                                            <span class="value">
                                                <span class="timer" data-from="83" data-to="8400" data-speed="900" data-refresh-interval="60">
                                                    8400
                                                </span>
                                            </span>
                                        </div>
                                    </div>
                                    <div class="col-lg-3 col-sm-6 col-xs-12">
                                        <div class="main-box infographic-box">
                                            <i class="fa fa-warning red-bg"></i>
                                            <span class="headline">Missed Calls</span>
                                            <span class="value">
                                                <span class="timer" data-from="539" data-to="12526" data-speed="1100">
                                                    12526
                                                </span>
                                            </span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        
                        
                        
                        <footer id="footer-bar" class="row">
                            <p id="footer-copyright" class="col-xs-12">
                                &copy; 2015 Powered by Allianz IT Team.
                            </p>
                        </footer>
                    </div>
                </div>
            </div>
        </div>
   
  <%@include file="footer.jsp" %>

      
    </body>


</html>
