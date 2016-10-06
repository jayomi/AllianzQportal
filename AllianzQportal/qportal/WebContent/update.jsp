

<%@page import="java.io.Writer"%>
<%@page import="java.io.File"%>
<%@page import="com.allianz.qportalapp.model.Question"%>
<%@page import="com.allianz.qportalapp.controller.FormQuestionImpl"%>
<%@page import="com.allianz.qportalapp.model.FormSegment"%>
<%@page import="com.allianz.qportalapp.controller.FormSegmentImple"%>
<%@page import="com.allianz.qportalapp.model.FormType"%>
<%@page import="com.allianz.qportalapp.controller.FormTypeImpl"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en" class="no-ie">
   <!--<![endif]-->
   <head>
      <%@ include file="pages/mainHeader.jsp" %>
      <title>QPortal - Questioniores</title>
      <style type="text/css">
         input[type="number"]::-webkit-outer-spin-button,
         input[type="number"]::-webkit-inner-spin-button {
         -webkit-appearance: none;
         margin: 0;
         }
         input[type="number"] {
         -moz-appearance: textfield;
         }
         .tableinput input{
         width:60px !important;
         }
      </style>
   </head>
   <body>
      <!-- START Main wrapper-->
      <%            
         FormTypeImpl formTypeImpl=new FormTypeImpl();                                                                                      
         String formName=request.getParameter("selected_formName");
         int fId=formTypeImpl.getFormIdByFormName(formName);
         FormQuestionImpl questionImpl=new FormQuestionImpl();
         int numberOfQuestion=questionImpl.getNoOfFieldByFormId(fId);
         
         FormType form=formTypeImpl.getFormByFormId(fId);
         
         //int paginateNo = formTypeImpl.getPaginateNumber(fId);
         int PassMark=form.getPassMark();      
         
         %>
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
               <h3>
                  <label id="formName"><%=formName %></label><small><%=form.getFormDescription() %></small>
                    <%@ include file="pages/allianzLogo.jsp" %>
               </h3>
               <ol class="breadcrumb">
                  <%@include file="pages/breadcrumb.jsp" %> 
                  <li><a href="selectForm.jsp">My Forms</a></li>
                  <li class="active"><%=formName %></li>
               </ol>
               <div class="row">
                  <div class="col-lg-12">
                     <!-- START panel-->
                     <div class="panel panel-default">
                        <div class="panel-heading">
                           Details <a href="#" data-perform="panel-collapse"
                              data-toggle="tooltip" title="Collapse Panel" class="pull-right">
                           <em class="fa fa-minus"></em>
                           </a>
                        </div>
                        <div class="panel-body">
                           <div class="row">
                              <div class="col-sm-2">
                                 <div class="panel widget">
                                    <div class="panel-body bg-primary text-center">
                                       <div class="text-md m0"><%=fId %></div>
                                       <p>Form ID</p>
                                    </div>
                                 </div>
                              </div>
                              <div class="col-sm-2">
                                 <div class="panel widget">
                                    <div class="panel-body bg-primary text-center">
                                       <div class="text-md m0"><%=numberOfQuestion %></div>
                                       <p>Number of Questions</p>
                                    </div>
                                 </div>
                              </div>
                              <div class="col-sm-2">
                                 <div class="panel widget">
                                    <div class="panel-body bg-primary text-center">
                                       <div class="text-md m0">40min</div>
                                       <p>Allocated Time</p>
                                    </div>
                                 </div>
                              </div>
                              <div class="col-sm-2">
                                 <div class="panel widget">
                                    <div class="panel-body bg-primary text-center">
                                       <div class="text-md m0"><%=PassMark %></div>
                                       <p>Pass Mark</p>
                                    </div>
                                 </div>
                              </div>
                              <div class="col-sm-2">
                                 <div class="panel widget">
                                    <div class="panel-body bg-primary text-center">
                                       <div class="text-md m0">06/05/2016</div>
                                       <p>Date Created</p>
                                    </div>
                                 </div>
                              </div>
                              <div class="col-sm-2">
                              </div>
                           </div>
                        </div>
                     </div>
                     <!-- END panel-->
                  </div>
               </div>
               <!-- //---------------------------- -->
               <div class="row">
                  <div class="col-lg-12">
                     <!-- START panel-->
                     <div class="panel panel-default">
                        <div class="panel-heading"></div>
                        <div class="panel-body">
                           <div id="accordion" class="panel-group">
                              <!-- START panel-->
                              <%int editQuestionId=0;%>
                              <% 
                                 FormSegmentImple formSegmentImple=new FormSegmentImple();                          
                                 for(FormSegment segment:formSegmentImple.getFormSegmentByFormId(fId)){
                                 String segmentName=segment.getSegmentName();
                                 String segmentDescription=segment.getSegmentDescription();
                                 int SegmentId=segment.getSegmentId();
                                 
                                 if(segmentDescription==null){
                                  segmentDescription="";
                                 }
                                 
                                       %>
                              <div class="panel panel-default segmentRow" seg_id="<%=SegmentId%>">
                                 <a data-toggle="collapse" data-parent="#accordion" href="#<%=SegmentId%>">
                                    <div class="panel-heading">
                                       <h4 class="panel-title">									
                                          <span id="segmentName" name="<%=segmentName%>"><%=segmentName%></span>
                                          <span><%=segmentDescription%></span>					
                                          <button id="deleteSegmentBtn" data-toggle="tooltip" title="Delete Segment"
                                             class="pull-right btn-danger btn-xs">
                                          <em class="fa fa-times"></em>
                                          </button>
                                 <a id="editSegment<%=SegmentId%>" data-toggle="modal" data-target="#segmentModal"
                                    data-toggle="tooltip" title="Edit Segment" class="editSegmentBtn btn btn-primary btn-xs pull-right" style="color: #fff;">										
                                 <em class="fa fa-edit"></em>
                                 </a>
                                 </h4>
                                 </div>			
                                 </a>
                                 <div id="<%=SegmentId%>" class="panel-collapse collapse">
                                    <div class="panel-body">
                                       <%int i=1;
                                          FormQuestionImpl formQuestionImpl=new FormQuestionImpl();
                                          for(Question question : formQuestionImpl.getFieldByFormIdAndSegmentId(fId, segment.getSegmentId())){
                                          int questionId=question.getQuestionId();  %>
                                       <fieldset id="<%=questionId%>" >
                                          <legend><span class="text-primary"><%=i+" . " %></span><%=question.getQuestionName()%>
                                             <button data-toggle="tooltip" title="Delete Question" class="deleteQuestionBtn pull-right btn-danger btn-xs">
                                             <em class="fa fa-times"></em>
                                             </button>
                                             <a id="editQuestion<%=questionId%>" data-toggle="modal" data-target="#questionModal" data-toggle="tooltip" title="Edit Question" class="editQuestionBtn btn btn-primary btn-xs pull-right"><em class="fa fa-edit"></em></a> 
                                          </legend>
                                          <div class="col-sm-10">
                                             <%
                                                String qType=question.getQuestionType();%>
                                             <%if(qType.equalsIgnoreCase("datePicker")){%>
                                             <input type="text" class="bdate" name="textFeild<%=questionId%>" size="100">
                                             <%}%>
                                             <%if(qType.equalsIgnoreCase("textFeild")){%>
                                             <input type="text" name="textFeild<%=questionId%>" size="100">
                                             <%}%>
                                             <%if(qType.equalsIgnoreCase("radioButton")){
                                                String radioBtnValues=question.getPreAnswers();
                                                String radioBtnArray[]=radioBtnValues.replaceAll("\\]|\\[|\"", "").split("\"?(:|,)(?![^\\{]*\\})\"?");
                                                for(int r=0;r<radioBtnArray.length;r++){%>
                                             <div class="radio c-radio">
                                                <label><input type="radio"
                                                   name="radioBtn<%=questionId%>"
                                                   value="<%=radioBtnArray[r] %>"> <span
                                                   class="fa fa-circle"></span><%=radioBtnArray[r] %></label>
                                             </div>
                                             <%}%>
                                             <%} %>
                                             <%if(qType.equalsIgnoreCase("dropDown")){
                                                String dropDownValues=question.getPreAnswers();
                                                String dropDownArray[]=dropDownValues.replaceAll("\\]|\\[|\"", "").split("\"?(:|,)(?![^\\{]*\\})\"?");%>
                                             <select name="dropDownList<%=questionId%>">
                                                <%for(int d=0;d<dropDownArray.length;d++){%>
                                                <option value="<%=dropDownArray[d]%>"><%=dropDownArray[d]%></option>
                                                <%} %>
                                             </select>
                                             <% } %>
                                             <%if(qType.equalsIgnoreCase("checkBox")){
                                                String checkBoxValues=question.getPreAnswers();
                                                String checkBoxArray[]=checkBoxValues.replaceAll("\\]|\\[|\"", "").split("\"?(:|,)(?![^\\{]*\\})\"?");%>
                                             <% for(int c=0;c<checkBoxArray.length;c++){%>
                                             <label><input type="checkbox" value="<%=checkBoxArray[c] %>"
                                                name="checkBoxBtn<%=questionId%>"><%=checkBoxArray[c] %></label><br>
                                             <%}       %>
                                             <% } %>
                                             <%if (qType.equalsIgnoreCase("textArea")){
                                                String textAreaValue=question.getPreAnswers();
                                                String textArea[]=textAreaValue.replaceAll("\\]|\\[|\"", "").split("\"?(:|,)(?![^\\{]*\\})\"?");%>
                                             <textarea rows="3" cols="100" name="textArea<%=questionId%>"></textarea>
                                             <%} %>
                                             <%
                                                if(qType.equalsIgnoreCase("table")){
                                                		String tableData=question.getPreAnswers();													
                                                		out.print(tableData);
                                                }
                                                		%>
                                             <%
                                                if(qType.equalsIgnoreCase("image")){
                                                		String imageFiles=question.getPreAnswers();
                                                		 String fileArray[]=imageFiles.replaceAll("\\[", "").replaceAll("\\]","").split(",");
                                                		for(int img=0;img<fileArray.length;img++){
                                                			String path=fileArray[img];
                                                			System.out.println("image path: ////"+path);
                                                			%>
                                             <img src="<%=path%>" width="160" height="160" class="img-thumbnail img-responsive thumb96" />
                                             <%}
                                                }
                                                 
                                                if(qType.equalsIgnoreCase("signature")){%>
                                             <div style="width:350px;height:auto;margin:50px auto;padding: 20px 0;background-color:#2a2a2a;color:#FFF;">
                                                <!-- <form method="post" action="capture_signature.php" class="sigPad"> -->
                                                <p class="drawItDesc">Click and drag to draw your signature in the box below.</p>
                                                <div class="sig sigWrapper sigPad">
                                                   <canvas class="pad" width="275" height="90" id='canvas'></canvas>
                                                </div>
                                                <button id="captureSignature" name="capture"  class="clearButton" onclick="captureSig()" capture="no">Capture Signature</button>									
                                                <button name="clear" type="clear" class="clearButton" onclick="clearSig()">Clear Signature</button>
                                                <div style="clear:both;"></div>
                                                <!-- </form> -->
                                             </div>
                                             <%}%>
                                             <%--  <%}%>  --%>
                                             <!-- end of getFieldByFormIdAndSegmentId -->
                                             <%++i;%>
                                          </div>
                                       </fieldset>
                                       <%}%>
                                       <div class="text-right">
                                          <button type="button" id="addQuestion<%=SegmentId%>" data-toggle="modal" data-target="#addQuestionModal"
                                             class="addQuestion btn btn-labeled btn-primary  btn-xs">
                                          <span class="btn-label"> <i
                                             class="fa fa-plus-square"></i>
                                          </span>Add Question
                                          </button>
                                       </div>
                                    </div>
                                 </div>
                              </div>
                              <div style="height:10px"></div>
                              <%}%>
                              <!-- END panel-->
                           </div>
                        </div>
                     </div>
                     <!-- END panel-->
                  </div>
               </div>
               <div class="panel-footer">
                  <button id="addSegment" name="addSegment" type="button" data-toggle="modal" data-target="#addSegmentModal"
                     class="addSegment btn btn-labeled btn-primary">
                  <span class="btn-label"> <i class="fa fa-plus-square"></i>
                  </span>Add Segment
                  </button>
               </div>
            </div>
            <!-- END DATATABLE 1 -->
            <!-- END -->
             <%@include file="pages/footer.jsp" %>
      </div>
      <!-- END Page content--> </section>
      <!-- END Main section-->
      </div>
      <!-- END Main wrapper-->
      <!-- start modal -->
      <!-- end modal -->
      <!-- START Scripts-->
      <!-- Main vendor Scripts-->
      <!-- Modal -->
      <!-- edit question -->
      <div id="questionModal" tabindex="-1" role="dialog"
         aria-labelledby="myModalLabel" aria-hidden="true" class="modal fade">
         <form action="UpdateController" method="post" class="">
            <div class="modal-dialog">
               <div class="modal-content panel-primary">
                  <div class="modal-header panel-heading">
                     <button type="button" data-dismiss="modal" aria-hidden="true"
                        class="close">×</button>
                     <h4 id="myModalLabel" class="modal-title">Edit Question</h4>
                  </div>
                  <div class="modal-body">
                     <div class="row question">
                        <div class="panel widget">
                           <%FormQuestionImpl formQuestionImpl=new FormQuestionImpl();
                              Question question=formQuestionImpl.getFieldByQid(editQuestionId);
                              request.setAttribute("formName", formName); 
                              
                              %> 
                           <style>
                              .tableinput input{
                              width:50px !important;
                              }
                           </style>
                           <div class="panel-body">
                              <div class="col-lg-12">
                                 <input type="hidden" value="<%=request.getParameter("selected_formName")%>" name="formName">
                              </div>
                              <div class="form-group form-inline">
                                 <!-- 	<label class="control-label col-sm-4">Question Id:</label> -->
                                 <input type="hidden" id="modal_question_formId" name="modal_question_formId" value="<%=fId %>" readonly>
                                 <input type="hidden" id="modal_question_segmentId" name="modal_question_segmentId" value="" readonly>
                                 <input type="hidden" id="modal_questionId" name="modal_questionId" value="" readonly>
                              </div>
                              <div class="form-group form-inline">
                                 <label class="control-label col-sm-4">Question Order:</label>
                                 <input id="modal_questionOrder" name="modal_questionOrder" type="text"
                                    class="question form-control" value="">
                              </div>
                              <div class="form-group form-inline">
                                 <label class="control-label col-sm-4">Question:</label>
                                 <input id="modal_question" name="modal_question" type="text" placeholder="question"
                                    class="question form-control" value="">
                              </div>
                              <div class="form-group form-inline">
                                 <label class="control-label col-sm-4">Question Type:</label>
                                 <select id = "modal_questionType" name="modal_questionType" class="modal_questionType form-control m-b">
                                    <option value='textFeild'>Text Feild</option>
                                    <option value='textArea'>TextArea</option>
                                    <option value='dropDown'>Drop Down List</option>
                                    <option value='checkBox'>Check Box</option>
                                    <option value='radioButton'>Radio Button</option>
                                    <option value='datePicker'>datePicker</option>
                                    <option value='image'>Image</option>
                                    <option value='signature'>Signature</option>
                                 </select>
                              </div>
                              <div class="modal_Question_changeTextAreaRow form-group">
                                 <div class="col-lg-6">
                                    <label class="col-lg-10 col-sm-6 control-label">Add Answers One by One:</label>
                                    <textarea name="modal_answerSet" rows="3" cols="50" id="modal_answers"
                                       placeholder="" class="modal_answerSet form-control" disabled="disabled"></textarea>
                                 </div>
                                 <div class="col-lg-6">
                                    <label class="col-lg-8 col-sm-6 control-label">Add Correct Answer:</label>
                                    <textarea rows="3" cols="50" id="modal_correctAnswer" name="modal_correctAnswer"
                                       placeholder="" class="modal_correctAnswer form-control"></textarea>
                                 </div>
                              </div>
                              <div id="modal_Question_changeImageRow" class="modal_Question_changeImageRow row" hidden="hidden">
         <form id="fileForm">
         <div id="image-holder"></div>
         <input id="files" name="files" type="file" multiple="true" class="imageFile" onclick="return confirm('Please select correct answer.')" /> <!-- required="required" -->
         <button id="btnUpload" class="btnUpload btn btn-labeled btn-primary  btn-xs" type="button" upload="no" >Upload File</button>
         </form>
         </div>
         </div>
         <!-- End Question Details -->
         </div>
         </div>
         </div>
         <div class="modal-footer">
         <button type="button" data-dismiss="modal" class="btn btn-labeled btn-primary btn-xs">Close</button>
         <input type="submit" class="btn btn-labeled btn-primary btn-xs" id="modal_saveQuestionBtn" value="Save changes" name="modal_saveQuestionBtn"></input>
         </div>
         </div>
         </div>
         </form>
      </div>
      <div id="segmentModal" tabindex="-1" role="dialog"
         aria-labelledby="myModalLabel" aria-hidden="true" class="modal fade">
         <form action="UpdateSegmentController" method="post" class="form-horizontal">
            <div class="modal-dialog">
               <div class="modal-content panel-primary">
                  <div class="modal-header panel-heading">
                     <button id="" type="button" data-dismiss="modal" aria-hidden="true"
                        class="close">×</button>
                     <h4 id="myModalLabel" class="modal-title">Edit Segment
                        <input type="hidden" value="<%=request.getParameter("selected_formName")%>" name="formName">
                     </h4>
                  </div>
                  <div class="modal-body">
                     <div class="row">
                        <div class="col-lg-12">
                           <input type="hidden" id="modal_segmentId" name="modal_segmentId" value="" readonly>
                        </div>
                        <br><br>
                        <div class="form-group">
                           <label class="col-lg-2 control-label">Order No :</label>
                           <div class="col-lg-10">
                              <input id="modal_segmentOrder" name="modal_segmentOrder" type="number"
                                 class="question form-control" value="">
                           </div>
                        </div>
                        <div class="form-group">
                           <label class="col-lg-2 control-label">Name :</label>
                           <div class="col-lg-10">
                              <input id="modal_segmentName" name="modal_segmentName" type="text" placeholder="segment name"
                                 class="form-control">
                           </div>
                        </div>
                        <br><br>
                        <div class="form-group">
                           <label class="col-lg-2 control-label">Description:</label>
                           <div class="col-lg-10">
                              <textarea rows="3" cols="50" id="modal_segmentDesciption" name="modal_segmentDesciption"
                                 placeholder="segment description" class="form-control"></textarea>
                           </div>
                        </div>
                        <!-- </div> -->
                     </div>
                  </div>
                  <div class="modal-footer">
                     <button type="button" data-dismiss="modal" class="btn btn-labeled btn-primary btn-xs">Close</button>
                     <input type="submit" class="btn btn-labeled btn-primary btn-xs" value="Save changes" id="modal_saveSegmentBtn" name="modal_saveSegmentBtn"/>
                  </div>
               </div>
            </div>
         </form>
      </div>
      <!-- add question modal -->
      <!-- Modal -->
      <div id="addQuestionModal" tabindex="-1" role="dialog"
         aria-labelledby="myModalLabel" aria-hidden="true" class="modal fade">
         <form action="UpdateController" method="post" class="">
            <div class="modal-dialog">
               <div class="modal-content panel-primary">
                  <div class="modal-header panel-heading">
                     <button type="button" data-dismiss="modal" aria-hidden="true"
                        class="close">×</button>
                     <h4 id="myModalLabel" class="modal-title">Edit Question</h4>
                  </div>
                  <div class="modal-body">
                     <div class="row question">
                        <div class="panel widget">
                           <!-- Question Details -->
                           <div class="panel-body">
                              <div class="form-group form-inline">
                                 <%-- <% request.setAttribute("formName", formName); %> --%>
                                 <input type="hidden" value="<%=formName %>" name="formName" >
                                 <input type="hidden" value="" id="addQuestionModal_sid" name="addQuestionModal_sid" >
                                 <input type="hidden" value="<%=fId %>" id="addQuestionModal_fId" name="addQuestionModal_fId" >
                              </div>
                              <div class="form-group form-inline">
                                 <label class="control-label col-sm-4">Question:</label>
                                 <input id="modal_addQuestion" name="modal_addQuestion" type="text" placeholder="question"
                                    class="question form-control" value="">
                              </div>
                              <div class="form-group form-inline">
                                 <label class="control-label col-sm-4">Question Type:</label>
                                 <select name="modal_addQuestionType" class="modal_addQuestionType form-control m-b">
                                    <option value='textFeild'>Text Feild</option>
                                    <option value='textArea'>TextArea</option>
                                    <option value='dropDown'>Drop Down List</option>
                                    <option value='checkBox'>Check Box</option>
                                    <option value='radioButton'>Radio Button</option>
                                    <option value='datePicker'>datePicker</option>
                                    <option value='signature'>Signature</option>
                                    <!-- <option value='image'>Image</option> -->
                                 </select>
                              </div>
                              <div id="modal_addQuestion_changeTextAreaRow" class="modal_addQuestion_changeTextAreaRow form-group">
                                 <div class="col-lg-6">
                                    <label class="col-lg-10 col-sm-6 control-label">Add Answers One by One:</label>
                                    <textarea name="modal_addQuestion_answerSet" rows="3" cols="50" id="modal_addQuestion_answerSet"
                                       placeholder="" class="modal_addQuestion_answerSet form-control" disabled="disabled"></textarea>
                                 </div>
                                 <div class="col-lg-6">
                                    <label class="col-lg-8 col-sm-6 control-label">Add Correct Answer:</label>
                                    <textarea rows="3" cols="50" id="modal_addQuestion_correctAnswer" name="modal_addQuestion_correctAnswer"
                                       placeholder="" class="modal_addQuestion_correctAnswer form-control"></textarea>
                                 </div>
                              </div>
                              <div id="modal_addQuestion_changeImageRow" class="modal_addQuestion_changeImageRow row" hidden="hidden">
         <form id="fileForm">
         <div id="image-holder"></div>
         <input id="files" name="files" type="file" multiple="true" class="imageFile" /> <!-- required="required" -->
         <button id="btnUpload" class="btnUpload btn btn-labeled btn-primary  btn-xs" type="button" upload="no">Upload File</button>
         </form>
         </div>
         </div>
         <!-- End Question Details -->
         </div>
         </div>
         </div>
         <div class="modal-footer">
         <button type="button" data-dismiss="modal" class="btn btn-labeled btn-primary btn-xs">Close</button>
         <input type="submit" class="btn btn-labeled btn-primary btn-xs" id="modal_save_addQuestionBtn" value="Save changes" name="modal_save_addQuestionBtn"></input>
         </div>
         </div>
         </div>
         </form>
      </div>
      <!-- end add question modal -->
      <!--start add segment modal -->
      <div id="addSegmentModal" tabindex="-1" role="dialog"
         aria-labelledby="myModalLabel" aria-hidden="true" class="modal fade">
         <form action="UpdateSegmentController" method="post" class="">
            <div class="modal-dialog">
               <div class="modal-content panel-primary">
                  <div class="modal-header panel-heading">
                     <button type="button" data-dismiss="modal" aria-hidden="true"
                        class="close">×</button>
                     <h4 id="myModalLabel" class="modal-title">Edit Segment</h4>
                  </div>
                  <div class="modal-body">
                     <div class="row question">
                        <div class="panel widget">
                           <!-- Question Details -->
                           <div class="panel-body">
                              <div class="form-group form-inline">
                                 <% request.setAttribute("formName", formName); %>
                                 <input type="hidden" value="" id="addQuestionModal_sid" name="addQuestionModal_sid" >
                                 <input type="hidden" value="<%=fId %>" id="addSegmentModal_fId" name="addSegmentModal_fId" >
                                 <input type="hidden" value="<%=formName%>" name="formName">
                              </div>
                              <!-- Segment Details -->
                              <div class="row">
                                 <div class="col-lg-12">
                                    <div class="col-lg-12">
                                       <input id='addsegmentModal_name' name='addsegmentModal_name' type='text'
                                          placeholder='Type title of Segment' size='50'
                                          class="form-control">
                                    </div>
                                    <br>
                                    <br>
                                    <div class="col-lg-12">
                                       <textarea rows="3" cols="50" id="addsegmentModal_description"
                                          placeholder="segment description" class="form-control"
                                          name='addsegmentModal_description'></textarea>
                                    </div>
                                 </div>
                              </div>
                              <!-- End Segment Details -->
                              <div class="form-group form-inline">
                                 <label class="control-label col-sm-4">Question:</label>
                                 <input id="modal_addQuestion" name="modal_addQuestion" type="text" placeholder="question"
                                    class="question form-control" value="">
                              </div>
                              <div class="form-group form-inline">
                                 <label class="control-label col-sm-4">Question Type:</label>
                                 <select name="modal_addQuestionType" class="modal_addQuestionType form-control m-b">
                                    <option value='textFeild'>Text Feild</option>
                                    <option value='textArea'>TextArea</option>
                                    <option value='dropDown'>Drop Down List</option>
                                    <option value='checkBox'>Check Box</option>
                                    <option value='radioButton'>Radio Button</option>
                                    <option value='datePicker'>datePicker</option>
                                    <option value='signature'>Signature</option>
                                    <!-- <option value='image'>Image</option> -->
                                 </select>
                              </div>
                              <div id="modal_addQuestion_changeTextAreaRow" class="modal_addQuestion_changeTextAreaRow form-group">
                                 <div class="col-lg-6">
                                    <label class="col-lg-10 col-sm-6 control-label">Add Answers One by One:</label>
                                    <textarea name="modal_addQuestion_answerSet" rows="3" cols="50" id="modal_addQuestion_answerSet"
                                       placeholder="" class="modal_addQuestion_answerSet form-control" disabled="disabled"></textarea>
                                 </div>
                                 <div class="col-lg-6">
                                    <label class="col-lg-8 col-sm-6 control-label">Add Correct Answer:</label>
                                    <textarea rows="3" cols="50" id="modal_addQuestion_correctAnswer" name="modal_addQuestion_correctAnswer"
                                       placeholder="" class="modal_addQuestion_correctAnswer form-control"></textarea>
                                 </div>
                              </div>
                              <div id="modal_addQuestion_changeImageRow" class="modal_addQuestion_changeImageRow row" hidden="hidden">
         <form id="fileForm">
         <div id="image-holder"></div>
         <input id="files" name="files" type="file" multiple="true" class="imageFile" /> <!-- required="required" -->
         <button id="btnUpload" class="btnUpload btn btn-labeled btn-primary  btn-xs" type="button" upload="no">Upload File</button>
         </form>
         </div>
         </div>
         <!-- End Question Details -->
         </div>
         </div>
         </div>
         <div class="modal-footer">
         <button type="button" data-dismiss="modal" class="btn btn-labeled btn-primary btn-xs">Close</button>
         <input type="submit" class="btn btn-labeled btn-primary btn-xs" id="modal_save_addSegmentBtn" value="Save changes" name="modal_save_addSegmentBtn"></input>
         </div>
         </div>
         </div>
         </form>
      </div>
      <!-- end add segment modal -->
      <!-- Strart Scripts-->
      <%@ include file="pages/script.jsp" %>
      <!-- END Scripts-->
      <script type="text/javascript" src="vendor/jquery.countdownTimer.js"></script>
      <script type="text/javascript">
         function captureSig(){
         	
         	var canvas = document.getElementById("canvas");
         	var img    = canvas.toDataURL("image/png");
         	//document.write('<img src="'+img+'"/>');
         	//alert('<img src="'+img+'"/>');
         }
         
          function clearSig()
           {
               var canvas = document.getElementById('canvas'),
                   ctx = canvas.getContext("2d");
               ctx.clearRect(0, 0, canvas.width, canvas.height);
               
           }
         
           $(document).ready(function(){ 
         	  
         	  $(".bdate").datepicker({
         	    	changeMonth: true,
         	    	changeYear: true,
         	    	yearRange: "1970:2020"
         	    	});
         	  
         	 
         	  
         	  $('.panel-collapse').first().addClass("in");
         	 
         	
             	
             	$(document).on('click', '.editQuestionBtn', function() {
         
             		var sid = $(this).closest('div .segmentRow').attr('seg_id');
             		//alert("sid: "+sid);
             		
             		var qid = $(this).closest('fieldset').attr('id');
             		//alert("qid: "+qid);
             		
             		$('#modal_question_segmentId').val(sid);
             		$('#modal_questionId').val(qid);
             		
             		/* alert(qid); */
             		var qOrder='';
             		var qName='';
             		var qType='';
             		var answerSet='';
             		var correctAnswer='';	    		
             		
             		   $.ajax({
                        	type: 'POST',
                        	url: 'UpdateModalController',
                        	/* data: {user:username}, */
                        	dataType: 'json',
                        	data: {id: qid},            	
                        	cache:false,              
                           
                        	success: function(data){	               		
                        		
                        		qOrder=data.qOrder;
                        		qName=data.qName;
                        		qType=data.qType;            		
                        		answerSet=data.qAnswers;	               		
                        		correctAnswer=data.qcorrectAnswer;	         		
                      
                        		var repaleStr=answerSet.replace(/\[|\]/g, "").replace(/\"/g, "").replace(/,/g, '\n');
                        		
                        		
                             console.log(data);                   
                             var data = $.parseJSON(JSON.stringify(data));                        
         
                           
                             
                             $('#modal_questionOrder').val(qOrder);
                             $('#modal_questionId').val(qid);
                              $('#modal_question').val(qName);
                              $('#modal_questionType').val(qType);
                             $('#modal_answers').val(repaleStr);
                             $('#modal_correctAnswer').val(correctAnswer);
                        		
                        	},
                        	 error:function(){
                                 alert('error');
                             }
                        	
                        });
             		   
             		  
             	 }); 
             	
             	
             	
             	$(document).on('click', '.editSegmentBtn', function() {
             		
             		var sid = $(this).closest('div .segmentRow').attr('seg_id');
             	/* 	alert(sid);	  */   
             		var segmentOrder='';
             		var segmentName='';
             		var segmentDescription='';
             		
             		$.ajax({
                        	type: 'POST',
                        	url: 'UpdateModalSegmentContoller',	             
                        	dataType: 'json',
                        	data: {segmentid : sid},            	
                        	cache:false,              
                           
                        	success: function(data){           		
                        		segmentOrder = data.segmentOrder;
                        		segmentName=data.segmentName;
                        		segmentDescription=data.segmentDescription;              			               		
                        		
                        	  	$('#modal_segmentId').val(sid);
                        		 $('#modal_segmentOrder').val(segmentOrder);	               	 
                            	$('#modal_segmentName').val(segmentName);
                             $('#modal_segmentDesciption').val(segmentDescription); 
                        		
                        	},
                        	 error:function(){
                                 alert('error');
                             }
                        	
                        });
             		
             	});
             	
             	
             	$(document).on('click', 'button.addQuestion', function() {
             		
             	    var sid = $(this).closest('div .segmentRow').attr('seg_id');
             	    ///alert("sid: "+sid);
             	  
             	    $('#addQuestionModal_sid').val(sid);	   
             	    
             	});
             	
             	$(document).on('click', '#deleteSegmentBtn', function() {
             		
             		var segid = $(this).closest('div .segmentRow').attr('seg_id');
             		var formName=$('#formName').text();
             		
             	if (confirm('Are you sure you want todelete?')) {
             		 $.ajax({
                        	type: 'GET',
                        	url: 'deleteController',	            	
                     	data: {segmentid : segid},            	
                        	cache:false,                 
                        	success: function(data){ 		
                        		
                        	  	alert("segment deleted successfully...");
                        	 	location.href =  "update.jsp?selected_formName="+formName;
                        	
                        		
                        	},
                        	 error:function(){
                                 alert('error');
                             }
                        	
                        });
             	} else {
             	    // Do nothing!
             	    alert("cancel deleting.");
             	}
             		
             	});
             	
             	
           //---------------delete question btn-----------------------------------
             	
         $(document).on('click', '.deleteQuestionBtn', function() {
             		
             		var qid = $(this).closest('fieldset').attr('id');
             		var formName=$('#formName').text();
             	
             	if (confirm('Are you sure you want todelete?')) {
             		 $.ajax({
                        	type: 'POST',
                        	url: 'deleteQuestionController',	             
                        	dataType: 'json',
                        	data: {questionId : qid},            	
                        	cache:false,              
                           
                        	success: function(data){           		
                        		
                        		alert("question deleted successfully..........");
                        		var result = JSON.stringify(data.formName);	
                        		location.href =  "update.jsp?selected_formName="+formName;
                        			               		
                        	},
                        	 error:function(){
                        		location.href =  "update.jsp?selected_formName="+formName;
                             }
                        	
                        }); 
             	} else {
             	    // Do nothing!
             	    alert("cancel deleting.");
             	}
             });
             	
           //-------------------------end of delete question btn-----------------------------------------------
           
           //----------------------------start add question modal show/hide div -------------------------------------------
           
           $(document).on('change', '.modal_addQuestionType', function () {		
         		
         	 
         	    var option = $(this).closest('.modal_addQuestionType').find('option:selected').val();
                    //var option = $('.modal_addQuestionType').find('option:selected').val();
         		 // alert("option:"+option);
                    if(option == "radioButton"){     
            			//alert("radio....................");
                    	
         			$('.modal_addQuestion_answerSet').prop('disabled', false);
         			$('.modal_addQuestion_changeTextAreaRow').show();
         			 $('.modal_addQuestion_changeImageRow').hide(); 
         			
         			}
         			else if(option == "checkBox"){
         				//alert("checkbox....................");
         			$('.modal_addQuestion_answerSet').prop('disabled', false);
         			$('.modal_addQuestion_changeTextAreaRow').show();
         			 $('.modal_addQuestion_changeImageRow').hide(); 
         			
         			}
         			else if(option == "dropDown"){
         				$('.modal_addQuestion_answerSet').prop('disabled', false);
         				$('.modal_addQuestion_changeTextAreaRow').show();
         			 	$('.modal_addQuestion_changeImageRow').hide(); 
         				
         				}
         			else if(option == "textArea"){
         				$('.modal_addQuestion_answerSet').prop('disabled', true);
         				$('.modal_addQuestion_changeTextAreaRow').show();
         			 	$('.modal_addQuestion_changeImageRow').hide(); 
         				
         			}
         			else if(option == "textFeild"){
         				
         				$('.modal_addQuestion_answerSet').prop('disabled', true);
         				$('.modal_addQuestion_changeTextAreaRow').show();					
         				$('.modal_addQuestion_changeImageRow').hide();
         			}
         			else if(option == "datePicker"){
         				
         				$('.modal_addQuestion_answerSet').prop('disabled', true);
         				$('.modal_addQuestion_changeTextAreaRow').show();					
         				$('.modal_addQuestion_changeImageRow').hide();
         			}
         			else if(option == "signature"){
         				
         				$('.modal_addQuestion_answerSet').prop('disabled', true);
         				$('.modal_addQuestion_changeTextAreaRow').show();					
         				$('.modal_addQuestion_changeImageRow').hide();
         			}
                    
         			else{
         				$('.modal_addQuestion_changeImageRow').show();
         				$('.modal_addQuestion_changeTextAreaRow').hide();
         			}
                    	
                    
             });
         	
         
           
           //----------------------------end add question modal show/hide div ---------------------------------------------
           
            //----------------------------start update question modal show/hide div -------------------------------------------
            
             $(document).on('change', '.modal_questionType', function () {		
         		
         		
         		
                    var option = $('.modal_questionType').find('option:selected').val();
         		  //alert("option:"+option);
                    if(option == "radioButton"){     
            			//alert("hi....................");
                    	
         			$('.modal_answerSet').prop('disabled', false);
         			$('.modal_Question_changeTextAreaRow').show();
         			 $('.modal_addQuestion_changeImageRow').hide(); 
         			
         			}
         			else if(option == "checkBox"){
         			$('.modal_answerSet').prop('disabled', false);
         			$('.modal_Question_changeTextAreaRow').show();
         			 $('.modal_Question_changeImageRow').hide(); 
         			
         			}
         			else if(option == "dropDown"){
         				$('.modal_answerSet').prop('disabled', false);
         				$('.modal_Question_changeTextAreaRow').show();
         			 	$('.modal_Question_changeImageRow').hide(); 
         				
         				}
         			else if(option == "textArea"){
         				$('.modal_answerSet').prop('disabled', true);
         				$('.modal_Question_changeTextAreaRow').show();
         			 	$('.modal_Question_changeImageRow').hide(); 
         				
         			}
         			else if(option == "textFeild"){
         				
         				$('.modal_answerSet').prop('disabled', true);
         				$('.modal_Question_changeTextAreaRow').show();					
         				$('.modal_Question_changeImageRow').hide();
         			}
         			else if(option == "datePicker"){
         				
         				$('.modal_answerSet').prop('disabled', true);
         				$('.modal_Question_changeTextAreaRow').show();					
         				$('.modal_Question_changeImageRow').hide();
         			}
         			else if(option == "signature"){
         				
         				$('.modal_answerSet').prop('disabled', true);
         				$('.modal_Question_changeTextAreaRow').show();					
         				$('.modal_Question_changeImageRow').hide();
         			}
         			else{
         				$('.modal_Question_changeImageRow').show();
         				$('.modal_Question_changeTextAreaRow').hide();
         			}
                    	
                    
             });
            
            //---------------------------- end update question modal --------------------------------------------------
           
           //---------------start image show after browse ------------------------------------------------------
           
         $(document).on('change', 'input.imageFile', function() {
         
         //Get count of selected files
            var countFiles = $("#files")[0].files.length;
         //alert("file length: "+countFiles);
         var image_holder = $("#image-holder");
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
                   
                    $("<input class='img_answer' type='radio' name='img_answer' style='display:inline' value='"+value+"'>"+value+"</input>").appendTo(image_holder);
                  	
                    ch++;
                    reader.readAsDataURL($(this)[0].files[i]);//"#files"+sno+qno
                    
                }
                
                image_holder.show();
         
            } else {
                alert("This browser does not support FileReader.");
            }
         
            
         });
            
         //--------------------------------------------------------------------------------------------------
         
         //upolad image script
         $(document).on('click', 'button.btnUpload', function() { 	
         
         
         
         var sno = $('#modal_question_segmentId').val();
         
         var qno=$('#modal_questionId').val();
         //alert("sno: "+sno);
         //alert("qno: "+qno);
           
            	var image = $('#files')[0].files[0];
         
                if( window.FormData ) {
                    formdata = new FormData();
                   
                   
                    var files = $('#files').prop('files');
                	for(var i=0;i<files.length;i++){    		
                		formdata.append('files[' + i + ']', files[i]);
                	}
                	
                	formdata.append("file", files);
                	formdata.append("fid",<%=fId%>); 
                	formdata.append("sid",sno);
                	formdata.append("qid",qno);        	
                	
                	$(this).attr('upload',"yes");
                	$(this).prop('disabled', 'disabled');
                
         
                    $.ajax({
                        url: 'UpdateFileUploadController',
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
            	
            	
            	
          
            
         });//end button upload
         
         
         //------------------------------------------------------------------------------------------------
         
         });	 // end document ready   	
         
      </script>
   </body>
</html>

