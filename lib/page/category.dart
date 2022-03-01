// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, deprecated_member_use

import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:soth_hak/model/nutrition.api.dart';
import 'package:soth_hak/model/nutrition_model.dart';

import '../model/food_model.dart';
import 'main_page.dart';

// ignore: must_be_immutable
class Category extends StatefulWidget {
  int id;
  int index;
  String title;
  String categoryPic;
  int time;
  Category(
      {Key? key,
      required this.id,
      required this.index,
      required this.title,
      required this.categoryPic,
      required this.time})
      : super(key: key);

  @override
  State<Category> createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  List<NutritionModel> _goodModel = [];

  bool _loading = true;
  @override
  void initState(){
    print("Init Category ");
    super.initState();
    getData();

  }
  Future<void> getData() async{
    print(widget.id.toString().runtimeType);
    _goodModel = await NutriModelApi.getGoodNutri(widget.id.toString());
    // _badModel = await NutriModelApi.getBadNutri(widget.id);
    // calories = await NutriModelApi.getCalories(widget.id);
    setState(() {
      _loading = false;
    });
    print(_goodModel);
  }
  @override
  Widget build(BuildContext context) {
    return _loading
          ? Center(child: CircularProgressIndicator())
          :Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
      ),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            buildHead(context),
            buildCategoryPic(),
            aboutMeal(),
            buildRecipe(),
          ],
        ),
      ),
      bottomNavigationBar: buildBottom(context),
    );
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
          // Container(
          //     margin: EdgeInsets.fromLTRB(25, 25, 25, 0),
          //     child: Column(
          //       children: [
          //     for ( int i = 0; i<=10;i++ )
          //       Text(_goodModel[0].good[i]["ingredient"]),                
          //       ]
          //     ),
          //   ),
          
          Container(
            margin: EdgeInsets.fromLTRB(25, 25, 25, 0),
            child: Text(
                ''),
          ),
          Container(
            alignment: Alignment.topLeft,
            margin: EdgeInsets.fromLTRB(25, 15, 0, 0),
            child: Text('Vitamin',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
          ),
          Container(
              margin: EdgeInsets.fromLTRB(25, 25, 25, 0),
              child: Column(
                children: [
              for ( int i = 0; i<=10;i++ )
                Text(_goodModel[0].good[i]["title"]),                
                ]
              ),
            ),
          Container(
            alignment: Alignment.topLeft,
            margin: EdgeInsets.fromLTRB(25, 15, 0, 0),
            child: Text('Calories',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(25, 25, 25, 0),
            child: Text(_goodModel[0].calories
                ),
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

  SliverToBoxAdapter buildRecipe() {
    return SliverToBoxAdapter(
      child: Container(
        height: 280,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: 2,
          itemBuilder: (context, index) {
            return Container(
              color: Color.fromARGB(255, 177, 78, 78),
              margin: EdgeInsets.fromLTRB(15, 20, 25, 3),
              width: 390,
              child: Stack(
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  Container(
                    margin: EdgeInsets.fromLTRB(12, 18, 0, 0),
                    child: Text(
                      'Step 1',
                      style: TextStyle(fontSize: 15, color: Colors.grey),
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
}
