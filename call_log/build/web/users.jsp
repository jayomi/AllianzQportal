<%-- 
    Document   : index
    Created on : Feb 23, 2015, 12:18:17 PM
    Author     : AKILAK
--%>

<%@page import="controller.BaseController"%>
<%@page import="controller.UserController"%>
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

    <body>
        <link rel="stylesheet" href="css/libs/select2.css" type="text/css"/>
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
                                            <li class="active"><span>User Management</span></li>
                                        </ol>                                       
                                    </div>
                                </div>
                                <div class="row">

                                    <div class="col-lg-12">
                                        <div class="main-box no-header clearfix">
                                            <div class="main-box-body clearfix">
                                                <div class="table-responsive">
                                                    <table class="table table-striped user-list table-hover">
                                                        <thead>
                                                            <tr>
                                                                <th><span>User</span></th> 
                                                                <th><span>Role</span></th>
                                                                <th class="text-center"><span>Status</span></th>                                                                
                                                                <th>&nbsp;</th>
                                                            </tr>
                                                        </thead>
                                                        <tbody>
                                                            <%UserController pc = new UserController();
                                                                for (map.User ac : pc.getList()) {%>



                                                            <tr>
                                                                <td>
                                                                    <img src="img/samples/scarlet-159.png" alt=""/>
                                                                    <a href="#" class="user-link"><%=ac.getFullName()%></a>
                                                                    
                                                                </td>
                                                                    <td><span class="user-link2"><%=ac.getType()%></span></td>

                                                                <td class="text-center">
                                                                    <span class="label label-success">Active</span>
                                                                </td>

                                                                <td style="width: 20%;">
                                                                    <a data-toggle="modal" href="#myModal" class="table-link" onclick="getExt('<%=ac.getIduser()%>')">
                                                                        <span class="fa-stack">
                                                                            <i class="fa fa-square fa-stack-2x"></i>
                                                                            <i class="fa fa-search-plus fa-stack-1x fa-inverse"></i>
                                                                        </span>
                                                                    </a>
                                                                    <a data-toggle="modal" href="#updateModal" class="table-link" onclick="updateUser('<%=ac.getIduser()%>')">
                                                                        <span class="fa-stack">
                                                                            <i class="fa fa-square fa-stack-2x"></i>
                                                                            <i class="fa fa-pencil fa-stack-1x fa-inverse"></i>
                                                                        </span>
                                                                    </a>
                                                                        <a href="#" class="table-link danger" onclick="deleteUser('<%=ac.getIduser()%>')">
                                                                        <span class="fa-stack">
                                                                            <i class="fa fa-square fa-stack-2x"></i>
                                                                            <i class="fa fa-trash-o fa-stack-1x fa-inverse"></i>
                                                                        </span>
                                                                    </a>
                                                                </td>
                                                            </tr>
                                                            <%}%> 
                                                        </tbody>
                                                    </table>
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

        <!--model-->
        <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                        <h4 class="modal-title">View</h4>
                    </div>
                    <div class="modal-body">
                        <form role="form" action="getExtension" method="POST">

                            <div class="form-group">
                                <label for=" ">Ext</label>
                                <select style="width:100%" id="sel2Multi" name="ext" multiple>                                                 

                                </select>
                            </div>


                            <input type="hidden" id="userid" name="id"/>
                            <input type="hidden" name="action" value="update" />
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                        <button type="submit" class="btn btn-primary">Update</button></form>
                    </div>
                </div> 
            </div>             
        </div>  
        
        <div class="modal fade" id="updateModal" tabindex="-1" role="dialog" aria-labelledby="updateModalLabel" aria-hidden="true">
            <form role="form" action="User" method="POST">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                        <h4 class="modal-title">Update Entry</h4>
                    </div>
                    <div class="modal-body">                        
                            <div class="form-group">
                                <label for=" ">User Name</label>
                                <input type="text" class="form-control" name="userName" id="userName" placeholder="Enter user name" required>
                            </div>
                            <div class="form-group">
                                <label for=" ">Full Name</label>
                                <input type="text" id="fullName" class="form-control" name="fullName" placeholder="Full Name" required>
                            </div>                                
                            <div class="form-group">
                                <label for=" ">User Type</label>
                                 <select class="form-control" name="type" required id="type">
                                    <option value="User">User</option>
                                    <option value="Admin">Admin</option>
                                    <option value="System Admin">System Admin</option>
                                </select>
                            </div>
                             <div class="form-group">
                                <label for=" ">Status</label>
                                <select class="form-control" name="status" required>
                                    
                                    <option value="Active">Active</option>
                                    <option value="Inactive">Inactive</option>
                                </select>
                            </div>  
                            
                             <input type="hidden" id="userId" name="id" value="" />  
                            <input type="hidden" id="oldUserName" name="oldUserName" value="" />    
                            <input type="hidden" id="oldFullName" name="oldFullName" />
                            <input type="hidden" id="oldType" name="oldType" />
                            <input type="hidden" id="oldStatus" name="oldStatus" />
                            <input type="hidden" name="action" value="update" />

                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                        <button type="submit" class="btn btn-primary">Update</button>
                    </div>
                </div> 
            </div>
            </form>
        </div>                      
        
        <%
            } catch (Exception e) {
            }

        %>

        <%@include file="footer.jsp" %>
        <script src="js/select2.min.js"></script>
        <script>
            $(function ($) {
                $('#sel2Multi').select2({
                    placeholder: 'example : 999',
                    allowClear: true
                });


            });

            function getExt(id) {
                $('#userid').val(id);
                $('#sel2Multi').empty();
                var query = "getExtension?action=getext&id=" + id;
                $.get(query, function (data, status) {

                    $('#sel2Multi').append(data);
                    $('#sel2Multi').select2();//users.jsp
                    

                });
            }
            
            function deleteUser(id){
               if (confirm('Are you sure you want to delete user?')) {
                   
                   var query = "User?action=deleteUser&id="+ id;
                   $.get(query,function(data,status){
                       //alert("user id="+id+"successfully deleted.");
                       var json = JSON.parse(data);                    
                       var deleteUser = json.userName;
                       alert(deleteUser+" deleted.");                     
                       location.href =  "users.jsp";
                   });           
             	}       
            }
            
            function updateUser(id){
                var query = "User?action=getdetails&id=" + id;
                $.get(query, function (data, status){
                    var json = JSON.parse(data);
                    $('#userId').val(json.userId);
                    $('#userName').val(json.userName);
                    $('#fullName').val(json.fullName);
                    $('#type').val(json.type);                   
                    $('#status').val(json.status);
                    
                    $('#oldUserName').val(json.userName);
                    $('#oldFullName').val(json.fullName);
                    $('#oldType').val(json.type);
                    $('#oldStatus').val(json.status);
                });
            }

        </script>
    </body>


</html>
