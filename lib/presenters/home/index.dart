import 'dart:io';

import 'package:braille_translator/services/translator.dart';
import 'package:braille_translator/styles/styles.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final ImagePicker _picker = ImagePicker();
  File? image;

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
    Future<void> onCameraPressed() async {
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

    Future<void> onFileAttachPressed() async {
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

    void clearImage() {
      setState(() {
        image = null;
      });
    }

    Future<void> sendImage() async {
      await translate(image!);
    }

    return Container(
      padding: EdgeInsets.all(Styles.padding),
      child: image == null
          ? Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                AspectRatio(
                  aspectRatio: 1.1,
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 30),
                    color: Colors.grey[300],
                    child: const Icon(Icons.image),
                  ),
                ),
                Column(
                  children: [
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
                )
              ],
            )
          : Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.only(bottom: 30),
                  child: AspectRatio(
                    aspectRatio: 1.1,
                    child: Image.file(File(image!.path)),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Styles.customElevatedButton(
                      clearImage,
                      Icons.delete,
                      "Deletar",
                      backgroundColor: Colors.red,
                      textColor: Colors.white,
                    ),
                    Styles.customElevatedButton(
                      sendImage,
                      Icons.check,
                      "Enviar",
                    ),
                  ],
                )
              ],
            ),
    );
  }
}
