<%@page import="com.allianz.qportalapp.controller.FormAssignToUserImple"%>
<%@page import="com.allianz.qportalapp.controller.FormAssignToUserController"%>
<%@page import="com.allianz.qportalapp.controller.FormAssginToDepartmentImpl"%>
<%@page import="com.allianz.qportalapp.model.DepartmentForm"%>
<%@page import="com.allianz.qportalapp.model.FormType"%>
<%@page import="com.allianz.qportalapp.controller.FormTypeImpl"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.util.Calendar"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en" class="no-ie">
<!--<![endif]-->
<head>
<!-- Meta-->

<%@include file="pages/mainHeader.jsp" %>
<title>QPortal - dashboard</title>

</head>

<body>
    <!-- START Main wrapper-->
    <div class="wrapper">
        <!-- START Top Navbar-->
        
        
        <%@include file="pages/navigationBar.jsp" %>
        
        <!-- END Top Navbar-->
        <!-- START aside-->
        
       	<%@include file="pages/aside.jsp" %>
       	
        <!-- End aside-->
        <!-- START Main section-->
        <section>
            <!-- START Page content-->
            <div class="content-wrapper">

                <div class="row">
                    <div class="col-lg-4">
						
						<%String userName=""; %>
						<% 
						String userAccess_Type=session.getAttribute("user_access_Type").toString();
						if(userAccess_Type.equalsIgnoreCase("public")){
							userName=session.getAttribute("public_userName").toString();
                   		} else if(userAccess_Type.equalsIgnoreCase("special")){
                   			userName=session.getAttribute("userName").toString();
                   		}%>
                      
                   </div>
                   
                </div> 
                
                 <!-- START DATATABLE 1 -->
                 
               <div class="row">
	               <div class="col-lg-12">
	                  <div class="panel panel-primary">
	                      <div class="panel-heading">Froms</div>
	                     <div class="panel-body">
	                        <table id="datatable_dashboard" class="table table-striped table-hover">
	                          <thead>
                                 <tr>
                                 <th></th>
                                 <th>Form Name</th>
                                 <th>Description</th>
                                 <th>Start Date</th>
                                 <th>End Date</th>
                                 <th>Type</th>	
                                 <th>Status</th>		                                
                             	</tr>
                              </thead>
	                          <tbody>
	                          	
	                          	 <%
	                         	
	                          	FormAssignToUserImple formAssignToUserImple=new FormAssignToUserImple();
	                          	FormAssginToDepartmentImpl departmentImpl = new FormAssginToDepartmentImpl();
	                          	 
                                    int index = 1;
                                    if(userAccess_Type.equalsIgnoreCase("public")){
                           			   	
                           			List<Integer> formList=formAssignToUserImple.getFormListByAccessType("public");
                           			String publicUser = null; List<Integer> onGoingFormList = new ArrayList<Integer>();
                           		 	if(session.getAttribute("public_userName")!=null){
                           		 		publicUser = session.getAttribute("public_userName").toString();
                           		 		onGoingFormList=formAssignToUserImple.getUpdatingFormListbyFormStatus(publicUser);//onGoing list
                           		 	}
                           			
                           			
                           			FormTypeImpl formTypeImpl=new FormTypeImpl();
        							
        							Date start=null;
        							Date end=null;
        							SimpleDateFormat sdf = new SimpleDateFormat("MM/dd/yyyy");
        							
            					//get ongoing form list 
        							
        							for(int i=0;i<onGoingFormList.size();i++){
        									int formId=onGoingFormList.get(i);																	
        									
        									//start=formAssignToUserImple.getStartDateByFormId(formId);
        									//end=formAssignToUserImple.getEndDateByFormId(formId);
        									start=departmentImpl.getStartDateByFormIdAndDepartment(formId,"public");    									
    										end=departmentImpl.getEndDateByFormIdAndDepartment(formId,"public");
        									
        									if(start==null | end ==null){
        										start=Calendar.getInstance().getTime();
        										end=Calendar.getInstance().getTime();
        										sdf.format(start);
        										sdf.format(end);
        									}
        									
        									
        									FormType formType=formTypeImpl.getFormByFormId(formId);        									
        									List<Integer> turnList=formAssignToUserImple.getOnGoingTurnList(publicUser, formId);
        									for(int j=0;j<turnList.size();j++){%>	
        									
        									
        									
        									<tr class="gradeC">
        									<td><%=index%></td>
        									 <td name="selected_formName"><%=formType.getFormName() %></td>
        									 <td><%=formType.getFormDescription() %></td>
        									 <td><%=start %></td>
        									 <td><%=end %></td>
        									 <td><%=formType.getFormType()%></td>
        									<%--   <td><%=turnList.get(j)%></td> --%>
        									<th>
        										<a href="onGoingExamPaper.jsp?formId=<%=formId%>&turn=<%=turnList.get(j) %>" class="btn btn-info btn-sm">
        											<em class="fa fa-hand-o-right"></em>
        											<span>Ongoing</span>
        										</a>
        										
        									</th>
        								</tr>
        								<%index++;%>
        								<% }%>	 	
        							<%}%>
        							
        							<!-- get to do list -->
    								<% for(int i=0;i<formList.size();i++){
    									int formId=formList.get(i);												
    									
    									
    									start=departmentImpl.getStartDateByFormIdAndDepartment(formId,"public");    									
    									end=departmentImpl.getEndDateByFormIdAndDepartment(formId,"public");
    									
    									if(start==null | end ==null){
    										start=Calendar.getInstance().getTime();
    										end=Calendar.getInstance().getTime();
    										sdf.format(start);
    										sdf.format(end);
    									}
    									
    									
    									FormType formType=formTypeImpl.getFormByFormId(formId);									
    									%>
    									
    									<tr class="gradeC">
    									
    									<td><%=index %></td>    									
    									 <td name="selected_formName"><%=formType.getFormName() %></td>
    									 <td><%=formType.getFormDescription() %></td>
    									 <td><%=start %></td>
    									 <td><%=end %></td>
    									 <td><%=formType.getFormType()%></td>
    									<th>
    										<a href="examPaper.jsp?formId=<%=formId%>" class="btn btn-info btn-sm">
    											<em class="fa fa-hand-o-right"></em>
    											<span>Go</span>
    										</a>
    										
    									</th>
    								</tr>
    								<%index++; %>
    							<%}%>
    							
                           		<%}%> <!-- end all user type  -->  
                          
                                                
								<%
							// start specific users
							if(userAccess_Type.equalsIgnoreCase("special")){									
									
								String user_Name=session.getAttribute("userName").toString();
								
								//userName
								
								List<Integer> publicFormList=formAssignToUserImple.getFormListByAccessType("public");// to do public list
    							
								//List<Integer> formList=formAssignToUserImple.getFormListbyUser(user_Name);//to do specific list
    							//get To do specific form List department wise
    							UserImpl userImple = new UserImpl();
    							String department = userImple.getUserDepartmentByUserName(user_Name);    							
    						
    							List<DepartmentForm> formList = departmentImpl.getFormsAssignedToDepatmentByDepartmentName(department);
    							
    							
    							
    							List<Integer> onGoingFormList=formAssignToUserImple.getUpdatingFormListbyFormStatus(user_Name);//onGoing list
    							List<Integer> finishedFormList=formAssignToUserImple.getFinishedFormListbyUser(user_Name);//finished list
    							FormTypeImpl formTypeImpl=new FormTypeImpl();
    							
    							Date start=null;
    							Date end=null;
    							SimpleDateFormat sdf = new SimpleDateFormat("MM/dd/yyyy");
    							
    							List<Integer> new_publicFormList = new ArrayList<Integer>();
    							
    							//get ongoing form list
    							
    							for(int i=0;i<onGoingFormList.size();i++){
    									int formId=onGoingFormList.get(i);																	
    									
    									start=departmentImpl.getStartDateByFormIdAndDepartment(formId,department);    									
    									end=departmentImpl.getEndDateByFormIdAndDepartment(formId,department);
    									
    									if(start==null | end ==null){
    										start=Calendar.getInstance().getTime();
    										end=Calendar.getInstance().getTime();
    										sdf.format(start);
    										sdf.format(end);
    									}
    									
    									
    									FormType formType=formTypeImpl.getFormByFormId(formId);
    									
    									//List<Integer> turnList=formAssignToUserImple.getTurnListbyFormNameAndUser(user_Name, formId);
    									String user_name=session.getAttribute("userName").toString();
    									List<Integer> turnList=formAssignToUserImple.getOnGoingTurnList(user_name, formId);
    									for(int j=0;j<turnList.size();j++){%>	
    									
    									<tr class="gradeC">
    									<td><%=index %></td>
    									 <td name="selected_formName"><%=formType.getFormName() %></td>
    									 <td><%=formType.getFormDescription() %></td>
    									 <td><%=start %></td>
    									 <td><%=end %></td>
    									 <td><%=formType.getFormType()%></td>
    									<%--   <td><%=turnList.get(j)%></td> --%>
    									<th>
    										<a href="onGoingExamPaper.jsp?formId=<%=formId%>&turn=<%=turnList.get(j) %>" class="btn btn-info btn-sm">
    											<em class="fa fa-hand-o-right"></em>
    											<span>Ongoing</span>
    										</a>
    										
    									</th>
    								</tr>
    								<%index++; 
    								 }	 	
    							}
    							
    							//get public form list without ongoing list
    							for(int i=0;i<publicFormList.size();i++){
    								
    								int new_formId;
    								boolean result=true;
    								
    								for(int j=0; j<onGoingFormList.size();j++){
    									if(publicFormList.get(i) == onGoingFormList.get(j)){
    										result=false;
    										break;
    									}
    									
    								}
    								if(result){
    									new_publicFormList.add(publicFormList.get(i));
    								}
    							}
    							
    							//get to do list with access type public/all
    							for(int i=0;i<new_publicFormList.size();i++){
									int formId=new_publicFormList.get(i);									
									
									 start=departmentImpl.getStartDateByFormIdAndDepartment(formId,"public");    									
    								 end=departmentImpl.getEndDateByFormIdAndDepartment(formId,"public");
    
									
									if(start==null | end ==null){
										start=Calendar.getInstance().getTime();
										end=Calendar.getInstance().getTime();
										sdf.format(start);
										sdf.format(end);
									}
									
									
									FormType formType=formTypeImpl.getFormByFormId(formId);									
									%>
									
									<tr class="gradeC">
									<td><%=index %></td>
									 <td name="selected_formName"><%=formType.getFormName() %></td>
									 <td><%=formType.getFormDescription() %></td>
									 <td><%=start %></td>
									 <td><%=end %></td>
									 <td><%=formType.getFormType()%></td>
									<th>
										<a href="examPaper.jsp?formId=<%=formId%>" class="btn btn-info btn-sm">
											<em class="fa fa-hand-o-right"></em>
											<span>Go</span>
										</a>
										
									</th>
								</tr>
								<%index++; %>	
							<%}%>
							
    							
    							<%//get to do list with accesstype 'specific'
								for(int i=0;i<formList.size();i++){
									int formId=formList.get(i).getFormId();																	
									
									//start=formAssignToUserImple.getStartDateByFormId(formId);
									//end=formAssignToUserImple.getEndDateByFormId(formId);
									start=departmentImpl.getStartDateByFormIdAndDepartment(formId,department);    									
    								end=departmentImpl.getEndDateByFormIdAndDepartment(formId,department);
    
									
									if(start==null | end ==null){
										start=Calendar.getInstance().getTime();
										end=Calendar.getInstance().getTime();
										sdf.format(start);
										sdf.format(end);
									}
									
									
									FormType formType=formTypeImpl.getFormByFormId(formId);									
									%>
									
									<tr class="gradeC">
									<td><%=index %></td>
									 <td name="selected_formName"><%=formType.getFormName() %></td>
									 <td><%=formType.getFormDescription() %></td>
									 <td><%=start %></td>
									 <td><%=end %></td>
									 <td><%=formType.getFormType()%></td>
									<!--  <td>Turn</td> -->
									<th>
										<a href="examPaper.jsp?formId=<%=formId%>" class="btn btn-info btn-sm">
											<em class="fa fa-hand-o-right"></em>
											<span>Go</span>
										</a>
										
									</th>
								</tr>
								<%index++; %>	
							<%}%>
							

						
						<%}%>	
						
						</tbody>
                        </table>
                     </div>
                  </div>
               </div>
            </div>
            <!-- END DATATABLE 1 -->         

            </div>
            <!-- END Page content-->
        </section>
        <!-- END Main section-->
        <%@ include file="pages/footer.jsp" %>
    </div>
    <!-- END Main wrapper-->

	
     <!-- START Scripts-->
    <%@ include file="pages/script.jsp" %>
    
     <script src="vendor/jquery-ui/jquery-ui.min.js"></script>    
    <!-- Main vendor Scripts--> 
    
    <!-- START Page Custom Script-->
    <!--  Flot Charts-->
    <script src="vendor/flot/jquery.flot.js"></script>
    <script src="vendor/flot.tooltip/js/jquery.flot.tooltip.js"></script>
    <script src="vendor/flot/jquery.flot.resize.js"></script>
    <script src="vendor/flot/jquery.flot.pie.js"></script>
    <script src="vendor/flot/jquery.flot.time.js"></script>
    <script src="vendor/flot/jquery.flot.categories.js"></script>
    <script src="vendor/flot-spline/js/jquery.flot.spline.min.js"></script>
    <!-- jVector Maps-->
    <script src="vendor/ika.jvectormap/jquery-jvectormap-1.2.2.min.js"></script>
    <script src="vendor/ika.jvectormap/jquery-jvectormap-us-mill-en.js"></script>
    <script src="vendor/ika.jvectormap/jquery-jvectormap-world-mill-en.js"></script>
    <!-- END Page Custom Script-->
    
    <!-- END Scripts-->
      
</body>

</html>     
                 