import 'dart:io';

import 'package:braille_translator/styles/styles.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

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

  Widget myBody() {
    final ImagePicker _picker = ImagePicker();
    File? image;

    Future onCameraPressed() async {
      try {
        final XFile? imagePicked =
            await _picker.pickImage(source: ImageSource.camera);
        if (imagePicked != null) {
          setState(() {
            image = File(imagePicked.path);
          });
        }
      } catch (e) {
        print(e);
      }
    }

    Future onFileAttachPressed() async {
      try {
        final XFile? imagePicked =
            await _picker.pickImage(source: ImageSource.gallery);
        if (imagePicked != null) {
          setState(() {
            image = File(imagePicked.path);
          });
        }
      } catch (e) {
        print(e);
      }
    }

    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          image == null
              ? AspectRatio(
                  aspectRatio: 1.5,
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 30),
                    color: Colors.grey[200],
                    child: const Icon(Icons.image),
                  ),
                )
              : AspectRatio(
                  aspectRatio: 1.5,
                  child: Image.file(File(image!.path)),
                ),
          Styles.customElevatedButton(
            onCameraPressed,
            Icons.camera_alt,
            "Tirar uma foto",
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: const Text("ou"),
          ),
          Styles.customElevatedButton(
            onFileAttachPressed,
            Icons.attach_file,
            "Selecionar um arquivo",
            backgroundColor: Colors.white,
            textColor: Colors.blue,
          )
        ],
      ),
    );
  }
}
