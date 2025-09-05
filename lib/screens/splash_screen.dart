import 'dart:async';
import 'package:flutter/material.dart';
import 'home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _logoController;
  late AnimationController _textController;

  @override
  void initState() {
    super.initState();

    // Logo Animation
    _logoController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    )..forward();

    // Text Animation
    _textController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    );

    // Trigger text animation after logo
    Future.delayed(const Duration(seconds: 3), () {
      _textController.forward();
    });

    // Navigate to HomeScreen after 5 seconds
    Future.delayed(const Duration(seconds: 7), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    });
  }

  @override
  void dispose() {
    _logoController.dispose();
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // background for splash
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo Animation (scale)
            ScaleTransition(
              scale: CurvedAnimation(
                parent: _logoController,
                curve: Curves.easeOutBack,
              ),
              child: Image.asset(
                "assets/images/logo.png",
                width: 220,
                height: 220,
              ),
            ),
            const SizedBox(height: 20),
            // Text Animation (fade)
            FadeTransition(
              opacity: _textController,
              child: const Text(
                "NAQDINA",
                style: TextStyle(
                  fontStyle: FontStyle.italic,
                  fontFamily: "Poppins", // attractive font
                  fontSize: 60,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 10,
                  color: Colors.blueGrey,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}