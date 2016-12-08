<%-- 
    Document   : manageExts
    Created on : Nov 10, 2016, 2:44:35 PM
    Author     : jayomir
--%>

<%@page import="org.json.JSONArray"%>
<%@page import="java.util.ArrayList"%>
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
                                                            <th><span>#</span></th>
                                                            <th><span>Extension</span></th>
                                                            <th><span>Forward Ext1</span></th>
                                                             <th><span>Forward Ext2</span></th> 
                                                              <th><span>Forward Ext3</span></th>
                                                              <th><span>Forward Ext4</span></th> 
                                                            <th><span>#</span></th>
                                                           

                                                        </tr>
                                                    </thead>
                                                    <tbody id="tdata">
                                                        <% BaseController bc = new BaseController();
                                                            int index=1;
                                                             for (map.Extension e : bc.getList()) {
                                                                 String forwadExt = e.getForwordExt();
                                                                 String[] forwardExt_arr=null;
                                                                 if(forwadExt!=null){
                                                                     forwardExt_arr = forwadExt.replaceAll("\\[", "").replaceAll("\\]","").replaceAll("\"", "").split(",");
                                                                    
                                                                 }
                                                                
                                                                 
                       
                                                        %>
                                                        
                                                            <%  //JSONArray ext_Jarry = new JSONArray(forwardExt_arr);
                                                                if(forwadExt!=null){
                                                                    JSONArray ext_Jarry = new JSONArray(forwardExt_arr); 
                                                                    
                                                                    
                                                                    if(ext_Jarry.length()==4){%>
                                                                        
                                                                        <tr>    
                                                                        <td style="display: none"></td>
                                                                        <th><%= index++ %></th>
                                                                        <td><%= e.getExtensionNo() %></td>                                                   
                                                                        <%if(ext_Jarry.getString(0)!=null){%><td><%= ext_Jarry.get(0) %></td> <%}else{%><td>Add</td><%}%>
                                                                        <%if(ext_Jarry.getString(1)!=null){%><td><%= ext_Jarry.get(1) %></td> <%}else{%><td>Add</td><%}%>
                                                                        <%if(ext_Jarry.get(2)!=null){%><td><%= ext_Jarry.get(2) %></td> <%}else{%><td>Add</td><%}%>
                                                                        <%if(ext_Jarry.get(3)!=null){%><td><%= ext_Jarry.get(3) %></td> <%}else{%><td>Add</td><%}%>
                                                                        <td>
                                                                            <a style="width: 20%;" href="#" onclick="getUpdate('<%= e.getIdExtension() %>')" data-toggle="modal" data-target="#updateModal" class="tooltips" data-placement="top" data-original-title="Edit"><i class="fa fa-edit"></i></a>
                                                                             <a style="width: 20%;" href="#" class="table-link danger" onclick="deleteExtension('<%= e.getIdExtension() %>')" data-original-title="Delete">
                                                                            <i class="fa fa-trash-o" aria-hidden="true"></i>
                                                                        </td>
                                                                    </tr>
                                                                   <% } else if(ext_Jarry.length()==3){%>
                                                                        
                                                                        <tr>    
                                                                        <td style="display: none"></td>
                                                                        <th><%= index++ %></th>
                                                                        <td><%= e.getExtensionNo() %></td>                                                   
                                                                        <%if(ext_Jarry.getString(0)!=null){%><td><%= ext_Jarry.get(0) %></td> <%}else{%><td>N/A</td><%}%>
                                                                        <%if(ext_Jarry.getString(1)!=null){%><td><%= ext_Jarry.get(1) %></td> <%}else{%><td>N/A</td><%}%>
                                                                        <%if(ext_Jarry.get(2)!=null){%><td><%= ext_Jarry.get(2) %></td> <%}else{%><td>N/A</td><%}%>
                                                                        <td>Add</td>
                                                                        <td>
                                                                            <a style="width: 20%;" href="#" onclick="getUpdate('<%= e.getIdExtension() %>')" data-toggle="modal" data-target="#updateModal" class="tooltips" data-placement="top" data-original-title="Edit"><i class="fa fa-edit"></i></a>
                                                                            <a style="width: 20%;" href="#" class="table-link danger" onclick="deleteExtension('<%= e.getIdExtension() %>')" data-original-title="Delete">
                                                                            <i class="fa fa-trash-o" aria-hidden="true"></i>
                                                                        </td>
                                                                    </tr>
                                                                   <% } else if(ext_Jarry.length()==2){%>
                                                                         <tr>    
                                                                        <td style="display: none"></td>
                                                                        <th><%= index++ %></th>
                                                                        <td><%= e.getExtensionNo() %></td>                                                   
                                                                        <%if(ext_Jarry.get(0)!=null){%><td><%= ext_Jarry.get(0) %></td> <%}else{%><td>Add</td><%}%>
                                                                        <%if(ext_Jarry.get(1)!=null){%><td><%= ext_Jarry.get(1) %></td> <%}else{%><td>Add</td><%}%>
                                                                        <td>Add</td>
                                                                        <td>Add</td>
                                                                        <td>
                                                                            <a style="width: 20%;" href="#" onclick="getUpdate('<%= e.getIdExtension() %>')" data-toggle="modal" data-target="#updateModal" class="tooltips" data-placement="top" data-original-title="Edit"><i class="fa fa-edit"></i></a>
                                                                            <a style="width: 20%;" href="#" class="table-link danger" onclick="deleteExtension('<%= e.getIdExtension() %>')" data-original-title="Delete">
                                                                            <i class="fa fa-trash-o" aria-hidden="true"></i>
                                                                        </a>
                                                                        </td>
                                                                    </tr>
                                                                    <%} else if(ext_Jarry.length()==1){%>
                                                                         <tr>    
                                                                        <td style="display: none"></td>
                                                                        <th><%= index++ %></th>
                                                                        <td><%= e.getExtensionNo() %></td>                                                   
                                                                        <%if(ext_Jarry.get(0)!=null){%><td><%= ext_Jarry.get(0) %></td> <%}else{%><td>N/A</td><%}%>
                                                                        <td>Add</td>
                                                                        <td>Add</td>
                                                                        <td>Add</td>
                                                                        <td>
                                                                            <a style="width: 20%;" href="#" onclick="getUpdate('<%= e.getIdExtension() %>')" data-toggle="modal" data-target="#updateModal" class="tooltips" data-placement="top" data-original-title="Edit"><i class="fa fa-edit"></i></a>
                                                                            <a style="width: 20%;" href="#" class="table-link danger" onclick="deleteExtension('<%= e.getIdExtension() %>')" data-original-title="Delete">
                                                                            <i class="fa fa-trash-o" aria-hidden="true"></i>
                                                                        </a>
                                                                        </td>
                                                                    </tr>
                                                                    <%} %>
                                                                    
                                                                <% }else{ %>
                                                                
                                                                <tr>    
                                                                    <td style="display: none"></td>
                                                                    <th><%= index++ %></th>
                                                                    <td><%= e.getExtensionNo() %></td>                                                   
                                                                    <td>Add</td>
                                                                     <td>Add</td>
                                                                     <td>Add</td>
                                                                     <td>Add</td>
                                                                    <td>
                                                                        <a style="width: 20%;" onclick="getUpdate('<%= e.getIdExtension() %>')" href="#" data-toggle="modal" data-target="#updateModal" class="tooltips" data-placement="top" data-original-title="Edit"><i class="fa fa-edit"></i></a>
                                                                        <a style="width: 20%;" href="#" class="table-link danger" onclick="deleteExtension('<%= e.getIdExtension() %>')" data-original-title="Delete">
                                                                            <i class="fa fa-trash-o" aria-hidden="true"></i>
                                                                        </a>
                                                                    </td>
                                                                </tr>
                                                        
                                                            <%    } %>
                                                          
                                                        


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
            <form role="form" action="ExtensionMng" method="POST" class="form-horizontal"> 
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                        <h4 class="modal-title">Create Entry</h4>
                    </div>
                    <div class="modal-body">
                                               
                           <div class="form-group" >
                                <label for=" "  class="col-lg-2 col-sm-2 control-label">Extension: </label>                                
                                 <div class="col-lg-10">
                                    <input type="text" class="form-control" name="ext" placeholder="Enter Extension" required> 
                                 </div>
                            </div>
                                
                            <!-- forward extentions-->
                            <label for=" " class="modal-title">Forward Extensions: </label>    
                            <div class="form-group" >
                                <label for=" " class="col-lg-2 col-sm-2 control-label">Extension 1: </label>
                                 <div class="col-lg-10">
                                    <input type="text" class="form-control" name="ext1" placeholder="Forward Extension 1" > 
                                 </div>
                            </div>
                                
                             <div class="form-group" >
                                <label for=" " class="col-lg-2 col-sm-2 control-label">Extension 2: </label>
                                 <div class="col-lg-10">
                                    <input type="text" class="form-control" name="ext2" placeholder="Forward Extension 2" > 
                                 </div>
                            </div>
                             <div class="form-group" >
                                <label for=" " class="col-lg-2 col-sm-2 control-label">Extension 3: </label>
                                 <div class="col-lg-10">
                                    <input type="text" class="form-control" name="ext3" placeholder="Forward Extension 3" > 
                                 </div>
                            </div>
                            
                            <div class="form-group" >
                                <label for=" " class="col-lg-2 col-sm-2 control-label">Extension 4: </label>
                                 <div class="col-lg-10">
                                    <input type="text" class="form-control" name="ext4" placeholder="Forward Extension 4" > 
                                 </div>
                            </div>
                            
                            <!-- forward extentions-->
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
            <form role="form" action="ExtensionMng" method="POST" class="form-horizontal" >
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                        <h4 class="modal-title">Update Entry</h4>
                    </div>
                    <div class="modal-body">
                       
                            <div class="form-group" >
                                <label for=" "  class="col-lg-2 col-sm-2 control-label">Extension: </label>                                
                                 <div class="col-lg-10">
                                    <input type="text" class="form-control" name="ext" id="ext" placeholder="Enter Extension" required> 
                                 </div>
                            </div>
                            
<!--    forward extentions-->                     
                   <label for=" " class="modal-title">Forward Extensions: </label>        

                            <div class="form-group" >                               
                                <label for=" "  class="col-lg-2 col-sm-2 control-label">Ext1: </label>
                                <div class="col-lg-10">
                                    <select name="ext1" id="ext1" class="form-control">
                                       <option value="" class="form-control">Select</option>
                                       <option value="none" class="form-control">None</option>
                                     <%
                                    for(map.Extension e : bc.getList()) {%>
                                        <option value="<%=e.getExtensionNo()%>" class="form-control"><%=e.getExtensionNo()%></option>
                                    <%}%>
                                    </select>
                                </div>
                            </div>   
                            <div class="form-group">
                                <label for=" " class="col-lg-2 col-sm-2 control-label">Ext2: </label>
                                <div class="col-lg-10">
                                  <select name="ext2" id="ext2" class="form-control"> 
                                      <option value="" class="form-control">Select</option>
                                      <option value="none" class="form-control">None</option>
                                     <%
                                    for (map.Extension e : bc.getList()) {%>
                                        <option value="<%=e.getExtensionNo()%>" class="form-control"><%=e.getExtensionNo()%></option>
                                    <%}%>
                                  </select>
                                </div>
                            </div>
                            <div class="form-group">
                                <label for=" " class="col-lg-2 col-sm-2 control-label">Ext3: </label>
                                <div class="col-lg-10">
                                <select name="ext3" id="ext3" class="form-control"> 
                                    <option value="" class="form-control">Select</option>
                                    <option value="none" class="form-control">None</option>
                                    <%
                                   for (map.Extension e : bc.getList()) {%>
                                       <option value="<%=e.getExtensionNo()%>" class="form-control"><%=e.getExtensionNo()%></option>
                                   <%}%>
                                </select>
                               </div>
                            </div> 
                                
                             <div class="form-group">
                                <label for=" " class="col-lg-2 col-sm-2 control-label">Ext4: </label>
                                <div class="col-lg-10">
                                <select name="ext4" id="ext4" class="form-control"> 
                                    <option value="" class="form-control">Select</option>
                                    <option value="none" class="form-control">None</option>
                                    <%
                                   for (map.Extension e : bc.getList()) {%>
                                       <option value="<%=e.getExtensionNo()%>" class="form-control"><%=e.getExtensionNo()%></option>
                                   <%}%>
                                </select>
                               </div>
                            </div> 
                                
            <!-- forward extentions-->              
                            <input type="hidden" id="updateExt" name="id" />
                            <input type="hidden" id="oldExt" name="oldExt" />
                            <input type="hidden" id="oldFdExt1" name="oldFdExt1" />
                            <input type="hidden" id="oldFdExt2" name="oldFdExt2" />
                            <input type="hidden" id="oldFdExt3" name="oldFdExt3" />
                            <input type="hidden" id="oldFdExt4" name="oldFdExt4" />
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
            //"sDom": '<"top"i>rt<"bottom"flp><"clear">',
                    'info': false,
                    'pageLength': 50
                });

                new $.fn.dataTable.FixedHeader(tableFixed);
            });
            
            function getUpdate(id) {

                var query = "ExtensionMng?action=getdetails&id=" + id;
                $.get(query, function (data, status){
                    var json = JSON.parse(data);                   
                    $('#ext').val(json.ext);
                    $('#oldExt').val(json.ext);
                    $('#updateExt').val(json.extId);
                    
                     if(!(new String(json.forwdExt1).valueOf() == new String("empty").valueOf())){
                          $('#ext1').val(json.forwdExt1); 
                          $('#oldFdExt1').val(json.forwdExt1);
                          
                     }
                    if(!(new String(json.forwdExt2).valueOf() == new String("empty").valueOf())){
                          $('#ext2').val(json.forwdExt2);  
                           $('#oldFdExt2').val(json.forwdExt2);
                     }
                     if(!(new String(json.forwdExt3).valueOf() == new String("empty").valueOf())){
                          $('#ext3').val(json.forwdExt3);
                          $('#oldFdExt3').val(json.forwdExt3);
                     }             
                    if(!(new String(json.forwdExt4).valueOf() == new String("empty").valueOf())){
                          $('#ext4').val(json.forwdExt4);
                          $('#oldFdExt4').val(json.forwdExt4); 
                     }   
                   
                    /*
                    if(!(new String(json.forwardExt_arr).valueOf() == new String("empty").valueOf())){
                        
                        var forwardExt = json.forwardExt_arr;
                        $('#ext1').val(forwardExt[0]);                  
                        $('#ext2').val(forwardExt[1]);
                        $('#ext3').val(forwardExt[2]);
                        $('#ext4').val(forwardExt[3]);

                        $('#oldFdExt1').val(forwardExt[0]);
                        $('#oldFdExt2').val(forwardExt[1]);
                        $('#oldFdExt3').val(forwardExt[2]);
                        $('#oldFdExt4').val(forwardExt[3]);                     
                    }            
                    */
                });

            }
            
            function deleteExtension(id){
               if (confirm('Are you sure you want to delete Extension ?')) {
                   
                   var query = "ExtensionMng?action=delete&id="+ id;
                   $.get(query,function(data,status){
                       //alert("user id="+id+"successfully deleted.");
                       var json = JSON.parse(data);                    
                       var deleteExt = json.ExtensionNo;
                       alert(deleteExt+" deleted.");                     
                       location.href =  "manageExts.jsp";
                   });           
             	}       
            }
    </script>


</html>
