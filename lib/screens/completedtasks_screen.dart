import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_application/components/todo_list.dart';
import 'package:todo_application/controllers/addtask_controller.dart';

class CompletedtasksScreen extends StatelessWidget {
  final _addtaskController = Get.put(AddtaskController());
  CompletedtasksScreen({super.key});

  final List<int> _colors = [0xFF5898E2, 0xFFEB8389, 0xFF82E89E, 0xFFAD79EE];
  final List<IconData> icons = [
      Icons.pending,
      Icons.network_cell,
      Icons.access_alarms,
      Icons.ac_unit_sharp,
      Icons.work,
      Icons.account_balance_sharp,
    ];

  @override
  Widget build(BuildContext context) { 
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5FA),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF5F5FA),
        leading: GestureDetector(
          onTap: () => Get.back(),
          child: Container(
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: const Color(0xFF7B4FD6),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.chevron_left, color: Colors.white),
          ),
        ),
        title: Text('Completed Tasks', style: TextStyle(fontWeight: FontWeight.bold),),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    'Completed Tasks',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  Spacer(),
                  GestureDetector(
                    child: Text(
                      'View all',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF7D5BE4),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Obx(
                  () => Column(
                    children: List.generate(_addtaskController.completedTasksFetched.length, (
                      index,
                    ) {
                      return TodoList(
                        projectTitle: _addtaskController.completedTasksFetched[index].taskTitle,
                        projectColor: _colors[Random().nextInt(_colors.length)],
                        projectDescription: _addtaskController.completedTasksFetched[index].taskDescription,
                        icons: icons[Random().nextInt(icons.length)],
                      );
                    }),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}