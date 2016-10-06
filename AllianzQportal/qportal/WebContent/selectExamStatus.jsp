

<%@page import="com.allianz.qportalapp.controller.FormAssignToUserImple"%>
<%@page import="com.allianz.qportalapp.model.FormType"%>
<%@page import="com.allianz.qportalapp.controller.FormTypeImpl"%>
<%@page import="com.allianz.qportalapp.model.FormSegment"%>
<%@page import="com.allianz.qportalapp.controller.FormSegmentImple"%>
<%@page import="com.allianz.qportalapp.model.Question"%>
<%@page import="com.allianz.qportalapp.controller.FormQuestionImpl"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.Date"%>
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
                  <title>Select exam status</title>
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
                         
                         	
                           <h3>Questionnaires
                              <small>View all Questionnaires</small>   
                              <%@ include file="pages/allianzLogo.jsp" %>            
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
                                                <th>Type</th>
                                                <th>Turn</th>
                                                <th>Proposal No</th>
                                                <th>Done Date</th>
                                                <th></th>
                                             </tr>
                                          </thead>
                                          <tbody>
                                             <%
                                                String userAccess_Type=session.getAttribute("user_access_Type").toString();
                                                if(userAccess_Type.equalsIgnoreCase("special")){
                                                	
                                                
                                                String user_Name=session.getAttribute("userName").toString();
                                                FormAssignToUserImple formAssignToUserImple=new FormAssignToUserImple();    							
                                                			List<Integer> formList=formAssignToUserImple.getFormListbyFormStatus(user_Name);
                                                			FormTypeImpl formTypeImpl=new FormTypeImpl();
                                                			FormSegmentImple formSegmentImple=new FormSegmentImple(); 
                                                			
                                                for(int i=0;i<formList.size();i++){
                                                	int formId=formList.get(i);																	
                                                //get proposal No as 1st input field of the form(1st input field of 1st segment)								
                                                          
                                                          int SegmentId = formSegmentImple.getSegmentIdByFormIdAndOrderId(formId,1);			           
                                                          FormQuestionImpl formQuestionImpl=new FormQuestionImpl();						          
                                                          int question =  formQuestionImpl.getQIdByOrder(formId, SegmentId, 1);
                                                        
                                                	
                                                	
                                                	FormType formType=formTypeImpl.getFormByFormId(formId);	
                                                	List<Integer> turnList=formAssignToUserImple.getTurnListbyFormNameAndUser(user_Name, formId);
                                                	for(int j=0;j<turnList.size();j++){%>							
                                             <tr class="gradeC">
                                                <td name="selected_formName"><%=formType.getFormName() %></td>
                                                <td><%=formType.getFormDescription() %></td>
                                                <td><%=formType.getFormType() %></td>
                                                <td><%=turnList.get(j)%></td>
                                                <%
                                                   Date done = formAssignToUserImple.getDoneDateByFormId(formId,user_Name,turnList.get(j));
                                                   
                                                   %>
                                                <%
                                                   String proposalNo = formQuestionImpl.getGivenAnswerByQId(formId, question,user_Name,turnList.get(j),userAccess_Type);
                                                   %>
                                                <td><%=proposalNo%></td>
                                                <td><%=done %></td>
                                                <th>
                                                   <a href="examStatus.jsp?formId=<%=formId%>&turn=<%=turnList.get(j) %>" class="btn btn-info btn-sm">
                                                   <em class="fa fa-hand-o-right"></em>
                                                   <span>View</span>
                                                   </a>
                                                </th>
                                             </tr>
                                             <% }%>	 
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

