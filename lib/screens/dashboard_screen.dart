import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_application/components/projects_card.dart';
import 'package:todo_application/components/todo_list.dart';
import 'package:todo_application/controllers/addtask_controller.dart';
import 'package:todo_application/controllers/signup_controller.dart';
import 'package:todo_application/screens/task_details_screen.dart';

class DashboardScreen extends StatelessWidget {
  final SignupController _signupController = Get.put(SignupController());
  final AddtaskController _addtaskController = Get.put(AddtaskController());
  DashboardScreen({super.key});
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
        leading: Icon(Icons.menu),
        actions: [Icon(Icons.person_2_rounded)],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Hi, ${_signupController.signInUser.value}',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  SizedBox(
                    width: 300,
                    child: TextField(
                      onChanged: (value) {},
                      //controller: textInput,
                      decoration: InputDecoration(
                        hintText: 'Search for task',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        contentPadding: EdgeInsets.symmetric(horizontal: 16),
                      ),
                    ),
                  ),
                  SizedBox(width: 20),
                  Icon(Icons.filter_list, color: Color(0xFF7D5BE4), size: 35),
                ],
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Text(
                    'In Progress',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  Spacer(),
                  GestureDetector(
                    child: Text(
                      'See all',
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
                scrollDirection: Axis.horizontal,
                child: Obx(
                  () => Row(
                    children: List.generate(
                      _addtaskController.fetchedtasks.length,
                      (index) {
                        return GestureDetector(
                          onTap: () {
                            Get.to(
                              () => TaskDetailsScreen(
                                projectTitle: _addtaskController
                                    .fetchedtasks[index]
                                    .taskTitle,
                                projectDescription: _addtaskController
                                    .fetchedtasks[index]
                                    .taskDescription,
                                deadLine: _addtaskController
                                    .fetchedtasks[index]
                                    .endTime,
                                projectId:
                                    _addtaskController.fetchedtasks[index].id,
                              ),
                            );
                          },
                          child: ProjectsCard(
                            projectColor: _colors[Random().nextInt(_colors.length)],
                            projectTitle: _addtaskController
                                .fetchedtasks[index]
                                .taskTitle,
                            projectDescription: _addtaskController
                                .fetchedtasks[index]
                                .taskDescription,
                            deadLine:
                                _addtaskController.fetchedtasks[index].endTime,
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Text(
                    'Todo List',
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
                    children: List.generate(
                      _addtaskController.fetchedtasks.length,
                      (index) {
                        return TodoList(
                          projectTitle:
                              _addtaskController.fetchedtasks[index].taskTitle,
                          projectColor: _colors[Random().nextInt(_colors.length)],
                          projectDescription: _addtaskController
                              .fetchedtasks[index]
                              .taskDescription,
                          icons: icons[Random().nextInt(icons.length)],
                        );
                      },
                    ),
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
