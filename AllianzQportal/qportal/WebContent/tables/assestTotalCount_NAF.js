 $(document).on('change', '#asset input', function() {
	var aValue=0;
	var bValue=0;
     var i=0
     var j=1;
     while(i<=26){
    	 var temp =document.getElementsByName('client_'+i)[0].value; 
    	 aValue += Number(temp);    	 
    	 i+=2;
    	
     }
     while(j<=27){
    	 var temp =document.getElementsByName('client_'+j)[0].value; 
    	 bValue += Number(temp);    	 
    	 j+=2;
     }
    
     document.getElementsByName('client_28')[0].value=aValue;
     document.getElementsByName('client_29')[0].value=bValue;
    // document.getElementsByTagName('totalA')[0].innerHTML =aValue
    // document.getElementById("asset").getAttribute("totala");
     document.getElementsByName("client_28")[0].setAttribute("totala", aValue);     
     document.getElementsByName("client_29")[0].setAttribute("totalb", bValue);
     
    
     
     
	}); 