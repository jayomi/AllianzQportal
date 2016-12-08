<%-- 
    Document   : index
    Created on : Feb 23, 2015, 12:18:17 PM
    Author     : AKILAK
--%>

<%@page import="controller.BaseController"%>
<%@page import="controller.PinController"%>
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
        <link rel="stylesheet" type="text/css" href="css/libs/dataTables.fixedHeader.css">
        <link rel="stylesheet" type="text/css" href="css/libs/dataTables.tableTools.css">
        <link rel="stylesheet" href="css/libs/datepicker.css" type="text/css"/>
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
                                            <li class="active"><span>PIN Management</span></li>
                                        </ol>              
                                        <div class="clearfix">
                                            <h1 class="pull-left">Users</h1>
                                            <div class="pull-right top-page-ui">
                                                <a  class="btn btn-primary pull-right" data-toggle="modal" href="#myModal">
                                                    <i class="fa fa-plus-circle fa-lg"></i> Add PIN
                                                </a>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-lg-12">
                                        <div class="main-box clearfix">
                                            <header class="main-box-header clearfix">

                                            </header>
                                            <div class="main-box-body clearfix">
                                                <!--<div class="table-responsive">-->
                                                <table class="table table-striped table-hover" id="table-example-fixed">
                                                    <thead>
                                                        <tr>
                                                            <th><span>#</span></th>
                                                            <th><span>PIN</span></th>
                                                            <th><span>User</span></th>
                                                            <th><span>Date given</span></th>
                                                            <th><span>Terminate Date</span></th>
                                                            <th><span>Department</span></th>
                                                            <th><span>Status</span></th>

                                                        </tr>
                                                    </thead>
                                                    <tbody id="tdata">
                                                        <%PinController pc = new PinController();
                                                            for (map.AccountCode ac : pc.getList()) {%>
                                                        <tr>
                                                            <td></td>
                                                            <td><%=ac.getCodeName()%></td>
                                                            <td><%=ac.getName()%></td>
                                                            <td><%=(ac.getDateGiven() != null) ? ac.getDateGiven() : ""%></td>
                                                            <td><%=(ac.getTerminate()!= null) ? ac.getTerminate(): ""%></td>
                                                            <td><%=ac.getDepartment().getDepartmentName()%></td>
                                                            <td><%=ac.getStatus()%></td>

                                                        </tr>


                                                        <%}%>

                                                    </tbody>
                                                </table>
                                                <img src="img/321.GIF" id="loader" class="center-block" style="height: 40px;display: none;" alt=""/>
                                                <!--</div>-->
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

        <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                        <h4 class="modal-title">Create PIN</h4>
                    </div>
                    <div class="modal-body">
                        <form role="form" action="user_pin" >
                            <div class="form-group">
                                <label for=" ">PIN</label>
                                <input type="text" class="form-control" name="pin" placeholder="Enter code" required>
                            </div>
                            <div class="form-group">
                                <label for=" ">User Name</label>
                                <input type="text" class="form-control" name="uname" placeholder="Enter name" required>
                            </div>
                            <div class="form-group">
                                <label for=" ">Date Given</label>
                                 <div class="input-group">
                                    <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                                    <input type="text" class="form-control" id="datepickerDate" name="dp" required>
                                </div>  
                            </div>
                            <div class="form-group">
                                <label for=" ">Department</label>
                                <select class="form-control" name="dept" required>
                                    <%  BaseController bc = new BaseController();
                                       for (map.Department d : bc.getDeptList()) {%>
                                    <option value="<%=d.getIddepartment().toString()%>"><%=d.getDepartmentName()%></option>
                                    <%}%>
                                </select>
                            </div>
                            <div class="form-group">
                                <label for=" ">Status</label>
                                <select class="form-control" name="status">
                                    <option>Active</option>
                                    <option>Inactive</option>
                                </select>
                            </div>
                                <input type="hidden" name="action" value="save" />
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                        <button type="submit" class="btn btn-primary">Save</button> </form>
                    </div>
                </div> 
            </div>             
        </div>        
    </div> 
    <%@include file="footer.jsp" %>
    <script src="js/bootstrap-datepicker.js"></script>
    <script src="js/jquery.dataTables.js"></script>
    <script src="js/dataTables.fixedHeader.js"></script>
    <script src="js/dataTables.tableTools.js"></script>
    <script src="js/jquery.dataTables.bootstrap.js"></script>
    <%
        } catch (Exception e) {
        }

    %>
</body>

<script>
    $(document).ready(function () {
//datepicker
        $('#datepickerDate').datepicker();

        var tableFixed = $('#table-example-fixed').dataTable({
//                "sDom": '<"top"i>rt<"bottom"flp><"clear">',
            'info': false,
            'pageLength': 50
        });

        new $.fn.dataTable.FixedHeader(tableFixed);
    });
</script>


</html>
