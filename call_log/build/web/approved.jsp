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
                                            <li class="active"><span>Approved</span></li>
                                        </ol>                                       
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-lg-12">
                                        <div class="main-box no-header clearfix">
                                            <div class="main-box-body clearfix">
                                                <div class="table-responsive">
                                                    <table class="table user-list table-hover">
                                                        <thead>
                                                            <tr>
                                                                <th class="text-center"><span>Username</span></th> 
                                                                <th class="text-center"><span>Full Name</span></th>  
                                                                <th class="text-center"><span>Requested Ext</span></th>  
                                                                <th class="text-center"><span>Requested Time</span></th>  
                                                                <th class="text-center"><span>Client IP</span></th>                                                                     
                                                                <th class="text-center"><span>Status</span></th>                                                                
                                                                <th>&nbsp;</th>
                                                            </tr>
                                                        </thead>
                                                        <tbody>
                                                            <%BaseController pc = new BaseController();
                                                                for (map.Register ac : pc.getPList()) {%>



                                                            <tr>
                                                                <td>
                                                                    <img src="img/samples/scarlet-159.png" alt=""/>
                                                                    <a href="#" class="user-link"><%=ac.getUsername()%></a>

                                                                </td>

                                                                <td class="text-center">
                                                                    <%=ac.getFullname()%>
                                                                </td>
                                                                <td class="text-center">
                                                                    <%
                                                                        for (map.RegisterHasExt ext : ac.getRegisterHasExts()) {
                                                                            out.write(ext.getExtension().getExtensionNo() + " ");

                                                                        }
                                                                    %>
                                                                </td>

                                                                <td class="text-center">
                                                                    <%=ac.getRequestedTime()%>
                                                                </td>
                                                                <td class="text-center">
                                                                    <%=ac.getClientIp()%>
                                                                </td>
                                                                <td class="text-center">
                                                                    <span class="label label-default"> <%=ac.getStatus()%></span>
                                                                </td>

                                                                <td style="width: 20%;">
                                                                    <a data-toggle="modal" href="#myModal" class="table-link" >
                                                                        <span class="fa-stack">
                                                                            <i class="fa fa-square fa-stack-2x"></i>
                                                                            <i class="fa fa-search-plus fa-stack-1x fa-inverse"></i>
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
                        <form role="form">

                            <div class="form-group">
                                <label for=" ">Ext</label>
                                <select style="width:300px" id="sel2Multi" name="ext" multiple>                                                 

                                </select>
                            </div>

                            <div class="form-group">
                                <label for=" ">Status</label>
                                <select class="form-control" name="status">
                                    <option>Active</option>
                                    <option>Inactive</option>
                                </select>
                            </div>
                        </form>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                        <button type="button" class="btn btn-primary">Save</button>
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
               


            });
                   
            
        </script>
    </body>


</html>
