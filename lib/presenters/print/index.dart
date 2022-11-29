import 'dart:convert';
import 'dart:io';

import 'package:braille_translator/styles/styles.dart';
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

    if (response.isRight) {
      setState(() {
        text = utf8.decode(response.right.runes.toList());
      });
    } else {
      print(response.left);
    }
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
    return ListView(
      padding: EdgeInsets.all(Styles.padding),
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
            : Text(text)
      ],
    );
  }
}
