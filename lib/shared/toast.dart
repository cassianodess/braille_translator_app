import 'package:flutter/material.dart';

void showToast(BuildContext context, String text, ) {
  final snackBar = SnackBar(
    content: Text(text),
    action: SnackBarAction(
      label: "X",
      onPressed: () {
        return;
      },
    ),
  );

  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
