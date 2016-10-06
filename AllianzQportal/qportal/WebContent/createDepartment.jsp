<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en" class="no-ie">

<head>
<%@ include file="pages/mainHeader.jsp" %>
<title>QPortal - Create Department</title>
<style type="text/css">
input[type="number"]::-webkit-outer-spin-button,
input[type="number"]::-webkit-inner-spin-button {
    -webkit-appearance: none;
    margin: 0;
}
input[type="number"] {
    -moz-appearance: textfield;
}
     
</style>
</head>



<body>
    <!-- START Main wrapper-->
    <div class="wrapper">
        <!-- START Top Navbar-->
     		<%@include file="pages/navigationBar.jsp" %>      		
       
        <!-- END Top Navbar-->
        <!-- START aside-->
        <aside class="aside">
      
			<%@include file="pages/aside.jsp" %> 
			
        </aside>
        <!-- End aside-->
        <!-- START Main section-->
        <section>
            <!-- START Page content-->
            <div class="content-wrapper">
                <h3>Create a Department
               <small>Q-portal department creation ... </small>
                <%@ include file="pages/allianzLogo.jsp" %>
            </h3>
                <ol class="breadcrumb">
                <%@include file="pages/breadcrumb.jsp" %> 
               <li class="active">Create a Department</li>
            </ol>
           
            <!-- START DATATABLE 1 -->
            <div class="row">
               <div class="col-lg-12">
                  <div class="panel panel-primary">
                      <div class="panel-heading">Department</div>
                     <div class="panel-body">
                        
						 <form action="DepartmentController" role="form" method="post">
					
							<div class="form-group">
                               <label class="col-lg-2 col-sm-2 control-label">Department Name *</label>
							   <input type="text" class="form-control" name="departmentName" placeholder="Department Name" required/>                             
	                        </div>                          

                            <div class="form-group">
                                <label class="col-lg-2 col-sm-2 control-label">Description *</label>
								<input type="text" name="description" class="form-control" placeholder="Description" >
                               
                            </div>
                            <!-- <div class="form-group">
                                <label class="col-lg-2 col-sm-2 control-label">Form Type *</label>
								<select class="form-control" name="formType" required>
								<option value="">None</option>
								<option value="mcq">MCQ</option>
								<option value="Analysis Structure">Analysis Structure</option>
								</select>
                               
                            </div>
                             <div class="form-group">
                                <label class="col-lg-2 col-sm-2 control-label">User Acess Type *</label>
								<select class="form-control" name="formAccessType" required>
								<option value="">None</option>
								<option value="public">Public</option>
								<option value="special">Special</option>
								</select>
                               
                            </div>
                             -->
                           
                              <div class="required">* Required fields</div>
	                         
	                          <div class="pull-right">
								<button type="submit"  name="submit_department" class="btn btn-primary">Save Form</button>		
								 					 
							</div>   
                            <!-- <div class="form-group">
								 <button type="submit" name="submit_formType" class="btn btn-primary"></button>
							</div> -->
	                              
						</form>
						
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
    
	 <!-- Start script-->
	<%@ include file="pages/script.jsp" %>
	 <!-- End script-->
	
</body>

</html>