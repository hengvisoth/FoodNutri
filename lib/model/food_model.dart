class Foodmodel {
  String img;
  String title;
  int id;
  int time;
  List? ingredient;


  Foodmodel({
    required this.img,
    required this.title,
    required this.id,
    required this.time,
    required this.ingredient
  });

  factory Foodmodel.fromJson(dynamic json){
    return Foodmodel(
      img: json["image"] as String,  
      title: json["title"] as String,
      id: json["id"] as int,
      time: json["readyInMinutes"] as int,
      ingredient: json["extendedIngredients"] 
      );
  }
  static List<Foodmodel> foodFromSnapShot(List snapshot){
    print("Snap Shot ${snapshot}");
     return snapshot.map((data) {
       return Foodmodel.fromJson(data);
     }).toList();
  }
  @override
  String toString() {
    // TODO: implement toString
    return 'Reciepe {title :$title, img: $img, time: $time, ingredient: $ingredient}';
  }
}




// List<Foodmodel> foodModel = [
//   Foodmodel(
//     img:
//         'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSliML04-q6K9uY54HOvUFp-UXINyIN-nH8qQ&usqp=CAU',
//     title: 'Spicy Arrabiata Pasta',
//     id: 01,
//     time: 45,
//   ),
//   Foodmodel(
//     img:
//         'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRL7JomJwu0iCJ0qrn_9H24KIIBXzOjExaQCg&usqp=CAU',
//     title: 'Graden Salad',
//     id: 02,
//     time: 45,
//   ),
  // Foodmodel(
  //   img:
  //       'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRL7JomJwu0iCJ0qrn_9H24KIIBXzOjExaQCg&usqp=CAU',
  //   title: 'Graden Salad',
  //   detail: 'Salad with legumes and leafy green',
  //   id: 03,
  //   time: '',
  // ),
// ];
