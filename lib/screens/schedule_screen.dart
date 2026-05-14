import 'package:flutter/material.dart';
import 'package:demo/theme/app_colors.dart';

class ScheduleScreen extends StatelessWidget {
  const ScheduleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkSurface,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: const BoxDecoration(
                        color: AppColors.primaryGreen,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.arrow_back_ios_new,
                        color: AppColors.lightMint,
                        size: 20,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  const Text(
                    'Jan 30 - Feb 05',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const Spacer(),
                  const Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.white,
                    size: 20,
                  ),
                ],
              ),
              const SizedBox(height: 32),
              Expanded(
                child: ListView(
                  children: [
                    _buildDayRow('Mo\n30.1', [
                      _buildScheduleBlock('11:00\nCall Elon\n\n16:00-17:00\nMeet Irchick\n\n20:00\nReview notes', AppColors.lightMint, flex: 2),
                      _buildScheduleBlock('Finish dribbble shot\n\nWithdraw money', AppColors.peachYellow, flex: 1),
                    ]),
                    const SizedBox(height: 12),
                    _buildDayRow('Tu\n31.1', [
                      _buildScheduleBlock('9:00\nSquash with I.', AppColors.lightMint, flex: 1),
                      _buildScheduleBlock('+', AppColors.peachYellow, isAdd: true, flex: 1),
                    ]),
                    const SizedBox(height: 12),
                    _buildDayRow('We\n1.2', [
                      _buildScheduleBlock('9:00\nReview design system', AppColors.lightMint, flex: 1),
                      _buildScheduleBlock('Post to sharovary', AppColors.peachYellow, flex: 1),
                    ]),
                    const SizedBox(height: 12),
                    _buildDayRow('Th\n2.2', [
                      _buildScheduleBlock('+', AppColors.lightMint, isAdd: true, flex: 1),
                      _buildScheduleBlock('+', AppColors.peachYellow, isAdd: true, flex: 1),
                    ]),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDayRow(String dayDate, List<Widget> blocks) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 50,
          child: Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: Text(
              dayDate,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
                height: 1.5,
              ),
            ),
          ),
        ),
        Expanded(
          child: IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: blocks.map((block) {
                return Expanded(
                  flex: block is _ScheduleBlockData ? block.flex : 1, // basic flex handling
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: block,
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildScheduleBlock(String text, Color color, {bool isAdd = false, int flex = 1}) {
    return _ScheduleBlockData(
      flex: flex,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(16),
        ),
        child: isAdd
            ? Center(
                child: Icon(Icons.add, color: AppColors.darkSurface.withOpacity(0.5), size: 32),
              )
            : Text(
                text,
                style: const TextStyle(
                  color: AppColors.textDark,
                  fontWeight: FontWeight.bold,
                  height: 1.4,
                ),
              ),
      ),
    );
  }
}

class _ScheduleBlockData extends StatelessWidget {
  final Widget child;
  final int flex;
  
  const _ScheduleBlockData({required this.child, required this.flex});

  @override
  Widget build(BuildContext context) {
    return child;
  }
}
