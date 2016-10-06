 $(document).on('change', '#audited_profit_and_loss_account input', function() {
	var year1Value=0;
	var year2Value=0;
	var year3Value=0;
     var i=3;
     var j=4;
     var k=5;
     while(i<=12){
    	 var temp =document.getElementsByName('Financial_Quest_Regional_Manager_Report_audited_profit_and_loss_account_'+i)[0].value; 
    	 year1Value += Number(temp);    	 
    	 i+=3;
    	
     }
     while(j<=13){
    	 var temp =document.getElementsByName('Financial_Quest_Regional_Manager_Report_audited_profit_and_loss_account_'+j)[0].value; 
    	 year2Value += Number(temp);    	 
    	 j+=3;
     }
     while(k<=14){
    	 var temp =document.getElementsByName('Financial_Quest_Regional_Manager_Report_audited_profit_and_loss_account_'+k)[0].value; 
    	 year3Value += Number(temp);    	 
    	 k+=3;
     }
     
    
     document.getElementsByName('Financial_Quest_Regional_Manager_Report_audited_profit_and_loss_account_15')[0].value=year1Value;
     document.getElementsByName('Financial_Quest_Regional_Manager_Report_audited_profit_and_loss_account_16')[0].value=year2Value;
     document.getElementsByName('Financial_Quest_Regional_Manager_Report_audited_profit_and_loss_account_17')[0].value=year3Value;
    
     document.getElementsByName("Financial_Quest_Regional_Manager_Report_audited_profit_and_loss_account_15")[0].setAttribute("audited_profit_and_loss_account1", year1Value);     
     document.getElementsByName("Financial_Quest_Regional_Manager_Report_audited_profit_and_loss_account_16")[0].setAttribute("audited_profit_and_loss_account2", year2Value);
     document.getElementsByName("Financial_Quest_Regional_Manager_Report_audited_profit_and_loss_account_17")[0].setAttribute("audited_profit_and_loss_account3", year3Value);
     
	}); 