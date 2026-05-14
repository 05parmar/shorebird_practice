import 'package:flutter/material.dart';
import 'package:demo/models/task_model.dart';
import 'package:demo/theme/app_colors.dart';
import 'package:demo/widgets/task_card.dart';
import 'package:demo/screens/schedule_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<TaskModel> _tasks = [
    TaskModel(
      id: '1',
      title: 'Call Elon',
      time: DateTime.now().subtract(const Duration(hours: 1)),
      icon: Icons.phone,
      color: AppColors.lightMint,
    ),
    TaskModel(
      id: '2',
      title: 'Meet Irchick',
      time: DateTime.now().add(const Duration(hours: 2)),
      icon: Icons.local_florist,
      color: AppColors.lightMint,
    ),
    TaskModel(
      id: '3',
      title: 'Finish dribbble shot',
      time: DateTime.now().add(const Duration(hours: 5)),
      icon: Icons.design_services,
      color: AppColors.peachYellow,
    ),
    TaskModel(
      id: '4',
      title: 'Post to sharovary',
      time: DateTime.now().add(const Duration(hours: 8)),
      icon: Icons.send,
      color: AppColors.peachYellow,
    ),
  ];

  void _toggleTaskCompletion(int index) {
    setState(() {
      _tasks[index].isCompleted = !_tasks[index].isCompleted;
    });
  }

  void _showTaskEditDialog(int index) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: const EdgeInsets.symmetric(horizontal: 20),
          child: Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: AppColors.lightMint,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: AppColors.cardBorder, width: 3),
              boxShadow: const [
                BoxShadow(
                  color: AppColors.cardBorder,
                  offset: Offset(0, 6),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        _tasks[index].title,
                        style: const TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textDark,
                        ),
                      ),
                    ),
                    Icon(_tasks[index].icon, size: 40, color: AppColors.textDark),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildDialogButton(
                      'Edit',
                      Colors.white,
                      () {
                        Navigator.pop(context);
                        // Future edit logic
                      },
                    ),
                    _buildDialogButton(
                      _tasks[index].isCompleted ? 'Undone' : 'Done ✓',
                      AppColors.peachYellow,
                      () {
                        _toggleTaskCompletion(index);
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildDialogButton(String text, Color color, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.cardBorder, width: 2),
          boxShadow: const [
            BoxShadow(
              color: AppColors.cardBorder,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppColors.textDark,
          ),
        ),
      ),
    );
  }

  String _getTodayString() {
    const days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    const months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
    final now = DateTime.now();
    return 'Today ${days[now.weekday - 1]} - ${months[now.month - 1]} ${now.day}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryGreen,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    _getTodayString(),
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: AppColors.peachYellow,
                    ),
                  ),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => const ScheduleScreen()),
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: const BoxDecoration(
                            color: AppColors.darkSurface,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.calendar_month,
                            color: AppColors.peachYellow,
                            size: 28,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      GestureDetector(
                        onTap: () {
                          // Add task logic here
                        },
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: const BoxDecoration(
                            color: AppColors.darkSurface,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.add,
                            color: AppColors.lightMint,
                            size: 28,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 32),
              Expanded(
                child: ListView.builder(
                  itemCount: _tasks.length,
                  itemBuilder: (context, index) {
                    return TaskCard(
                      task: _tasks[index],
                      onTap: () => _showTaskEditDialog(index),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
