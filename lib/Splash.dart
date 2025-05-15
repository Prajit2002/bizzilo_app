import 'package:ecommerce_app/Routes/AppRoutes.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  double _opacity = 0.0; // Start with opacity 0 for fade-in effect

  @override
  void initState() {
    super.initState();
    // Simulate loading or network call before navigating
    Timer(const Duration(seconds: 1), () {
      // Change opacity to 1 to trigger the fade-in effect
      setState(() {
        _opacity = 1.0;
      });
    });

    // Navigate after splash screen (after 3 seconds)
    Timer(const Duration(seconds: 3), () {
    Get.toNamed(Approutes.Home);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // White background
      body: Center(
        child: AnimatedOpacity(
          opacity: _opacity, // Controlled by the _opacity variable
          duration: const Duration(seconds: 2), // Duration of fade-in
          child: Image.asset("assets/app_logo.png"), // Your logo image
        ),
      ),
    );
  }
}
