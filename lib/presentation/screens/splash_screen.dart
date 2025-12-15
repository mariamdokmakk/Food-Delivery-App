
import 'dart:async';
import 'package:flutter/material.dart';
import '/presentation/screens/home_screen.dart';
import '/presentation/screens/onboarding_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 2), checkFirstSeen);

    // Animation setup
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );

    _controller.forward();
  }

  Future<void> checkFirstSeen() async {
    final prefs = await SharedPreferences.getInstance();
    final seenOnboarding = prefs.getBool('seenOnboarding') ?? false;

    if (seenOnboarding) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const HomeScreen()),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const OnboardingScreen()),
      );
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.white,
                    child: Image.asset('assets/images/logo.png', height: 60),
                  ),
                  // Image.asset(
                  //   'assets/images/logo.jpg',
                  //   height: 120,
                  // ),
                  const SizedBox(width: 5),

                  const Text(
                    "TO The Bone",
                    style: TextStyle(
                      fontSize: 28,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                    ),
                  ),
                ],
              ),
               SizedBox(height: 60),
               CircularProgressIndicator(
                //padding: EdgeInsets.only(top: 500),
                valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).colorScheme.primary),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
