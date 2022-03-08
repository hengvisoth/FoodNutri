class FoodIngredient{
  int id ;
  List ingredient;
  List analyzedInstructions;

 FoodIngredient({
    required this.id,
    required this.ingredient,
    required this.analyzedInstructions
  });
  factory FoodIngredient.fromJson(dynamic json){
    return FoodIngredient(
      id: json["id"] as int,
      ingredient: json["extendedIngredients"] as List,
      analyzedInstructions: json["analyzedInstructions"] as List
      );
  }
  static List<FoodIngredient> foodFromSnapShot(List snapshot){
    print("FoodIngreDient Snapshot ${snapshot}");
     return snapshot.map((data) {
       return FoodIngredient.fromJson(data);
     }).toList();
  }
  @override
  String toString() {
    // TODO: implement toString
    return 'Ingredient {int :$id, ingredient: $ingredient, analyzedInstruction: $analyzedInstructions}';
  }
}