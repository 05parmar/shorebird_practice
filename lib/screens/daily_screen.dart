import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../models/task_model.dart';
import '../widgets/task_card.dart';
import '../widgets/task_dialog.dart';
import '../widgets/add_task_sheet.dart';
import '../services/task_service.dart';

class DailyScreen extends StatelessWidget {
  final VoidCallback onNext;

  const DailyScreen({super.key, required this.onNext});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryTeal,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.only(left: 24, top: 24, bottom: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Text(
                        'Today ',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: AppColors.yellowAccent,
                        ),
                      ),
                      const Text(
                        'Mo - Jan 30 ',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            backgroundColor: Colors.transparent,
                            builder: (_) => const AddTaskSheet(),
                          );
                        },
                        child: const Icon(Icons.add, color: AppColors.lightGreenAccent, size: 28),
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: onNext,
                    child: Container(
                      width: 50,
                      height: 50,
                      decoration: const BoxDecoration(
                        color: AppColors.darkAccent,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(30),
                        ),
                      ),
                      child: const Center(
                        child: Icon(Icons.circle, color: AppColors.primaryTeal, size: 12),
                      ),
                    ),
                  )
                ],
              ),
            ),
            
            // Task List
            Expanded(
              child: ValueListenableBuilder<List<Task>>(
                valueListenable: TaskService().tasksNotifier,
                builder: (context, tasks, child) {
                  if (tasks.isEmpty) {
                    return const Center(child: Text("No tasks for today", style: TextStyle(color: Colors.white)));
                  }
                  return ListView.separated(
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                    itemCount: tasks.length,
                    separatorBuilder: (context, index) => const SizedBox(height: 16),
                    itemBuilder: (context, index) {
                      final task = tasks[index];
                      return GestureDetector(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (_) => TaskDialog(task: task),
                          );
                        },
                        child: TaskCard(task: task),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
