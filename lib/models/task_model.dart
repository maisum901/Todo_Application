
class TaskModel {
  final int id;
  final String taskTitle;
  final String taskDescription;
  final DateTime endTime;
  final bool isCompleted;

  TaskModel({
    required this.id,
    required this.taskTitle,
    required this.taskDescription,
    required this.endTime,
    this.isCompleted = false,
  });
}
