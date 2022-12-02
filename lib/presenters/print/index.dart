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
      setState(() {
        text = response.right;
      });
    });

    setLoading(false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Print"),
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
                      SizedBox(
                        width: Styles.deviceWidth(context),
                        height: Styles.deviceHeight(context) * .7,
                        child: SingleChildScrollView(
                          child: SelectableText(
                            text,
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontSize: 25,
                            ),
                            toolbarOptions: ToolbarOptions(
                              copy: true,
                              selectAll: true,
                            ),
                          ),
                        ),
                      ),
                      Styles.customElevatedButton(
                        () async => createPDF(text),
                        Icons.picture_as_pdf,
                        "Download",
                      ),
                    ],
                  ),
                )
        ],
      ),
    );
  }
}
