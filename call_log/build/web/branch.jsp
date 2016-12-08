<%-- 
    Document   : index
    Created on : Feb 23, 2015, 12:18:17 PM
    Author     : AKILAK
--%>

<%@page import="map.User"%>
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
                                            <h1 class="pull-left">Branch Directory</h1>
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
                                                            <th><span>Branch Name</span></th>
                                                            <th><span>Direct No</span></th>
                                                            <th><span>Fax</span></th>
                                                             <th><span>DID No</span></th>
                                                            <th><span>Speed Dial/Ext</span></th>
                                                            <th></th>


                                                        </tr>
                                                    </thead>
                                                    <tbody id="tdata">
                                                        <%DirectoryController pc = new DirectoryController();
                                                                for (map.Branch ac : pc.getBranchList()) {%>
                                                        <tr>
                                                            <td style="display: none"></td>
                                                            <td><%=ac.getBranchName()%></td>
                                                            <td><%=ac.getTel()%></td>
                                                            <td><%=ac.getFax()%></td>
                                                            <td><%=ac.getDidNo() %></td>
                                                            <td><%=ac.getSpeedDial()%></td>
                                                            <td><a style="width: 20%;" onclick="getUpdate('<%=ac.getIdbranch().toString() %>')" style="cursor: pointer" data-toggle="modal" data-target="#updateModal" class="tooltips" data-placement="top" data-original-title="Edit"><i class="fa fa-edit"></i></a>
                                                                <a style="width: 20%;" href="#" class="table-link danger" onclick="deleteUser('<%= ac.getIdbranch() %>')">
                                                                <i class="fa fa-trash-o" aria-hidden="true"></i>
                                                                </a>
                                                            
                                                            </td>
                                                                    

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
                        <form role="form" action="branchd" method="POST">
                            <div class="form-group">
                                <label for=" ">Branch Name</label>
                                <input type="text" class="form-control" name="ou_name" placeholder="Enter name" required>
                            </div>
                            <div class="form-group">
                                <label for=" ">Telephone</label>
                                <input type="text" class="form-control" name="tel" placeholder="Enter Telephone" required>
                            </div>
                            <div class="form-group">
                                <label for=" ">Fax</label>
                                <input type="text" class="form-control" name="fax" placeholder="Fax" size="10" >
                            </div>
                            <div class="form-group">
                                <label for=" ">DID No</label>
                                <input type="text" class="form-control" name="did" placeholder="DID" size="10" >
                            </div>
                            <div class="form-group">
                                <label for=" ">Speed Dial/Ext</label>
                                <input type="text" class="form-control" name="speed_dial" placeholder="Fax" size="10" >
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

        <div class="modal fade" id="updateModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                        <h4 class="modal-title">Update Entry</h4>
                    </div>
                    <div class="modal-body">
                        <form role="form" action="branchd" method="POST">
                            <div class="form-group">
                                <label for=" ">Branch Name</label>
                                <input type="text" class="form-control" name="ou_name" id="ou_name" placeholder="Enter name" required>
                            </div>
                            <div class="form-group">
                                <label for=" ">Telephone</label>
                                <input type="text" class="form-control" name="tel" id="tel" placeholder="Enter Telephone" required>
                            </div>
                            <div class="form-group">
                                <label for=" ">Fax</label>
                                <input type="text" class="form-control" name="fax" id="fax" placeholder="Fax" size="10" >
                            </div>
                            <div class="form-group">
                                <label for=" ">DID No</label>
                                <input type="text" class="form-control" name="did" id="did" placeholder="DID" size="10" >
                            </div>
                            <div class="form-group">
                                <label for=" ">Speed Dial/Ext</label>
                                <input type="text" class="form-control" name="speed_dial" id="speed_dial" placeholder="Fax" size="10" >
                            </div>
                            <input type="hidden" name="id" id="branch_id" />
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
        
        function getUpdate(id){
            
             var query = "branchd?action=getdetails&id=" + id; 
                $.get(query , function (data, status) {
                     var json = JSON.parse(data);
                    $('#ou_name').val(json.ou_name);
                    $('#tel').val(json.tel);
                    $('#did').val(json.did);
                    $('#fax').val(json.fax);
                    $('#speed_dial').val(json.speed_dial);                    
                    $('#branch_id').val(json.branch_id);
                });
            
        }
        
        function deleteUser(id){
               if (confirm('Are you sure you want to delete Branch ?')) {
                   
                   var query = "branchd?action=delete&id="+ id;
                   $.get(query,function(data,status){
                       //alert("user id="+id+"successfully deleted.");
                       var json = JSON.parse(data);                    
                       var branch = json.branchName;
                       alert(branch+" is deleted.");                     
                       location.href =  "branch.jsp";
                   });           
             	}       
            }
    </script>


</html>
