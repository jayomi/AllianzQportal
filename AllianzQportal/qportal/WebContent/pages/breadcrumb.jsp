<%@page import="com.allianz.qportalapp.controller.UserImpl"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    
    <%String UserAccess_Type_breadcrumb=session.getAttribute("user_access_Type").toString();
		
		
		
		
		if(UserAccess_Type_breadcrumb.equalsIgnoreCase("public")){%>
			
               <li><a href="dashboard.jsp">Dashboard</a>
               </li>
              
		 <%}else if(UserAccess_Type_breadcrumb.equalsIgnoreCase("special")){
			String logInuserName=session.getAttribute("userName").toString();
			UserImpl userImpl = new UserImpl();
			String userRole = userImpl.getUserRoleByUserName(logInuserName);
			
			if(userRole.equalsIgnoreCase("admin")){%>
				
               <li><a href="adminDashboard.jsp">Dashboard</a>
               </li>
              
		<% }else if(userRole.equalsIgnoreCase("modarator")){%>
		
				
               <li><a href="modaratorDashboard.jsp">Dashboard</a>
               </li>
              
            
	    	    	    	 
	    <%}else{%>
	   
               <li><a href="dashboard.jsp">Dashboard</a>
               </li>
              
               <% } %>
		 <%}%>
	      
<!--  <ol class="breadcrumb">
               <li><a href="dashboard.jsp">Dashboard</a>
               </li>
               <li class="active">Questionnaires</li>
            </ol> -->