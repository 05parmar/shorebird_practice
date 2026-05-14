import 'package:flutter/material.dart';

class Task {
  final String title;
  final String time;
  final Color color;
  final String? icon;

  Task({
    required this.title,
    required this.time,
    required this.color,
    this.icon,
  });
}
