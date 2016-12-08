<%-- 
    Document   : index
    Created on : Feb 23, 2015, 12:18:17 PM
    Author     : AKILAK
--%>

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
        <link rel="stylesheet" href="css/libs/select2.css" type="text/css"/>
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
                                                            <th><span>Full Name</span></th>
                                                            <th><span>Designation</span></th>
                                                            <th><span>Direct No</span></th>
                                                            <th><span>Ext</span></th>
                                                            <th><span>Department</span></th>
                                                            <th><span>#</span></th>

                                                        </tr>
                                                    </thead>
                                                    <tbody id="tdata">
                                                        <%DirectoryController pc = new DirectoryController();
                                                            for (map.Assignee ac : pc.getList()) {%>
                                                        <tr>
                                                            <td style="display: none"></td>
                                                            <td><%=ac.getFullName()%></td>
                                                            <td><%=ac.getDesignation()%></td>
                                                            <td><%=ac.getDirectNo()%></td>
                                                            <td><%=ac.getExtension().getExtensionNo()%></td>
                                                            <td><%=ac.getDepartment().getDepartmentName()%></td>   
                                                            <td>
                                                                <a style="width: 20%;" onclick="getUpdate('<%=ac.getIdassignee()%>')" style="cursor: pointer" data-toggle="modal" data-target="#updateModal" class="tooltips" data-placement="top" data-original-title="Edit"><i class="fa fa-edit"></i></a>
                                                                
<!--                                                                <a data-toggle="modal" href="#updateModal" data-target="#updateModal" class="table-link" onclick="getUpdate('<%=ac.getIdassignee()%>')" data-placement="top" data-original-title="Edit">
                                                                        <span class="fa-stack">
                                                                            <i class="fa fa-square fa-stack-2x"></i>
                                                                            <i class="fa fa-pencil fa-stack-1x fa-inverse"></i>
                                                                        </span>
                                                                    </a>-->
                                                                        <a style="width: 20%;" href="#" class="table-link danger" onclick="deleteUser('<%= ac.getIdassignee() %>')">
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
                        <form role="form" action="direct" method="POST">
                            <div class="form-group">
                                <label for=" ">Full Name</label>
                                <input type="text" class="form-control" name="fname" placeholder="Enter name" required>
                            </div>
                            <div class="form-group">
                                <label for=" ">Designation</label>
                                <input type="text" class="form-control" name="desig" placeholder="Enter Designation" required>
                            </div>
                            <div class="form-group">
                                <label for=" ">Direct No</label>
                                <input type="text" class="form-control" name="dno" placeholder="" size="10" >
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
                            <div class="form-group" >
                                <label for=" ">Extension</label>
                                <select class="form-control" name="ext" required>
                                    <%
                                        for (map.Extension e : bc.getList()) {%>
                                    <option value="<%=e.getIdExtension()%>"><%=e.getExtensionNo()%></option>
                                    <%}%>
                                </select>
                            </div>
                                
                            <!-- forward extentions-->
                               
                            <!-- forward extentions-->

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
            <form role="form" action="direct" method="POST" >
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                        <h4 class="modal-title">Update Entry</h4>
                    </div>
                    <div class="modal-body">
                       
                            <div class="form-group">
                                <label for=" ">Full Name</label>
                                <input type="text" class="form-control" name="fname" id="fname" placeholder="Enter name" required>
                            </div>
                            <div class="form-group">
                                <label for=" ">Designation</label>
                                <input type="text" class="form-control" name="desig" id="desig" placeholder="Enter Designation" required>
                            </div>
                            <div class="form-group">
                                <label for=" ">Direct No</label>
                                <input type="text" class="form-control" name="dno" id="dno" placeholder="" size="10" >
                            </div>
                            <div class="form-group">
                                <label for=" ">Department</label>
                                <select class="form-control" name="dept" id="dept" required>
                                    <%
                                        for (map.Department d : bc.getDeptList()) {%>
                                    <option value="<%=d.getIddepartment().toString()%>"><%=d.getDepartmentName()%></option>
                                    <%}%>
                                </select>
                            </div>
                            <div class="form-group" >
                                <label for=" ">Extension</label>
                                <select class="form-control" name="ext" id="ext" required>
                                    <%
                                        for (map.Extension e : bc.getList()) {%>
                                    <option value="<%=e.getIdExtension()%>"><%=e.getExtensionNo()%></option>
                                    <%}%>
                                </select>
                            </div>
                            
<!--                            forward extentions-->
                                <div class="form-group" >
                                <label for=" ">Forward Extensions: </label>
                                <select style="width:100%" id="sel2Multi" name="forwardExt" multiple>                                                 

                                </select>
                                </div>
                                
<!--                            forward extentions-->
                                
                            <div class="form-group">
                                <label for=" ">Order</label>
                                <input type="text" id="order" class="form-control" name="order" placeholder="Order" required>
                            </div> 
<!--                            <div class="form-group">
                                <label for=" ">EPF</label>
                                <input type="text" class="form-control" name="epf" id="epf" placeholder="Enter EPF No" required>
                            </div>-->
                              
                            <input type="hidden" id="oldOrder" name="oldOrder" value="" />    
                            <input type="hidden" id="assign" name="id" />
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

        <%@include file="footer.jsp" %>
        <script src="js/jquery.dataTables.js"></script>
        <script src="js/dataTables.fixedHeader.js"></script>
        <script src="js/dataTables.tableTools.js"></script>
        <script src="js/jquery.dataTables.bootstrap.js"></script>        
        <script src="js/select2.min.js"></script>        
        <script src="js/select2.min.js"></script>
       
         
    </body>
 
    <script>
        
            $(document).ready(function () {

                $('#sel2Multi').select2({
                    placeholder: 'example : 999',
                    allowClear: true
                });


                var tableFixed = $('#table-example-fixed').dataTable({
            //"sDom": '<"top"i>rt<"bottom"flp><"clear">',
                    'info': false,
                    'pageLength': 50
                });

                new $.fn.dataTable.FixedHeader(tableFixed);
            });
            
            function getUpdate(id) {

                var query = "direct?action=getdetails&id=" + id;
                $.get(query, function (data, status){
                    var json = JSON.parse(data);
                    $('#fname').val(json.full_name);
                    $('#desig').val(json.designation);
                    $('#dno').val(json.direct);
                    $('#dept').val(json.dept);
                    $('#ext').val(json.ext);                   
                    $('#assign').val(json.assign);
                    $('#order').val(json.order);
                    $('#oldOrder').val(json.order);
                    
                    var forwardExt = json.forwardExt_arr; 
                    //var forwardExtId = json.forwardExtId_arr;
                                        
                    $('#sel2Multi').empty();
                    for (i = 0; i < forwardExt.length; i++) { 
                      
                        //$('select#sel2Multi').append('<option selected="selected" value='+forwardExtId[i]+'>'+forwardExt[i]+'</option>');
                        $('select#sel2Multi').append('<option selected="selected" value='+forwardExt[i]+'>'+forwardExt[i]+'</option>');
                        //$('#sel2Multi').select2();//users.jsp
                    }
                                          
                    <%for (map.Extension exten : bc.getList()) {%>
                             $('select#sel2Multi').append('<option value="<%=exten.getExtensionNo()%>"><%=exten.getExtensionNo()%></option>');

                       <% }%>
                   
                    $('#sel2Multi').select2();//users.jsp  
                    
                });

            }
            
            function deleteUser(id){
               if (confirm('Are you sure you want to delete Assignee ?')) {
                   
                   var query = "direct?action=delete&id="+ id;
                   $.get(query,function(data,status){
                       //alert("user id="+id+"successfully deleted.");
                       var json = JSON.parse(data);                    
                       var deleteUser = json.assigneeName;
                       alert(deleteUser+" deleted.");                     
                       location.href =  "directory.jsp";
                   });           
             	}       
            }
    </script>


</html>
