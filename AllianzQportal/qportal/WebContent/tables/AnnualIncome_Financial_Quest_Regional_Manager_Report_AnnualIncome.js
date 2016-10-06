 $(document).on('change', '#Financial_Quest_Regional_Manager_Report_AnnualIncome input', function() {
	var year1Value=0;
	var year2Value=0;
	var year3Value=0;
     var i=3;
     var j=4;
     var k=5;
     while(i<=27){
    	 var temp =document.getElementsByName('Financial_Quest_Regional_Manager_Report_AnnualIncome_'+i)[0].value; 
    	 year1Value += Number(temp);    	 
    	 i+=3;
    	
     }
     while(j<=28){
    	 var temp =document.getElementsByName('Financial_Quest_Regional_Manager_Report_AnnualIncome_'+j)[0].value; 
    	 year2Value += Number(temp);    	 
    	 j+=3;
     }
     while(k<=29){
    	 var temp =document.getElementsByName('Financial_Quest_Regional_Manager_Report_AnnualIncome_'+k)[0].value; 
    	 year3Value += Number(temp);    	 
    	 k+=3;
     }
     
    
     document.getElementsByName('Financial_Quest_Regional_Manager_Report_AnnualIncome_30')[0].value=year1Value;
     document.getElementsByName('Financial_Quest_Regional_Manager_Report_AnnualIncome_31')[0].value=year2Value;
     document.getElementsByName('Financial_Quest_Regional_Manager_Report_AnnualIncome_32')[0].value=year3Value;
    
     document.getElementsByName("Financial_Quest_Regional_Manager_Report_AnnualIncome_30")[0].setAttribute("annualIncomeYear1", year1Value);     
     document.getElementsByName("Financial_Quest_Regional_Manager_Report_AnnualIncome_31")[0].setAttribute("annualIncomeYear1", year2Value);
     document.getElementsByName("Financial_Quest_Regional_Manager_Report_AnnualIncome_32")[0].setAttribute("annualIncomeYear1", year3Value);
     
     
     
	}); 