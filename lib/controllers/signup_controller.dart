import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/state_manager.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_application/screens/home_screen.dart';

class SignupController extends GetxController {
  var taskBox = Hive.box('task_box');
  RxList<String> savedUsers = [''].obs;
  RxString userName = ''.obs;
  RxString signInUser = ''.obs;

  void saveUser() {
    List users = taskBox.get('Users', defaultValue: []);
    if (users.contains(userName.value)) {
      print('user Already');
      Get.snackbar('Already', 'User Already Exists');
    } else {
      users.add(userName.value);
      taskBox.put('Users', users);
      Get.snackbar('Successful', 'User Added Successfully');
      print('User added');
    }
  }

  void loginUser() {
    List users = taskBox.get('Users', defaultValue: []);
    if (users.contains(signInUser.value)) {
      Get.to(() => HomeScreen());
    } else {
      Get.snackbar('Allert', 'Add User First');
    }
  }
}
