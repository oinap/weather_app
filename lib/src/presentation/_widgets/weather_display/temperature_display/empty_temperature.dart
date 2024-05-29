import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class EmptyTemperature extends StatelessWidget {
  final double fontSize;
  const EmptyTemperature({required this.fontSize, super.key});

  @override
  Widget build(BuildContext context) {
    return Animate(
      effects: const [
        SlideEffect(begin: Offset(0, -0.08), duration: Durations.short4)
      ],
      child: Text(
        ' --°',
        style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.w500),
      ),
    );
  }
}
