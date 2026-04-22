import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:todo_application/controllers/addtask_controller.dart';


class TaskDetailsScreen extends StatelessWidget {
  final int projectId;
  final String projectTitle;
  final String projectDescription;
  final DateTime deadLine;
  TaskDetailsScreen({
    super.key,
    required this.projectTitle,
    required this.projectDescription,
    required this.deadLine, required this.projectId,
  });
  final AddtaskController _addTaskController = Get.put(AddtaskController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(),
        title: Text(
          'Task Details',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [GestureDetector(
          onTap: (){
            _addTaskController.markCompleted(projectId, projectTitle, projectDescription, deadLine);
          },
          child: Icon(Icons.check_box)),
         GestureDetector(
          onTap: (){
            _addTaskController.deleteTaskFunction(projectId);
            Get.back();},
          child: Icon(Icons.delete))
          ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              projectTitle,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text(
              'Description',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Text(projectDescription),
            SizedBox(height: 20),
            Text(
              'DeadLine',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Text(
              DateFormat('dd/MM/yyyy  hh:mm:aa').format(deadLine),
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
