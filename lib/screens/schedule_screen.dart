// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';

// class ScheduleScreen extends StatelessWidget {
//   const ScheduleScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Schedule Screen', style: TextStyle(fontWeight: FontWeight.bold),),
//         centerTitle: true,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text('Today', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey, fontSize: 20),),
//               SizedBox(height: 10,),
//               Row(
//                 children: [
//                   Icon(Icons.calendar_month),
//                   SizedBox(width: 10,),
//                   Text(DateFormat('dd/MM/yyyy').format(DateTime.now()), style: TextStyle(fontWeight: FontWeight.bold),),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }



import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_application/controllers/addtask_controller.dart';
import 'package:todo_application/models/task_model.dart';

class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({super.key});

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  final AddtaskController _controller = Get.find();

  late DateTime _weekStart;
  late DateTime _selectedDay;

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    _weekStart = now.subtract(Duration(days: now.weekday - 1));
    _weekStart = DateTime(_weekStart.year, _weekStart.month, _weekStart.day);
    _selectedDay = DateTime(now.year, now.month, now.day);
  }

  String _dayName(int weekday) {
    const days = ['', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    return days[weekday];
  }

  String _monthName(int month) {
    const months = [
      '', 'January', 'February', 'March', 'April', 'May',
      'June', 'July', 'August', 'September', 'October', 'November', 'December'
    ];
    return months[month];
  }

  String _formatTime(DateTime dt) {
    final hour = dt.hour % 12 == 0 ? 12 : dt.hour % 12;
    final min = dt.minute.toString().padLeft(2, '0');
    final period = dt.hour >= 12 ? 'pm' : 'am';
    return '$hour:$min $period';
  }

  bool _isToday(DateTime day) {
    final now = DateTime.now();
    return day.year == now.year &&
        day.month == now.month &&
        day.day == now.day;
  }

  List<TaskModel> _tasksForDay(DateTime day) {
    return _controller.fetchedtasks.where((task) {
      final d = task.endTime;
      return d.year == day.year &&
          d.month == day.month &&
          d.day == day.day;
    }).toList()
      ..sort((a, b) => a.endTime.compareTo(b.endTime));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5FA),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF5F5FA),
        elevation: 0,
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
        title: const Text(
          'Schedule',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1A1A2E),
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert, color: Color(0xFF1A1A2E)),
            onPressed: () {},
          ),
        ],
      ),
      body: Obx(() {
        final tasks = _tasksForDay(_selectedDay);
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Today label + date header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (_isToday(_selectedDay))
                    const Text(
                      'Today',
                      style: TextStyle(
                        fontSize: 13,
                        color: Color(0xFF888888),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  Row(
                    children: [
                      const Icon(Icons.calendar_today,
                          size: 16, color: Color(0xFF7B4FD6)),
                      const SizedBox(width: 8),
                      Text(
                        '${_dayName(_selectedDay.weekday)}day, ${_selectedDay.day} ${_monthName(_selectedDay.month)}',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1A1A2E),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 12),

            // Floating day selector tabs
            SizedBox(
              height: 72,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: 7,
                itemBuilder: (context, index) {
                  final day = _weekStart.add(Duration(days: index));
                  final isSelected = day.year == _selectedDay.year &&
                      day.month == _selectedDay.month &&
                      day.day == _selectedDay.day;
                  final isToday = _isToday(day);

                  return GestureDetector(
                    onTap: () => setState(() => _selectedDay = day),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      curve: Curves.easeInOut,
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      width: 54,
                      decoration: BoxDecoration(
                        color: isSelected
                            ? const Color(0xFF7B4FD6)
                            : Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: isSelected
                                ? const Color(0xFF7B4FD6).withOpacity(0.35)
                                : Colors.black.withOpacity(0.06),
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            _dayName(day.weekday),
                            style: TextStyle(
                              fontSize: 11,
                              color: isSelected
                                  ? Colors.white70
                                  : const Color(0xFF888888),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '${day.day}',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: isSelected
                                  ? Colors.white
                                  : isToday
                                      ? const Color(0xFF7B4FD6)
                                      : const Color(0xFF1A1A2E),
                            ),
                          ),
                          if (isToday && !isSelected)
                            Container(
                              margin: const EdgeInsets.only(top: 3),
                              width: 5,
                              height: 5,
                              decoration: const BoxDecoration(
                                color: Color(0xFF7B4FD6),
                                shape: BoxShape.circle,
                              ),
                            ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 20),

            // Tasks list
            Expanded(
              child: tasks.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.event_available,
                            size: 60,
                            color: const Color(0xFF7B4FD6).withOpacity(0.25),
                          ),
                          const SizedBox(height: 12),
                          const Text(
                            'No tasks for this day',
                            style: TextStyle(
                              color: Color(0xFF888888),
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      itemCount: tasks.length,
                      itemBuilder: (context, index) {
                        final task = tasks[index];
                        final colors = [
                          const Color(0xFF7B4FD6),
                          const Color(0xFF4F8EF7),
                          const Color(0xFF43C59E),
                          const Color(0xFFFF6B6B),
                        ];
                        final color = colors[index % colors.length];

                        return Container(
                          margin: const EdgeInsets.only(bottom: 14),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.05),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              // Color accent bar
                              Container(
                                width: 5,
                                height: 85,
                                decoration: BoxDecoration(
                                  color: color,
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(16),
                                    bottomLeft: Radius.circular(16),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 14),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 14),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      // Category chip
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8, vertical: 2),
                                        decoration: BoxDecoration(
                                          color: color.withOpacity(0.1),
                                          borderRadius:
                                              BorderRadius.circular(6),
                                        ),
                                        child: Text(
                                          'Task',
                                          style: TextStyle(
                                            fontSize: 10,
                                            color: color,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 6),
                                      Text(
                                        task.taskTitle,
                                        style: const TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xFF1A1A2E),
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      const SizedBox(height: 4),
                                      Row(
                                        children: [
                                          const Icon(Icons.access_time,
                                              size: 13,
                                              color: Color(0xFF888888)),
                                          const SizedBox(width: 4),
                                          Text(
                                            'Deadline: ${_formatTime(task.endTime)}',
                                            style: const TextStyle(
                                              fontSize: 12,
                                              color: Color(0xFF888888),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              IconButton(
                                icon: const Icon(Icons.more_vert,
                                    color: Color(0xFF888888), size: 18),
                                onPressed: () {},
                              ),
                            ],
                          ),
                        );
                      },
                    ),
            ),
          ],
        );
      }),
    );
  }
}