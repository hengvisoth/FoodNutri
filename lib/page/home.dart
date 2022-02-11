// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:soth_hak/model/food_model.dart';
import 'package:soth_hak/page/category.dart';
import 'package:soth_hak/page/login.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color.fromARGB(255, 255, 255, 255),
        child: Center(
          child: CustomScrollView(
            slivers: [
              buildHeader(),
              buildMenu(),
            ],
          ),
        ),
      ),
    );
  }
}

SliverToBoxAdapter buildHeader() {
  return SliverToBoxAdapter(
    child: Container(
      margin: EdgeInsets.fromLTRB(15, 50, 0, 0),
      child: Stack(
        // ignore: prefer_const_literals_to_create_immutables
        children: [
          Text(
            'Good afternoon',
            style: TextStyle(fontSize: 40),
          ),
          Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
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
            margin: EdgeInsets.fromLTRB(5, 90, 0, 0),
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

SliverFixedExtentList buildMenu() {
  return SliverFixedExtentList(
    delegate: SliverChildBuilderDelegate((context, index) {
      return InkWell(
        onTap: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => Category()));
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.amber,
            image: DecorationImage(
              fit: BoxFit.cover,
              image: NetworkImage(
                foodModel[index].img,
              ),
            ),
          ),
          margin: EdgeInsets.fromLTRB(20, 5, 20, 10),
          alignment: Alignment.center,
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Color.fromARGB(230, 255, 255, 255),
                ),
                // height: 180,
                width: 300,
                margin: EdgeInsets.fromLTRB(20, 160, 20, 15),
                child: Container(
                  padding: EdgeInsets.fromLTRB(20, 20, 20, 15),
                  // decoration: BoxDecoration(shape: RoundedRectangleBorder()),
                  child: Stack(
                    children: [
                      Text(
                        foodModel[index].title,
                        style: TextStyle(fontSize: 20),
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(1, 30, 20, 15),
                        child: Text(
                          foodModel[index].detail,
                          style: TextStyle(
                              color: Color.fromARGB(255, 136, 117, 117)),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }, childCount: foodModel.length),
    itemExtent: 290.0,
  );
}
// Image.network(
//               'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSkpHCGUepyja_eF2w1T-F40NtrU_XGTtznIw&usqp=CAU',
//               fit: BoxFit.cover,
//               width: 340,
//               height: 280,
//             ),
