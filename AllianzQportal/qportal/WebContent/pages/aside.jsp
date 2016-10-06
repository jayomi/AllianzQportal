<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

    
     <aside class="aside">
        
     <!-- START Sidebar (left)--> 
		<%String logInUserAccess_Type=session.getAttribute("user_access_Type").toString();
		
		
		
		
		if(logInUserAccess_Type.equalsIgnoreCase("public")){%>
			 <%@ include file="/pages/sidebar.jsp" %>
		 <%}else if(logInUserAccess_Type.equalsIgnoreCase("special")){
			String logInuserName=session.getAttribute("userName").toString();
			UserImpl userImpl = new UserImpl();
			String userRole = userImpl.getUserRoleByUserName(logInuserName);
			
			if(userRole.equalsIgnoreCase("admin")){%>
				<%@ include file="/pages/sidebarAdmin.jsp" %>
		<% }else if(userRole.equalsIgnoreCase("modarator")){%>
		
				<%@ include file="/pages/sidebarModarator.jsp" %>
	    	    	    	 
	    <%}else{%>
	    	<%@ include file="/pages/sidebar.jsp" %>
	    <% } %>
		 <%}%>
	      
           

        </aside>