<!DOCTYPE html>
<html>
     <%
      
            if (session.getAttribute("uid") != null) {
                response.sendRedirect("detail.jsp");

            } 
     
     %>
    <%@include  file="header.jsp" %>
    <body id="login-page">
        <div class="container">          
            <div class="row">  
                <div class="col-xs-12"> <a href="index.jsp" class="btn btn-success"> <i class="fa fa-home fa-2x"></i></a>
                    <div id="login-box">
                        <div id="login-box-holder">
                            <div class="row">
                                <div class="col-xs-12">
                                    <header id="login-header">
                                        <div id="login-logo">
                                            <img src="img/logo-black.png" alt=""/>
                                        </div>
                                    </header>
                                    <div id="login-box-inner">
                                        <form role="form" action="ulogin" method="POST">
                                            <div class="input-group">
                                                <span class="input-group-addon"><i class="fa fa-user"></i></span>
                                                <input class="form-control" name="username" type="text" placeholder="Username" autofocus>
                                            </div>
                                            <div class="input-group">
                                                <span class="input-group-addon"><i class="fa fa-key"></i></span>
                                                <input type="password" name="password" class="form-control" placeholder="Password">
                                            </div>
                                            <input  name="action" type="hidden" value="login">
                                            <div class="row">
                                                <div class="col-xs-12">
                                                    <button type="submit" class="btn btn-success col-xs-12">Login</button>
                                                    <a href="register.jsp" class="btn btn-prev col-xs-12">Sign Up</a>
                                                </div>
                                            </div>

                                        </form>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div id="login-box-footer">
                            <div class="row">
                                <div class="col-xs-12">
                                    Powered by Allianz IT Team.
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>


        <script src="js/demo-skin-changer.js"></script>  
        <script src="js/jquery.js"></script>
        <script src="js/bootstrap.js"></script>
        <script src="js/jquery.nanoscroller.min.js"></script>



        <script src="js/scripts.js"></script>

    </body>


</html>