import 'dart:async';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import '../provider/splash_state_manager.dart';
import '../widgets/bottom_nav.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    // Delay splash screen for 3 seconds, then complete splash state.
    Timer(const Duration(seconds: 5), () {
      // Complete splash state and navigate to the next screen
      Provider.of<SplashScreenProvider>(context, listen: false).completeSplash();
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const BottomNavBar(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    // Use Consumer to listen to SplashScreenProvider
    return Consumer<SplashScreenProvider>(
      builder: (context, splashProvider, child) {
        // If splash screen is done, navigate to the BottomNavBar
        if (!splashProvider.showSplash) {
          return const BottomNavBar();
        }

        // Otherwise, show the splash animation
        return Center(
          child: Lottie.asset(
            "assets/movie.json",
          ),
        );
      },
    );
  }
}
