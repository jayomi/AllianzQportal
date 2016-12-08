<%-- 
    Document   : manageDepartments.jsp
    Created on : Nov 8, 2016, 9:41:15 AM
    Author     : jayomir
--%>

<%@page import="java.util.Set"%>
<%@page import="map.Department"%>
<%@page import="controller.InternalSearch"%>
<%@page import="controller.BaseController"%>
<%@page import="controller.DirectoryController"%>
<%@page import="controller.PinController"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

    <%@include  file="header.jsp" %>

    <%
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
                                            <li class="active"><span>Directory Management</span></li>
                                        </ol>              
                                        <div class="clearfix">
                                            <h1 class="pull-left">Directory</h1>
                                            <div class="pull-right top-page-ui">
                                                <a  class="btn btn-primary pull-right" data-toggle="modal" href="#myModal">
                                                    <i class="fa fa-plus-circle fa-lg"></i> Add Entry
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
                                                             <th style="display: none"><span>#</span></th>
                                                             <th><span>#</span></th>
                                                             <th><span>Department Name</span></th>
<!--                                                         <th><span>Order</span></th>                                                            -->
                                                             <th><span>#</span></th>
                                                             <th><span>#</span></th>

                                                        </tr>
                                                    </thead>
                                                    <tbody id="tdata">
                                                        <%InternalSearch is = new InternalSearch();
                                                        int index=1; 
                                                        for (map.HeadDepartment head : is.getHeaderList()) {
                                                             
                                                        %>
                                                        <tr>
                                                            <td style="display: none"></td>
                                                            <th><%=index++%></th>
                                                            <td><%= head.getHeadDepartName() %></td>
<!--                                                            <td><%= head.getHeadDepartmentOrder() %></td> -->                                                            
                                                            <td>
                                                                <a onclick="getUpdate('<%= head.getIdheadDepartment() %>')" style="cursor: pointer" data-toggle="modal" data-target="#updateModal" class="tooltips" data-placement="top" data-original-title="Edit"><i class="fa fa-edit"></i></a>
                                                                <a style="width: 20%;" href="#" class="table-link danger" onclick="deleteHeadDept('<%= head.getIdheadDepartment() %>')" data-original-title="Delete">
                                                                    <i class="fa fa-trash-o" aria-hidden="true"></i>
                                                                </a>
                                                            </td>
                                                            <td><a href="manageSubDepartments.jsp?idhead=<%= head.getIdheadDepartment() %>&head=<%= head.getHeadDepartName() %>">View Sub Departments</a></td>
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
                        <h4 class="modal-title">Create Entry</h4>
                    </div>
                    <div class="modal-body">
                        <form role="form" action="Department" method="POST">
                            <div class="form-group">
                                <label for=" ">Full Name</label>
                                <input type="text" class="form-control" name="department" placeholder="Enter department name" required>
                            </div>                    
                            <input type="hidden" name="action" value="save" />
                            
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                        <button type="submit" class="btn btn-primary">Save</button></form>
                    </div>
                </div> 
            </div>             
        </div> 


        <div class="modal fade" id="updateModal" tabindex="-1" role="dialog" aria-labelledby="updateModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                        <h4 class="modal-title">Update Entry</h4>
                    </div>
                    <div class="modal-body">
                        <form role="form" action="Department" method="POST">
                            <div class="form-group">
                                <label for=" ">Department Name: </label>
                                <input type="text" class="form-control" name="department" id="department" placeholder="Enter Department Name" required>
                            </div>                   
                            <div class="form-group">
                                <label for=" ">Order</label>
                                <input type="text" id="order" class="form-control" name="order" placeholder="Order" required>
                            </div>                                
                              
                            <input type="hidden" id="oldOrder" name="oldOrder" value="" />  
                            <input type="hidden" id="oldDepartment" name="oldDepartment" value="" />
                            <input type="hidden" id="IdHead" name="id" />
                            <input type="hidden" name="action" value="update" />

                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                        <button type="submit" class="btn btn-primary">Update</button></form>
                    </div>
                </div> 
            </div>             
        </div>                        

        <%@include file="footer.jsp" %>
        <script src="js/jquery.dataTables.js"></script>
        <script src="js/dataTables.fixedHeader.js"></script>
        <script src="js/dataTables.tableTools.js"></script>
        <script src="js/jquery.dataTables.bootstrap.js"></script>

    </body>

    <script>
            $(document).ready(function () {


                var tableFixed = $('#table-example-fixed').dataTable({
            //                "sDom": '<"top"i>rt<"bottom"flp><"clear">',
                    'info': false,
                    'pageLength': 50
                });

                new $.fn.dataTable.FixedHeader(tableFixed);
            });

            function getUpdate(id) {

                var query = "Department?action=getdetails&id=" + id;
                $.get(query, function (data, status){
                    var json = JSON.parse(data);
                    $('#IdHead').val(json.headId);
                    $('#department').val(json.departmentName);
                    $('#oldDepartment').val(json.departmentName);
                    $('#order').val(json.order);                   
                    $('#oldOrder').val(json.order);
                });

            }
            
            
             function deleteHeadDept(id){
               if (confirm('Are you sure you want to delete head Department ?')) {
                   
                   var query = "Department?action=delete&id="+ id;
                   $.get(query,function(data,status){
                       //alert("user id="+id+"successfully deleted.");
                       var json = JSON.parse(data);                    
                       var deletedHeadDept = json.deletedHeadDept;                      
                       alert(deletedHeadDept+" deleted.");                     
                       location.href = "manageHeadDepartments.jsp";
                   });           
             	}       
            }
            
    </script>


</html>
