import 'dart:async';
import 'dart:io';

import 'package:braille_translator/shared/toast.dart';
import 'package:braille_translator/styles/styles.dart';
import 'package:braille_translator/utils/to-pdf.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:text_to_speech/text_to_speech.dart';
import 'package:braille_translator/services/translator.dart';
import '../../shared/custom-appbar.dart';
import 'package:braille_translator/shared/gradient.dart';

class PrintPage extends StatefulWidget {
  final File file;
  const PrintPage({
    Key? key,
    required this.file,
  }) : super(key: key);

  @override
  State<PrintPage> createState() => _PrintPageState();
}

class _PrintPageState extends State<PrintPage> {
  String braille = "";
  String text = "";
  bool isLoading = false;
  String errorText = "Erro ao tentar reproduzir texto!";
  TextToSpeech tts = TextToSpeech();
  final String defaultLanguage = 'pt-BR';
  double volume = 1;
  double rate = 1.0;
  double pitch = 1.0;
  String? language;
  String? languageCode;
  List<String> languages = <String>[];
  List<String> languageCodes = <String>[];
  String? voice;
  bool supportPause = defaultTargetPlatform != TargetPlatform.android;
  bool supportResume = defaultTargetPlatform != TargetPlatform.android;


  Future<void> initLanguages() async {
    languageCodes = await tts.getLanguages();

    final List<String>? displayLanguages = await tts.getDisplayLanguages();
    if (displayLanguages == null) {
      return;
    }

    languages.clear();
    for (final dynamic lang in displayLanguages) {
      languages.add(lang as String);
    }

    final String? defaultLangCode = await tts.getDefaultLanguage();
    if (defaultLangCode != null && languageCodes.contains(defaultLangCode)) {
      languageCode = defaultLangCode;
    } else {
      languageCode = defaultLanguage;
    }
    language = await tts.getDisplayLanguageByCode(languageCode!);

    voice = await getVoiceByLang(languageCode!);

    if (mounted) {
      setState(() {});
    }
  }

  Future<String?> getVoiceByLang(String lang) async {
    final List<String>? voices = await tts.getVoiceByLang(languageCode!);
    if (voices != null && voices.isNotEmpty) {
      return voices.first;
    }
    return null;
  }

  @override
  void initState() {
    sendFile();
    super.initState();
  }

  void setLoading(bool value) {
    setState(() {
      isLoading = value;
    });
  }

  Future<void> sendFile() async {
    setLoading(true);
    var response = await translate(widget.file, widget.file.path.split("/").last);
    response.fold((left) {
      Navigator.pop(context);
      showToast(
        context,
        "Não foi possível fazer a leitura.\nTente Novamente!",
        isError: true,
      );
    }, (right) {
      if (right.data.braille == "" || right.data.raw_text == "") {
        Navigator.pop(context);
        showToast(context, "Erro de leitura, tente novamente!", isError: true);
      }

      setState(() {
        braille = right.data.braille;
        text = right.data.raw_text;
      });
    });

    setLoading(false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
          context,
          Styles.deviceHeight(context)*.2,
          gradientText("BRAILLE TRANSLATOR"),
          canPop: true,
          isCentered: true,
        ),
      body: printBody(),
    );
  }

  void speak() async {
    await tts.setVolume(volume);
    await tts.setRate(rate);
    if (languageCode != null) {
      await tts.setLanguage(languageCode!);
    }
    await tts.setPitch(pitch);
    var result = await tts.speak(text);
    if(!result!) {
      await tts.speak(errorText);
      showToast(context, errorText, isError: true);
    }
  }

  void stop() async {
    await tts.stop();
  }

  Widget printBody() {
    return Container(
      padding: EdgeInsets.all(Styles.padding),
      height: Styles.deviceHeight(context),
      child: Column(
        children: [
          isLoading
              ? SizedBox(
                  width: Styles.deviceWidth(context),
                  height: Styles.deviceHeight(context) * .6,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: const [
                      CircularProgressIndicator(
                        color: Colors.blue,
                      )
                    ],
                  ),
                )
              : SizedBox(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade600,
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(
                              color: Colors.black,
                            )),
                        child: SizedBox(
                          width: Styles.deviceWidth(context),
                          height: Styles.deviceHeight(context) * .6,
                          child: SingleChildScrollView(
                            child: SelectableText(
                              braille,
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontSize: 24,
                                color: Colors.white,
                                overflow: TextOverflow.fade,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: Styles.padding*2),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Styles.customElevatedButton(
                              () async => stop(),
                              Icons.stop_circle,
                              "Parar",
                            ),
                            Styles.customElevatedButton(
                              () async => speak(),
                              Icons.play_circle,
                              "Ouvir",
                            ),
                            Styles.customElevatedButton(
                              () async => createPDF(braille, "braille"),
                              Icons.download,
                              "PDF",
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                )
        ],
      ),
    );
  }
}
