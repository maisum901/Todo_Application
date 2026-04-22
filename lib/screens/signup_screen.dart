import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_application/controllers/addtask_controller.dart';
import 'package:todo_application/controllers/signup_controller.dart';

class SignupScreen extends StatelessWidget {
  final SignupController _signupController = Get.put(SignupController());
  final AddtaskController addController = Get.put(AddtaskController());
  SignupScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 100),
                Image.asset(
                  'assets/images/landing.jpg',
                  height: 400,
                  width: 400,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Taksdo',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF7D5BE4),
                        fontSize: 30,
                      ),
                    ),
                    Icon(Icons.check_box_sharp, color: Color(0xFF7D5BE4)),
                  ],
                ),
                SizedBox(height: 20),
                Text(
                  'Plan what you will do to be more oranized for today, tomorrow and beyond',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
                SizedBox(height: 20),
                TextField(
                  onChanged: (value) {
                    _signupController.userName.value = value;
                  },
                  //controller: textInput,
                  decoration: InputDecoration(
                    hintText: 'Enter your Name',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    contentPadding: EdgeInsets.symmetric(horizontal: 16),
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF7D5BE4),
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    minimumSize: Size(350, 60),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  onPressed: () {
                    _signupController.saveUser();
                  },
                  child: Text('Sign Up', style: TextStyle(color: Colors.white)),
                ),
                SizedBox(height: 20),
                TextField(
                  onChanged: (value) {
                    _signupController.signInUser.value = value;
                  },
                  //controller: textInput,
                  decoration: InputDecoration(
                    hintText: 'Enter your Name',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    contentPadding: EdgeInsets.symmetric(horizontal: 16),
                  ),
                ),
                
                SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF7D5BE4),
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    minimumSize: Size(350, 60),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  onPressed: () {
                    addController.refreshItems();
                    _signupController.loginUser();
                  },
                  child: Text('Sign In', style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
