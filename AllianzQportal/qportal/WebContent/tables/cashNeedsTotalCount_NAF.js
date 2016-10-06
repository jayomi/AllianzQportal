 $(document).on('change', '#cashNeeds input', function() {
	var aValue=0;
	var bValue=0;
     var i=0
     var j=1;
     while(i<=12){
    	 var temp =document.getElementsByName('cashNeeds_'+i)[0].value; 
    	 aValue += Number(temp);    	 
    	 i+=2;
    	
     }
     while(j<=13){
    	 var temp =document.getElementsByName('cashNeeds_'+j)[0].value; 
    	 bValue += Number(temp);    	 
    	 j+=2;
     }
    
     document.getElementsByName('cashNeeds_14')[0].value=aValue;
     document.getElementsByName('cashNeeds_15')[0].value=bValue;
    // document.getElementsByTagName('totalA')[0].innerHTML =aValue
    // document.getElementById("asset").getAttribute("totala");
     document.getElementsByName("cashNeeds_14")[0].setAttribute("cashneedstotala", aValue);     
     document.getElementsByName("cashNeeds_15")[0].setAttribute("cashneedstotalb", bValue);
     
     //document.getElementsByName("liability_13")[0].setAttribute("totalb", bValue);
     
	}); 