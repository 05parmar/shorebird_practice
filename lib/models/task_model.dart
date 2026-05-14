import 'package:flutter/material.dart';

class Task {
  final String id;
  final String title;
  final String time;
  final Color color;
  final String? icon;

  Task({
    required this.id,
    required this.title,
    required this.time,
    required this.color,
    this.icon,
  });
}
