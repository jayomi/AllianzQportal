 $(document).on('change', '#liabilities input', function() {
	var aValue=0;
	var bValue=0;
     var i=0
     var j=1;
     while(i<=10){
    	 var temp =document.getElementsByName('liability_'+i)[0].value; 
    	 aValue += Number(temp);    	 
    	 i+=2;
    	
     }
     while(j<=11){
    	 var temp =document.getElementsByName('liability_'+j)[0].value; 
    	 bValue += Number(temp);    	 
    	 j+=2;
     }
    
     document.getElementsByName('liability_12')[0].value=aValue;
     document.getElementsByName('liability_13')[0].value=bValue;
     // document.getElementsByTagName('totalA')[0].innerHTML =aValue
     // document.getElementById("asset").getAttribute("totala");
     document.getElementsByName("liability_12")[0].setAttribute("totala", aValue);     
     document.getElementsByName("liability_13")[0].setAttribute("totalb", bValue);
     
     
	}); 