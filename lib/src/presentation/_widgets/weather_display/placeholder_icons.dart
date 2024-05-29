import 'package:flutter/material.dart';

class PlaceholderIcons extends StatelessWidget {
  const PlaceholderIcons({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Icon(
          Icons.cloud,
          size: 60,
        ),
        Icon(
          Icons.sunny,
          size: 60,
        ),
        Icon(
          Icons.snowing,
          size: 60,
        )
      ],
    );
  }
}
