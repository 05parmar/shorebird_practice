import 'package:flutter/material.dart';

class TaskModel {
  final String id;
  String title;
  DateTime time;
  IconData icon;
  Color color;
  bool isCompleted;

  TaskModel({
    required this.id,
    required this.title,
    required this.time,
    required this.icon,
    required this.color,
    this.isCompleted = false,
  });
}
