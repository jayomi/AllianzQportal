<%-- 
    Document   : index
    Created on : Feb 23, 2015, 12:18:17 PM
    Author     : AKILAK
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

    <%@include  file="header.jsp" %>

    <%
        try {
            User user = null;
            if (session.getAttribute("uid") == null) {
                response.sendRedirect("login.jsp");

            } else {

                user = (User) session.getAttribute("uid");
            }
    %>
    <body>
        <link rel="stylesheet" href="css/libs/select2.css" type="text/css"/>
        <link rel="stylesheet" href="css/libs/daterangepicker.css" type="text/css"/>
        <link rel="stylesheet" href="css/libs/bootstrap-timepicker.css" type="text/css"/>
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
                                            <li class="active"><span>Call Summery</span></li>
                                        </ol>              

                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-lg-12">
                                        <div class="main-box clearfix">
                                            <header class="main-box-header clearfix">
                                                <form class="form-inline row" role="form" action="#"  id="form1">
                                                    <div class="form-group form-group-sm">
                                                        <label for="datepickerDateRange">Ext:</label>
                                                        <select style="width:200px" id="sel2Multi" name="ext" multiple>
                                                            <option value="All">All</option>
                                                            <%
                                                                for (map.UserHasExt ext : u.getUserHasExts()) {
                                                            %>

                                                            <option value="<%=ext.getExtension().getExtensionNo()%>"><%=ext.getExtension().getExtensionNo()%></option>
                                                            <%          }

                                                            %>
                                                        </select>
                                                    </div>
                                                    <div class="form-group">
                                                        <label for="datepickerDateRange">Date Range: </label>
                                                        <div class="input-group">
                                                            <span class="input-group-addon"><i class="fa fa-calendar-o"></i></span>
                                                            <input type="text" name="dr" class="form-control" id="datepickerDateRange">
                                                        </div>
                                                    </div>



                                                    <button type="submit" class="btn btn-success btn-sm pull-right">Search</button>


                                                </form>
                                            </header>
                                            <div class="main-box-body clearfix">
                                                <div class="table-responsive">
                                                    <table class="table table-bordered table-hover" id="tdata">


                                                    </table>
                                                    <img src="img/321.GIF" id="loader" class="center-block" style="height: 40px;display: none;" alt=""/>
                                                </div>
                                            </div>
                                        </div>
                                    </div>



                                </div>
                            </div>
                        </div>



                        <%@include file="coprights.jsp" %>
                    </div>
                </div>
            </div>
        </div>

        <%@include file="footer.jsp" %>
        <%
            } catch (Exception e) {
            }

        %>
        <script src="js/select2.min.js"></script>
        <script src="js/moment.min.js"></script>
        <script src="js/bootstrap-datepicker.js"></script>
        <script src="js/daterangepicker.js"></script>
        <script src="js/bootstrap-timepicker.min.js"></script>
        <script>
            $(function ($) {
                $('#sel2Multi').select2({
                    placeholder: 'example : 999',
                    allowClear: true
                });

                $('#datepickerDateRange').daterangepicker();



                $('#form1').on('submit', function (e) {

                    e.preventDefault();
                    $('#tdata').empty();
                    $('#loader').fadeIn(1000);
                    $.ajax({
                        type: 'post',
                        url: 'call_sum',
                        data: $('#form1').serialize(),
                        success: function (data) {


                            $('#tdata').append(data);
                            $('#loader').fadeOut(10);
                        }
                    });

                });

            });
        </script>

    </body>


</html>
