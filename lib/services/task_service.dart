import 'package:flutter/material.dart';
import '../models/task_model.dart';
import '../theme/app_colors.dart';

class TaskService {
  static final TaskService _instance = TaskService._internal();
  factory TaskService() => _instance;
  TaskService._internal() {
    _initTasks();
  }

  final ValueNotifier<List<Task>> tasksNotifier = ValueNotifier([]);

  void _initTasks() {
    tasksNotifier.value = [
      Task(id: '1', title: 'Call Elon', time: '11:00 Mo (Jan 30)', color: AppColors.taskLightGreen),
      Task(id: '2', title: 'Meet Irchick', time: '16:00-17:00 Mo (Jan 30)', color: AppColors.taskDarkGreen, icon: '🪴'),
      Task(id: '3', title: 'Finish dribbble shot', time: '20:00 Mo (Jan 30)', color: AppColors.taskYellow),
      Task(id: '4', title: 'Meet Uriyovich', time: '21:00 Mo (Jan 30)', color: AppColors.taskDarkGreen, icon: '☕'),
      Task(id: '5', title: 'Post to sharovary', time: '22:00 Mo (Jan 30)', color: AppColors.taskYellow),
    ];
  }

  void addTask(Task task) {
    tasksNotifier.value = [...tasksNotifier.value, task];
  }

  void updateTask(Task task) {
    final index = tasksNotifier.value.indexWhere((t) => t.id == task.id);
    if (index != -1) {
      final updatedTasks = List<Task>.from(tasksNotifier.value);
      updatedTasks[index] = task;
      tasksNotifier.value = updatedTasks;
    }
  }

  void removeTask(String id) {
    tasksNotifier.value = tasksNotifier.value.where((t) => t.id != id).toList();
  }
}
