import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 12), () {
      Navigator.of(context).pushReplacementNamed('/home');
    });
  }
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Stack(
        children: [
          Positioned.fill(
            child: Padding(padding: EdgeInsets.symmetric(horizontal: 130,),
            child: CircleAvatar(
              backgroundColor: Color(0xFF1E1E1E),
            )
            .animate()
            .slideY(begin: -0.5, end: 0.2, duration: 4.seconds)
            .then(delay: 300.milliseconds)
            .slideY(end: -0.3, duration: 3.seconds)
            .then(delay: 150.milliseconds)
            .slideY(end: 0.1, duration: 3.seconds)
            .then(delay: 1.milliseconds)
            .scaleXY(end: 20, duration: 0.5.seconds)
            .then(delay: 2.milliseconds),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Text(
              "2048",
              style: TextStyle(
                fontSize: 60,
                fontWeight: FontWeight.bold,
                color: const Color.fromARGB(255, 82, 51, 51),
              ),
            )
            .animate()
            .fadeIn(duration: 10.seconds, curve: Curves.easeIn)
            .then(delay: 200.milliseconds)
            .slideX(begin: -0.5, end: 0, duration: 1.seconds)
          )
        ],
      ),
    );
  }
}