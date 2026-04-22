import 'package:flutter/material.dart';

class ProjectsCard extends StatelessWidget {
  final int projectColor;
  final String projectTitle;
  final String projectDescription;
  final DateTime deadLine;
  
  const ProjectsCard({super.key, required this.projectColor, required this.projectTitle, required this.projectDescription, required this.deadLine});

  Duration calculateTime(){
    Duration differenceHours = deadLine.difference(DateTime.now());
    return differenceHours;
  }
  
  
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8),
      width: 280,
      height: 180,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Color(projectColor),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  projectTitle,
                  style: TextStyle(
                    overflow: TextOverflow.ellipsis,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
                Spacer(),
                Icon(Icons.more_vert, color: Colors.white),
              ],
            ),
            Text(
              projectDescription,
              style: TextStyle(overflow: TextOverflow.ellipsis,color: Colors.white, fontSize: 13),
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Row(
                  children: List.generate(4, (index) {
                    return Container(
                      margin: EdgeInsets.symmetric(horizontal: 0),
                      width: 38,
                      height: 38,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white,
                      ),
                      child: Icon(Icons.add),
                    );
                  }),
                ),
                Spacer(),
                Column(
                  children: [
                    Row(
                      children: [
                        Icon(Icons.lock_clock, color: Colors.white, size: 12),
                        Text(
                         "${calculateTime().inHours} hours",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(Icons.task, color: Colors.white, size: 12),
                        Text(
                          '5 tasks',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 10),
            Text(
              'in progress 60%',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            LinearProgressIndicator(
              borderRadius: BorderRadiusGeometry.circular(10),
              minHeight: 15,
              value: 0.6,
              backgroundColor: Colors.grey[300],
              color: const Color.fromARGB(255, 81, 3, 182),
            ),
          ],
        ),
      ),
    );
  }
}
