<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>  

		<!-- START Nav wrapper-->
		
	<style>
        .userlog{
            color: #fff;
            padding-top: 18px;
        }
        .fullscreen{
            color: #fff;
            padding-top: 7px;
            padding-right: 15px;
        }
    </style>
    
		<div class="nav-wrapper">
			<!-- START Left navbar-->
			<ul class="nav navbar-nav">
				<li>
					<!-- Button used to collapse the left sidebar. Only visible on tablet and desktops-->
					<a href="#" data-toggle-state="aside-collapsed" class="hidden-xs">
						<em class="fa fa-navicon"></em>
				</a> <!-- Button to show/hide the sidebar on mobile. Visible on mobile only.-->
					<a href="#" data-toggle-state="aside-toggled" class="visible-xs">
						<em class="fa fa-navicon"></em>
				</a>
				</li>
			</ul>
			<!-- END Left navbar-->
			<!-- START Right Navbar-->
			<ul class="nav navbar-nav navbar-right">

				<!-- Fullscreen-->
				<li class="fullscreen"><a href="javascript:void(0);" data-toggle="fullscreen"> <em class="fa fa-expand"></em> </a></li>
				
				
							
                <%
                if(session.getAttribute("user_access_Type")!=null){
                	 String user_access_Type=session.getAttribute("user_access_Type").toString();
                     if(user_access_Type.equalsIgnoreCase("special")){
                     String logged_user=session.getAttribute("userName").toString();
                     String[] parts = logged_user.split("@");
                     logged_user = parts[0];
                 %>
                 <li class="userlog">Hi <%=logged_user %></li> 
 				<li>
                     <a>
                     <form action="LogoutController" method="post">
                         <button type="submit" class="btn btn-primary btn-sm"><i class="fa fa-sign-out" aria-hidden="true"></i>
                          Logout</button>
                     </form>
                     </a>
                     
                    
 				</li> 
 				      
 				<%} 
 				else if(user_access_Type.equalsIgnoreCase("public")){%>
 				
 				<li>
                     <a href="firstPage.jsp">Home</a>	
 				</li>  
 				
 				<li>
                     <a>
                     <form action="register.jsp" method="post">
                         <input type="submit" value="Register" class="btn btn-square btn-primary btn-sm">
                     </form>
                     </a>	
 				</li>  
 				<%}
                }%>
               
				
			</ul>
			<!-- END Right Navbar-->
		</div>
		<!-- END Nav wrapper-->