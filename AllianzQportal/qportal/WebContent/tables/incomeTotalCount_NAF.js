 $(document).on('change', '#income input', function() {
	var aValue=0;
	
     var i=0
     
     while(i<=4){
    	 var temp =document.getElementsByName('income_'+i)[0].value; 
    	 aValue += Number(temp);    	 
    	 i+=1;
    	
     }
     
    
     document.getElementsByName('income_5')[0].value=aValue;
   
     document.getElementsByName("income_5")[0].setAttribute("incomeA", aValue);   
     document.getElementsByName("income_5")[0].setAttribute("value", aValue);  
    
     
     
	}); 