import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

class TodayDateDisplay extends StatelessWidget {
  const TodayDateDisplay({super.key});

  @override
  Widget build(BuildContext context) {
    // Get the current date
    DateTime now = DateTime.now();

    // Format the date
    String formattedDate = DateFormat('EEEE, d MMMM').format(now);
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Theme.of(context).primaryColor,
      ),
      child: Text(
        formattedDate,
        style: TextStyle(
            fontSize: 15, color: Theme.of(context).colorScheme.surface),
      ),
    );
  }
}
