import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


AppBar CustomAppBar(BuildContext context, double height, Widget title, {double toolbarHeight = 100.0, List<Widget> actions = const [SizedBox.shrink()], bool canPop= false}) {
  return AppBar(
    leading: canPop ? IconButton(onPressed: () => Navigator.of(context).pop(), icon: Icon(Icons.arrow_back)) : null,
    systemOverlayStyle: SystemUiOverlayStyle(statusBarColor: Colors.transparent),
    backgroundColor: Colors.transparent,
    toolbarHeight: toolbarHeight,
    flexibleSpace:  Container(
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(0),
          topRight: Radius.circular(0),
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
        color: Colors.blue.shade900,
      ),
    ),
    title: title,
    automaticallyImplyLeading: false,
    actions: actions,
  );
}