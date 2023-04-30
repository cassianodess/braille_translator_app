import 'dart:io';

import 'package:braille_translator/presenters/print/index.dart';
import 'package:braille_translator/shared/gradient.dart';
import 'package:braille_translator/styles/styles.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:flutter/services.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final ImagePicker _picker = ImagePicker();
  File? image;
  File? croppedImage;
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
          systemOverlayStyle: SystemUiOverlayStyle(statusBarColor: Colors.transparent),
          backgroundColor: Colors.transparent,
          toolbarHeight: 100.0,
          flexibleSpace:  Container(
            height: Styles.deviceHeight(context)*.2,
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
          title: gradientText(image == null ? "BRAILLE\nTRANSLATOR" : "Recorte"),
          automaticallyImplyLeading: false,
          actions: [
            if(image == null)IconButton(onPressed: null, icon: Icon(Icons.menu, color: Colors.white,))
          ],
        ),
        body: myBody(),
      ),
    );
  }

  Widget myBody() {
    Future<void> croppImage() async {
      File? currentCroppedImage = await ImageCropper().cropImage(
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

      if (currentCroppedImage != null) {
        setState(() {
          croppedImage = File(currentCroppedImage.path);
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
      }
    }

    Future<void> onFileAttachPressed() async {
      final XFile? imagePicked =
          await _picker.pickImage(source: ImageSource.gallery);
      if (imagePicked != null) {
        setState(() {
          image = File(imagePicked.path);
        });
      }
    }

    void clearImage() {
      setState(() {
        image = null;
        croppedImage = null;
      });
    }

    return Container(
      width: Styles.deviceWidth(context),
      height: Styles.deviceHeight(context),
      padding: EdgeInsets.all(Styles.padding),
      // decoration: BoxDecoration(
      //     image: DecorationImage(
      //   fit: BoxFit.cover,
      //   image: AssetImage("assets/images/background.png"),
      // )),
      child: image == null
          ? Stack(
            alignment: Alignment.center,
              children: [
                Positioned(
                  top: Styles.deviceHeight(context)*.2,
                  right: 0,
                  left: 0,
                  child: Image.asset(
                    "assets/images/braille.png",
                    width: 80,
                    height: 80,
                  ),
                ),
                Positioned(
                  top: Styles.deviceHeight(context)*.35,
                  bottom: 0,
                  right: 0,
                  left: 0,
                  child: Text(
                    "Tire uma foto ou escolha uma imagem da sua galeria para iniciar com a tradução.",
                     textAlign: TextAlign.center,
                     style: TextStyle(
                      fontWeight: FontWeight.w400,
                      color: Color(0xff8E8E8E),
                      fontSize: 20,
                     ),
                  )),
                Positioned(
                  top: Styles.deviceHeight(context)*.55,
                  child: Styles.customElevatedButton(
                    onCameraPressed,
                    Icons.camera_alt,
                    "TIRAR FOTO",
                  ),
                ),
                Positioned(
                  bottom: Styles.deviceHeight(context)*.1,
                  child: const Text("ou"),
                ),
                Positioned(
                  bottom: 0,
                  child: Styles.customElevatedButton(
                    onFileAttachPressed,
                    Icons.attach_file,
                    "ADICIONAR ARQUIVO",
                    backgroundColor: Colors.white,
                    textColor: Colors.blue,
                  ),
                )
              ],
            )
          : Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.only(bottom: 30),
                  child: AspectRatio(
                    aspectRatio: 1.1,
                    child: Image.file(
                      File(croppedImage == null
                          ? image!.path
                          : croppedImage!.path),
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: IconButton(
                    onPressed: () async => {await croppImage()},
                    icon: Icon(Icons.crop_rotate),
                    color: Colors.white,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Styles.customElevatedButton(
                      clearImage,
                      Icons.cancel_outlined,
                      "Cancelar",
                      backgroundColor: Colors.red,
                      textColor: Colors.white,
                    ),
                    Styles.customElevatedButton(
                      () => Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => PrintPage(
                              image: croppedImage == null
                                  ? image!
                                  : croppedImage!))),
                      Icons.check_circle_outline,
                      "Traduzir",
                    ),
                  ],
                )
              ],
            ),
    );
  }
}
