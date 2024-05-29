import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class LoadingAnimation extends StatelessWidget {
  final double fontSize;
  const LoadingAnimation({required this.fontSize, super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Dot(delay: Duration.zero, fontSize: fontSize),
        Dot(delay: 100.ms, fontSize: fontSize),
        Dot(delay: 200.ms, fontSize: fontSize)
      ],
    );
  }
}

class Dot extends StatelessWidget {
  final double fontSize;
  final Duration delay;
  const Dot({required this.delay, required this.fontSize, super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      '.',
      style: TextStyle(
        fontSize: fontSize,
      ),
    ).animate(effects: [FadeEffect(duration: 1.ms)], delay: delay);
  }
}
