// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:soth_hak/model/category_img.dart';
import 'package:soth_hak/page/main_page.dart';

class Category extends StatelessWidget {
  const Category({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            buildHead(context),
            buildCategoryPic(),
          ],
        ),
      ),
      bottomNavigationBar: buildBottom(context),
    );
  }
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
    // onTap: (index) {
    //   setState(() {
    //     currentIndex = index;
    //   });
    // },
  );
}

SliverToBoxAdapter buildHead(BuildContext context) {
  return SliverToBoxAdapter(
    child: Stack(
      children: [
        IconButton(
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (_) => Homepage()));
          },
          icon: Icon(Icons.arrow_back),
        ),
        Container(
          margin: EdgeInsets.fromLTRB(20, 50, 0, 0),
          child: Text(
            'Spicy Arrabiata Pasta',
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
                '30 - 40 min',
                style: TextStyle(color: Colors.grey),
              ),
            ],
          ),
        ),
      ],
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
        itemCount: catePic.length,
        itemBuilder: (context, index) {
          return Container(
            color: Color.fromARGB(255, 250, 249, 249),
            margin: EdgeInsets.fromLTRB(15, 20, 25, 3),
            width: 390,
            child: Column(
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                  child: Image.network(
                    catePic[index].img,
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
