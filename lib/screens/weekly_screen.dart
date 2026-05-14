import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../models/task_model.dart';
import '../services/task_service.dart';

class WeeklyScreen extends StatelessWidget {
  final VoidCallback onBack;

  const WeeklyScreen({super.key, required this.onBack});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBackground,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.only(right: 24, top: 24, bottom: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: onBack,
                    child: Container(
                      width: 50,
                      height: 50,
                      decoration: const BoxDecoration(
                        color: AppColors.primaryTeal,
                        borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(30),
                        ),
                      ),
                      child: const Center(
                        child: Icon(Icons.circle, color: AppColors.darkAccent, size: 12),
                      ),
                    ),
                  ),
                  const Row(
                    children: [
                      Icon(Icons.chevron_left, color: Colors.white, size: 30),
                      SizedBox(width: 8),
                      Text(
                        'Jan 30 - Feb 05',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(width: 8),
                      Icon(Icons.chevron_right, color: Colors.white, size: 30),
                    ],
                  ),
                  const SizedBox(width: 50),
                ],
              ),
            ),

            // Timetable
            Expanded(
              child: ValueListenableBuilder<List<Task>>(
                valueListenable: TaskService().tasksNotifier,
                builder: (context, tasks, child) {
                  return ListView(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    children: [
                      _buildDayRow('Mo\n30.1', [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: tasks.map((t) => Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: _buildWeeklyTask(
                              color: t.color,
                              text: '${t.time.split(' ').first}\n${t.title}',
                            ),
                          )).toList(),
                        ),
                        _buildWeeklyTask(
                          color: AppColors.taskYellow,
                          child: RichText(
                            text: const TextSpan(
                              style: TextStyle(
                                color: AppColors.darkAccent,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                height: 1.4,
                                fontFamily: 'Helvetica',
                              ),
                              children: [
                                TextSpan(text: 'Finish dribbble shot\n\n'),
                                TextSpan(text: 'Withdraw money\n\n'),
                                TextSpan(text: 'Finish dribbble shot', style: TextStyle(color: Colors.redAccent)),
                              ],
                            ),
                          ),
                        ),
                      ]),
                      _buildDayRow('Tu\n31.1', [
                        _buildWeeklyTask(text: '9:00\nSquash with I.', color: AppColors.taskLightGreen, height: 80),
                        _buildWeeklyTask(color: AppColors.taskYellow, isAdd: true, height: 80),
                      ]),
                      _buildDayRow('We\n1.2', [
                        _buildWeeklyTask(text: '9:00\nReview design\nsystem for AUTO\nRIA', color: AppColors.taskLightGreen, height: 120),
                        _buildWeeklyTask(text: 'Post to sharovary', color: AppColors.taskYellow, height: 120),
                      ]),
                      _buildDayRow('Th\n2.2', [
                        _buildWeeklyTask(color: AppColors.taskLightGreen, isAdd: true, height: 80),
                        _buildWeeklyTask(color: AppColors.taskYellow, isAdd: true, height: 80),
                      ]),
                      _buildDayRow('Fr\n3.2', [
                        _buildWeeklyTask(text: '9:00\nShoping =(\n\n19:00\nConcert', color: AppColors.taskLightGreen, height: 120),
                        _buildWeeklyTask(text: 'Order power\nstation\n\nTiktok video', color: AppColors.taskYellow, height: 120),
                      ]),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDayRow(String day, List<Widget> columns) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 50,
            child: Text(
              day,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: columns.map((col) => Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: col,
                ),
              )).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWeeklyTask({String? text, Widget? child, required Color color, bool isAdd = false, double? height}) {
    return Container(
      height: height,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
      ),
      child: isAdd
          ? const Center(
              child: Icon(Icons.add, color: Colors.black45, size: 28),
            )
          : child ?? Text(
              text ?? '',
              style: const TextStyle(
                color: AppColors.darkAccent,
                fontSize: 12,
                fontWeight: FontWeight.w600,
                height: 1.4,
              ),
            ),
    );
  }
}
