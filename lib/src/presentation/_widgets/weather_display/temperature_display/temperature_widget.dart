import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class TemperatureWidget extends StatelessWidget {
  final int temperature;
  final double fontSize;
  const TemperatureWidget(
      {required this.fontSize, required this.temperature, super.key});

  @override
  Widget build(BuildContext context) {
    return Animate(
      effects: const [
        SlideEffect(begin: Offset(0, -0.08), duration: Durations.short4),
      ],
      child: Text(
        ' $temperature°',
        style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.w500),
      ),
    );
  }
}
