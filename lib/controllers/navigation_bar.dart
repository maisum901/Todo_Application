import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:todo_application/screens/completedtasks_screen.dart';
import 'package:todo_application/screens/dashboard_screen.dart';
import 'package:todo_application/screens/schedule_screen.dart';

class NavigationController extends GetxController {
  RxInt currentIndex = 0.obs;

  // Screens list
  final screens = [
    Center(child: DashboardScreen()),
    Center(child: ScheduleScreen()),
    Center(child: CompletedtasksScreen()),
    Center(child: Text("Profile Screen")),
  ];

  void changeIndex(int index) {
    currentIndex.value = index;
  }
}