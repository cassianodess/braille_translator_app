import 'package:braille_translator/presenters/home/index.dart';
import 'package:braille_translator/presenters/landing_page/index.dart';
import 'package:flutter/cupertino.dart';

Map<String, Widget Function(BuildContext)> routes(BuildContext context) {
  return {
    "/landing-page": (context) => const LandingPage(),
    "/": (context) => const Home(),
  };
}
