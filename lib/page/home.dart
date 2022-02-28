// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers

import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../model/food_model.dart';
import '../model/foodmodel.api.dart';
import 'category.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Foodmodel> _foodModel = [];
  bool _isloading = true;
  @override
  void initState() {
    print("Init State");
    super.initState();
    getReciepes();
  }

  Future<void> getReciepes() async {
    print("Get reciepes Execute");
    _foodModel = await FoodModelApi.getModel();
    setState(() {
      _isloading = false;
    });
    print("Food Model");
  ;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isloading
          ? Center(child: CircularProgressIndicator())
          : Container(
              color: Color.fromARGB(255, 255, 255, 255),
              child: Center(
                child: CustomScrollView(
                  slivers: [
                    defualtAppBar(),
                    // fixedAppBar(),
                    buildHeader(),
                    buildMenu1()
                  ],
                ),
              ),
            ),
    );
  }

  SliverAppBar defualtAppBar() {
    return SliverAppBar(
      pinned: false,
      // expandedHeight: MediaQuery.of(context).size.height*0.35,
      flexibleSpace: FlexibleSpaceBar(
        title: AppBar(
          backgroundColor: Colors.transparent,
          systemOverlayStyle: SystemUiOverlayStyle.dark,
          elevation: 0,
          title: Text("HomePage"),
          centerTitle: true,
          leading: Icon(Icons.person),
        ),
      ),
    );
  }

  SliverToBoxAdapter buildHeader() {
    return SliverToBoxAdapter(
      child: Container(
        margin: EdgeInsets.fromLTRB(15, 50, 0, 0),
        child: Stack(
          // ignore: prefer_const_literals_to_create_immutables
          children: [
            Text(
              'Find the Best\nHealthy Food ',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Container(
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(20)),
              margin: EdgeInsets.fromLTRB(0, 50, 0, 0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search food here',
                  prefixIcon: (Icon(Icons.search)),
                  disabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(5, 100, 0, 0),
              child: Text(
                'Trending Food',
                style: TextStyle(fontSize: 30),
              ),
            )
          ],
        ),
      ),
    );
  }

  SliverToBoxAdapter buildMenu1() {
    return SliverToBoxAdapter(
      child: Container(
        height: 100,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: _foodModel.length,
          itemBuilder: (context, index) {
          
          return InkWell(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => Category(
                        index: index,
                        id: _foodModel[index].id,
                        title: _foodModel[index].title,
                        categoryPic: _foodModel[index].img,
                        time: foodModel[index].time,
                      )));
            },
            child: Hero(
              tag: _foodModel[index].id,
              child: Container(
                margin: EdgeInsets.fromLTRB(20, 20, 20, 10),
                alignment: Alignment.center,
                child: Stack(
                  children: [
                    Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.amber,
                        image: DecorationImage(
                          fit: BoxFit.contain,
                          image: NetworkImage(
                            _foodModel[index].img,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  SliverFixedExtentList buildMenu() {
    return SliverFixedExtentList(
      delegate: SliverChildBuilderDelegate((context, index) {
        return InkWell(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => Category(
                      index: index,
                      id: _foodModel[index].id,
                      title: _foodModel[index].title,
                      categoryPic: _foodModel[index].img,
                      time: foodModel[index].time,
                    )));
          },
          child: Hero(
            tag: _foodModel[index].id,
            child: Container(
              margin: EdgeInsets.fromLTRB(20, 20, 20, 10),
              alignment: Alignment.center,
              child: Stack(
                children: [
                  Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.amber,
                      image: DecorationImage(
                        fit: BoxFit.contain,
                        image: NetworkImage(
                          _foodModel[index].img,
                        ),
                      ),
                    ),
                  ),

                  // Container(
                  //   decoration: BoxDecoration(
                  //     borderRadius: BorderRadius.circular(20),
                  //     color: Color.fromARGB(230, 255, 255, 255),
                  //   ),
                  //   width: 300,
                  //   margin: EdgeInsets.fromLTRB(20, 150, 20, 15),
                  //   child: Container(
                  //     padding: EdgeInsets.fromLTRB(20, 20, 20, 15),
                  //     child: Stack(
                  //       children: [
                  //         Text(
                  //           _foodModel[index].title,
                  //           style: TextStyle(fontSize: 18),
                  //         ),

                  //       ],
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
        );
      }, childCount: _foodModel.length.compareTo(0  )),
      itemExtent: 100.0,
    );
  }
}
