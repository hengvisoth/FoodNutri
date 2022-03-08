class TodaysMealModel {
  // String img;
  String title;
  int id;
  int time;

  TodaysMealModel({
    // required this.img,
    required this.title,
    required this.id,
    required this.time,
  });
  factory TodaysMealModel.fromJson(dynamic json){
    print(json);
    return TodaysMealModel(
      title: json["title"] as String, 
      id: json["id"] as int,
      time: json["readyInMinutes"] as int,
      // img: json["image"] as String, 

    );
  }
  static List<TodaysMealModel> mealsFromSnapShot(List snapshot){
    return snapshot.map((data){
      return TodaysMealModel.fromJson(data);
    }).toList();
  }
  @override
  String toString() {
    // TODO: implement toString
    return 'MealsToday {title :$title,  time: $time, id: $id}';
  }
}