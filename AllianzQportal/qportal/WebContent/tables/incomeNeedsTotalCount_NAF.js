 $(document).on('change', '#incomeNeeds input', function() {
	var aValue=0;
	var bValue=0;
     var i=0
     var j=1;
     while(i<=18){
    	 var temp =document.getElementsByName('incomeNeeds_'+i)[0].value; 
    	 aValue += Number(temp);    	 
    	 i+=2;
    	
     }    
     while(j<=19){
    	 var temp =document.getElementsByName('incomeNeeds_'+j)[0].value; 
    	 bValue += Number(temp);    	 
    	 j+=2;
    	
     }
    
     document.getElementsByName('incomeNeeds_20')[0].value=aValue;
     document.getElementsByName('incomeNeeds_21')[0].value=bValue;
    // document.getElementsByTagName('totalA')[0].innerHTML =aValue
    // document.getElementById("asset").getAttribute("totala");
     document.getElementsByName("incomeNeeds_20")[0].setAttribute("incomeneedsa", aValue);     
     document.getElementsByName("incomeNeeds_21")[0].setAttribute("incomeneedsb", bValue);
     document.getElementsByName("incomeNeeds_20")[0].setAttribute("value", aValue);
     document.getElementsByName("incomeNeeds_21")[0].setAttribute("value", bValue);
     
     
	}); 