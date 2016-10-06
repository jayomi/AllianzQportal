 $(document).on('change', '#expensess input', function() {
	var aValue=0;
	var bValue=0;
     var i=0
     var j=1;
     while(i<=20){
    	 var temp =document.getElementsByName('expensess_'+i)[0].value; 
    	 aValue += Number(temp);    	 
    	 i+=2;
    	
     }
     while(j<=21){
    	 var temp =document.getElementsByName('expensess_'+j)[0].value; 
    	 bValue += Number(temp);    	 
    	 j+=2;
     }
    
     document.getElementsByName('expensess_22')[0].value=aValue;
     document.getElementsByName('expensess_23')[0].value=bValue;
    // document.getElementsByTagName('totalA')[0].innerHTML =aValue
    // document.getElementById("asset").getAttribute("totala");
     document.getElementsByName("expensess_22")[0].setAttribute("expensessa", aValue);     
     document.getElementsByName("expensess_23")[0].setAttribute("expensessb", bValue);
     document.getElementsByName("expensess_22")[0].setAttribute("value", aValue);     
     document.getElementsByName("expensess_23")[0].setAttribute("value", bValue);
     
     
	}); 