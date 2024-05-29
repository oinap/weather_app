import 'package:flutter/material.dart';

class ErrorSnackbar extends SnackBar {
  final String message;
  ErrorSnackbar({super.key, required this.message})
      : super(
            content: Text(
              message,
              style: const TextStyle(color: Colors.white, fontSize: 19),
            ),
            backgroundColor: Colors.red);
}
