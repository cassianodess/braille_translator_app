import 'dart:async';
import 'dart:io';

import 'package:braille_translator/shared/toast.dart';
import 'package:braille_translator/styles/styles.dart';
import 'package:braille_translator/utils/to-pdf.dart';
import 'package:flutter/material.dart';

import 'package:braille_translator/services/translator.dart';

class PrintPage extends StatefulWidget {
  final File image;
  const PrintPage({
    Key? key,
    required this.image,
  }) : super(key: key);

  @override
  State<PrintPage> createState() => _PrintPageState();
}

class _PrintPageState extends State<PrintPage> {
  String braille = "";
  String text = "";
  bool isLoading = false;

  @override
  void initState() {
    sendImage();
    super.initState();
  }

  void setLoading(bool value) {
    setState(() {
      isLoading = value;
    });
  }

  Future<void> sendImage() async {
    setLoading(true);
    var response = await translate(widget.image);
    response.fold((Left) {
      Navigator.pop(context);
      showToast(
        context,
        "Não foi possível fazer a leitura.\nTente Novamente!",
        isError: true,
      );
    }, (right) {

      if(right.data.braille == "" || right.data.raw_text == "") {
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
      appBar: AppBar(
        title: const Text("Braille"),
      ),
      body: printBody(),
    );
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
                  height: Styles.deviceHeight(context) * .8,
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
                  height: Styles.deviceHeight(context) * .8,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                            border: Border.all(
                          color: Colors.black,
                        )),
                        child: SizedBox(
                          width: Styles.deviceWidth(context),
                          height: Styles.deviceHeight(context) * .7,
                          child: SingleChildScrollView(
                            child: SelectableText(
                              braille,
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontSize: 14,
                              ),
                              toolbarOptions: ToolbarOptions(
                                copy: true,
                                selectAll: true,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Styles.customElevatedButton(
                            () async => createPDF(text, "texto"),
                            Icons.picture_as_pdf,
                            "Texto",
                          ),
                          Styles.customElevatedButton(
                            () async => createPDF(braille, "braille"),
                            Icons.download,
                            "Braille",
                          ),
                        ],
                      )
                    ],
                  ),
                )
        ],
      ),
    );
  }
}
