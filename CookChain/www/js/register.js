//https://cookchain-dannthamann.c9.io/
$(function(){
    //event binding
    $('#register').click(register);
    
    
    
    
    function register() {
        //check if passwords match
        if($("#password").val() !== $("#confirmPassword").val()) {
            alert("not same");
            return;
        }

        var data = 
            {username: $("#email").val(), 
            password: $("#password").val()};
            
        //alert("Email: " + data['email'] + "\nPassword: " + data['pass']);
            
        $.ajax({
            url: domain + '/create',
            type: 'POST',
            data: data, //might need to change 
            //success: registerResponse
        });
        alert("You username is :" + data['username'] + "\nYou password is :" + data['password']);
        fakeregister();

    }
    
    
    function fakeregister(){
        console.log("here");
        $('.confirmPassword').remove();
        $('.password').remove();
        $('.email').remove();
        $('#register').remove();
        $('#alert-container').remove();
        $('#form-container').append('<div class="row text-center"><h3>Registraition Complete</h3></div><div class="row text-center"><h3><small>Redirecting to log in page</small></h3></div>');
        $('#loading').show();
        setTimeout(function(){
            window.location.href = "ingredients.html";
        },3000);        
    }

    function registerResponse(res) {
        //login will be true or false depending on if the user can log in
        //if(res['success']) {
            console.log("here");
            $('.confirmPassword').remove();
            $('.password').remove();
            $('.email').remove();
            $('#register').remove();
            $('#alert-container').remove();
            $('#form-container').append('<div class="row text-center"><h3>Registraition Complete</h3></div><div class="row text-center"><h3><small>Redirecting to log in page</small></h3></div>');
            $('#loading').show();
            setTimeout(function(){
                window.location.href = "search.html";
            },3000);
        //} else {
        //    $('#password').val('');
        //    $('#confirmPassword').val('');
        //    $("#alert-container").append('<div data-alert class="alert-box alert radius">There was an error. Please fill out the form and try again.<a href="#" class="close">&times;</a></div>');
        //    $(document).foundation('alert', 'reflow');
            //alert("There was an error, please try again");
        //}
    }
    
    
});