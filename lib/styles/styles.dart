import 'package:flutter/material.dart';

class Styles {
  static Color primaryColor = const Color(0xff5D3FD3);

  static customElevatedButton(Function onPressed, IconData icon, String label,
      {Color backgroundColor = Colors.blue, Color textColor = Colors.white}) {
    return ElevatedButton.icon(
      onPressed: () => onPressed(),
      icon: Icon(
        icon,
        color: textColor,
      ),
      label: Text(
        label,
        style: TextStyle(
          color: textColor,
        ),
      ),
      style: ElevatedButton.styleFrom(
        primary: backgroundColor,
        padding: const EdgeInsets.all(10),
      ),
    );
  }
}
