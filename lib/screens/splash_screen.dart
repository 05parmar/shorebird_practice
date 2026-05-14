import 'package:flutter/material.dart';
import 'package:demo/screens/home_screen.dart';
import 'package:demo/theme/app_colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Reduced splash screen duration to 1 second
    Future.delayed(const Duration(milliseconds: 1000), () {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const HomeScreen()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryGreen,
      body: Stack(
        children: [
          // Decorative Blobs
          Positioned(
            top: -50,
            right: -80,
            child: Container(
              width: 300,
              height: 350,
              decoration: const BoxDecoration(
                color: AppColors.darkSurface,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(200),
                  bottomRight: Radius.circular(100),
                ),
              ),
            ),
          ),
          Positioned(
            top: 250,
            left: 50,
            child: Container(
              width: 8,
              height: 8,
              decoration: const BoxDecoration(
                color: Colors.redAccent,
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            bottom: -80,
            left: -80,
            child: Container(
              width: 250,
              height: 250,
              decoration: const BoxDecoration(
                color: AppColors.lightMint,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(200),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: -150,
            right: -50,
            child: Container(
              width: 300,
              height: 400,
              decoration: const BoxDecoration(
                color: AppColors.peachYellow,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(250),
                ),
              ),
            ),
          ),
          // Main Text
          Padding(
            padding: const EdgeInsets.only(left: 40.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'TOIO',
                  style: TextStyle(
                    fontSize: 72,
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                    letterSpacing: 2.0,
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  'The simplest todo\napp ever',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
