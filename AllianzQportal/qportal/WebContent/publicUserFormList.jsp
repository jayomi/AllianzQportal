

<%@page import="com.allianz.qportalapp.controller.FormAssignToUserImple"%>
<%@page import="com.allianz.qportalapp.controller.FormAssignToUserController"%>
<%@page import="com.allianz.qportalapp.model.FormType"%>
<%@page import="com.allianz.qportalapp.controller.FormTypeImpl"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.util.Calendar"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@page import="com.allianz.qportalapp.controller.FormAssginToDepartmentImpl"%>
<%@page import="com.allianz.qportalapp.model.DepartmentForm"%>
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
         <%@include file="pages/navigationBar.jsp"%>
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
                  </div>
               </div>
               <div class="row">
                  <div class="col-lg-12">
                     <!-- START panel-->
                     <div class="panel panel-primary">
                        <div class="panel-heading">Survey / Exam Status
                           <a href="#" data-perform="panel-dismiss" data-toggle="tooltip" title="Close Panel" class="pull-right">
                           <em class="fa fa-times"></em>
                           </a>
                           <a href="#" data-perform="panel-collapse" data-toggle="tooltip" title="Collapse Panel" class="pull-right">
                           <em class="fa fa-minus"></em>
                           </a>
                        </div>
                        <!-- START table-responsive-->
                        <div class="table-responsive">
                           <table id="datatable1" class="table table-striped table-bordered table-hover">
                              <thead>
                                 <tr>
                                    <th></th>
                                    <th>Form Name</th>
                                    <th>Description</th>
                                    <th>Start Date</th>
                                    <th>End Date</th>
                                    <th>Type</th>
                                 </tr>
                              </thead>
                              <tbody>
                                 <%
                                    int index = 1;
                                    FormAssginToDepartmentImpl departmentImpl = new FormAssginToDepartmentImpl();
                                    
                                    String userAccess_Type=session.getAttribute("user_access_Type").toString();
                                    if(userAccess_Type.equalsIgnoreCase("public")){
                                    FormAssignToUserImple formAssignToUserImple=new FormAssignToUserImple();    	
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
                                    
                                    //get to do list
                                    for(int i=0;i<formList.size();i++){
                                    int formId=formList.get(i);																	
                                    
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
                                 <!-- get ongoing form list -->
                                 <%							
                                    for(int i=0;i<onGoingFormList.size();i++){
                                    		int formId=onGoingFormList.get(i);																	
                                    		
                                    		start=departmentImpl.getStartDateByFormIdAndDepartment(formId,"public");    									
                                    		end=departmentImpl.getEndDateByFormIdAndDepartment(formId,"public");
                                    		
                                    		if(start==null | end ==null){
                                    			start=Calendar.getInstance().getTime();
                                    			end=Calendar.getInstance().getTime();
                                    			sdf.format(start);
                                    			sdf.format(end);
                                    		}
                                    		
                                    		
                                    		FormType formType=formTypeImpl.getFormByFormId(formId);
                                    		
                                    		//List<Integer> turnList=formAssignToUserImple.getTurnListbyFormNameAndUser(user_Name, formId);
                                    		//String user_name=session.getAttribute("userName").toString();
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
                                 <%}%> <!-- end all user type  -->  
                              </tbody>
                           </table>
                        </div>
                        <!-- END table-responsive-->
                        <div class="panel-footer">
                           <div class="row">
                              <div class="col-lg-2">
                                 <div class="input-group">
                                    <input type="text" placeholder="Search" class="input-sm form-control">
                                    <span class="input-group-btn">
                                    <button type="button" class="btn btn-sm btn-default">Search</button>
                                    </span>
                                 </div>
                              </div>
                              <div class="col-lg-8"></div>
                              <div class="col-lg-2">
                                 <div class="input-group pull-right">
                                    <a href="javascript:void(0);"><small>Load more</small></a>
                                 </div>
                              </div>
                           </div>
                        </div>
                     </div>
                     <!-- END panel-->
                  </div>
               </div>
               <!-- END row-->
            </div>
            <!-- END Page content-->
         </section>
         <!-- END Main section-->
         <%@include file="pages/footer.jsp" %>
      </div>
      <!-- END Main wrapper-->
      <!-- START Scripts-->
      <!-- Main vendor Scripts-->
      <script src="vendor/jquery/dist/jquery.min.js"></script>
      <script src="vendor/bootstrap/dist/js/bootstrap.min.js"></script>
      <!-- Plugins-->
      <script src="vendor/chosen/chosen.jquery.js"></script>
      <script src="vendor/seiyria-bootstrap-slider/dist/bootstrap-slider.min.js"></script>
      <script src="vendor/bootstrap-filestyle/src/bootstrap-filestyle.min.js"></script>
      <!-- Animo-->
      <script src="vendor/animo.js/animo.min.js"></script>
      <!-- Sparklines-->
      <script src="vendor/sparkline/index.js"></script>
      <!-- Slimscroll-->
      <script src="vendor/slimScroll/jquery.slimscroll.min.js"></script>
      <!-- Store + JSON-->
      <script src="vendor/store-js/store%2bjson2.min.js"></script>
      <!-- ScreenFull-->
      <script src="vendor/screenfull/dist/screenfull.min.js"></script>
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
      <!-- App Main-->
      <script src="app/js/app.js"></script>
      <!-- END Scripts-->
   </body>
</html>

