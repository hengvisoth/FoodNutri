
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class NutritionModel{
  String calories;
  List bad;
  List good;
  NutritionModel({
    required this.calories,
    required this.bad,
    required this.good
  });
  
  factory NutritionModel.fromJson(dynamic json){
    print("Json : $json");
    return NutritionModel(
      calories: json["calories"] as String, 
      bad: json["bad"] as List,
      good: json["good"] as List
      
      );
  
      }
    static List<NutritionModel> nutriFromSnapshot(List snapshot){
      print("Snap Shot ${snapshot}");
      return snapshot.map((data){
      
        return NutritionModel.fromJson(data);
      }).toList();
    }
    @override
    String toString(){
      return 'Nutrition {calories : $calories, bad : $bad, good : $good';
    }
}