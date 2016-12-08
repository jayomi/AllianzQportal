<%-- 
    Document   : index
    Created on : Feb 23, 2015, 12:18:17 PM
    Author     : AKILAK
--%>

<%@page import="controller.ExtensionController"%>
<%@page import="controller.BaseController"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.Comparator"%>
<%@page import="java.util.TreeMap"%>
<%@page import="java.util.HashSet"%>
<%@page import="java.util.SortedSet"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.TreeSet"%>
<%@page import="java.util.List"%>
<%@page import="org.hibernate.Criteria"%>
<%@page import="map.Assignee"%>
<%@page import="map.Department"%>
<%@page import="java.util.Set"%>
<%@page import="java.util.Set"%>
<%@page import="controller.InternalSearch"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

    <%@include  file="header.jsp" %>
    <head>
        <style>
            .depatHeader{
                color: #f49542;
            }        
        </style>

<script type='text/javascript' src='http://ajax.googleapis.com/ajax/libs/jquery/1.4/jquery.min.js?ver=3.2.1'></script>
    </head>



    <body>
        <link rel="stylesheet" type="text/css" href="css/libs/dataTables.fixedHeader.css">
        <link rel="stylesheet" type="text/css" href="css/libs/dataTables.tableTools.css">
        <div id="theme-wrapper">
            <header class="navbar" id="header-navbar">
                <div class="container">
                    <a href="index.jsp" id="logo" class="navbar-brand">

                        <img src="img/logo-black.png" alt="" class="normal-logo logo-white"/>

                    </a>
                    <div class="clearfix">
                        <button class="navbar-toggle" data-target=".navbar-ex1-collapse" data-toggle="collapse" type="button">
                            <span class="sr-only">Toggle navigation</span>
                            <span class="fa fa-bars"></span>
                        </button>
                        <div class="nav-no-collapse navbar-left pull-left hidden-sm hidden-xs">
                            <ul class="nav navbar-nav pull-left">
                                <li>
                                    <a class="btn" id="make-small-nav">
                                        <i class="fa fa-bars"></i>
                                    </a>
                                </li>
                            </ul>
                        </div>
                        <div class="nav-no-collapse pull-right" id="header-nav">
                            <ul class="nav navbar-nav pull-right">


                                <li class="hidden-xxs">
                                    <a href="index.jsp" class="btn">
                                        <i class="fa fa-power-off"></i>
                                    </a>
                                </li>
                            </ul>
                        </div>
                    </div>
                </div>
            </header>
            <div id="page-wrapper" class="container">
                <div class="row">
                    <div id="nav-col">
                        <section id="col-left" class="col-left-nano">
                            <div id="col-left-inner" class="col-left-nano-content">
                                <div id="user-left-box" class="clearfix hidden-sm hidden-xs">
                                    <img alt="" src="img/samples/scarlet-159.png"/>
                                    <div class="user-box">
                                        <span class="name">
                                            Welcome<br/>
                                            Guest
                                        </span>
                                        <span class="status">
                                            <i class="fa fa-circle"></i> Online
                                        </span>
                                    </div>
                                </div>
                                <div class="collapse navbar-collapse navbar-ex1-collapse" id="sidebar-nav">
                                    <ul class="nav nav-pills nav-stacked">
                                        <li>
                                            <a href="#">
                                                <i class="fa fa-dashboard"></i>
                                                <span>Internal Directory</span>

                                            </a>
                                        </li>

                                    </ul>
                                </div>
                            </div>
                        </section>
                    </div>
                    <div id="content-wrapper">
                        <div class="row">
                            <div class="col-lg-12">
                                <div class="row">
                                    <div class="col-lg-12">
                                        <ol class="breadcrumb">
                                            <li><a href="internal.jsp">Home</a></li>
                                            <li class="active"><span>Internal Directory</span></li>
                                        </ol>                                       
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-lg-12">
                                        <table id="table-example" class="table table-hover">
                                            <thead>

                                                <tr>

                                                    <th style="display: none"> </th>
                                                    <th>Head</th>
                                                    <th style="display: none"> </th>
                                                    <th style="display: none">Dept</th>
                                                    <th>Name</th>
                                                    <th>Designation</th>
                                                    <th>Direct No</th>
                                                    <th>Extension</th>
                                                    <th>#</th>

                                                </tr>
                                            </thead>
                                            <tbody>

                                                <% 
                                                    InternalSearch es = new InternalSearch(); 
                                                    ExtensionController ec = new ExtensionController();
                                                    for (map.HeadDepartment head : es.getHeaderList()) {//get parent department
                                                        //int headDepartmentId = head.getIdheadDepartment();
                                                        String headDepartmentName = head.getHeadDepartName();
                                                     
                                                        //getsubdepartment & arange by order
                                                        //--------------
                                                        Set<Department> subDepartmentList = head.getDepartments();
                                                        List<Department> newDepartmentSet = new ArrayList<Department>();
                                                        Map<Integer,Department> orderDepartmentMap = new HashMap<Integer, Department>();
                                                       // Set<Department> newsubDepartmentSet = new HashSet<Department>();
                                                            for (map.Department test : subDepartmentList) {                                              
                                                                orderDepartmentMap.put( test.getDepartmentOrder(),test);                                                        
                                                            }                                                           
                                                          
                                                            Map<Integer, Department> treeMap_subdepartment = new TreeMap<Integer, Department>(
                                                                new Comparator<Integer>() {

                                                                    @Override
                                                                    public int compare(Integer o1, Integer o2) {
                                                                        return o1.compareTo(o2);
                                                                    }

                                                                });
                                                            
                                                            treeMap_subdepartment.putAll(orderDepartmentMap);
                                                              
                                                               
                                                            for (Map.Entry<Integer, Department> entry : treeMap_subdepartment.entrySet()) {
                                                                //System.out.println("Key : " + entry.getKey()+ " Value : " + entry.getValue());
                                                                 map.Department as = (Department)entry.getValue();
                                                                 newDepartmentSet.add(as);
                                                             }                                                          
                                                        //-----------------
                                                        
                                                    //for (map.Department b : head.getDepartments()) {//get sub departments of parent
                                                      for (map.Department b : newDepartmentSet) {
                                                %>       

                                                <% 
                                                    
                                                    //--------------------------------
                                                     Set<Assignee> assigneeList = b.getAssignees();
                                                    
                                                        List<Assignee> newAssigneeList = new ArrayList<Assignee>();
                                                        Map<Integer,Assignee> orderAssigneeMap = new HashMap<Integer, Assignee>();
                                                       // Set<Department> newsubDepartmentSet = new HashSet<Department>();
                                                            for (map.Assignee test : assigneeList) {                                              
                                                                orderAssigneeMap.put( test.getAssigneeOrder(),test);                                                        
                                                            }                                                           
                                                          
                                                            Map<Integer, Assignee> treeMap_asssignee = new TreeMap<Integer, Assignee>(
                                                                new Comparator<Integer>() {

                                                                    @Override
                                                                    public int compare(Integer o1, Integer o2) {
                                                                        return o1.compareTo(o2);
                                                                    }

                                                                });
                                                            
                                                            treeMap_asssignee.putAll(orderAssigneeMap);
                                                              
                                                               
                                                            for (Map.Entry<Integer, Assignee> entry : treeMap_asssignee.entrySet()) {
                                                                //System.out.println("Key : " + entry.getKey()+ " Value : " + entry.getValue());
                                                                 map.Assignee as = (Assignee)entry.getValue();
                                                                 newAssigneeList.add(as);
                                                             }                      
                                                    //---------------------------------
                                                    
                                                 
                                                %>

                                                <% //for (map.Assignee a : b.getAssignees()) {
                                                    for (map.Assignee a : newAssigneeList) {
                                                       
                                                %>

                                                <tr style="background-color: #dce0db">
                                            
                                                    <td style="display: none;">#</td>  
                                                    <td><%=headDepartmentName%></td>
                                                    <td style="display: none">#</td>  
                                                    <td style="display: none"><%=b.getDepartmentName()%></td> 
                                                    <td><%=a.getFullName()%></td> 
                                                    <td><%=a.getDesignation()%></td>    
                                                    <td><%=a.getDirectNo()%></td>    
                                                    <td><a><b><%=a.getExtension().getExtensionNo()%></b></a></td>
                                                    
                                                    <%
                                                        String ext = a.getExtension().getExtensionNo();                                                       
                                                        
                                                       
                                                        Set<String> exts = new HashSet<String>();
                                                        exts.addAll(ec.getExtensionByForwdExt1(ext));//ec= ExtensionController object
                                                        exts.addAll(ec.getExtensionByForwdExt2(ext));
                                                        exts.addAll(ec.getExtensionByForwdExt3(ext));
                                                        exts.addAll(ec.getExtensionByForwdExt4(ext));
                                                            
                                                    %>
                                                    
                                                    <td><a href="#" forwardExt="<%= a.getExtension().getForwordExt()%>" forwdExt1="<%= a.getExtension().getForwdExt1() %>" forwdExt2="<%= a.getExtension().getForwdExt2() %>" forwdExt3="<%= a.getExtension().getForwdExt3() %>" forwdExt4="<%= a.getExtension().getForwdExt4() %>" exts="<%= exts %>" extNo="<%= a.getExtension().getExtensionNo()%>" data-toggle="modal" data-target="#extentionModal" data-toggle="tooltip" title="Edit Segment" class="extentionModal"><i class="fa fa-phone-square" aria-hidden="true"></i></a></td>
                                                    <!-- <td></td>-->                                                    
                                                </tr>
                                                <% }%>

                                                <% }%>
                                                <% }%>                           
                                        </table>
                                        </tbody>
                                    </div>
                                </div>
                            </div>

                            <%@include file="coprights.jsp" %>
                        </div>
                    </div>
                </div>
            </div>

            <!-- start modal -->

            <div id="extentionModal" tabindex="-1" role="dialog"
                 aria-labelledby="myModalLabel" aria-hidden="true" class="modal fade">
                <form action="" method="post" class="form-horizontal">

                    <div class="modal-dialog">
                        <div class="modal-content panel-primary">
                            <div class="modal-header panel-heading">
                                <button id="" type="button" data-dismiss="modal" aria-hidden="true"
                                        class="close">×</button>
                                <h4 id="myModalLabel" class="modal-title">Call Forwarding  Extensions: </h4>
                            </div>

                            <div class="modal-body" style="margin-right: 10px;">
                                <div class="row">
                                
                                    <div class="form-group">
                                        <label class="col-lg-2 control-label">From :</label>
                                        <div class="col-lg-10">
<!--                                            <input id="modal_fromExtention" name="modal_fromExtention" type="text"
                                                   class="form-control" value="">-->
                                                 <div id="modal_fromExtention"></div>
<!--                                                  <div id="modal_toExtention"></div>-->
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-lg-2 control-label">To :</label>
                                        <div class="col-lg-10">                                                
                                                  <div id="modal_toExtention"></div>
                                        </div>
                                    </div>                                   
                                  
                                </div>
                            </div>

                            <div class="modal-footer">
                                <button type="button" data-dismiss="modal" class="btn btn-labeled btn-primary btn-xs">Close</button>
<!--                                <input type="submit" class="btn btn-labeled btn-primary btn-xs" value="Save changes" id="modal_saveSegmentBtn" name="modal_saveSegmentBtn"/>-->
                            </div>
                        </div>
                    </div>

                </form>
            </div>

            <!-- END modal -->

            <%@include file="footer.jsp" %>
           
            <script src="js/jquery.dataTables.js"></script>
            <script src="js/dataTables.fixedHeader.js"></script>
            <script src="js/dataTables.tableTools.js"></script>
            <script src="js/jquery.dataTables.bootstrap.js"></script>
                
                
            <script>
                $(document).ready(function () {
              
              
                    //start data table
                    $('#table-example').dataTable({
                        "columnDefs": [
                            {"visible": false, "targets": 1}
                        ],
                        "drawCallback": function (settings) {
                            var api = this.api();
                            var rows = api.rows({page: 'current'}).nodes();
                            var last = null;

                            api.column(1, {page: 'current'}).data().each(function (group, i) {
                                if (last !== group) {
                                    $(rows).eq(i).before(
//                                            '<tr class="group" align="center" style="font-style: italic; font-size: 0.875em; background-color: rgb(185, 196, 245);"><td colspan="4"><b>' + group + '</b></td><td colspan="4"><a href="#" class="writeExcel" onclick="writeExcel()"><i class="fa fa-file" aria-hidden="true"></i></a></td></tr>'
                                                '<tr class="group" align="center" style="font-style: italic; font-size: 0.875em; background-color: rgb(185, 196, 245);"><td colspan="8"><b>' + group + '</b></td></tr>'
                                            );
                                    last = group;
                                }
                            });

                            api.column(3, {page: 'current'}).data().each(function (group, i) {
                                if (last !== group) {
                                    $(rows).eq(i).before(
                                            '<tr class="group" align="left" style="font-style: italic;font-size: 0.875em; background-color: #90d8f9;"><td colspan="8"><b>' + group + '</b></td></tr>'
                                            );
                                    last = group;
                                }
                            });
                        },
                        'pageLength': 200

                    });
                    //end data table

                    //start extension modal                   
                    $(document).on('click', '.extentionModal', function () {
                        $('div#modal_forwardExt').children().remove();
                         $('div#modal_fromExtention').children().remove();
                          $('div#modal_toExtention').children().remove();
                          
                        //var extentionNo = $(this).text();                        
                        var extentionNo = $(this).attr('extNo');
                           //$('#modal_fromExtention').val(extentionNo);
                          //$('#modal_fromExtention').html(extentionNo);
                          $('div#modal_fromExtention').append('<p class="btn btn-primary btn-sm">'+extentionNo+'</p>&nbsp;');
                        
                        
                        var arr = $(this).attr('forwardExt');
                        var forwdExt1 = $(this).attr('forwdExt1');
                        var forwdExt2 = $(this).attr('forwdExt2');
                        var forwdExt3 = $(this).attr('forwdExt3');
                        var forwdExt4 = $(this).attr('forwdExt4');
                       
                        if(forwdExt1!=='null'){ $('div#modal_fromExtention').append('&nbsp;---> <p class="btn btn-success btn-sm">'+forwdExt1+'</p>&nbsp;');}
                        if(forwdExt2!=='null'){$('div#modal_fromExtention').append('&nbsp;---> <p class="btn btn-success btn-sm">'+forwdExt2+'</p>&nbsp;');}
                        if(forwdExt3!=='null'){$('div#modal_fromExtention').append('&nbsp;---> <p class="btn btn-success btn-sm">'+forwdExt3+'</p>&nbsp;');}
                        if(forwdExt4!=='null'){$('div#modal_fromExtention').append('&nbsp;---> <p class="btn btn-success btn-sm">'+forwdExt4+'</p>&nbsp;');}                      
                        
                       var toExts = $(this).attr('exts');
                       var toExtArray = JSON.parse(toExts);
                       for (i = 0; i < toExtArray.length; i++) {                  
                          
                            // $('div#modal_forwardExt').append('<p class="btn btn-success btn-sm">'+forwardExt[i]+'</p>&nbsp;');
                            $('div#modal_toExtention').append('&nbsp;<p class="btn btn-success btn-sm">'+toExtArray[i]+'</p>---->&nbsp;<p class="btn btn-primary btn-sm">'+extentionNo+'</p>&nbsp;<br><br>');
                        }
                       
                        //  $('div#modal_toExtention').append('&nbsp;<p class="btn btn-primary btn-sm">'+extentionNo+'</p>&nbsp;');
                        
                       /* var forwardExt = JSON.parse(arr);// convert string to array type in jquery                        
                        for (i = 0; i < forwardExt.length; i++) {                  
                          
                            // $('div#modal_forwardExt').append('<p class="btn btn-success btn-sm">'+forwardExt[i]+'</p>&nbsp;');
                            $('div#modal_fromExtention').append('&nbsp;---> <p class="btn btn-success btn-sm">'+forwardExt[i]+'</p>&nbsp;');
                        }*/
        
                       
                    });
                    //end extension modal
                });
                
            </script>
    </body>


</html>
