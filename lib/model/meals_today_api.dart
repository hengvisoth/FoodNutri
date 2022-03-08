import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import 'meals_today.dart';

class MealsTodayApi {
  static Future<List<TodaysMealModel>> getModel() async {
    var uri = Uri.https("spoonacular-recipe-food-nutrition-v1.p.rapidapi.com",
        "/recipes/mealplans/generate", {
      "timeFrame": "day",
      "targetCalories": "2000",
      "diet": "vegetarian",
      "exclude": "shellfish, olives"
    });
    final response = await http.get(uri, headers: {
      "x-rapidapi-host": "spoonacular-recipe-food-nutrition-v1.p.rapidapi.com",
      "x-rapidapi-key": "f4ca362583msh599f5c38eed05c2p15652cjsnb06895e6b7c1",
    });
    // select specific data from api call
    Map data = jsonDecode(response.body);
    print("Data$data");
    List _temp = [];
    for (var i in data['meals']) {
      _temp.add(i);
    }

    return TodaysMealModel.mealsFromSnapShot(_temp);
 
  }
}


// var unirest = require("unirest");

// var req = unirest("GET", "https://spoonacular-recipe-food-nutrition-v1.p.rapidapi.com/recipes/mealplans/generate");

// req.query({
// 	"timeFrame": "day",
// 	"targetCalories": "2000",
// 	"diet": "vegetarian",
// 	"exclude": "shellfish, olives"
// });

// req.headers({
// 	"x-rapidapi-host": "spoonacular-recipe-food-nutrition-v1.p.rapidapi.com",
// 	"x-rapidapi-key": "f4ca362583msh599f5c38eed05c2p15652cjsnb06895e6b7c1",
// 	"useQueryString": true
// });


// req.end(function (res) {
// 	if (res.error) throw new Error(res.error);

// 	console.log(res.body);
// });