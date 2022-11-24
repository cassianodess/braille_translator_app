import 'package:braille_translator/styles/styles.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
      ),
      body: myBody(),
    );
  }
}

Widget myBody() {
  void onPhotoPressed() {
    print("Camera pressed");
  }

  void onFileAttachPressed() {
    print("File attach pressed");
  }

  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Styles.customElevatedButton(
          onPhotoPressed,
          Icons.camera_alt,
          "Tire uma foto",
        ),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 15),
          child: const Text("ou"),
        ),
        Styles.customElevatedButton(
          onFileAttachPressed,
          Icons.attach_file,
          "Selecione um arquivo",
          backgroundColor: Colors.white,
          textColor: Colors.blue,
        )
      ],
    ),
  );
}
