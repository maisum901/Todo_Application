import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:todo_application/controllers/addtask_controller.dart';

void addTaskFunction(BuildContext context) {
  final _addTaskController = Get.find<AddtaskController>();

  Future<void> _selectDate() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2027),
    );
    if (pickedDate != null) {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay(hour: 9, minute: 0),
      );
      if (pickedTime != null) {
        _addTaskController.endTime.value = DateTime(
          pickedDate.year,
          pickedDate.month,
          pickedDate.day,
          pickedTime.hour,
          pickedTime.minute,
        );
      }
    }
  }

  Get.bottomSheet(
    Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Enter Task Details",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          TextField(
            onChanged: (value) {
              _addTaskController.taskTitle.value = value;
            },
            //controller: textInput,
            decoration: InputDecoration(
              hintText: 'Enter Task Title',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              contentPadding: EdgeInsets.symmetric(horizontal: 16),
            ),
          ),
          SizedBox(height: 10),
          TextField(
            onChanged: (value) {
              _addTaskController.taskDescription.value = value;
            },
            //controller: textInput,
            decoration: InputDecoration(
              hintText: 'Enter Task Description',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              contentPadding: EdgeInsets.symmetric(horizontal: 16),
            ),
          ),
          SizedBox(height: 10),
          Container(
            padding: EdgeInsets.only(left: 16, right: 16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(width: 1.0),
            ),
            child: Row(
              children: [
                Obx(
                  () => Text(
                    DateFormat(
                      'dd/MM/yyyy  hh:mm:a',
                    ).format(_addTaskController.endTime.value),
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                Spacer(),
                IconButton(
                  onPressed: _selectDate,
                  icon: Icon(Icons.calendar_today, color: Color(0xFF7D5BE4)),
                ),
              ],
            ),
          ),
          SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {
              // if (_addTaskController.taskTitle.value.isEmpty ||
              //     _addTaskController.taskDescription.value.isEmpty) {
              //   Get.snackbar("Error", "Please fill all fields");
              //   return;
              // }
              _addTaskController.addTask();
              Get.back();
            },
            child: Text("Save Task"),
          ),
        ],
      ),
    ),
  );
}
