class Foodmodel {
  String img;
  String title;
  String detail;

  Foodmodel({required this.img, required this.title, required this.detail});
}

List<Foodmodel> foodModel = [
  Foodmodel(
    img:
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSliML04-q6K9uY54HOvUFp-UXINyIN-nH8qQ&usqp=CAU',
    title: 'Spicy Arrabiata Pasta',
    detail: 'Pasta with hot pepper',
  ),
  Foodmodel(
    img:
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRL7JomJwu0iCJ0qrn_9H24KIIBXzOjExaQCg&usqp=CAU',
    title: 'Graden Salad',
    detail: 'Salad with legumes and leafy green',
  ),
];
