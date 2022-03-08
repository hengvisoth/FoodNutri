import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/countdown_timer_controller.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:get/get.dart';

class AmountController extends GetxController {
  var protein = 0.obs;
  var calories = 0.obs;
  
  void addProtein(amount){
    protein += amount;
  }
  void addCalories(amount){
    calories += amount;
  }
  void resetAmount(){
    protein = 0.obs;
    calories = 0.obs;
  }
  
}