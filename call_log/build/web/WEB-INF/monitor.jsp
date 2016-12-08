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
                                    <img alt="" src="img/samples/scarlet-159.png"/>
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
                                
                                
                            </div>
                        </div>
                        
                        
                        
                        <footer id="footer-bar" class="row">
                            <p id="footer-copyright" class="col-xs-12">
                                &copy; 2014 Powered by Allianz IT Team.
                            </p>
                        </footer>
                    </div>
                </div>
            </div>
        </div>
   
  <%@include file="footer.jsp" %>

      
    </body>


</html>
