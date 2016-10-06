

<%@page import="com.allianz.qportalapp.controller.FormAssignToUserImple"%>
<%@page import="com.allianz.qportalapp.controller.FormAssignToUserController"%>
<%@page import="com.allianz.qportalapp.model.FormType"%>
<%@page import="com.allianz.qportalapp.controller.FormTypeImpl"%>
<%@page import="com.allianz.qportalapp.controller.FormQuestionImpl"%>
<%@page import="com.allianz.qportalapp.listner.ServletContextListner"%>
<%@page import="com.allianz.qportalapp.controller.FormAssginToDepartmentImpl"%>
<%@page import="java.util.Random"%>
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
      <title>QPortal - Questionnaires</title>
   </head>
   <body>
      <!-- START Main wrapper-->
      <div class="wrapper">
         <!-- START Top Navbar-->
         <%@include file="pages/navigationBar.jsp" %>
         <!-- END Top Navbar-->
         <%
            com.allianz.qportalapp.controller.FirstPageController.path = ServletContextListner.getApplicationContext().getRealPath("/");
            
            String userAccess_Type=null;
            if(session.getAttribute("user_access_Type")==null){
            	session.setAttribute("user_access_Type", "public");	//set user access type
            }
            else if(session.getAttribute("user_access_Type")!=null){
            userAccess_Type=session.getAttribute("user_access_Type").toString();}
            
            ServletContext context = session.getServletContext();
            FormQuestionImpl questionImpl=new FormQuestionImpl();
            
            String referenceId = null;String userName="";
            
            if(context.getAttribute("public_userName")!=null){
            	referenceId =  context.getAttribute("public_userName").toString();				
            }
            
            if(referenceId==null){
            	
            	 final String CHAR_LIST = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890";				 
            	 final int RANDOM_STRING_LENGTH = 6;
            	 Random randomGenerator = new Random();
            	 userName=questionImpl.generateString(randomGenerator, CHAR_LIST, RANDOM_STRING_LENGTH);
            	 session.setAttribute("public_userName", userName);			
            	 context.setAttribute("public_userName", userName);
            	
            	 
            }else if(referenceId!=null){
            	
            	userName = referenceId;					
            	session.setAttribute("public_userName", userName);
            	context.setAttribute("public_userName", userName);
            	
            }
            
            %>  
         <!-- START Main section-->
         <section class="sidehidden">
            <!-- START Page content-->
            <div class="content-wrapper">
               <div class="row">
                  <div class="col-lg-4">					
                  </div>
               </div>
               <!-- START DATATABLE 1 -->
               <div class="row">
                  <div class="col-lg-12">
                     <div class="panel panel-primary">
                        <div class="panel-heading">Froms</div>
                        <div class="panel-body">
                           <table id="datatable_publicList" class="table table-striped table-hover">
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
                                    List<Integer> formList=formAssignToUserImple.getFormListByAccessType("public");                           			
                                    
                                    FormTypeImpl formTypeImpl=new FormTypeImpl();
                                    
                                    Date start=null;
                                    Date end=null;
                                    SimpleDateFormat sdf = new SimpleDateFormat("MM/dd/yyyy");
                                    int index = 1;
                                    //get to do list
                                    for(int i=0;i<formList.size();i++){
                                    int formId=formList.get(i);																	
                                    
                                    start=departmentImpl.getStartDateByFormIdAndDepartment(formId,"public");    									
                                    end=departmentImpl.getEndDateByFormIdAndDepartment(formId,"public");
                                    String current_date =null;
                                    
                                    if(start==null | end ==null){
                                    
                                    Date currentDate = new Date();
                                    current_date = new SimpleDateFormat("MM-dd-yyyy").format(currentDate);
                                    
                                    }
                                    
                                    
                                    FormType formType=formTypeImpl.getFormByFormId(formId);    								
                                    context.setAttribute("public_form_id", formId);
                                    session.setAttribute("public_form_id",formId);
                                    
                                    %>
                                 <tr class="gradeC">
                                    <td><%=index %></td>
                                    <td name="selected_formName"><%=formType.getFormName() %></td>
                                    <td><%=formType.getFormDescription() %></td>
                                    <%if(start !=null && end !=null){ %>
                                    <td><%=start %></td>
                                    <td><%=end %></td>
                                    <%}else{%>
                                    <td><%=current_date %></td>
                                    <td><%=current_date %></td>
                                    <%} %>
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

