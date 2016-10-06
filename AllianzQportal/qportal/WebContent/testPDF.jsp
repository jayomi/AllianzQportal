

<%@page import="com.allianz.qportalapp.controller.FormAssignToUserImple"%>
<%@page import="com.allianz.qportalapp.controller.FormAssignToUserController"%>
<%@page import="com.allianz.qportalapp.model.FormType"%>
<%@page import="com.allianz.qportalapp.controller.FormTypeImpl"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.util.Calendar"%>
<%@ page import="java.text.SimpleDateFormat"%>
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
                  
                  <style type="text/css">
					
    </style>
    
    
               </head>
               <body >
                  <!-- START Main wrapper-->
                  <div class="wrapper">
                     <!-- START Top Navbar-->
                     <nav role="navigation" class="navbar navbar-default navbar-top navbar-fixed-top">
                        <!-- START navbar header-->
                        <div class="navbar-header">
                           <a href="login.jsp" class="navbar-brand">
                              <div class="brand-logo">
                                 <img src="app/img/logo.png" alt="App Logo" class="img-responsive">
                              </div>
                              <div class="brand-logo-collapsed">
                                 <img src="app/img/logo-single.png" alt="App Logo" class="img-responsive">
                              </div>
                           </a>
                        </div>
                        <!-- END navbar header-->
                        <!-- START Nav wrapper-->
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
                              <li><a href="#" data-toggle="fullscreen"> <em
                                 class="fa fa-expand"></em>
                                 </a>
                              </li>
                              <li><a href="firstPage.jsp" >Home 
                                 </a>
                              </li>
                              <li>
                                 <a>
                                    <form action="register.jsp" method="post">
                                       <input type="submit" value="Register" class="register btn btn-square btn-primary btn-sm">
                                    </form>
                                 </a>
                              </li>
                           </ul>
                           <!-- END Right Navbar-->
                        </div>
                        <!-- END Nav wrapper-->
                        <!-- END Nav wrapper-->
                        <!-- START Search form-->
                        <form role="search" action="" class="navbar-form">
                           <div class="form-group has-feedback">
                              <input type="text" placeholder="Type and hit Enter.." class="form-control">
                              <div data-toggle="navbar-search-dismiss" class="fa fa-times form-control-feedback"></div>
                           </div>
                           <button type="submit" class="hidden btn btn-default">Submit</button>
                        </form>
                        <!-- END Search form-->
                     </nav>
                     <!-- END Top Navbar-->
                     <!-- START aside-->
                     <!-- End aside-->
                     <!-- START Main section-->
                     <!-- START wrapper-->
                    
                        <div class="row">
                             <div class="panel panel-primary">
			                      <div class="panel-heading">User</div>
			                     <div class="panel-body">
                            
                              <span id="widget" class="widget">
  
  									 <div class="form-group">
                                    <label >User name: </label>
                                    <input id="userName" type="text" placeholder="Enter user name" class="form-control" name="userName" value="Jayomi">
                                 </div>
                                 
								    <div class="element ng-scope">
								      <div ng-show="hasData()" class="content">
								      <h2>AAAAAAAAA</h2>
								      <input type='text' value='test image'>
								      </div>
								    </div>
								
							</span>
								<br/>
								<!-- <input type="button" id="btnSave" value="Save PNG"/> -->

								<!-- <canvas id="canvas"></canvas> -->

									<a id="downloadpdf">Download as pdf</a>
                             
                              </div>
                               </div>
                               
                        </div>
                   
                      <%@include file="pages/footer.jsp" %>
                  </div>
                  <!-- END DATATABLE 1 -->
                  <!-- START Scripts-->
                  <%@ include file="pages/script.jsp" %>
                  <!-- END Scripts-->
                  
                   <script src="vendor/jsPDF/dist/jspdf.min.js"></script>
                   <script src="vendor/jsPDF/dist/html2canvas.js"></script>
                   <script src="vendor/jsPDF/dist/canvas2image.js"></script>
                   <script src="vendor/jsPDF/lib/base64.js"></script>
                   
                  
                 
               </body>
            </html>

<script type="text/javascript">



/* function savePDF(){
	 try {
		 
		 html2canvas($("#widget"), {
	     onrendered: function(canvas) {
	     theCanvas = canvas;
	     $("#canvas").append(canvas);
	     }
	        });
		 
		 
	     
		canvas.getContext('2d');
		var imgData = canvas.toDataURL("image/jpeg", 1.0);
	    //var pdf = new jsPDF('p', 'mm', [297, 210]);
	    var pdf = new jsPDF();
	    pdf.setFontSize(40);
	    pdf.text(35, 25, "Octonyan loves jsPDF");
	   // pdf.addImage(imgData, 'JPEG', 5, 5);
	    pdf.addImage(imgData, 'JPEG', 15, 40, 180, 180);
	    var namefile = prompt("insert name of file");
	    pdf.save(namefile + ".pdf");
	    
	   
	    
	 } catch(e) {
		 alert("Error description: " + e.message);
	 }	 
} */

function savePDF(){
	
	 try {
		 
	
    html2canvas($("#widget"), {
    	
    onrendered: function (canvas) {
    	
    var imageData = canvas.toDataURL("image/jpeg");
    var image = new Image();
    image = Canvas2Image.convertToJPEG(canvas);
    var doc = new jsPDF();
    doc.addImage(imageData, 'JPEG', 12, 10);
    var croppingYPosition = 1095;
  
   
   // count = (image.height) / 1095;

    
          doc.addPage();
            var sourceX = 0;
            var sourceY = croppingYPosition;
            var sourceWidth = image.width;
            var sourceHeight = 1095;
            var destWidth = sourceWidth;
            var destHeight = sourceHeight;
            var destX = 0;
            var destY = 0; 
            var canvas1 = document.createElement('canvas');
            canvas1.setAttribute('height', sourceHeight);
            canvas1.setAttribute('width', sourceWidth);                         
            var ctx = canvas1.getContext("2d");
            ctx.drawImage(image, sourceX, 
                                 sourceY,
                                 sourceWidth,
                                 sourceHeight, 
                                 destX, 
                                 destY, 
                                 destWidth, 
                                 destHeight);  
            var image2 = new Image();
            image2 = Canvas2Image.convertToJPEG(canvas1);
            image2Data = image2.src;
            doc.addImage(image2Data, 'JPEG', 12, 10);
            //croppingYPosition += destHeight;              
                      
            var namefile = prompt("insert name of file");
            doc.save(namefile + ".pdf");
}
    
});
    
	 }catch(e) {
		 alert("Error description: " + e.message);
	 }	 
	 
}





document.getElementById('downloadpdf').addEventListener('click', savePDF, false);


</script>
