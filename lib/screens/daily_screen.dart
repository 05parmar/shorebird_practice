import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../models/task_model.dart';
import '../widgets/task_card.dart';
import '../widgets/task_dialog.dart';

class DailyScreen extends StatelessWidget {
  final VoidCallback onNext;

  const DailyScreen({super.key, required this.onNext});

  @override
  Widget build(BuildContext context) {
    final List<Task> tasks = [
      Task(title: 'Call Elon', time: '11:00 Mo (Jan 30)', color: AppColors.taskLightGreen),
      Task(title: 'Meet Irchick', time: '16:00-17:00 Mo (Jan 30)', color: AppColors.taskDarkGreen, icon: '🪴'),
      Task(title: 'Finish dribbble shot', time: '20:00 Mo (Jan 30)', color: AppColors.taskYellow),
      Task(title: 'Meet Uriyovich', time: '21:00 Mo (Jan 30)', color: AppColors.taskDarkGreen, icon: '☕'),
      Task(title: 'Post to sharovary', time: '22:00 Mo (Jan 30)', color: AppColors.taskYellow),
    ];

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
                  const Row(
                    children: [
                      Text(
                        'Today ',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: AppColors.yellowAccent,
                        ),
                      ),
                      Text(
                        'Mo - Jan 30 ',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Icon(Icons.add, color: AppColors.lightGreenAccent, size: 28),
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
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                itemCount: tasks.length,
                separatorBuilder: (context, index) => const SizedBox(height: 16),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      if (index == 2) {
                        showDialog(
                          context: context,
                          builder: (_) => const TaskDialog(),
                        );
                      }
                    },
                    child: TaskCard(task: tasks[index]),
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
