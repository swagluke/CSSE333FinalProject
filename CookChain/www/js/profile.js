$(function(){
setEmail();




function setEmail() {
	var email = $.cookie("email");
	$("#email").html(email);
}
});