import 'package:braille_translator/presenters/home/index.dart';
import 'package:flutter/cupertino.dart';

Map<String, Widget Function(BuildContext)> routes(BuildContext context) {
  return {
    "/": (context) => const Home(),
  };
}
