import 'package:flutter/material.dart';
import 'package:demo/models/task_model.dart';
import 'package:demo/theme/app_colors.dart';

class TaskCard extends StatelessWidget {
  final TaskModel task;
  final VoidCallback onTap;

  const TaskCard({super.key, required this.task, required this.onTap});

  String _formatDate(DateTime date) {
    const days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    const months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
    
    final hour = date.hour.toString().padLeft(2, '0');
    final min = date.minute.toString().padLeft(2, '0');
    final dayName = days[date.weekday - 1];
    final monthName = months[date.month - 1];
    
    return '$hour:$min $dayName ($monthName ${date.day})';
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        decoration: BoxDecoration(
          color: task.color,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: AppColors.cardBorder,
            width: 2.5,
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.cardBorder,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    task.title,
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textDark,
                      decoration: task.isCompleted ? TextDecoration.lineThrough : null,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    _formatDate(task.time),
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textDark.withOpacity(0.8),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.3),
                shape: BoxShape.circle,
                border: Border.all(
                  color: AppColors.cardBorder,
                  width: 2,
                ),
              ),
              child: Icon(
                task.isCompleted ? Icons.check_circle : task.icon,
                color: AppColors.textDark,
                size: 32,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
