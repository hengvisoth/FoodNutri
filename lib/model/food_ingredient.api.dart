import 'package:http/http.dart' as http;
import 'dart:convert';

import 'food_ingre.dart';

class FoodIngredientApi{
  static Future<List<FoodIngredient>> getModel(id) async {
    var uri = Uri.https("spoonacular-recipe-food-nutrition-v1.p.rapidapi.com",
        "/recipes/$id/information");
    final response = await http.get(uri, headers: {
      'x-rapidapi-host': 'spoonacular-recipe-food-nutrition-v1.p.rapidapi.com',
      'x-rapidapi-key': 'f4ca362583msh599f5c38eed05c2p15652cjsnb06895e6b7c1',
      "useQueryString": "true"

    });
    // select specific data from api call
    Map data = jsonDecode(response.body);
    List _temp = [];
    _temp.add(data);

    return FoodIngredient.foodFromSnapShot(_temp);
  }
}