import 'package:flutter/material.dart';

void showToast(BuildContext context, String text, {bool isError = false, Duration duration = const Duration(seconds: 5)}) {
  final snackBar = SnackBar(
    backgroundColor: isError ? Colors.red : Colors.green,
    duration: duration != null ? duration : Duration(seconds: 5),
    content: Text(text),
    behavior: SnackBarBehavior.floating,
    action: SnackBarAction(
      label: "X",
      onPressed: () {
        return;
      },
    ),
  );

  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
