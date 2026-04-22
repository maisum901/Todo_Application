import 'dart:typed_data';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:todo_application/main.dart';

Future<void> showNotification(String taskTitle) async {
  print('🔔 showNotification called for: $taskTitle');
  
  try {
    AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
      'task_channel',
      'Task Notifications',
      importance: Importance.max,
      priority: Priority.high,
      playSound: true,
      enableVibration: true,
      vibrationPattern: Int64List.fromList([0, 1000, 500, 1000]),
    );

    NotificationDetails details = NotificationDetails(android: androidDetails);

    await notificationsPlugin.show(
      taskTitle.hashCode,
      "⏰ Task Alarm",
      taskTitle,
      details,
    );
    print('✅ Notification sent successfully');
  } catch (e) {
    print('❌ Notification error: $e');
  }
}