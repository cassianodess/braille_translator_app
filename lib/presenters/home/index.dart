import 'dart:io';

import 'package:braille_translator/presenters/about/index.dart';
import 'package:braille_translator/presenters/landing_page/index.dart';
import 'package:braille_translator/presenters/print/index.dart';
import 'package:braille_translator/shared/gradient.dart';
import 'package:braille_translator/styles/styles.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import '../../shared/custom-appbar.dart';
import 'package:file_picker/file_picker.dart';
import '../../utils/isImage.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final ImagePicker _picker = ImagePicker();
  File? file;
  File? croppedImage;
  String text = "";
  var currentTime = null;

  void clearImage() {
    setState(() {
      file = null;
      croppedImage = null;
    });
  }

  Future<void> croppImage() async {
      File? currentCroppedImage = await ImageCropper().cropImage(
        sourcePath: file!.path,
        aspectRatioPresets: [
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.ratio3x2,
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.ratio4x3,
          CropAspectRatioPreset.ratio16x9
        ],
        androidUiSettings: const AndroidUiSettings(
          toolbarTitle: '',
          toolbarColor: Color(0xFF0D47A1),
          toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.original,
          lockAspectRatio: false,
          showCropGrid: true,
        ),
        iosUiSettings: const IOSUiSettings(
          title: 'AJUSTES',
        ),
      );

      if (currentCroppedImage != null) {
        setState(() {
          croppedImage = File(currentCroppedImage.path);
        });
      }
    }

    Future<void> onCameraPressed() async {
      final XFile? imagePicked = await _picker.pickImage(source: ImageSource.camera);
      if (imagePicked != null) {
        setState(() {
          file = File(imagePicked.path);
        });
      }
    }

    Future<void> onFileAttachPressed() async {
      FilePickerResult? filePicked = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['jpg', 'png', 'pdf', 'docx', 'txt'],
      );
      if (filePicked != null) {
        setState(() {
          file = File(filePicked.files.single.path!);
        });
      } 

    }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        if (file != null) {
          setState(() {
            file = null;
          });
          return Future.value(false);
        } 
        DateTime now = DateTime.now();
        if(currentTime == null || now.difference(currentTime as DateTime) > Duration(seconds: 2)) {
          setState(() {
            currentTime = now;
          });
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Pressione voltar duas vezes seguidas para sair."))
          );
          return Future.value(false);
        }
        return Future.value(true);
      },
      child: Scaffold(
        appBar: CustomAppBar(
          context,
          Styles.deviceHeight(context)*.2,
          gradientText(file == null ? "BRAILLE TRANSLATOR" : "AJUSTES"),
          isCentered: true,
          actions: [
            if(file == null) PopupMenuButton(
              onSelected: (String route) {
                if(route == "/landing-page") {
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) => LandingPage(cameFromHome: true),
                      transitionDuration: Duration(seconds: 0),
                      reverseTransitionDuration: Duration(seconds: 0)
                    )
                  );
                } else {
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) => AboutPage(),
                      transitionDuration: Duration(seconds: 0),
                      reverseTransitionDuration: Duration(seconds: 0)
                    )
                  );
                }
              },
              itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              const PopupMenuItem<String>(
                value: "/landing-page",
                child: Text("Ajuda"),
              ),
              const PopupMenuItem<String>(
                value: "/about",
                child: Text('Sobre nós'),
              ),
            ])
          ]
        ),
        body: myBody(),
      ),
    );
  }

  Widget myBody() {
    return Container(
      width: Styles.deviceWidth(context),
      height: Styles.deviceHeight(context),
      padding: EdgeInsets.all(Styles.padding),
      // decoration: BoxDecoration(
      //     image: DecorationImage(
      //   fit: BoxFit.cover,
      //   image: AssetImage("assets/images/background.png"),
      // )),
      child: file == null
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
                    "Tire uma foto ou escolha um arquivo de imagem, txt, pdf ou docx da sua galeria para iniciar com a tradução.",
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
                  decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  margin: const EdgeInsets.only(bottom: 30),
                  child: AspectRatio(
                    aspectRatio: 1.1,
                    child: isImage(file!) ? Image.file(
                      File(croppedImage == null
                          ? file!.path
                          : croppedImage!.path),
                    ) : Icon(
                       file!.path.split(".").last == "pdf" ? Icons.picture_as_pdf : Icons.edit_document,
                      size: Styles.deviceHeight(context)*.2,
                      color: file!.path.split(".").last == "pdf"? Colors.red : Colors.blue,
                    ),
                  ),
                ),
                isImage(file!) ? Container(
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: IconButton(
                    onPressed: () async => {await croppImage()},
                    icon: Icon(Icons.crop_rotate),
                    color: Colors.white,
                  ),
                ) : Container(
                  child: Styles.SubTitle(file!.path.split("/").last),
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
                      () => Navigator.push(
                        context,
                        PageRouteBuilder(
                          pageBuilder: (context, animation, secondaryAnimation) => PrintPage(
                                  file: croppedImage == null
                                      ? file!
                                      : croppedImage!),
                          transitionDuration: Duration(seconds: 0),
                          reverseTransitionDuration: Duration(seconds: 0)
                        )
                      ),
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
