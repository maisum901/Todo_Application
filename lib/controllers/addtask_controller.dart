import 'dart:async';

import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_application/components/show_notification.dart';
import 'package:todo_application/controllers/signup_controller.dart';
import 'package:todo_application/models/task_model.dart';

class AddtaskController extends GetxController {
  final SignupController _signupController = Get.find();
  Timer? time;
  var taskBox = Hive.box('task_box');
  RxList<TaskModel> fetchedtasks = <TaskModel>[].obs;
  RxList<TaskModel> completedTasksFetched = <TaskModel>[].obs;

  RxString taskTitle = ''.obs;
  RxString taskDescription = ''.obs;
  Rx<DateTime> endTime = DateTime.now().obs;
  RxBool isCompleted = false.obs;
  @override
  void onInit() {
    super.onInit();
    
    autoCompleteTask();
    time = Timer.periodic(Duration(seconds: 30), (timer) {
      autoCompleteTask();
      refreshItems();
    });
    refreshItems();
  }

  @override
  void onClose() {
    time?.cancel(); 
    super.onClose();
  }

  void refreshItems() {
    Map userData = taskBox.get(
      _signupController.signInUser.value,
      defaultValue: {},
    );
    List pendingtasks = userData['pending_tasks'] ?? [];
    List completedtasks = userData['completed_tasks'] ?? [];
    fetchedtasks.value = pendingtasks
        .map(
          (task) => TaskModel(
            id: task['id'],
            taskTitle: task['taskTitle'],
            taskDescription: task['taskDescription'],
            endTime: DateTime.parse(task['deadLine']),
          ),
        )
        .toList();
    completedTasksFetched.value = completedtasks
        .map(
          (task) => TaskModel(
            id: task['id'],
            taskTitle: task['taskTitle'],
            taskDescription: task['taskDescription'],
            endTime: DateTime.parse(task['deadLine']),
          ),
        )
        .toList();
    print('hi from refresh items');
  }

  void addTask() async {
    int taskId = DateTime.now().millisecondsSinceEpoch;
    Map userData = taskBox.get(
      _signupController.signInUser.value,
      defaultValue: {},
    );
    List tasks = userData['pending_tasks'] ?? [];
    tasks.add({
      'id': taskId,
      'taskTitle': taskTitle.value,
      'taskDescription': taskDescription.value,
      'deadLine': endTime.value.toString(),
    });
    userData['pending_tasks'] = tasks;

    taskBox.put(_signupController.signInUser.value, userData);
    if (tasks.isNotEmpty) {
      fetchedtasks.value = tasks
          .map(
            (task) => TaskModel(
              id: task['id'],
              taskTitle: task['taskTitle'],
              taskDescription: task['taskDescription'],
              endTime: DateTime.parse(task['deadLine']),
            ),
          )
          .toList();
    } else {
      print('No Tasks');
    }
  }

  void markCompleted(
    int id,
    String taskTitle,
    String taskDescription,
    DateTime endTime,
  ) async {
    Map userData = taskBox.get(
      _signupController.signInUser.value,
      defaultValue: {},
    );
    List completedTasks = userData['completed_tasks'] ?? [];
    bool alreadyExists = completedTasks.any((task) => task['id'] == id);
    if (!alreadyExists) {
      completedTasks.add({
        'id': id,
        'taskTitle': taskTitle,
        'taskDescription': taskDescription,
        'deadLine': endTime.toString(),
      });
      userData['completed_tasks'] = completedTasks;

      taskBox.put(_signupController.signInUser.value, userData);
    } else {
      Get.snackbar('Allert', 'Already Added to completed Tasks');
    }
    // taskBox.put(_signupController.signInUser.value, {
    //   'completed_tasks': completedTasks,
    // });
    if (completedTasks.isNotEmpty) {
      completedTasksFetched.value = completedTasks
          .map(
            (task) => TaskModel(
              id: task['id'],
              taskTitle: task['taskTitle'],
              taskDescription: task['taskDescription'],
              endTime: DateTime.parse(task['deadLine']),
            ),
          )
          .toList();
    } else {
      print('No Tasks');
    }
    deleteTaskFunction(id);
    print('Task marked as completed');
  }

  void deleteTaskFunction(int id) async {
    Map userData = taskBox.get(
      _signupController.signInUser.value,
      defaultValue: {},
    );
    List tasks = userData['pending_tasks'] ?? [];
    tasks.removeWhere((task) => task['id'] == id);
    userData['pending_tasks'] = tasks;
    taskBox.put(_signupController.signInUser.value, userData);
    fetchedtasks.removeWhere((task) => task.id == id);
    print('Object Deleted');
  }

 void autoCompleteTask() {
  print('🔄 autoCompleteTask called, tasks count: ${fetchedtasks.length}');
  final expiredTasks = fetchedtasks
      .where((task) => task.endTime.isBefore(DateTime.now()))
      .toList();

  print('⏰ Expired tasks found: ${expiredTasks.length}');
  for (var task in expiredTasks) {
    bool alreadyCompleted = completedTasksFetched
        .any((t) => t.id == task.id);
  print('Task: ${task.taskTitle}, alreadyCompleted: $alreadyCompleted');
    if (!alreadyCompleted) {
      markCompleted(
        task.id,
        task.taskTitle,
        task.taskDescription,
        task.endTime,
      );

      showNotification(task.taskTitle); // fixed

    }
  }
}
}
