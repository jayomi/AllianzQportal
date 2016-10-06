 $(document).on('change', '#details_of_personal_liabilities_fqrmr input', function() {
	var value=0;
	
	
     var i=0;
     
    
     while(i<=4){
    	 var temp =document.getElementsByName('Financial_Quest_Regional_Manager_Report_details_of_personal_liabilities_'+i)[0].value; 
    	 value += Number(temp);    	 
    	 i+=1;
    	
     }
   
    
     document.getElementsByName('Financial_Quest_Regional_Manager_Report_details_of_personal_liabilities_5')[0].value=value;
    
     document.getElementsByName("Financial_Quest_Regional_Manager_Report_details_of_personal_liabilities_5")[0].setAttribute("personal_liabilities", value);     
     
	}); 