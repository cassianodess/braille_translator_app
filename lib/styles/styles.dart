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

  static Widget Title(String text) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: padding),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
  static Widget SubTitle(String text, {bool justify = true}) {
    return Container(
      // margin: EdgeInsets.only(bottom: padding),
      child: Center(
        child: Text(
          text,
          style: TextStyle(
            fontSize: 19,
          ),
          textAlign: justify ? TextAlign.justify : TextAlign.start,
        ),
      ),
    );
  }

  static Widget DevelopersContainer(String name, List<Widget> socialMedias) {
    return Column(
      children: [
        Styles.SubTitle(name, justify: false),
            SizedBox(height: Styles.padding,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: socialMedias
            ),
            SizedBox(height: Styles.padding,),
      ],
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
