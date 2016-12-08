<%-- 
    Document   : index
    Created on : Feb 23, 2015, 12:18:17 PM
    Author     : AKILAK
--%>

<%@page import="map.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

    <%
        try {
            User user = null;
            if (session.getAttribute("uid") == null) {
                response.sendRedirect("login.jsp");

            } else {

                user = (User) session.getAttribute("uid");
            }
    %>

    <%@include  file="header.jsp" %>
    <link rel="stylesheet" href="css/libs/select2.css" type="text/css"/> 
    <link rel="stylesheet" href="css/libs/bootstrap-timepicker.css" type="text/css"/>
    <link rel="stylesheet" type="text/css" href="css/libs/bootstrap-editable.css">
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
                                            <li class="active"><span>Live Monitor</span></li>
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

                                                    <div class="form-group form-group-sm">
                                                        <label for="sel2">Call Type: </label>
                                                        <select style="width:100px" id="sel2" name="info" class="select">
                                                            <option value="All">All</option>
                                                            <option value="Incoming">Incoming</option>
                                                            <option value="Outgoing">Outgoing</option>

                                                        </select> 
                                                    </div>


                                                    <div class="form-group">
                                                        <label for="sel2">Ring Duration: </label>
                                                        <select style="width:100px" class="form-control" name="ringt">
                                                            <option value="=">Equal</option>
                                                            <option value=">">Greater Than</option>
                                                            <option value="<">Less Than</option>
                                                        </select> 
                                                        To
                                                        <div class="input-group input-append bootstrap-timepicker" style="width:120px">
                                                            <input type="text" class="form-control timepicker" id="timepicker" name="ring">
                                                            <span class="add-on input-group-addon"><i class="fa fa-clock-o"></i></span>
                                                        </div>

                                                    </div>

                                                    <div class="form-group ">
                                                        <label for="sel2">Call Duration: </label>
                                                        <select style="width:100px" class="form-control" name="callt">
                                                            <option value="=">Equal</option>
                                                            <option value=">">Greater Than</option>
                                                            <option value="<">Less Than</option>
                                                        </select>  
                                                        To
                                                        <div class="input-group input-append bootstrap-timepicker" style="width:120px">
                                                            <input type="text" class="form-control timepicker" id="timepicker" name="call">
                                                            <span class="add-on input-group-addon"><i class="fa fa-clock-o"></i></span>
                                                        </div>
                                                    </div>


                                                    <input type="button" class="btn btn-success btn-sm" id="start" value="Refresh"/> 


                                                </form>
                                            </header>

                                        </div>
                                    </div>

                                    <div class="col-lg-12">
                                        <div class="main-box clearfix">
                                            <header class="main-box-header clearfix">
                                                <div class="pull-left"> <i class="fa fa-circle green"></i> Incoming &nbsp; <i class="fa fa-circle purple"></i> Outgoing &nbsp; <i class="fa fa-circle red"></i> Missed/Unanswered </div>


                                            </header>
                                            <div class="main-box-body clearfix">
                                                <div class="table-responsive">
                                                    <table class="table table-striped table-hover">
                                                        <thead>
                                                            <tr>
                                                                <th><span>Type</span></th>
                                                                <th><span>Ext</span></th>
                                                                <th><span>Date</span></th>
                                                                <th><span>Time</span></th>                                                                
                                                                <th><span>Ringing</span></th>
                                                                <th><span>Duration</span></th>
                                                                <th><span>Station No</span></th>
                                                                <th><span>Cost</span></th>
                                                                <th><span>PIN</span></th> 
                                                                <th><span>Remarks</span></th>  
                                                                <th><span>Comment</span></th>  
                                                            </tr>
                                                        </thead>
                                                        <tbody id="tdata">

                                                        </tbody>
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
        <%
            } catch (Exception e) {
            }

        %>
        <%@include file="footer.jsp" %>
        <script src="js/select2.min.js"></script>
        <script src="js/moment.min.js"></script>
        <script src="js/bootstrap-timepicker.min.js"></script>
        <script src="js/bootstrap-editable.min.js"></script>
        <script>
            $(function ($) {
                var STATUS = false;
                var timer;

                //select 2
                $('.select').select2();

                //Multi select
                $('#sel2Multi').select2({
                    placeholder: 'example : 999',
                    allowClear: true
                });

                //timepicker
                $('.timepicker').timepicker({
                    minuteStep: 1,
                    defaultTime: false,
                    showSeconds: true,
                    showMeridian: false,
                    disableFocus: false,
                    showWidget: true
                }).focus(function () {
                    $(this).next().trigger('click');
                });

                function updateFeed() {
                    $.ajax({
                        url: 'search',
                        data: $('#form1').serialize(),
                        type: 'POST',
                        success: function (response) {
                            $('#tdata').append(response);
                            $('.editable-click').editable({
                                emptytext: 'enter comment'
                            });
                            $('#loader').fadeOut(10);
                        }
                    });
                }



                //form submit
                $('#start').on('click', function (e) {
                    $('#tdata').empty();
                    $('#loader').fadeIn(1000);
                    updateFeed();

                });

            });
        </script>

    </body>


</html>
