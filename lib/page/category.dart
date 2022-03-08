// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, deprecated_member_use


import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';

import 'package:carousel_slider/carousel_slider.dart';

import '../controller/amount_controller.dart';
import '../model/food_ingre.dart';
import '../model/food_ingredient.api.dart';
import '../model/food_model.dart';
import '../model/nutrition.api.dart';
import '../model/nutrition_model.dart';
import 'main_page.dart';

// ignore: must_be_immutable
class Category extends StatefulWidget {
  int id;
  String title;
  String categoryPic;
  int time;
  Category({
    Key? key,
    required this.id,
    required this.title,
    required this.categoryPic,
    required this.time,
  }) : super(key: key);

  @override
  State<Category> createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  List<NutritionModel> _goodModel = [];
  List<FoodIngredient> _ingredient = [];
  bool _loading = true;
  @override
  void initState() {
    print("Init Category ");
    super.initState();
    getData();
    getIngredient();
  }

  Future<void> getData() async {
    _goodModel = await NutriModelApi.getGoodNutri(widget.id.toString());
    // _badModel = await NutriModelApi.getBadNutri(widget.id);
    // calories = await NutriModelApi.getCalories(widget.id);

    print("GoodModel$_goodModel");
  }

  Future<void> getIngredient() async {
    _ingredient = await FoodIngredientApi.getModel(widget.id.toString());
    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return _loading
        ? Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            color: Colors.white,
            child: Center(
              child: CircularProgressIndicator(),
            ))
        : Scaffold(
            
            body: SafeArea(
              child: CustomScrollView(
                slivers: [
                  // buildHead(context),
                  // buildCategoryPic(),
                  // aboutMeal(),
                  buildAppBar(),
                  buildTitle(),
                  buildRecipe(context),
                  // buildRecipeCard(context)
                  buildlButton()
                ],
              ),
            ),
            // bottomNavigationBar: buildBottom(context),
          );
  }

  SliverAppBar buildAppBar() {
    return SliverAppBar(
      snap: true,
      floating: true,
      backgroundColor: Color(0xFF200087),
      expandedHeight: 300,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(40))),
      flexibleSpace: FlexibleSpaceBar(
        background: ClipRRect(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(40)),
          child: Image.network(
            widget.categoryPic,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  SliverToBoxAdapter buildTitle() {
    return SliverToBoxAdapter(
        child: Container(
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.5,
                child: Text(
                  widget.title,
                  style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 18,
                      color: Colors.black),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text("${_goodModel[0].calories} kcal"),
                  Row(
                    children: [
                      Icon(Icons.access_time),
                      SizedBox(
                        width: 4,
                      ),
                      Text("${widget.time} mins")
                    ],
                  )
                ],
              )
            ],
          ),
          SizedBox(
            height: 14,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
            child: Text(
              "Ingredients",
              style: TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 18,
                  color: Colors.black),
            ),
          ),
          Container(
            height: 35.0,
            padding: EdgeInsets.fromLTRB(0, 0, 0, 8),
            child: ListView.builder(
                itemCount: _ingredient[0].ingredient.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Color.fromARGB(255, 99, 98, 98)),
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    margin: EdgeInsets.only(right: 20),
                    alignment: Alignment.center,
                    child: Text(
                      _ingredient[0].ingredient[index]["name"],
                      style: TextStyle(color: Colors.white),
                    ),
                  );
                }),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
            child: Text(
              "Nutritions",
              style: TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 18,
                  color: Colors.black),
            ),
          ),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: List.generate(10, ((index) {
              return Container(
                height: 40,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: Colors.green.withOpacity(0.7),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.green.withOpacity(0.5),
                          spreadRadius: 0.0,
                          blurRadius: 6.0,
                          offset: Offset(0, 2)),
                    ],
                    borderRadius: BorderRadius.circular(10)),
                child: Text(_goodModel[0].good[index]["title"]),
              );
            })),
          )
        ],
      ),
    ));
  }

  BottomNavigationBar buildBottom(BuildContext context) {
    return BottomNavigationBar(
      // currentIndex: currentIndex,
      items: [
        BottomNavigationBarItem(
            icon: IconButton(
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (_) => Homepage()));
              },
              icon: Icon(Icons.home),
            ),
            label: 'Home'),
        BottomNavigationBarItem(
            icon: IconButton(
              onPressed: () {},
              icon: Icon(Icons.person),
            ),
            label: 'Profile'),
      ],
    );
  }

  SliverToBoxAdapter buildHead(BuildContext context) {
    return SliverToBoxAdapter(
      child: Hero(
        tag: widget.id,
        child: Stack(
          children: [
            Container(
              margin: EdgeInsets.fromLTRB(20, 0, 0, 0),
              child: Text(
                widget.title,
                style: TextStyle(fontSize: 30),
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(20, 100, 0, 0),
              child: Row(
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  Icon(
                    Icons.watch_later_outlined,
                    color: Colors.black,
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    widget.time.toString(),
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  SliverToBoxAdapter buildCategoryPic() {
    return SliverToBoxAdapter(
      child: Container(
        color: Color.fromARGB(255, 255, 255, 255),
        height: 280,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: 1,
          itemBuilder: (context, index) {
            return Container(
              color: Color.fromARGB(255, 250, 249, 249),
              margin: EdgeInsets.fromLTRB(15, 20, 25, 3),
              width: 390,
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                    child: Image.network(
                      widget.categoryPic,
                      width: 390,
                      height: 250,
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  SliverToBoxAdapter aboutMeal() {
    return SliverToBoxAdapter(
      child: Column(
        children: [
          Container(
            alignment: Alignment.topLeft,
            margin: EdgeInsets.fromLTRB(25, 15, 0, 0),
            child: Text('Ingredient',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(25, 25, 25, 0),
            child: Column(children: [
              for (int i = 0; i < (_ingredient[0].ingredient.length); i++)
                Text("${_ingredient[0].ingredient[i]["name"]}"),
            ]),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(25, 25, 25, 0),
            child: Text(''),
          ),
          Container(
            alignment: Alignment.topLeft,
            margin: EdgeInsets.fromLTRB(25, 15, 0, 0),
            child: Text('Vitamin',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(25, 25, 25, 0),
            child: Column(children: [
              for (int i = 0; i <= 10; i++)
                Text(_goodModel[0].good[i]["title"]),
            ]),
          ),
          Container(
            alignment: Alignment.topLeft,
            margin: EdgeInsets.fromLTRB(25, 15, 0, 0),
            child: Text('Calories',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(25, 25, 25, 0),
            child: Text(_goodModel[0].calories),
          ),
          Container(
            alignment: Alignment.topLeft,
            margin: EdgeInsets.fromLTRB(25, 15, 0, 0),
          ),
          Container(
            alignment: Alignment.topLeft,
            margin: EdgeInsets.fromLTRB(25, 15, 0, 0),
            child: Text('Recipe',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
          ),
        ],
      ),
    );
  }

  SliverToBoxAdapter buildRecipe(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        height: 300,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: _ingredient[0].analyzedInstructions[0]["steps"].length,
          itemBuilder: (context, index) {
            return Container(
              // color: Color.fromARGB(255, 99, 98, 98),

              margin: EdgeInsets.fromLTRB(15, 20, 25, 3),
              width: MediaQuery.of(context).size.width * 0.9,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Color.fromARGB(255, 99, 98, 98),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Step ${index + 1} :",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 20),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "    ${_ingredient[0].analyzedInstructions[0]["steps"][index]["step"]}",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  SliverToBoxAdapter buildlButton() {
    var getController = Get.put(AmountController());
    return SliverToBoxAdapter(
      child: Container(
        margin: EdgeInsets.fromLTRB(60, 30, 60, 30),
        child: FloatingActionButton.extended(
          onPressed: () {
            var cal = _goodModel[0].calories;
            var pro = _goodModel[0].protein;
            cal = cal.substring(0, cal.indexOf("k"));
            pro = pro.substring(0, pro.indexOf("g"));
            getController.addCalories(int.parse(cal));
            getController.addProtein(int.parse(pro));
            Get.defaultDialog(
                title: "Reciepe has been added to daily progress.",
                middleText: "",
                titleStyle: TextStyle(fontWeight: FontWeight.bold));
            Navigator.pop(context);
                
            print("Get caloriess${getController.calories}");
            print("Get protein${getController.protein}");
          },
          backgroundColor: Colors.green,
          icon: Icon(Icons.add),
          label: Text("Add"),
        ),
      ),
    );
  }
}
