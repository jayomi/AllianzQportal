$(function() {
	alert("sssssssssssssssssssssss");
   $("#mainform").validate({
        rules : {
        	question_paginating : "required"
        },
        messages : {
        	question_paginating : "Please enter your first name"
        },
        submitHandler: function(form) {
            form.submit();
        }
  });
});