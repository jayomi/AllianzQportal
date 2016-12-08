<%-- 
    Document   : index
    Created on : Feb 23, 2015, 12:18:17 PM
    Author     : AKILAK
--%>

<%@page import="java.util.HashMap"%>
<%@page import="java.util.Comparator"%>
<%@page import="java.util.TreeMap"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.TreeSet"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Collection"%>
<%@page import="java.util.Set"%>
<%@page import="map.Branch"%>
<%@page import="controller.ExternalSearch"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

    <%@include  file="header.jsp" %>
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
                                                <span>Branch Directory</span>

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
                                            <li><a href="external.jsp">Home</a></li>
                                            <li class="active"><span>Branch Directory</span></li>
                                        </ol>                                       
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-lg-12">

                                        <table id="table-example" class="table table-hover">
                                            <thead>
                                                <tr>
                                                    <th style="display: none">#</th>
                                                    <th>Head Branch</th>
                                                    <th>Branch Name</th>
                                                    <th>Telephone</th>
                                                    <th>Fax</th>
                                                    <th><span>Direct No</span></th>
                                                    <th>Speed Dial/Ext</th> 
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <% ExternalSearch es = new ExternalSearch();
                                                    for(map.HeadBranch head : es.getHeadBranchList()){
                                                        int headBranchId = head.getIdheadBranch();                                                        
                                                        Set<Branch> branchList = head.getBranches();
                                                    
                                                    //   start Alphabetical order list
                                                    
                                                        Map<String,Branch> branchMap = new HashMap<String, Branch>();
                                                      
                                                            for (map.Branch b : branchList) {                                              
                                                                branchMap.put( b.getBranchName(),b);                                                        
                                                            }
                                                       
                                                        Map<String, Branch> newTreeMap = new TreeMap<String, Branch>(
                                                                new Comparator<String>() {
                                                                    @Override
                                                                    public int compare(String o1, String o2) {
                                                                        return o1.compareTo(o2);
                                                                    }
                                                                });
                                                        
                                                         newTreeMap.putAll(branchMap);
                                                         List<Branch> orderedList = new ArrayList<Branch>();
                                                         for (Map.Entry<String, Branch> entry : newTreeMap.entrySet()) {
                                                                //System.out.println("Key : " + entry.getKey()+ " Value : " + entry.getValue());
                                                                 map.Branch br = (Branch)entry.getValue();
                                                                 orderedList.add(br);
                                                        } 
                                                         
                                                         String tel,fax,didNo,seepdDial=null;
                                                    //   end Alphabetical order list
                                                       for(map.Branch b : orderedList){
                                                           if(b.getTel()==null || b.getTel().isEmpty() )tel="N/A";else tel=b.getTel();
                                                           if(b.getFax()==null || b.getFax().isEmpty() )fax="N/A";else fax=b.getFax();
                                                           if(b.getDidNo()==null || b.getDidNo().isEmpty())didNo="N/A";else didNo=b.getDidNo();
                                                           if(b.getSpeedDial()==null || b.getSpeedDial().isEmpty())seepdDial="N/A";else seepdDial= b.getSpeedDial();
                                                %>
                                                            <tr>
                                                               <td style="display: none"> </td>
                                                               <td><%=head.getHeadBranchName()%></td>
                                                               <td><%=b.getBranchName()%></td>
                                                               <td><%=tel%></td>
                                                               <td><%=fax%></td>
                                                               <td><%=didNo%></td>
                                                               <td><%=seepdDial%></td>
                                                           </tr>
                                                        <%}%>
                                                     <%}%>
                                                
                                            </tbody>
                                        </table>


                                    </div>
                                </div>
                            </div>



                            <%@include file="coprights.jsp" %>
                        </div>
                    </div>
                </div>
            </div>

            <%@include file="footer.jsp" %>
            <script src="js/jquery.dataTables.js"></script>
            <script src="js/dataTables.fixedHeader.js"></script>
            <script src="js/dataTables.tableTools.js"></script>
            <script src="js/jquery.dataTables.bootstrap.js"></script>

             <script>
                $(document).ready(function () {
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
                                            '<tr class="group" align="left" style="font-style: italic;font-size: 0.875em; background-color: rgb(185, 196, 245); "><td colspan="6"><b>' + group + '</b></td></tr>'
                                            );
                                    last = group;
                                }
                            });
                        },
                         'pageLength': 200

                    });
                });
            </script>

    </body>


</html>
