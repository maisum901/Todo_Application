import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:todo_application/main.dart';

Future<void> scheduleTaskNotification({
  required int id,
  required String title,
  required String body,
  required DateTime scheduledTime,
}) async {
  await notificationsPlugin.zonedSchedule(
    id,
    title,
    body,
    tz.TZDateTime.from(scheduledTime, tz.local), // named parameter
    const NotificationDetails(
      android: AndroidNotificationDetails(
        'task_channel',
        'Task Notifications',
        importance: Importance.max,
        priority: Priority.high,
      ),
    ),
    uiLocalNotificationDateInterpretation:
      UILocalNotificationDateInterpretation.absoluteTime,
    androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
    // removed uiLocalNotificationDateInterpretation
  );
}