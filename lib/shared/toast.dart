import 'package:flutter/material.dart';

void showToast(BuildContext context, String text, {bool isError = false}) {
  final snackBar = SnackBar(
    backgroundColor: isError ? Colors.red : Colors.black,
    duration: Duration(seconds: 5),
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
