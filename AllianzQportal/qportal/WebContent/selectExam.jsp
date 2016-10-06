

<%@page import="com.allianz.qportalapp.controller.FormAssignToUserImple"%>
<%@page import="com.allianz.qportalapp.controller.FormAssignToUserController"%>
<%@page import="com.allianz.qportalapp.model.FormType"%>
<%@page import="com.allianz.qportalapp.controller.FormTypeImpl"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.util.Calendar"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@page import="com.allianz.qportalapp.controller.FormAssginToDepartmentImpl"%>
<%-- <%@ page import="java.sql.Date"%> --%>
<%@ page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<!DOCTYPE html>
<!--[if lt IE 7]> 
<html class="ie ie6 lt-ie9 lt-ie8 lt-ie7" lang="en">
   <![endif]-->
   <!--[if IE 7]>    
   <html class="ie ie7 lt-ie9 lt-ie8"        lang="en">
      <![endif]-->
      <!--[if IE 8]>    
      <html class="ie ie8 lt-ie9"               lang="en">
         <![endif]-->
         <!--[if IE 9]>    
         <html class="ie ie9"                      lang="en">
            <![endif]-->
            <!--[if !IE]><!-->
            <html lang="en" class="no-ie">
               <!--<![endif]-->
               <head>
                  <%@ include file="pages/mainHeader.jsp" %>
                  <title>QPortal -Questionnaires</title>
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
                           <%-- <h2><%=userName%></h2> --%>
                           <h3>Questionnaires
                              <small>View all Questionnaires
                              </small>               
                           </h3>
                           <ol class="breadcrumb">
                              <%@include file="pages/breadcrumb.jsp" %> 
                              <li class="active">Questionnaires</li>
                           </ol>
                           <!-- START DATATABLE 1 -->
                           <div class="row">
                              <div class="col-lg-12">
                                 <div class="panel panel-primary">
                                    <div class="panel-heading">Froms</div>
                                    <div class="panel-body">
                                       <table id="datatable1" class="table table-striped table-hover">
                                          <thead>
                                             <tr>
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
                                                FormAssginToDepartmentImpl departmentImpl = new FormAssginToDepartmentImpl();
                                                
                                                String userAccess_Type=session.getAttribute("user_access_Type").toString();
                                                if(userAccess_Type.equalsIgnoreCase("public")){
                                                		FormAssignToUserImple formAssignToUserImple=new FormAssignToUserImple();    	
                                                		List<Integer> formList=formAssignToUserImple.getFormListByAccessType("public");
                                                		
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
                                                <td name="selected_formName"><%=formType.getFormName() %></td>
                                                <td><%=formType.getFormDescription() %></td>
                                                <td><%=start %></td>
                                                <td><%=end %></td>
                                                <td><%=formType.getFormType()%></td>
                                                <th>
                                                   <a href="examPaper.jsp?selected_formName=<%=formType.getFormName()%>" class="btn btn-info btn-sm">
                                                   <em class="fa fa-hand-o-right"></em>
                                                   <span>Go</span>
                                                   </a>
                                                </th>
                                             </tr>
                                             <%}%>
                                             <%}%> <!--  end all user type  -->  
                                             <%
                                                if(userAccess_Type.equalsIgnoreCase("special")){									
                                                	
                                                String user_Name=session.getAttribute("userName").toString();
                                                
                                                UserImpl userImple = new UserImpl();
                                                			String department = userImple.getUserDepartmentByUserName(user_Name);
                                                
                                                //userName
                                                FormAssignToUserImple formAssignToUserImple=new FormAssignToUserImple();
                                                List<Integer> publicFormList=formAssignToUserImple.getFormListByAccessType("public");// to do public list
                                                			List<Integer> formList=formAssignToUserImple.getFormListbyUser(user_Name);//to do specific list
                                                			List<Integer> onGoingFormList=formAssignToUserImple.getUpdatingFormListbyFormStatus(user_Name);//onGoing list
                                                			List<Integer> finishedFormList=formAssignToUserImple.getFinishedFormListbyUser(user_Name);//finished list
                                                			FormTypeImpl formTypeImpl=new FormTypeImpl();
                                                			
                                                			Date start=null;
                                                			Date end=null;
                                                			SimpleDateFormat sdf = new SimpleDateFormat("MM/dd/yyyy");
                                                			
                                                			//get to do list with access type public/all
                                                			for(int i=0;i<publicFormList.size();i++){
                                                	int formId=publicFormList.get(i);																	
                                                	
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
                                                <td name="selected_formName"><%=formType.getFormName() %></td>
                                                <td><%=formType.getFormDescription() %></td>
                                                <td><%=start %></td>
                                                <td><%=end %></td>
                                                <td><%=formType.getFormType()%></td>
                                                <th>
                                                   <a href="examPaper.jsp?selected_formName=<%=formType.getFormName()%>" class="btn btn-info btn-sm">
                                                   <em class="fa fa-hand-o-right"></em>
                                                   <span>Go</span>
                                                   </a>
                                                </th>
                                             </tr>
                                             <%}%>
                                             <%//get to do list with accesstype 'specific'
                                                for(int i=0;i<formList.size();i++){
                                                	int formId=formList.get(i);																	
                                                	
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
                                                <td name="selected_formName"><%=formType.getFormName() %></td>
                                                <td><%=formType.getFormDescription() %></td>
                                                <td><%=start %></td>
                                                <td><%=end %></td>
                                                <td><%=formType.getFormType()%></td>
                                                <!--  <td>Turn</td> -->
                                                <th>
                                                   <a href="examPaper.jsp?selected_formName=<%=formType.getFormName()%>" class="btn btn-info btn-sm">
                                                   <em class="fa fa-hand-o-right"></em>
                                                   <span>Go</span>
                                                   </a>
                                                </th>
                                             </tr>
                                             <%}%>
                                             <!-- get ongoing form list -->
                                             <%
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
                                                <td name="selected_formName"><%=formType.getFormName() %></td>
                                                <td><%=formType.getFormDescription() %></td>
                                                <td><%=start %></td>
                                                <td><%=end %></td>
                                                <td><%=formType.getFormType()%></td>
                                                <%--   <td><%=turnList.get(j)%></td> --%>
                                                <th>
                                                   <a href="onGoingExamPaper.jsp?selected_formName=<%=formType.getFormName()%>&turn=<%=turnList.get(j) %>" class="btn btn-info btn-sm">
                                                   <em class="fa fa-hand-o-right"></em>
                                                   <span>Ongoing</span>
                                                   </a>
                                                </th>
                                             </tr>
                                             <% }%>	 	
                                             <%}%>
                                             <!-- get finished list -->
                                             <% 					
                                                for(int i=0;i<finishedFormList.size();i++){
                                                		int formId=finishedFormList.get(i);
                                                		
                                                		start=departmentImpl.getStartDateByFormIdAndDepartment(formId,department);    									
                                                					end=departmentImpl.getEndDateByFormIdAndDepartment(formId,department);
                                                		
                                                		if(start==null | end ==null){
                                                			start=Calendar.getInstance().getTime();
                                                			end=Calendar.getInstance().getTime();
                                                			sdf.format(start);
                                                			sdf.format(end);
                                                		}
                                                		
                                                		FormType formType=formTypeImpl.getFormByFormId(formId);
                                                		
                                                		System.out.println("formName: selectExam:"+formType.getFormName());
                                                		System.out.println("formDescription: selectExam:"+formType.getFormDescription());
                                                		
                                                		%>
                                             <tr class="gradeC">
                                                <td name="selected_formName"><%=formType.getFormName() %></td>
                                                <td><%=formType.getFormDescription() %></td>
                                                <td><%=start %></td>
                                                <td><%=end %></td>
                                                <td>MCQ</td>
                                                <th>
                                                   <button class="btn btn-info btn-sm" disabled="disabled">
                                                   <em class="fa fa-hand-o-right"></em>
                                                   <span>Done</span>
                                                   </button>
                                                </th>
                                             </tr>
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
                      <%@include file="pages/footer.jsp" %>
                  </div>
                  <!-- END Main wrapper-->
                  <!-- START Scripts-->
                  <%@ include file="pages/script.jsp" %>
                  <!-- END Scripts-->
               </body>
            </html>

