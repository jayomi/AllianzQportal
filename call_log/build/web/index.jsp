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
            <header class="navbar" id="header-navbar">
                <div class="container">

                    <div class="clearfix">
                        <h1 style="color: #FFF;margin-top: 10px;text-align: center">Allianz Call Information Center</h1>

                    </div>
                </div>
            </header>
            <div id="page-wrapper" class="container row" >
                <div class="row" >                
                   <img style="margin-top: 50px" src="img/logo.png" width="259" height="60" class="img-responsive center-block" alt="logo"/>
                </div>
                <div class="row" style="margin: 5% 10% 15% 10% ">                   


                    <div class="col-lg-4 col-sm-6 col-xs-12"  onclick="window.location = 'login.jsp';"  style="cursor:pointer">


                        <div class="main-box infographic-box" style="height: 200px" >
                            <img src="img/index/calllog_icon_green_L.png" style="height: 125px">

                            <span class="headline"><h2>Call Accounting</h2> </span>

                        </div>
                    </div>
                    <div class="col-lg-4 col-sm-6 col-xs-12" onclick="window.location = 'internal.jsp';"  style="cursor:pointer">
                        <div class="main-box infographic-box" style="height: 200px">
                            <img src="img/index/apple-contacts-icon.jpg" style="height: 125px">
                            <span class="headline"><h2>Internal Directory</h2></span>

                        </div>
                    </div>
                    <div class="col-lg-4 col-sm-6 col-xs-12" onclick="window.location = 'external.jsp';"  style="cursor:pointer">
                        <div class="main-box infographic-box" style="height: 200px">
                            <img src="img/index/directory-icon.png" style="height: 125px">
                            <span class="headline"><h2>External Directory</h2></span>

                        </div>
                    </div>

                </div>
                
                


            </div>



        </div>
        <p id="footer-copyright" class="col-xs-12" style="margin-top: 10px">
            Powered by Allianz IT Team.
        </p>

        <%@include file="footer.jsp" %>

    </body>


</html>
