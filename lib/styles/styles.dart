import 'package:flutter/material.dart';

class Styles {
  static Color primaryColor = const Color(0xff5D3FD3);
  static double padding = 20.0;
  
  static double deviceWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  static double deviceHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  static TextStyle landingPageHeaderStyle() {
    return TextStyle(
      fontWeight: FontWeight.w400,
      color: Colors.white,
      // color: Color(0xff212121),
      fontSize: 20,
    );
  }

  static Widget customElevatedButton(Function onPressed, IconData icon, String label,
      {Color backgroundColor = Colors.blue, Color textColor = Colors.white}) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: ElevatedButton.icon(
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
          backgroundColor: backgroundColor,
          padding: const EdgeInsets.all(10),
        ),
      ),
    );
  }
}
