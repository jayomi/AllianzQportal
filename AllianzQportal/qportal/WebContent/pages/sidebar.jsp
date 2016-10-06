<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="com.allianz.qportalapp.controller.UserImpl"%>
<%@ page import="java.util.List"%>
<%@ page import="com.allianz.qportalapp.model.User"%>

 <%
 String user_accessType=null;
 if(session.getAttribute("user_access_Type")!=null){
	 user_accessType =  session.getAttribute("user_access_Type").toString();%>
	 
              <%
              if(user_accessType.equalsIgnoreCase("special")){%>
              
  <!-- START Sidebar (left)-->
     <nav class="sidebar">
         <ul class="nav">
             <!-- START Menu-->
             <li class="nav-heading">Qportal Forms</li>
             
             <li class="active">
                 <a href="dashboard.jsp" title="Dashboard" data-toggle="" class="no-submenu">
                     <em class="fa fa-dot-circle-o"></em>
                     <span class="item-text">Dashboard</span>
                 </a>

             </li> 
              
             <li>
                 <a href="selectExamStatus.jsp" data-toggle="" class="no-submenu" title="My Submissions">
                     <em class="fa fa-file-text"></em>
                 <span class="item-text">My Submissions</span>
                 </a>
             </li>
             
             
               <!-- END SubMenu item-->
            <!--  </li> -->
         </ul>
     </nav> 
             
              <% } %>
             	
				
				
           
               
	 
 	<%}

			 	%>
			 	
           
            <!-- END Sidebar (left)-->