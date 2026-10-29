import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:netfilx/core/theme/app_colors.dart';
import 'package:netfilx/features/movies/presentation/pages/bottom_navbar.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Center(
        child: Lottie.asset(
          'assets/Netflix Logo Swoop.json',
          height: 240,
          repeat: false,
         
onLoaded: (composition) {
  Future.delayed(composition.duration, () {
    if (!mounted) return;

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => BottomNavBar(),
      ),
    );
  });
},

        ),
      ),
    );
  }
}
