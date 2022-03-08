// ignore_for_file: prefer_const_constructors, prefer_void_to_null

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';


import '../controller/amount_controller.dart';
import '../controller/navigationController.dart';
import 'home.dart';
import 'search.dart';



void resetTime(){
    final AmountController amtController = Get.put(AmountController());
    amtController.calories =0.obs;
    amtController.protein=0.obs;
}
class Homepage extends StatelessWidget {
  var protein ;
  final timer = Timer.periodic( const Duration(hours: 24), (timer){
      resetTime();
    });
  BottomNavigationController bottomNavigationController =
  Get.put(BottomNavigationController());
  
  final screens = [Home(), Search()];
  int currentIndex = 0;


  @override
  
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => IndexedStack(
            index: bottomNavigationController.selectedIndex.value,
            children: screens,
          )),
      bottomNavigationBar: Obx(() => buildBottom(context)),
    );
  }

  BottomNavigationBar buildBottom(BuildContext context) {
    return BottomNavigationBar(
      selectedItemColor: (Color.fromARGB(255, 0, 0, 0)),
      unselectedItemColor: (Color.fromARGB(255, 169, 163, 163)),
      currentIndex: bottomNavigationController.selectedIndex.value,
      items: [
        BottomNavigationBarItem(
            icon: IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.home,
              ),
            ),
            label: 'Home'),
        BottomNavigationBarItem(

            icon: IconButton(
              onPressed: () {},
              icon: Icon(Icons.search,),
            ),
            label: 'Explore'),
      ],
      onTap: (index) {
        bottomNavigationController.changeIndex(index);
      },
    );
  }
}

// class Homepage extends StatefulWidget {
//   const Homepage({Key? key}) : super(key: key);

//   @override
//   State<Homepage> createState() => _HomepageState();
// }

// class _HomepageState extends State<Homepage> {
//   final screens = [Home(), Search()];
//   int currentIndex = 0;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: screens[currentIndex],
//       bottomNavigationBar: buildBottom(context),
//     );
//   }

//   BottomNavigationBar buildBottom(BuildContext context) {
//     return BottomNavigationBar(
//       currentIndex: currentIndex,
//       items: [
//         BottomNavigationBarItem(
//             icon: IconButton(
//               onPressed: () {},
//               icon: Icon(
//                 Icons.home,
//                 color: Colors.black,
//               ),
//             ),
//             label: 'Home'),
//         BottomNavigationBarItem(
//             icon: IconButton(
//               onPressed: () {},
//               icon: Icon(Icons.search),
//             ),
//             label: 'Explore'),
//       ],
//       onTap: (index) {
//         setState(() {
//           currentIndex = index;
//         });
//       },
//     );
//   }
// }
