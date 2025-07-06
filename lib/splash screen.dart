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
              backgroundColor: Color(0xFFEEE4Da),
            )
            .animate()
            .slideY(begin: -0.5, end: 0.2, duration: 3.5.seconds)
            .then(delay: 200.milliseconds)
            .slideY(end: -0.3, duration: 2.5.seconds)
            .then(delay: 100.milliseconds)
            .slideY(end: 0.1, duration: 2.5.seconds)
            .then(delay: 0.5.milliseconds)
            .scaleXY(end: 20, duration: 0.5.seconds)
            .then(delay: 1.milliseconds),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: AnimatedGradientText(
              text: "2048",
              style: TextStyle(
                fontSize: 60,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ).animate()
            .fadeIn(duration: 10.seconds, curve: Curves.easeIn)
            .then(delay: 1.seconds)
            .fadeOut(duration: 3.seconds, curve: Curves.easeInOut)
           
          )
        ],
      ),
    );
  }
}

class AnimatedGradientText extends StatefulWidget {
  final String text;
  final TextStyle style;
  const AnimatedGradientText({required this.text, required this.style, super.key});

  @override
  State<AnimatedGradientText> createState() => _AnimatedGradientTextState();
}

class _AnimatedGradientTextState extends State<AnimatedGradientText> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return ShaderMask(
          shaderCallback: (Rect bounds) {
            return LinearGradient(
              colors: [Colors.red, Colors.amber, Colors.green, Colors.blue],
              begin: Alignment(-1 + 2 * _controller.value, -1),
              end: Alignment(1 - 2 * _controller.value, 1),
            ).createShader(bounds);
          },
          child: Text(widget.text, style: widget.style),
        );
      },
    );
  }
}