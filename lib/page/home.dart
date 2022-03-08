// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_countdown_timer/countdown_timer_controller.dart';
import 'package:intl/intl.dart';

import 'package:get/get.dart';

import '../controller/amount_controller.dart';
import '../model/food_model.dart';
import '../model/foodmodel.api.dart';
import '../model/meals_today.dart';
import '../model/meals_today_api.dart';
import '../widget/custom_progress.dart';
import 'category.dart';

class Home extends StatefulWidget {
  
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  
  List<Foodmodel> foodModel = [];
  List<Foodmodel> temp = [];

  List<TodaysMealModel> _mealsPlanModel = [];
  List<Foodmodel> _searchResult = [];
  bool _isloading = true;
  var getController = Get.put(AmountController());
  var proteinAmount; 
  var calAmount;
  
  @override
  void initState() {
    super.initState();
    getReciepes();
    generateMealsPlan();
    
  }
   

  Future<void> getReciepes() async {
    print("Get reciepes Execute");
    temp = await FoodModelApi.getModel();
    foodModel.addAll(temp);
    setState(() {
      _isloading = false;
    });
  }

  Future<void> generateMealsPlan() async {
    _mealsPlanModel = await MealsTodayApi.getModel();
    setState(() {
      _isloading = false;
    });
  }

  Future<void> update() async{
    print("update execute");
    proteinAmount = getController.protein;
    calAmount = getController.calories;
    print(proteinAmount);
    print(calAmount);
  }

  @override
  Widget build(BuildContext context) {
    proteinAmount = getController.protein.toString();
    calAmount = getController.calories.toString();
    TimeOfDay releaseTime = TimeOfDay(hour: 15, minute: 0);
    final now = DateTime.now();

    return Scaffold(
      body: _isloading
          ? Center(child: CircularProgressIndicator())
          : RefreshIndicator(
            onRefresh: () async{
              update();
            },
            child: Container(
                color: Color.fromARGB(255, 255, 255, 255),
                child: Center(
                  child: CustomScrollView(
                    slivers: [
                      // defualtAppBar(),
                      buildHeader(context, calAmount, proteinAmount),
                      container("Meals For Today"),
          
                      buildMenu1(),
                      container("Random Healthy Reciepes"),
          
                      buildMenu(context),
                      seeMoreButton()
                    ],
                  ),
                ),
              ),
          ),
    );
  }
  SliverToBoxAdapter seeMoreButton(){
    return SliverToBoxAdapter(
      child: TextButton(
        child: Text("See More"),
        onPressed: (){
          _isloading = true;
          getReciepes();
          _isloading = false;
        },

      )
    );

  }
  SliverToBoxAdapter container(String title) {
    return SliverToBoxAdapter(
      child: Container(
        padding: EdgeInsets.fromLTRB(18, 8, 12, 8),
        child: Text(
          title,
          style: TextStyle(
              color: Colors.blueGrey,
              fontSize: 18,
              fontWeight: FontWeight.w700,
              letterSpacing: 1.1),
        ),
      ),
    );
  }

  // SliverAppBar defualtAppBar() {
  //   return SliverAppBar(
  //     pinned: false,
  //     flexibleSpace: FlexibleSpaceBar(
  //       title: AppBar(
  //         backgroundColor: Colors.transparent,
  //         systemOverlayStyle: SystemUiOverlayStyle.dark,
  //         elevation: 0,
  //         title: Text("HomePage"),
  //         centerTitle: true,
  //         leading: Icon(Icons.person),
  //       ),
  //     ),
  //   );
  // }

  SliverToBoxAdapter buildHeader(
    BuildContext context, String calAmount, String porteinAmount) {
    var controller = TextEditingController();
    final today = DateTime.now();
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    print(calAmount);
    print(porteinAmount);
    return SliverToBoxAdapter(
      child: Container(
        margin: EdgeInsets.fromLTRB(15, 30, 0, 0),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(
                  bottom: const Radius.circular(40)),
              child: Container(
                color: Colors.white,
                padding: const EdgeInsets.only(
                    top: 40, left: 16, right: 16, bottom: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    ListTile(
                      title: Text(
                        DateFormat("EEEE").format(today) +
                            DateFormat("d MMMM").format(today),
                        style: TextStyle(
                            fontWeight: FontWeight.w400, fontSize: 25),
                      ),
                      subtitle: Text(
                        "Welcome User",
                        style: TextStyle(
                            fontWeight: FontWeight.w800,
                            fontSize: 26,
                            color: Colors.black),
                      ),
                      trailing: ClipOval(
                        child: Image.network(
                            "https://cdn2.vectorstock.com/i/1000x1000/20/76/man-avatar-profile-vector-21372076.jpg"),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        RadialProgressCalories(
                          height: width * 0.1,
                          width: width * 0.05,
                          color: Color.fromARGB(255, 75, 15, 121),
                          amount: int.parse(calAmount),
                          text: "kcal",
                          divider: 2000,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        RadialProgressProtein(
                          height: width * 0.1,
                          width: width * 0.05,
                          color: Color.fromARGB(255, 18, 18, 125),
                          amount: int.parse(porteinAmount),
                          text: "grams",
                          divider: 56,
                        ),
                      ],
                    ),
                    
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  SliverToBoxAdapter buildMenu1() {
    List dishTime = ["BreakFast", "Lunch", "Dinner"];
    return SliverToBoxAdapter(
      child: Container(
        height: 250,
        margin: EdgeInsets.fromLTRB(30, 10, 30, 15),
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: _mealsPlanModel.length,
            itemBuilder: (context, index) {
              return Row(children: [
                InkWell(
                  onTap: () async{
                    Navigator.of(context).push(MaterialPageRoute(
                       builder: (context) =>Category(
                              id: _mealsPlanModel[index].id,
                              title: _mealsPlanModel[index].title,
                              categoryPic:
                                  "https://spoonacular.com/recipeImages/${_mealsPlanModel[index].id}-556x370.jpg",
                              time: _mealsPlanModel[index].time,
                            )));
                  },
                  child: Hero(
                    tag: _mealsPlanModel[index].id,
                    child: Material(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      elevation: 4,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Flexible(
                            fit: FlexFit.tight,
                            child: ClipRRect(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                                child: Image.network(
                                    "https://spoonacular.com/recipeImages/${_mealsPlanModel[index].id}-556x370.jpg",
                                    width: 145,
                                    fit: BoxFit.cover)),
                          ),
                          Flexible(
                            fit: FlexFit.tight,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                SizedBox(
                                  width: 120,
                                  child: (Text(
                                    _mealsPlanModel[index].title.toString(),
                                    maxLines: 2,
                                    style: TextStyle(
                                        color: Colors.black87,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700,
                                        letterSpacing: 1.1),
                                  )),
                                ),
                                Row(children: [
                                  SizedBox(
                                    width: 4,
                                  ),
                                  Text(
                                    "DishTypes: ",
                                    style: TextStyle(
                                        color: Colors.black38,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        letterSpacing: 1),
                                  ),
                                  Text(
                                    dishTime[index],
                                    style: TextStyle(
                                        color: Colors.black38,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        letterSpacing: 1),
                                  ),
                                  SizedBox(
                                    width: 4,
                                  ),
                                ]),
                                Row(
                                  children: [
                                    Icon(Icons.lock_clock),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      "${_mealsPlanModel[index].time.toString()} min",
                                      style: TextStyle(
                                          color: Colors.black54,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          letterSpacing: 1.1),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 15,
                )
              ]);
            }),
      ),
    );
  }

  SliverFixedExtentList buildMenu(BuildContext context) {
    return SliverFixedExtentList(
      delegate: SliverChildBuilderDelegate((context, index) {
        return InkWell(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => Category(
                      id: foodModel[index].id,
                      title: foodModel[index].title,
                      categoryPic: foodModel[index].img,
                      time: foodModel[index].time,
                    )));
          },
          child: Hero(
            tag: foodModel[index].id,
            child: Container(
              margin: EdgeInsets.fromLTRB(20, 20, 20, 10),
              alignment: Alignment.center,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.grey,
                      image: DecorationImage(
                        fit: BoxFit.fill,
                        image: NetworkImage(
                          "https://spoonacular.com/recipeImages/${foodModel[index].id}-556x370.jpg",
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius:
                              const BorderRadius.all(const Radius.circular(40)),
                          child: Container(
                            decoration: BoxDecoration(color: Colors.black),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.schedule,
                                  color: Colors.yellow,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  "${foodModel[index].time} min",
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.white),
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Color.fromARGB(149, 81, 78, 78),
                    ),
                    margin: EdgeInsets.fromLTRB(20, 150, 20, 15),
                    child: Container(
                      padding: EdgeInsets.fromLTRB(20, 20, 20, 15),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          foodModel[index].title,
                          style: TextStyle(fontSize: 18, color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }, childCount: foodModel.length),
      itemExtent: 290.0,
    );
  }
}
