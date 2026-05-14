import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import 'main_layout.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryTeal,
      body: GestureDetector(
        onTap: () {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (_) => const MainLayout()),
          );
        },
        child: Stack(
          children: [
            // Dark shape top right
            Positioned(
              top: -50,
              right: -80,
              child: Container(
                width: 250,
                height: 350,
                decoration: BoxDecoration(
                  color: AppColors.darkAccent,
                  borderRadius: BorderRadius.circular(120),
                ),
              ),
            ),
            // Light green shape bottom left
            Positioned(
              bottom: 50,
              left: -50,
              child: Container(
                width: 200,
                height: 250,
                decoration: BoxDecoration(
                  color: AppColors.lightGreenAccent,
                  borderRadius: BorderRadius.circular(100),
                ),
              ),
            ),
            // Yellow shape bottom right
            Positioned(
              bottom: -50,
              right: 20,
              child: Container(
                width: 150,
                height: 250,
                decoration: BoxDecoration(
                  color: AppColors.yellowAccent,
                  borderRadius: BorderRadius.circular(80),
                ),
              ),
            ),
            // Text Content
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'TOIO',
                      style: TextStyle(
                        fontSize: 64,
                        fontWeight: FontWeight.w900,
                        color: Colors.white,
                        letterSpacing: 2,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'The simplest todo\napp ever',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w500,
                        color: Colors.white.withOpacity(0.9),
                        height: 1.2,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Red dot
            Positioned(
              top: 280,
              left: 80,
              child: Container(
                width: 8,
                height: 8,
                decoration: const BoxDecoration(
                  color: Colors.redAccent,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
