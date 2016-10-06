function savePDF(){
	
	var options = {
		    background: '#fff',
		    pagesplit: true
		};
	
	
	 try {
		 
	$('.panel-collapse').addClass( "in" );
	
    html2canvas($("#widget"), {
    	
	    onrendered: function (canvas) {
	    	
		    var imageData = canvas.toDataURL("image/jpeg");
		    var image = new Image();
		    image = Canvas2Image.convertToJPEG(canvas);
		   var doc = new jsPDF();
		   // var doc = new jsPDF("l", "mm", "a4");
		    doc.addImage(imageData, 'JPEG', 12, 10);
		    var croppingYPosition = 1095;
		    count = (image.height) / 1095;
	
		    for (var i =1; i < count; i++) {
		    
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
		            
		           // canvas1.setAttribute('height', $(window).height());
			       // canvas1.setAttribute('width', $(window).width());
		            
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
	          
		           croppingYPosition += destHeight;              
		    }                  
                      
            var namefile = prompt("insert name of file");           
            doc.save(namefile + ".pdf");
	    }
    
});
    
	 }catch(e) {
		 alert("Error description: " + e.message);
	 }	 
	 
}





document.getElementById('downloadpdf').addEventListener('click', savePDF, false);

