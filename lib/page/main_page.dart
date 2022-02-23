// ignore_for_file: prefer_const_constructors, prefer_void_to_null

import 'package:flutter/material.dart';
import 'package:soth_hak/page/category.dart';
import 'package:soth_hak/page/home.dart';
import 'package:soth_hak/page/profile.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final screens = [
    Home(),
    ProfileWidget()

  ];
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[currentIndex],
      bottomNavigationBar: buildBottom(context),
    );
  }

  BottomNavigationBar buildBottom(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      items: [
        BottomNavigationBarItem(
            icon: IconButton(
              onPressed: () {},
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
      onTap: (index) {
        setState(() {
          currentIndex = index;
        });
      },
    );
  }
}
