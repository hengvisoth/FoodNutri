
import 'dart:convert';

import 'package:http/http.dart' as http;



import 'nutrition_model.dart';

class NutriModelApi{
  static Future<List<NutritionModel>> getGoodNutri(String id) async{
    var uri = Uri.https("spoonacular-recipe-food-nutrition-v1.p.rapidapi.com", "/recipes/$id/nutritionWidget.json",{
      "id" : id
    });
    final _response = await http.get(uri,headers: {
        'Content-Type': 'application/json',
      	"x-rapidapi-host": "spoonacular-recipe-food-nutrition-v1.p.rapidapi.com",
      	"x-rapidapi-key": "f4ca362583msh599f5c38eed05c2p15652cjsnb06895e6b7c1",
    });
   
    Map _data = jsonDecode(_response.body);
    List allData = [] ; 
    allData.add(_data);
    return NutritionModel.nutriFromSnapshot(allData);
  }
  // static Future<List<NutritionModel>> getBadNutri(String id) async{
  //   var uri = Uri.https("https://spoonacular-recipe-food-nutrition-v1.p.rapidapi.com", "recipes/$id/nutritionWidget.json",{
  //     "id" : id
  //   });
  //   final _response = await http.get(uri,headers: {
  //     	"x-rapidapi-host": "spoonacular-recipe-food-nutrition-v1.p.rapidapi.com",
  //     	"x-rapidapi-key": "f4ca362583msh599f5c38eed05c2p15652cjsnb06895e6b7c1",
  //   });
  //   Map _data = jsonDecode(_response.body);
  //   List bad = [];
    
  //   for(var i in _data['bad']){
  //     bad.add(i);
  //   }
  //   return NutritionModel.nutriFromSnapshot(bad);
  // }
  // static Future<List<NutritionModel>> getCalories(id) async{
  //   var uri = Uri.https("https://spoonacular-recipe-food-nutrition-v1.p.rapidapi.com", "recipes/1003464/nutritionWidget.json",{
  //     "id" : "1003464"
  //   });
  //   final _response = await http.get(uri,headers: {
  //     	"x-rapidapi-host": "spoonacular-recipe-food-nutrition-v1.p.rapidapi.com",
  //     	"x-rapidapi-key": "f4ca362583msh599f5c38eed05c2p15652cjsnb06895e6b7c1",
  //   });
  //   Map _data = jsonDecode(_response.body);
  //   List calories = [];
    
  //   for(var i in _data['calories']){
  //     calories.add(i);
  //   }
  //   return NutritionModel.nutriFromSnapshot(calories);
  // }
}
// var unirest = require("unirest");

// var req = unirest("GET", "https://spoonacular-recipe-food-nutrition-v1.p.rapidapi.com/recipes/1003464/nutritionWidget.json");

// req.headers({
// 	"x-rapidapi-host": "spoonacular-recipe-food-nutrition-v1.p.rapidapi.com",
// 	"x-rapidapi-key": "f4ca362583msh599f5c38eed05c2p15652cjsnb06895e6b7c1",
// 	"useQueryString": true
// });


// req.end(function (res) {
// 	if (res.error) throw new Error(res.error);

// 	console.log(res.body);
// });