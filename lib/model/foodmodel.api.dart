import 'dart:convert';
import 'package:http/http.dart' as http;

import 'food_model.dart';

class FoodModelApi {
  static Future<List<Foodmodel>> getModel() async {
    var uri = Uri.https("spoonacular-recipe-food-nutrition-v1.p.rapidapi.com",
        "/recipes/random", {"number": "10"});
    final response = await http.get(uri, headers: {
      'x-rapidapi-host': 'spoonacular-recipe-food-nutrition-v1.p.rapidapi.com',
      'x-rapidapi-key': 'f4ca362583msh599f5c38eed05c2p15652cjsnb06895e6b7c1'
    });
    // select specific data from api call
    Map data = jsonDecode(response.body);
    List _temp = [];
    for (var i in data['recipes']) {
      _temp.add(i);
    }

    return Foodmodel.foodFromSnapShot(_temp);
  }

  static Future<List<Foodmodel>> searchFood(String query) async {
    var uri = Uri.https("spoonacular-recipe-food-nutrition-v1.p.rapidapi.com",
        "/recipes/search", {
      "query": query,
      "excludeIngredients": "coconut",
      "number": "5",
      "offset": "0"
    });
    final response = await http.get(uri, headers: {
      "x-rapidapi-host": "spoonacular-recipe-food-nutrition-v1.p.rapidapi.com",
      "x-rapidapi-key": "f4ca362583msh599f5c38eed05c2p15652cjsnb06895e6b7c1",
      "useQueryString": "true"
    });
    Map data = jsonDecode(response.body);
    List _temp = [];
    for (var i in data['results']) {
      _temp.add(i);
    }
    return Foodmodel.foodFromSnapShot(_temp);
  }
}
