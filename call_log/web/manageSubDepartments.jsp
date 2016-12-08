<%-- 
    Document   : manageSubDepartments
    Created on : Nov 8, 2016, 10:21:05 AM
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
                                            <li><a href="">Home</a></li>
                                            <li><a href="manageHeadDepartments.jsp">Directory</a></li>
                                            <li class="active"><span><%= request.getParameter("head").toString() %></span></li>
                                            <li class="active"><span>Sub Directory</span></li>
                                            
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
                                                            <th><span>#</span></th>

                                                        </tr>
                                                    </thead>
                                                    <tbody id="tdata">
                                                        <%                                                         
                                                            String idHead = request.getParameter("idhead");                                              
                                                            int headId=0;if(idHead!=null){headId = Integer.parseInt(idHead);}
                                                            InternalSearch is = new InternalSearch();                                        
                                                            int index=1;
                                                            for (Department dept : is.getListByHeaderId(headId) ) {                                                                
                                                        %>
                                                        <tr>
                                                            <td style="display: none"></td>
                                                            <th><%=index++%></th>
                                                            <td><%= dept.getDepartmentName() %></td>                                                             
                                                            <td>
                                                                <a onclick="getUpdate('<%= dept.getIddepartment() %>')" style="cursor: pointer" data-toggle="modal" data-target="#updateModal" class="tooltips" data-placement="top" data-original-title="Edit"><i class="fa fa-edit"></i></a>
                                                                 <a style="width: 20%;" href="#" class="table-link danger" onclick="deleteSubDept('<%= dept.getIddepartment() %>')" data-original-title="Delete">
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
            <form role="form" action="SubDepartment" method="POST">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                        <h4 class="modal-title">Create Entry</h4>
                    </div>
                    <div class="modal-body">                        
                            <div class="form-group">
                                <label for=" ">Department Name</label>
                                <input type="text" class="form-control" name="department" placeholder="Enter department name" required>
                            </div>                            
                           
                            <input type="hidden" id="headDeptId" name="headDeptId" value="<%=idHead%>" />
                            <input type="hidden" name="action" value="save" />                            
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                        <button type="submit" class="btn btn-primary">Save</button>
                    </div>
                </div> 
            </div> 
        </form>
        </div> 


        <div class="modal fade" id="updateModal" tabindex="-1" role="dialog" aria-labelledby="updateModalLabel" aria-hidden="true">
           <form role="form" action="SubDepartment" method="POST">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                        <h4 class="modal-title">Update Entry</h4>
                    </div>
                    <div class="modal-body">
                        
                            <div class="form-group">
                                <label for=" ">Department Name</label>
                                <input type="text" class="form-control" name="department" id="department" placeholder="Enter department name" required>
                            </div>
                            <div class="form-group">
                                <label for=" ">Order</label>
                                <input type="text" id="order" class="form-control" name="order" placeholder="Order" required>
                            </div>                                
                            
                             <input type="hidden" id="headDeptId" name="headDeptId" value="<%=idHead%>" />  
                            <input type="hidden" id="oldOrder" name="oldOrder" value="" />    
                            <input type="hidden" id="departmentId" name="id" />
                            <input type="hidden" id="oldDepartment" name="oldDepartment" />
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

                var query = "SubDepartment?action=getdetails&id=" + id;
                $.get(query, function (data, status){
                    var json = JSON.parse(data);                    
                    $('#departmentId').val(json.headId);
                    $('#department').val(json.departmentName);
                    $('#oldDepartment').val(json.departmentName);
                    $('#order').val(json.order);
                    $('#oldOrder').val(json.order);
                });

            }
            
            function deleteSubDept(id){
               if (confirm('Are you sure you want to delete Sub Department ?')) {
                   
                   var query = "SubDepartment?action=delete&id="+ id;
                   $.get(query,function(data,status){
                       //alert("user id="+id+"successfully deleted.");
                       var json = JSON.parse(data);                    
                       var deleteSubDept = json.deletedSubDept;
                       var headDept = json.headOfSub;
                       var headId = json.headId;
                       alert(deleteSubDept+" deleted.");                     
                       location.href =  "manageSubDepartments.jsp?idhead="+headId+"&head="+headDept;
                   });           
             	}       
            }
            
    </script>


</html>
