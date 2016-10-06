<%@page import="org.json.JSONArray"%>
<%@page import="org.json.JSONObject"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.util.Calendar"%>
<%@ page import="java.text.SimpleDateFormat"%>

<!DOCTYPE html>
<!--[if lt IE 7]> <html class="ie ie6 lt-ie9 lt-ie8 lt-ie7" lang="en"> <![endif]-->
<!--[if IE 7]>    <html class="ie ie7 lt-ie9 lt-ie8"        lang="en"> <![endif]-->
<!--[if IE 8]>    <html class="ie ie8 lt-ie9"               lang="en"> <![endif]-->
<!--[if IE 9]>    <html class="ie ie9"                      lang="en"> <![endif]-->
<!--[if !IE]><!-->
<html lang="en" class="no-ie">
<!--<![endif]-->
<head>

 <link rel="stylesheet" href="vendor/wymeditor/skins/default/skin.css">
<%@ include file="pages/mainHeader.jsp" %>

<script src="vendor/jquery-validation/dist/jquery.validate.min.js"></script>
<script src="vendor/jquery-validation/dist/validate.js"></script>
<title>QPortal - Create Form</title>
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
		

	<% String FormName=request.getParameter("formName").toString(); //getParameter
       String description=request.getParameter("description").toString();
       String formType=request.getParameter("formType").toString();
       String formAccessType=request.getParameter("formAccessType").toString();
       String duration=request.getParameter("duration").toString();
       String passMark=request.getParameter("passMark").toString();
    	int pass_Mark=Integer.parseInt(passMark);
    	String stratDate = request.getParameter("stratDate");
    	String endDate = request.getParameter("endDate");
    	
    	Date createDate=Calendar.getInstance().getTime();    	
		SimpleDateFormat sdf = new SimpleDateFormat("MM/dd/yyyy");
		String formCreateDate=sdf.format(createDate);
		
		String departments = request.getParameter("departments");
		
		
		
      %>
		<section>
			<!-- START Page content-->
			<div class="content-wrapper">
				
				
				<div class="row">
				<div class="col-lg-12">
					<!-- START panel-->
					<div class="panel panel-default">
						
						<div class="panel-body">
							<div class="row">
								<div class="col-sm-2">
									<div class="panel widget">
										<div class="panel-body bg-primary text-center">											
											<div id="formName" class="text-md m0"><%=FormName %></div>
											<p>Form Name</p>
										</div>
									</div>
								</div>
								 <div class="col-sm-3" hidden="hidden">									
									<div class="panel widget">
										<div class="panel-body bg-primary text-center">											
											<div id="formDescription" class="text-md m0"><%= description%></div>
											<p>Form Description</p>
										</div>
									</div>
								</div> 
								<div class="col-sm-2">									
									<div class="panel widget">
										<div class="panel-body bg-primary text-center">											
											<div id="formType" class="text-md m0"><%=formType %></div>
											<p>Form Type</p>				
											
										</div>
									</div>								
								</div>
								<div class="col-sm-2">									
									<div class="panel widget">
										<div class="panel-body bg-primary text-center">					 											
											<div id="formAccessType" class="text-md m0"><%=formAccessType %></div>
											<p>User Access Type</p>
										</div>
									</div>								
								</div>	
                                    
                                    	<div class="col-sm-2">
									<div class="panel widget">
										<div class="panel-body bg-primary text-center">
											<div id="passMark" class="text-md m0"><%= pass_Mark%></div>
											<p>Pass Mark</p>
										</div>
									</div>
								</div>
								<div class="col-sm-2">
									<div class="panel widget">
										<div class="panel-body bg-primary text-center">
											<div id="formDuration" class="text-md m0"><%= duration%></div>
											<p>Duration</p>
										</div>
									</div>
								</div>
								
								<div class="col-sm-2">
									<div class="panel widget">
										<div class="panel-body bg-primary text-center">
											<div class="text-md m0"><%=formCreateDate %></div>
											<p>Date Created</p>
										</div>
									</div>
								</div>
								
							</div>
						</div>
					</div>
					<!-- END panel-->
					
					<div id="startDate" hidden="hidden"><%= stratDate%></div>
					<div id="endDate" hidden="hidden"><%= endDate%></div>
					
				</div>
			</div>

				<!-- Breadcrumb -->
				<ol class="breadcrumb">
					<li><a href="dashboard.jsp">Dashboard</a></li>
					<li class="active">Create Form</li>
				</ol>
				<!-- End Breadcrumb -->
				<!-- Segment -->
				<form action="TempFormSegmentController" id="mainform" method="post"
					name="mainform">
					<div id="segmentDiv">
						<div class="panel  panel-primary segment" name='sName1'
							id='sName1' sg_id="1">
							<div class="panel-heading">
								Segment 1 
								<button data-toggle="tooltip" title="Close Panel" class="removeSegmentButton pull-right btn-danger btn-xs">
                           			<em class="fa fa-times"></em>
                        		</button>
								
								<a data-original-title="Collapse Panel"
									href="javascript:void(0);" data-perform="panel-collapse"
									data-toggle="tooltip" title="" class="pull-right"> <em
									class="fa fa-minus"></em>
								</a>
							</div>
							<div class="panel-body">
								<!-- Segment Details -->


								<div class="row">
									<div class="col-lg-12">
										<div class="col-lg-12">
											
											<input id='segmentName1' name='segmentName1' type='text'
												placeholder='Type title of Segment' size='50'
												class="form-control">

										</div>
										<br>
										<br>
										<div class="col-lg-12">
											<textarea rows="3" cols="50" id="description"
												placeholder="segment description" class="form-control"
												id='segmentDescription1' name='segmentDescription1'></textarea>

										</div>

									</div>
								</div>
								<!-- End Segment Details -->
								<hr />

								<!-- Question -->
								<div class='qpanel'>
									<div class="row question" id='question1' qu_id="1">
										<div class="panel widget">
											<div class="panel-heading">
												<label class='qNo text-primary'>Question 1</label> 
												<a href="#"
													data-perform="panel-collapse" data-toggle="tooltip"
													title="Collapse Panel" class="pull-right"> <em
													class="fa fa-minus"></em>
												</a>
											</div>
											<!-- Question Details -->
											<div class="panel-body">
											<div class="row ">
												
												<div class="col-lg-3">
													<div class="form-group">
														<label class="control-label">Question Order Number:</label>
														<input type="number" name="questionOrder11" class="form-control" placeholder="1" value="1">
													</div>
												</div>												
												<div class="col-lg-3">
													<div class="form-group">
														<label class="control-label">Question Type:</label>
														<select id='questionType11' name='questionType11'
															class="questionType form-control m-b ">
															<option value='textFeild'>Text Feild</option>
															<option value='textArea'>TextArea</option>
															<option value='dropDown'>Drop Down List</option>
															<option value='checkBox'>Check Box</option>
															<option value='radioButton'>Radio Button</option>
															<option value='datePicker'>datePicker</option>
															<option value='image'>Image</option>
															<option value='table'>Table</option>
															<option value='signature'>Signature</option>
														</select>

													</div>
												</div>
											</div>
												
											<div class="row ">
												<div class="col-lg-12">
												
													<label class="control-label">Question:</label>
													<input id='QuestionName' name='QuestionName11' type='text'
														class="form-control" placeholder="question">
												</div>
												
												
											</div>
												
												<div class="changeTextAreaRow row" id="changeTextAreaRow11">
												<div class="col-lg-6">
													<label class="col-lg-6 col-sm-4 control-label">Add Answers One by One:</label>
													<textarea rows='4' cols='80' id='predefineValues11'
														placeholder="Add pre-define Answers one by one"
														name='predefineValues11'
														class='predefineValues form-control' disabled="disabled"></textarea>
												</div>
												
												<div class="col-lg-6">
														<label class="col-lg-6 col-sm-4 control-label">Add Correct Answer:</label>																									
														<textarea rows='4' cols='80' id='correctAnswer'
														placeholder="Add correct Answers here"
														name='correctAnswer11'
														class='correctAnswer form-control'></textarea>
												</div>
												</div>
												
												<div id="changeImageRow11" class="changeImageRow row" hidden="hidden">
												<form id="fileForm11">
													<div id="image-holder11"></div>
													<input id="files11" name="files11" type="file" multiple="true" class="imageFile" required="required"/>
													  
													<button id="btnUpload11" class="btnUpload btn btn-labeled btn-primary  btn-xs" type="button" upload="no">Upload File</button>
													
												</form>
												</div>
												
												<div id="changeTableRow11" class="changeTableRow row" hidden="hidden">
													<form action="" method="post">
							
											           <textarea id="my-wymeditor" class="wymeditor"><p>I'm initial content!</p></textarea>
													   <!-- <input type="submit" class="wymupdate" name="formName"/>  -->                            
												   		
												   		<button type="button" class="tableBtn">Create Table</button>
												   </form>
												</div>
												
												
											</div> <!-- End panel body -->
											<!-- End Question Details -->
											<!-- Question Footer (Add/Delete Buttons) -->
											<div class="panel-footer text-right">

												<button type="button"
													class="addQuestion btn btn-labeled btn-primary  btn-xs">
													<span class="btn-label"> <i
														class="fa fa-plus-square"></i>
													</span>Add Question
												</button>
												<button type="button"
													class="removeQestionButton btn btn-labeled btn-danger  btn-xs">
													<span class="btn-label"> <i class="fa fa-times"></i>
													</span>Delete
												</button>
											</div>
											<!-- End Question Footer (Add/Delete Buttons) -->
										</div>
									</div>
								</div>
								<!-- End Question -->
							</div>

							
						</div>
					</div>

							<div class="panel-footer">

								<button id="addSegment" name="addSegment" type="button"
									class="btn btn-labeled btn-primary addSegment">
									<span class="btn-label"> <i class="fa fa-plus-square"></i>
									</span>Add Segment
								</button>
							</div>
							
							<div class="panel-footer">
								
									<input type="button" value="Submit" id="SegmentForm"
							class="SegmentForm btn btn-labeled btn-primary">								
							</div>
						
					<!-- End Segment -->
					
				</form>

			</div>



			<!-- END Page content-->
		</section>
		<!-- END Main section-->
		<%@ include file="pages/footer.jsp" %>
	</div>
	<!-- END Main wrapper-->
	<!-- START Scripts-->
	<!-- Main vendor Scripts-->
	

	<!-- END Main wrapper-->
	<!-- START Scripts-->
	
	<%@ include file="pages/script.jsp" %>
	<script type="text/javascript" src="vendor/wymeditor/jquery.wymeditor.min.js"></script>
	  <script type="text/javascript" src="vendor/wymeditor/plugins/table/jquery.wymeditor.table.js"></script> 
	
	<!-- END Scripts-->
	
	<script type="text/javascript">

	
	/*$('.questionType').change(function() 	*/
			
		$(document).on('change', '.questionType', function () {	
			
			  var sno = $(this).closest('div .segment').attr('sg_id');
			  var qno=$(this).closest('div .question').attr('qu_id');
			  
			  //alert("sno: "+sno);
			  //alert("qno: "+qno);
			  //var sno =$('#segmentDiv .segment').length;			   
			 // var qno=document.querySelectorAll('#'+div_S_id+' div.qpanel .question').length 			   
		
	
            var option = $('#questionType'+sno+qno).find('option:selected').val();
			  //alert("option:"+option);
            if(option == "radioButton"){     
    			//alert("hi....................");
            	
				$('#predefineValues'+sno+qno).prop('disabled', false);
				$('#changeTextAreaRow'+sno+qno).show();
				$('#changeImageRow'+sno+qno).hide();
				//$('#signatureRow'+sno+qno).hide();
				$('#changeTableRow').hide();
				
				
				}
				else if(option == "checkBox"){
				$('#predefineValues'+sno+qno).prop('disabled', false);
				$('#changeTextAreaRow'+sno+qno).show();
				$('#changeImageRow'+sno+qno).hide();
				//$('#signatureRow'+sno+qno).hide();
				$('#changeTableRow').hide();
				
				}
				else if(option == "dropDown"){
					$('#predefineValues'+sno+qno).prop('disabled', false);
					$('#changeTextAreaRow'+sno+qno).show();
					$('#changeImageRow'+sno+qno).hide();
					//$('#signatureRow'+sno+qno).hide();
					$('#changeTableRow').hide();
					}
				else if(option == "textArea"){
					$('#predefineValues'+sno+qno).prop('disabled', true);
					$('#changeTextAreaRow'+sno+qno).show();
					$('#changeImageRow'+sno+qno).hide();
					//$('#signatureRow'+sno+qno).hide();
					$('#changeTableRow').hide();
				}
				else if(option == "textFeild"){
					
					$('#predefineValues'+sno+qno).prop('disabled', true);
					$('#changeTextAreaRow'+sno+qno).show();					
					$('#changeImageRow'+sno+qno).hide();
					//$('#signatureRow'+sno+qno).hide();
					$('#changeTableRow').hide();
					
					
				}else if(option == "image"){
					$('#changeImageRow'+sno+qno).show();
					$('#changeTextAreaRow'+sno+qno).hide();
					//$('#signatureRow'+sno+qno).hide();
					$('#changeTableRow').hide();
				}
				else if(option == 'table'){
					/* $('#tebleTextArea11').wymeditor(); */
					$('#changeTableRow'+sno+qno).show();
					$('#predefineValues'+sno+qno).prop('disabled', false);
					 $('#changeTextAreaRow'+sno+qno).show(); 
					$('#changeImageRow'+sno+qno).hide();
					//$('#signatureRow'+sno+qno).hide();
				}
				else if(option == "datePicker"){
					
					$('#predefineValues'+sno+qno).prop('disabled', true);
					$('#changeTextAreaRow'+sno+qno).show();					
					$('#changeImageRow'+sno+qno).hide();
					$('#changeTableRow').hide();
				}
				else if(option == "signature"){
					$('#predefineValues'+sno+qno).prop('disabled', true);
					$('#changeTextAreaRow'+sno+qno).show();					
					$('#changeImageRow'+sno+qno).hide();
					$('#changeTableRow').hide();
				}
            
	    });
		
	
	
	
    var segJson = {         
            
            Segments: [],
            Questions: []
   			
            
        }; 


    $(document).ready(function(){
    	
    	/* $('.predefineValues').hide(); */
     
            $('.wymeditor').wymeditor({
                	postInit: function (wym){
                		wym.table();
                	}
                });
           
 	
    	
    	$(document).on('click', '#addSegment', function(){            
        	
        	
            var sno =$('#segmentDiv .segment').length;
            //var j=$(this).find('div .qpanel').siblings('div .question').length;
            var j=$(this).closest('div .qpanel .question').length;
            
            i=++sno;
            qno=++j;
            
            trow =  "<div class='panel  panel-primary segment' name='sName"+i+"' id='sName"+i+"' sg_id='"+i+"'>"
                      + "<div class='panel-heading'>"
                      +"<label id='row"+i+"' class='row_S_No'>"+"Segment "+i+"</label>"
                      +"<button data-toggle='tooltip' title='Close Panel' class='removeSegmentButton pull-right btn-danger btn-xs'>"
                  	  +"<em class='fa fa-times'></em>"
                  	  +"</button>"        
                      + "<a data-original-title='Collapse Panel' href='javascript:void(0);' data-perform='panel-collapse' data-toggle='tooltip' title='' class='pull-right'>"
                      + "<em class='fa fa-minus'></em>"
                      + "</a>"
                      + "</div>"
                                                      
                      + "<div class='panel-body'>"
                      +"<div class='row'>"
					  + "<div class='col-lg-12'>"
                    + "<div class='col-lg-12'>"
                                                
                    + "<input id='segmentName"+i+"' name='segmentName"+i+"' type='text' placeholder='Type title of Segment' size='50' class='form-control'>"                
                    + "</div>"  
                    +"<br/><br/>"
                    + "<div class='col-lg-12'>"
                    + "<textarea rows='3' cols='50' id='segmentDescription"+i+"' placeholder='segment description' class='form-control' name='segmentDescription"+i+"'></textarea>"
                    + "</div>"
                    +"</div>"
                    + "</div>"
          /* End Segment Details  */

            		+ "<hr />"

                   /*  Question */
                   +"<div class='qpanel'>"
                   +"<div class='row question' id='question"+qno+"' qu_id='"+qno+"'>"
                   +"<div class='panel widget'>"
                   +"<div class='panel-heading'>"
                   +"<label class='qNo text-primary'>"+"Question "+qno+"</label>"
                 /*   +" <a href='#' data-perform='panel-collapse' data-toggle='tooltip' title='Collapse Panel' class='pull-right'>"
                                   +"<em class='fa fa-minus'></em>" */
                   
                   +"<a data-original-title='Collapse Panel' href='javascript:void(0);' data-perform='panel-collapse' data-toggle='tooltip' title='Collapse Panel' class='pull-right'> <em class='fa fa-minus'></em></a>"
                                   
                   +" </a>"
   				   +"</div>"        
   
   				 /*  Question Details */ 
                   +"<div class='panel-body'>"
                   +"<div class='row'>"
   				  
                   +"<div class='col-lg-3'>"
                    +"<div class='form-group'>"
                    +"<label class='control-label'>Question Order Number:</label>"
                    +"<input type='number' name='questionOrder"+sno+qno+"' class='form-control' placeholder='"+qno+"' value='"+qno+"'>"
                    +"</div>"
                   +"</div>	"
   				 
   				+"<div class='col-lg-3'>"
                   +"<div class='form-group'>"
   				+"<label class='control-label'>Question Type:</label>"
                   +"<select id='questionType"+sno+qno+"' name='questionType"+sno+qno+"' class='questionType form-control m-b'>"
                   +" <option value='textFeild'>Text Feild</option>"
                   +"<option value='textArea'>TextArea</option>"
                   +"<option value='dropDown'>Drop Down List</option>"
                  +"<option value='checkBox'>Check Box</option>"
                  +"<option value='radioButton'>Radio Button</option>"
                  +"<option value='datePicker'>datePicker</option>"
                  +"<option value='image'>Image</option>"
                  +"</select>"
                  +"</div>"
   			    +"</div>"
   			+"</div>"	
   			
   				+"<div class='row'>"			
                     +" <div class='col-lg-12'>"
                     +"<input type='hidden' id='question_segmentId' name='question_segmentId["+sno+"]["+qno+"]' value='["+sno+"]'>"
                     +"<label class='control-label'>Question:</label>"
                     +"<input id='QuestionName' name='QuestionName"+sno+qno+"' type='text' class='form-control' placeholder='question'>"
                     +"</div>"

                   
   				+"</div>"				
   				
   				 +"<div class='changeTextAreaRow row' id='changeTextAreaRow"+sno+qno+"'>"
   				+ "<div class='col-lg-6'>" 
   				+"<label class='col-lg-6 col-sm-4 control-label'>Add Answers One by One:</label>"
   				+ "<textarea rows='4' cols='80' id='predefineValues"+sno+qno+"' placeholder='Add pre-define Answers one by one'  name='predefineValues"+sno+qno+"' class='predefineValues form-control'></textarea>"  
   				+ "</div>" 
   				
   				+"<div class='col-lg-6'>"
   				+"<label class='col-lg-6 col-sm-4 control-label'>Add Correct Answer:</label>"
   				+"<textarea rows='4' cols='80' id='correctAnswer' placeholder='Add correct Answers here' name='correctAnswer"+sno+qno+"' class='correctAnswer form-control'></textarea>"
   				+"</div>"
   				+"</div>" 
   				
   				+"<div class='changeImageRow row' id='changeImageRow"+sno+qno+"' hidden='hidden'>"
   				+"<form id='fileForm"+sno+qno+"'>"
   				+"<div id='image-holder"+sno+qno+"'></div>"
   				+"<input id='files"+sno+qno+"' name='files"+sno+qno+"' type='file' multiple='true' class='imageFile' required='required'/>"
   				+"<button id='btnUpload"+sno+qno+"' class='btnUpload btn btn-labeled btn-primary  btn-xs' type='button' upload='no'>Upload File</button>"
   				+"</div>"
   				
                   + "</div>" 
                   /* End Question Details*/
                 
                /*Question Footer (Add/Delete Buttons)  */
                + "<div class='panel-footer text-right'>" 

                                + "<button type='button' class='addQuestion btn btn-labeled btn-primary  btn-xs'>" 
                                + "  <span class='btn-label'>" 
                                + "  <i class='fa fa-plus-square'></i>" 
                                + " </span>Add Question" 
                                + " </button>" 
                                
                                + "<button type='button' class='removeQestionButton btn btn-labeled btn-danger  btn-xs'>" 
                                + "<span class='btn-label'>" 
                                + "    <i class='fa fa-times'></i>" 
                                + " </span>Delete" 
                                + " </button>" 
                + "</div>" 
   				/*  End Question Footer (Add/Delete Buttons)  */
                                       
                                       
                + " </div>" 
                + "</div>" 
    			+ "</div>" 
     /* End Question  */                                                             
 				+"</div>";
            
                         
      $('#segmentDiv').append(trow);    
    /*   $('.predefineValues').hide();  */ 
      
      
        });
        
       
        
        
    });



$(document).on('click', 'button.addQuestion', function() {
    
	
	
    var div_S_id = $(this).closest('div .segment').attr('id');
    
    var sno =$('#segmentDiv .segment').length;  
    
    var qlength=document.querySelectorAll('#'+div_S_id+' div.qpanel .question').length
    
    
    var qno=++qlength;
    

    trow = "<div class='row question' id='question"+qno+"' qu_id='"+qno+"'>"
    +"<div class='panel widget'>"
    +"<div class='panel-heading'>"
    +"<label class='qNo text-primary'>"+"Question"+qno+"</label>" 
    +"<a href='#' data-perform='panel-collapse' data-toggle='tooltip' title='Collapse Panel' class='pull-right'>"
    +"<em class='fa fa-minus'></em>"
    +"</a>"
    +"</div>"   
    
    +"<div class='panel-body'>"
    +"<div class='row'>"
    
    +"<div class='col-lg-3'>"
    +"<div class='form-group'>"
    +"<label class='control-label'>Question Order Number:</label>"
    +"<input type='number' name='questionOrder"+sno+qno+"' class='form-control' placeholder='"+qno+"' value='"+qno+"'>"
    +"</div>"
    +"</div>"

		+"<div class='col-lg-3'>"
		+"<div class='form-group'>" 
		+"<label class='control-label'>Question Type:</label>"
		+"<select id='questionType"+sno+qno+"' name='questionType"+sno+qno+"' class='questionType form-control m-b'>"
			+ "<option value='textFeild'>Text Feild</option>"
			+ "<option value='textArea'>TextArea</option>"
			+ "<option value='dropDown'>Drop Down List</option>"
			+ "<option value='checkBox'>Check Box</option>"
			+ "<option value='radioButton'>Radio Button</option>"
			+"<option value='datePicker'>datePicker</option>"
			+ "<option value='image'>Image</option>"
		+ "</select>"
		+ "</div>"
		+ "</div>" 
	+ "</div>"
	
	+"<div class='row'>"
    +"<div class='col-lg-12'>"
    +"<label class='control-label'>Question:</label>"
    +"<input type='hidden' id='question_segmentId' name='question_segmentId"+sno+qno+"' value='"+sno+"'>"    
    +"<input id='QuestionName' name='QuestionName"+sno+qno+"' type='text' class='form-control' placeholder='question'>"
    +"</div>"
    
     
    + "</div>"
    
    +"<div class='changeTextAreaRow row' id='changeTextAreaRow"+sno+qno+"'>"
    +"<div class='col-lg-6'>"
    +"<label class='col-lg-6 col-sm-4 control-label'>Add Answers One by One:</label>"
    +"<textarea rows='4' cols='80' id='predefineValues"+sno+qno+"' placeholder='Add pre-define Answers one by one' name='predefineValues"+sno+qno+"' class='predefineValues form-control' disabled='disabled'></textarea>"  
    +"</div>"
    
    +"<div class='col-lg-6'>"
    +"<label class='col-lg-6 col-sm-4 control-label'>Add Correct Answer:</label>"
	+"<textarea rows='4' cols='80' id='correctAnswer' placeholder='Add correct Answers here' name='correctAnswer"+sno+qno+"' class='correctAnswer form-control'></textarea>"
	+"</div>"
	+"</div>"
	+"<div class='changeImageRow row' id='changeImageRow"+sno+qno+"' hidden='hidden'>"
	+"<form id='fileForm"+sno+qno+"'>"
	+"<div id='image-holder"+sno+qno+"'></div>"
	+"<input id='files"+sno+qno+"' name='files"+sno+qno+"' type='file' multiple='true' class='imageFile' required='required'/>"
	+"<button id='btnUpload"+sno+qno+"' class='btnUpload btn btn-labeled btn-primary  btn-xs' type='button' upload='no' >Upload File</button>"
	+"</form>"	
	+"</div>"
    +"</div>" 
    
    
    
    /* End Question Details
    Question Footer (Add/Delete Buttons)  */
    +"<div class='panel-footer text-right'>"

    +"<button type='button' class='addQuestion btn btn-labeled btn-primary  btn-xs'>"
    +"<span class='btn-label'>"
    +"<i class='fa fa-plus-square'></i>"
    +"</span>Add a Question"
    +"</button>"
    +"<button type='button' class='removeQestionButton btn btn-labeled btn-danger  btn-xs'>"
    +"<span class='btn-label'>"
    +"<i class='fa fa-times'></i>"
    +"</span>Delete"
    +"  </button>"
    +"</div>"
  /*   End Question Footer (Add/Delete Buttons) */
    +"</div>"
    +"</div>";                                                    
   
    $(this).closest('div .qpanel').append(trow);  
    
   
});

//display images before upload btn clicked
//imageFile
//$("#fileUpload").on('change', function () { 

$(document).on('change', 'input.imageFile', function() {
	//alert("image select......");
	var sno = $(this).closest('div .segment').attr('sg_id');
	var qno=$(this).closest('div .question').attr('qu_id');	
	
	//Get count of selected files
    var countFiles = $("#files"+sno+qno)[0].files.length;
	//alert("file length: "+countFiles);
	var image_holder = $("#image-holder"+sno+qno);
    if (typeof (FileReader) != "undefined") {
    	var ch=65;
    	var value;
    	
        //loop for each file selected for uploaded.
        for (var i = 0; i < countFiles; i++) {         	
        	
        	value=String.fromCharCode(ch);
            var reader = new FileReader();
           
            reader.onload = function (e) {       
                $("<img/>", {"src": e.target.result,"class": "thumb-image","width": "100px","height": "100px"}).appendTo(image_holder);
            }
           
            $("<input class='img_answer' type='radio' name='img_answer"+sno+qno+"' style='display:inline' value='"+value+"'>"+value+"</input>").appendTo(image_holder);
          	
            ch++;
            reader.readAsDataURL($(this)[0].files[i]);//"#files"+sno+qno
            
        }
        
        image_holder.show();

    } else {
        alert("This browser does not support FileReader.");
    }
 
    
});

//end dispay images

//upolad image script
$(document).on('click', 'button.btnUpload', function() { 	

	var sno = $(this).closest('div .segment').attr('sg_id');
	var qno=$(this).closest('div .question').attr('qu_id');
	  
  //  $('#btnUpload'+sno+qno).on('click', function() {
    	//alert("hi....");
    	//var file = $('[name="file"]');
    	//var filename = $.trim(file.val());
    	
    	var image = $('#files'+sno+qno)[0].files[0];

        if( window.FormData ) {
            formdata = new FormData();
            //formdata.append( 'image', image );
           // formdata.append( 'action', 'save-image' );
           
            var files = $('#files'+sno+qno).prop('files');
        	for(var i=0;i<files.length;i++){    		
        		formdata.append('files[' + i + ']', files[i]);
        	}
        	
        	formdata.append("file", files);
        	formdata.append("sid",sno);
        	formdata.append("qid",qno);        	
        	
        	$(this).attr('upload',"yes");
        	$(this).prop('disabled', 'disabled');
        

            $.ajax({
                url: 'FileUploadController',
                type: 'POST',
                data: formdata,
                cache: false,
                processData: false,
                contentType: false
            	}).done(function(data) {
            		 alert("successfully uploaded image....");
            	 }).fail(function(jqXHR, textStatus) {
                     //alert(jqXHR.responseText);
                     alert('File upload failed ...');
                 });
        }
    	
    	
    	
    /* }); */
    
	});



$(document).on('click', 'button.removeSegmentButton', function() {
    
	var sno =$('#segmentDiv .segment').length;
	 if(sno>1){ 
		$(this).closest('div .segment').remove();
		
	 } 
	 
    
    var sno=1;
    
     $('div .segment').each(function() {         
         $(this).find(".row_S_No").html("Segment "+sno);           
        
            sno++;          

        }); 
     
    
    return false;
});

$(document).on('click', 'button.removeQestionButton', function() {
    
    var div_S_id = $(this).closest('div .segment').attr('id');
    
    var total_qNo=$('div.question').length; 
    if(total_qNo!=1){
    	  $(this).closest('.question').remove();  
    }
   /*  alert("total_qNo: "+total_qNo); */
    
  
    
    var qlength=$('#sName1').find('div.question').length; 
    
    qno=1;
     $('#'+div_S_id+'').find('div.question').each(function(){ 
        
        $(this).find(".qNo").html("Question "+qno);     
        qno++;
    });
        
    return false;
});

/*
$(document).on('click', '.tableBtn', function(){ 
	
	var sno = $(this).closest('div .segment').attr('sg_id');
	var qno=$(this).closest('div .question').attr('qu_id');
	
	var  table=$('textarea.wym_html_val').val();
	alert("table: "+table); 
	var htmlTable=$('textarea.wym_html_val');
	
	alert("htmlTable :"+htmlTable);
	$('textarea.wym_html_val').find('table tr').each(function (i) {//  not go inside the function
		
		   alert("jjjjjjjjjj");
	       $(this).find("td:empty" ).append( '<input type="text"  value="text">' );
	       alert("aaa : "+htmlTable);
	    });
	
	
	
	 /*  $('#table1 tr').each(function() {
	$(this).find( "td:empty" )
	  .append( '<input type="text">' );
	}); */
	

	/* var editHtml = $(htmlTable).find( "td:empty" ).append( '<input type="text">' ); */
/*	
	var editHtml = $(htmlTable).val();
	alert("editTable: "+editHtml);
	$('#predefineValues'+sno+qno).text(editHtml);
	$('#changeTableRow'+sno+qno).hide();

});
*/

//=================================================================================
$("#SegmentForm").click(function() {            
	
	
	//-------------------------------------------------
	
    var segmentNo =$('#segmentDiv .segment').length;
   
    var sno=++segmentNo;
    
    var formName=document.getElementById("formName" ).innerHTML;
    var formDescription=document.getElementById("formDescription").innerHTML;
    var formType=document.getElementById("formType").innerHTML;
    var formAccessType=document.getElementById("formAccessType").innerHTML;    
    var formDuration= document.getElementById("formDuration").innerHTML;
    var passMark= document.getElementById("passMark").innerHTML;
    var startDate = document.getElementById("startDate").innerHTML;
    var endDate =  document.getElementById("endDate").innerHTML;
 
    
    var k=1;
    /* var segmentCount =$('#segmentDiv .segment').length; */
    var i=1;
    var j=1;
    
    for(k=1;k<sno;k++){ 
        
    	
        var segName=document.getElementsByName('segmentName'+i)[0].value;               
        var segDescription=document.getElementsByName('segmentDescription'+i)[0].value;
        i++;        
        
         var qlength=document.querySelectorAll('#sName'+k+' div.question').length;
        
         qno=++qlength;
        
         segJson.Segments.push({ 
                "formName" : formName,
                "formDescription" : formDescription,
                "formType" : formType,
                "formAccessType" : formAccessType,
                "segmentId":k,
                "segName" : segName,
                "segDescription" : segDescription
            });
        
        
         
         for(j=1;j<qno;j++){        
           
            
            var qsegId=k;
            var qid=j;
           
            var qOrder=document.getElementsByName('questionOrder'+k+j+'')[0].value;  
            var qName=document.getElementsByName('QuestionName'+k+j+'')[0].value;    
            var qType=document.getElementsByName('questionType'+k+j+'')[0].value;   
            /* var isPredefine=document.getElementsByName('isPredefineValue'+k+j+'')[0].value;  */ 
            
            var values=document.getElementsByName('predefineValues'+k+j+'')[0].value;             
            var preValuelist=values.split('\n'); 
            var correctAnswer;
            var correct_img_answer;
            
         // if qType is image
         


            //get images correct answer
            if(new String(qType).valueOf() == new String("image").valueOf()){
            	
            	
            	//image upload validation befor submit
                
    			var checkUploadBtn =$('#btnUpload'+k+j).attr('upload');	
             alert("......checkUploadBtn.....before..."+checkUploadBtn);
    			if(new String(checkUploadBtn).valueOf() == new String("no").valueOf()){
    				
    				/* alert("checkUploadBtn..."+checkUploadBtn); */
    				 alert("Please upload images");
              	      $('#btnUpload'+k+j).focus();
              	      return false;
    			}
            	
    			//--------------------------------------------
            	correct_img_answer=$('input[name=img_answer'+k+j+']:checked').val();
            	
            	if ($.trim(correct_img_answer) ==="") {
           	      alert("Please enter correct answer for images type");
           	      $('input[name=img_answer'+k+j+']').focus();
           	      return false;
           		}else{
           			/*  correct_img_answer=$('input[name="img_answer11"]:checked').val(); */
               	 correctAnswer=correct_img_answer;	
           			/* alert("correctAnswer: image:  "+correctAnswer); */
           		}    
            	
            	
            	
            }else{
            	correctAnswer=document.getElementsByName('correctAnswer'+k+j+'')[0].value;
            	/* alert("correctAnswer: not image:  "+correctAnswer); */
            }
     
           
            segJson.Questions.push({ 
                

                "formName" : formName,
                "formDescription" : formDescription,
                "departments" : <%=departments%>,
                "formType" : formType,
                "formAccessType" : formAccessType,
                "passMark" : passMark,
                "duration" : formDuration,
                "startDate" : startDate,
                "endDate" : endDate,
                "segmentId":k,
                "segName" : segName,
                "segDescription" : segDescription,  
                "qsegId" : qsegId,
                "qid" : qid,
                "qOrder" : qOrder,
                "qName" : qName, 
                "qType" : qType,
                "preAnswerList" : preValuelist,
                "correctAnswer" : correctAnswer
               
            }); 
   	    
   	 
            
         }  
         
    }   
    

    $.ajax({
    	
    	
        url:'TempFormSegmentController',
        type:'POST',
        dataType:'json',
    	cache:false,  
        data: {         
        
          json : JSON.stringify(segJson)
          
        },      
       success: function(data){
          alert("successfully created form.....!!!");          
          url = data.url;
          location.href = url;
        },
         error: function(){
            alert("falar to create form.....!!!");  
            // location.href = "selectForm.jsp"; 
         }   
    });

});
</script>
	<!-- END Scripts-->
	
	
        
</body>
</html>