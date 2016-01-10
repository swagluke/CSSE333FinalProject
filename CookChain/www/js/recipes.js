$(function(){
	//spoofRecipes();
	getIngredients();
	
	Array.prototype.contains = function ( needle ) {
	   for (var i = 0; i < this.length; i++) {
	       if (this[i].trim() == needle.trim()) return true;
	   }
	   return false;
	}

	Array.prototype.containsAll = function( array ) {
		if(array.length == 0){
			return false;
		}
		for(var i=0; i<array.length; i++) {
			if(!this.contains(array[i]))
			{
				return false;
			}
		}
		return true;
	}

	function createRecipe(recipe, time, cal, imgURL) {
	
		//create elements
		var recipeContainer = $('<div class="row result"></div>');
		var contentContainer = $('<div class="small-5 small-offset-7 columns result-desc"></div>');
		var nameRow = $('<div class="row"></div>');
		var name = $('<h5 class="result-desc">'+recipe+'</h5>');
		var paramsRow = $('<div class="row"></div>');
		var paramsUL = $('<ul></ul>');
		var paramTime = $('<li>'+time+'</li>');
		var paramCal = $('<li>'+cal+'</li>')

		//set image
		$(recipeContainer).css('background', 
			'linear-gradient('+
				'to right,'+
				'rgba(0, 0, 0, 0),'+
				'rgba(0, 0, 0, 0.6)),'+
				'url('+imgURL+') no-repeat');
		$(recipeContainer).css('background-size', 'cover');

		//collapse
		$(paramsUL).append(paramTime);
		$(paramsUL).append(paramCal);
		$(paramsRow).append(paramsUL);
		$(nameRow).append(name);
		$(contentContainer).append(nameRow);
		$(contentContainer).append(paramsRow);
		$(recipeContainer).append(contentContainer);

		//add to DOM
		$(".search-results").append(recipeContainer);
	}

	//

	function RecipesList1() {
		createRecipe('Beefstew', '2 h 20 m', '256 cals', 'img/Beefstew.jpg');
		createRecipe('Scrambled Eggs', '0 h 6 m', '210 cals', 'img/ScrambledEggs.jpg');
		createRecipe('Neat SloppyJoe', '0 h 50 m', '407 cals', 'img/NeatSloppyJoe.jpg');
		createRecipe('Chicken Tinga Tostados', '1 h 20 m', '514 cals', 'img/ChickenTingaTostados.jpg');
		createRecipe('Belgian Chicken Booyah', '6 h 25 m', '256 cals', 'img/BelgianChickenBooyah.jpg');
		createRecipe('Thai Salad', '1 h 0 m', '644 cals', 'img/ThaiSalad.jpg');
		createRecipe('Easy Lasagna', '1 h 25 m', '377 cals', 'img/EasyLasagna.jpg');

	}
	function RecipesList2() {
		createRecipe('Butter nut Squash', '2 h 20 m', '256 cals', 'img/ButternutSquash.jpg');
		createRecipe('Curry Tofu', '0 h 6 m', '110 cals', 'img/CurryTofu.jpg');
		createRecipe('Grilled Tofu', '0 h 50 m', '207 cals', 'img/GrilledTofu.jpg');
		createRecipe('Thai Curry Tofu', '1 h 20 m', '114 cals', 'img/ThaiTofu.jpg');
		createRecipe('Tofu Lasagna', '6 h 25 m', '156 cals', 'img/Tofu.jpg');
		createRecipe('Tofu with vegetable', '1 h 0 m', '144 cals', 'img/TofuV.jpg');

	}

	function getIngredients() {
		$.ajax({
	    	url: domain + '/user/ingredients',
	    	type: 'GET',
	    	success: setRecipes
	    });
	}

	function setRecipes(res) {
		console.log(res['content']);
		var ingredients = res['content'];
		//var list1 = ["beef chuck and blade", "salt", "onion", "chicken", "egg"];
		//var list2 = ["flour", "tofu", "olive oil", "coconut"];
		var list1 = ["chicken","beef chuck and blade"];
		var list2 = ["tofu"];
		if(ingredients.containsAll(list1)) {
			RecipesList1();
		} else if (ingredients.containsAll(list2)) {
			RecipesList2();
		} else {
			var none = $('<div class="row text-center"><h4>Please add ingredients from the ingredients page.</h4></div>');
			$(".search-results").append(none);
		}
	}
});
