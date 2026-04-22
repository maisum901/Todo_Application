import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_application/components/addtask_function.dart';
import 'package:todo_application/controllers/navigation_bar.dart';

class HomeScreen extends StatelessWidget {
  final controller = Get.put(NavigationController());


  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      body: Obx(() => controller.screens[controller.currentIndex.value]),

      floatingActionButton: FloatingActionButton(
        shape: CircleBorder(),
        onPressed: () => addTaskFunction(context),
        backgroundColor: Color(0xFF7D5BE4),
        child: Icon(Icons.add, color: Colors.white),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: Obx(
        () => BottomAppBar(
          color: Colors.white,
          shape: CircularNotchedRectangle(),
          notchMargin: 8,
          child: Container(
            height: 65,
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // LEFT
                Row(
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.home_filled,
                        color: controller.currentIndex.value == 0
                            ? Color(0xFF7D5BE4)
                            : Colors.grey,
                      ),
                      onPressed: () => controller.changeIndex(0),
                    ),
                    SizedBox(width: 20),
                    IconButton(
                      icon: Icon(
                        Icons.schedule,
                        color: controller.currentIndex.value == 1
                            ? Color(0xFF7D5BE4)
                            : Colors.grey,
                      ),
                      onPressed: () => controller.changeIndex(1),
                    ),
                  ],
                ),

                // RIGHT
                Row(
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.folder,
                        color: controller.currentIndex.value == 2
                            ? Color(0xFF7D5BE4)
                            : Colors.grey,
                      ),
                      onPressed: () => controller.changeIndex(2),
                    ),
                    SizedBox(width: 20),
                    IconButton(
                      icon: Icon(
                        Icons.person,
                        color: controller.currentIndex.value == 3
                            ? Color(0xFF7D5BE4)
                            : Colors.grey,
                      ),
                      onPressed: () => controller.changeIndex(3),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
