<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

		<!-- START Nav wrapper-->
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
				<li><a href="#" data-toggle="fullscreen"> <em
						class="fa fa-expand"></em>
				</a></li>
				
				<%String user_access_Type_=session.getAttribute("user_access_Type").toString();%>
			<% 	if(user_access_Type_.equalsIgnoreCase("special")){
						String logged_user=session.getAttribute("userName").toString();%>
						<li style="color: #ffffff">Hi <%=logged_user %></li> 
						
						<li>
							<a>
							<form action="LogoutController" method="post">
								<input type="submit" value="Logout" class="btn btn-square btn-primary btn-sm">
							</form>
							</a>
							
						</li>       
				<%}%>
			
			
			</ul>
			<!-- END Right Navbar-->
		</div>
		<!-- END Nav wrapper-->