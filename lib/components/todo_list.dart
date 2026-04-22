import 'package:flutter/material.dart';

class TodoList extends StatelessWidget {
  final String projectTitle;
  final int projectColor;
  final String projectDescription;
  final IconData icons;
  const TodoList({super.key, required this.projectTitle, required this.projectColor, required this.projectDescription, required this.icons});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.all(0),
      minTileHeight: 70,
      leading: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Color(projectColor),
        ),
        child: Icon(icons),
      ),
      title: Text(projectTitle, style: TextStyle(fontWeight: FontWeight.bold, overflow: TextOverflow.ellipsis),),
      subtitle: Text(projectDescription, style: TextStyle(overflow: TextOverflow.ellipsis),),
      trailing: Container(
        width: 38,
        height: 38,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
        child: Icon(Icons.add, color: Color(projectColor)),
      ),
    );
  }
}
