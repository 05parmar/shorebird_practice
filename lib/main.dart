import 'package:flutter/material.dart';
import 'package:demo/screens/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TOIO Todo App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'Helvetica', // Assuming standard font
        scaffoldBackgroundColor: const Color(0xFF161616),
      ),
      home: const SplashScreen(),
    );
  }
}
