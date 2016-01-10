// $.ajax({
//             url: 'http://example.com/',
//             type: 'PUT',
//             data: 'ID=1&Name=John&Age=10', // or $('#myform').serializeArray()
//             success: function()
//         });

$(function(){
    //event binding
    $('#login').click(login);
    
    
    
    
    function login() {
        
        var data = 
            {email: $("#email").val(), 
            password: $("#password").val()};
        //remove this   
        //alert("Email: " + data['email'] + "\nPassword: " + data['pass']);
            
        $.ajax({
            url: domain + '/user/login',
            type: 'POST',
            data: data, //might need to change 
            success: loginResponse
        });
    }
    
    
    
    function loginResponse(res) {
    	if(res['success']) {
    		window.location.href = "search.html";
    	} else {
    		$("#password").val('');
    		$(".alert-container").append('<div data-alert class="alert-box alert round">Email and/or password incorrect.<a href="#" class="close">&times;</a></div>');
    		$(document).foundation('alert', 'reflow');
    	}
    }
    
    
});