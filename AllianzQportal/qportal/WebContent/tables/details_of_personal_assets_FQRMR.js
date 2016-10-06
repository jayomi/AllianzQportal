 $(document).on('change', '#details_of_personal_assets_fqrmr input', function() {
	var aValue=0;
	var bValue=0;
	
     var i=0;
     var j=1;
    
     while(i<=8){
    	 var temp =document.getElementsByName('Financial_Quest_Regional_Manager_Report_details_of_personal_assets_'+i)[0].value; 
    	 aValue += Number(temp);    	 
    	 i+=2;
    	
     }
     while(j<=9){
    	 var temp =document.getElementsByName('Financial_Quest_Regional_Manager_Report_details_of_personal_assets_'+j)[0].value; 
    	 bValue += Number(temp);    	 
    	 j+=2;
     }
    
     
    
     document.getElementsByName('Financial_Quest_Regional_Manager_Report_details_of_personal_assets_10')[0].value=aValue;
     document.getElementsByName('Financial_Quest_Regional_Manager_Report_details_of_personal_assets_11')[0].value=bValue;
   
    
     document.getElementsByName("Financial_Quest_Regional_Manager_Report_details_of_personal_assets_10")[0].setAttribute("personal_assetsA", aValue);     
     document.getElementsByName("Financial_Quest_Regional_Manager_Report_details_of_personal_assets_11")[0].setAttribute("personal_assetsB", bValue);
   
     
	}); 