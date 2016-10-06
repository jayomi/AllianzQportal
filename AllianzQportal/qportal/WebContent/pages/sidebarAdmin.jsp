<%@page import="com.allianz.qportalapp.model.FormType"%>
<%@page import="com.allianz.qportalapp.controller.FormTypeImpl"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

            <!-- START Sidebar (left)-->
            <nav class="sidebar">
                <ul class="nav">
                    <!-- START Menu-->
                    <li class="nav-heading">Qportal Forms</li>
                    <li class="active">
                        <a href="adminDashboard.jsp" title="Dashboard" data-toggle="" class="no-submenu">
                            <em class="fa fa-dot-circle-o"></em>
                            <span class="item-text">Dashboard</span>
                        </a>

                    </li> 
                    <!-- <li>
                        <a href="selectExamStatus.jsp" title="My Submissions" data-toggle="" class="no-submenu">
                            <em class="fa fa-file-text"></em>
                            <span class="item-text">My Submissions</span>
                        </a>
                    </li> -->
                   <!--  <li>
                       <a href="select_All_ExamStatus.jsp" data-toggle="" class="no-submenu" title="Forms Data">
                           <em class="fa fa-file-text"></em>
                           <span class="item-text">View Forms Data</span>
                       </a>
		            </li> -->
		            <li>
                       <a href="selectDepartmentForms.jsp" data-toggle="" class="no-submenu" title="Forms Data">
                           <em class="fa fa-file-text"></em>
                           <span class="item-text">View Department Forms</span>
                       </a>
		            </li>
                    
                    <li class="nav-heading">Manage Forms</li>
                    
                  
                   	<!--  <li>
                        <a href="goToViewForm.jsp" data-toggle="" class="no-submenu" title="View Form">
                            <em class="fa fa-file-text"></em>
                            <span class="item-text">View Form</span>
                        </a>
                    </li>  -->
                  
	                
	                <li>
                        <a href="createfrom.jsp" data-toggle="" class="no-submenu" title="Create a Form">
                            <em class="fa fa-file-text"></em>
                            <span class="item-text">Create a Form</span>
                        </a>
                    </li> 
                      <li>
	                     <a href="selectForm.jsp" data-toggle="" class="no-submenu" title="Manage Forms">
	                            <em class="fa fa-folder"></em>
	                           <!--  <span class="item-text">Manage Questionnaires</span> -->
	                            <span class="item-text">Update Forms</span>
	                     </a>
	                </li> 
                    <!--  <li>
                          <a href="FormAssignToUser.jsp" data-toggle="" class="no-submenu" title="Form Assign To User">
                            <em class="fa fa-file-text"></em>
                              <span class="item-text">Assign To User</span>
                          </a>
                    </li>   -->
                     <li>
                          <a href="FormAssignToDepartment.jsp" data-toggle="" class="no-submenu" title="Form Assign To User">
                            <em class="fa fa-file-text"></em>
                              <span class="item-text">Assign To Department</span>
                          </a>
                    </li> 
                     <li>
                          <a href="ListForms_DepartmentWise.jsp" data-toggle="" class="no-submenu" title="Form Assign To User">
                            <em class="fa fa-file-text"></em>
                              <span class="item-text">Department's Forms</span>
                          </a>
                    </li> 
                    
					<li class="nav-heading">Manage Departments</li>
						 <li>
	                        <a href="createDepartment.jsp" data-toggle="" class="no-submenu" title="Create a Form">
	                            <em class="fa fa-file-text"></em>
	                            <span class="item-text">Create Department</span>
	                        </a>
	                    </li> 
	                      <li>
		                     <a href="selectDepartment.jsp" data-toggle="" class="no-submenu" title="Manage Forms">
		                            <em class="fa fa-folder"></em>
		                           <!--  <span class="item-text">Manage Questionnaires</span> -->
		                            <span class="item-text">Update Department</span>
		                     </a>
		                </li> 
					<li class="nav-heading">Manage Users</li>
					 	<li>
	                        <a href="createUser.jsp" data-toggle="" class="no-submenu" title="Create a Form">
	                            <em class="fa fa-file-text"></em>
	                            <span class="item-text">Create Users</span>
	                        </a>
	                   </li> 
	                   <li>
		                     <a href="selectUser.jsp" data-toggle="" class="no-submenu" title="Manage Forms">
		                           <em class="fa fa-folder"></em>
		                           <!--  <span class="item-text">Manage Questionnaires</span> -->
		                           <span class="item-text">Update Users</span>
		                     </a>
		              </li> 
                                     
                  
                </ul>
            </nav>
            <!-- END Sidebar (left)-->