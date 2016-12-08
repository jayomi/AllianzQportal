<%-- 
    Document   : index
    Created on : Feb 23, 2015, 12:18:17 PM
    Author     : AKILAK
--%>

<%@page import="controller.BaseController"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>


    <%@include  file="header.jsp" %>

    <body id="login-page">
        <link rel="stylesheet" href="css/libs/select2.css" type="text/css"/>
        <div class="container">
            <div class="row">
                <div class="col-xs-12"><a href="login.jsp" class="btn btn-success"> <i class="fa fa-arrow-left  fa-2x"></i></a>
                    <div id="login-box">
                        <div class="row">
                            <div class="col-xs-12">
                                <header id="login-header">
                                    <div id="login-logo">
                                        <img src="img/logo-black.png" alt=""/>
                                    </div>
                                </header>
                                <div id="login-box-inner">
                                    <form role="form" action="reg" id="form1">
                                        <div class="input-group">
                                            <span class="input-group-addon"><i class="fa fa-user"></i></span>
                                            <input class="form-control" type="text" name="username" placeholder="PC username">
                                        </div>                                      
                                        <div class="input-group">
                                            <span class="input-group-addon"><i class="fa fa-lock"></i></span>
                                            <input type="password" class="form-control" name="password" placeholder="PC password">
                                        </div>
                                        <div class="input-group">
                                            <span class="input-group-addon"><i class="fa fa-envelope"></i></span>
                                            <input class="form-control" type="text" name="email" placeholder="Email address">
                                        </div>
                                        <div class="input-group">
                                            <label for="datepickerDateRange">Extensions:</label>
                                            <select style="width:300px" id="sel2Multi" name="ext" multiple>                                                 
                                                <%  BaseController bc = new BaseController();
                                                    for (map.Extension ext : bc.getList()) {
                                                %>

                                                <option value="<%=ext.getIdExtension()%>"><%=ext.getExtensionNo()%></option>
                                                <%          }

                                                %>
                                            </select>
                                        </div>

                                        <div class="row">
                                            <div class="col-xs-12">
                                                <button type="submit" class="btn btn-success col-xs-12">Register</button>
                                            </div>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        
        <%@include file="footer.jsp" %>
        <script src="js/select2.min.js"></script>


        <script>
            $(function ($) {
                $('.select').select2();


                $('#sel2Multi').select2({
                    placeholder: 'example : 999',
                    allowClear: true
                });


                $('#form1').on('submit', function (e) {

                    e.preventDefault();

                    $.ajax({
                        type: 'post',
                        url: 'reg',
                        data: $('#form1').serialize(),
                        success: function (data) {
                            if (data === '1') {
                              window.location.assign("login.jsp");

                            } else{
                                    alert(data);
                            }
                        }
                    });

                });


            });
        </script>

    </body>


</html>
