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
    print("Food Model$_foodModel");
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
                    // defualtAppBar(),
                    buildHeader(),
                    container("TrendingFood"),

                    buildMenu1(),
                    container("Meals For Today")
                  ],
                ),
              ),
            ),
    );
  }

  SliverToBoxAdapter container(String title) {
    return SliverToBoxAdapter(
      child: Container(
        padding: EdgeInsets.fromLTRB(18, 8, 12, 8),
        // margin: EdgeInsets.fromLTRB(5, 20, 0, 0),
        child: Text(
          title,
          style: TextStyle(
              color: Colors.blueGrey,
              fontSize: 16,
              fontWeight: FontWeight.w700,
              letterSpacing: 1.1),
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
        margin: EdgeInsets.fromLTRB(15, 15, 0, 0),
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
          ],
        ),
      ),
    );
  }

  SliverToBoxAdapter buildMenu1() {
    return SliverToBoxAdapter(
      child: Container(
        height: 250,
        margin: EdgeInsets.fromLTRB(30, 0, 30, 0),
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: _foodModel.length,
            itemBuilder: (context, index) {
              return Row(children: [
                InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => Category(
                              index: index,
                              id: _foodModel[index].id,
                              title: _foodModel[index].title,
                              categoryPic: _foodModel[index].img,
                              time: _foodModel[index].time,
                            )));
                  },
                  child: Hero(
                    tag: _foodModel[index].id,
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
                                child: Image.network(_foodModel[index].img,
                                    width: 145, fit: BoxFit.cover)),
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
                                    _foodModel[index].title.toString(),
                                    maxLines: 2,
                                    style: TextStyle(
                                        color: Colors.black87,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700,
                                        letterSpacing: 1.1),
                                  )),
                                ),
                                Row(children: const [
                                  Text(
                                    "Calories: ",
                                    style: TextStyle(
                                        color: Colors.black38,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        letterSpacing: 1.1),
                                  ),
                                  Text(
                                    "512 Kcal",
                                    style: TextStyle(
                                        color: Colors.black38,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        letterSpacing: 1.1),
                                  ),
                                ])
                                ,
                                Row(
                                  children: [
                                    Icon(Icons.lock_clock),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      "${_foodModel[index].time.toString()} min",
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

  // SliverFixedExtentList buildMenu() {
  //   return SliverFixedExtentList(
  //     delegate: SliverChildBuilderDelegate((context, index) {
  //       return InkWell(
  //         onTap: () {
  //           Navigator.of(context).push(MaterialPageRoute(
  //               builder: (context) => Category(
  //                     index: index,
  //                     id: _foodModel[index].id,
  //                     title: _foodModel[index].title,
  //                     categoryPic: _foodModel[index].img,
  //                     time: foodModel[index].time,
  //                   )));
  //         },
  //         child: Hero(
  //           tag: _foodModel[index].id,
  //           child: Container(
  //             margin: EdgeInsets.fromLTRB(20, 20, 20, 10),
  //             alignment: Alignment.center,
  //             child: Stack(
  //               children: [
  //                 Container(
  //                   height: 300,
  //                   width: 100,
  //                   decoration: BoxDecoration(
  //                     borderRadius: BorderRadius.circular(20),
  //                     color: Colors.amber,
  //                     image: DecorationImage(
  //                       fit: BoxFit.contain,
  //                       image: NetworkImage(
  //                         _foodModel[index].img,
  //                       ),
  //                     ),
  //                   ),
  //                 ),

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
//                 ],
//               ),
//             ),
//           ),
//         );
//       }, childCount: _foodModel.length.compareTo(0)),
//       itemExtent: 100.0,
//     );
//   }
}
