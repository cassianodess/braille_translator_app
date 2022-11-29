import 'dart:io';

import 'package:braille_translator/presenters/print/index.dart';
import 'package:braille_translator/shared/toast.dart';
import 'package:braille_translator/styles/styles.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final ImagePicker _picker = ImagePicker();
  File? image;
  String text = "";

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (image != null) {
          setState(() {
            image = null;
          });
          return false;
        }
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Home"),
        ),
        body: myBody(),
      ),
    );
  }

  Widget myBody() {
    Future<void> croppImage() async {
      File? croppedImage = await ImageCropper().cropImage(
        sourcePath: image!.path,
        aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
        aspectRatioPresets: [
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.ratio3x2,
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.ratio4x3,
          CropAspectRatioPreset.ratio16x9
        ],
        androidUiSettings: const AndroidUiSettings(
          toolbarTitle: 'Ajustes',
          toolbarColor: Colors.blue,
          toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.original,
          lockAspectRatio: false,
          showCropGrid: true,
        ),
        iosUiSettings: const IOSUiSettings(
          title: 'Ajustes',
        ),
      );

      if (croppedImage != null) {
        setState(() {
          image = File(croppedImage.path);
        });
      }
    }

    Future<void> onCameraPressed() async {
      final XFile? imagePicked =
          await _picker.pickImage(source: ImageSource.camera);
      if (imagePicked != null) {
        setState(() {
          image = File(imagePicked.path);
        });
        showToast(context, "Clique na imagem para recortar.");
      }
    }

    Future<void> onFileAttachPressed() async {
      final XFile? imagePicked =
          await _picker.pickImage(source: ImageSource.gallery);
      if (imagePicked != null) {
        setState(() {
          image = File(imagePicked.path);
        });
        showToast(context, "Clique na imagem para recortar.");
      }
    }

    void clearImage() {
      setState(() {
        image = null;
      });
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
                GestureDetector(
                  onTap: () async => {await croppImage()},
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 30),
                    child: AspectRatio(
                      aspectRatio: 1.1,
                      child: Image.file(
                        File(image!.path),
                      ),
                    ),
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
                      () => Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => PrintPage(image: image!))),
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
