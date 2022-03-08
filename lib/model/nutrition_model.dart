

class NutritionModel{
  String calories;
  List bad;
  List good;
  String protein;
  NutritionModel({
    required this.calories,
    required this.bad,
    required this.good,
    required this.protein
  });
  
  factory NutritionModel.fromJson(dynamic json){
    print("Json : $json");
    return NutritionModel(
      calories: json["calories"] as String, 
      bad: json["bad"] as List,
      good: json["good"] as List,
      protein : json["protein"] as String
      );
  
      }
    static List<NutritionModel> nutriFromSnapshot(List snapshot){
      print("SnampShot$snapshot");
      return snapshot.map((data){
      
        return NutritionModel.fromJson(data);
      }).toList();
    }
    @override
    String toString(){
      return 'Nutrition {calories : $calories, bad : $bad, good : $good, protein : $protein';
    }
}