import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import "package:braille_translator/styles/styles.dart";
import "../home/index.dart";

class LandingPage extends StatefulWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: landingPageBody(context),
    );
  }

  Widget landingPageBody(BuildContext context) {
    List<Widget> pages = [
      Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Faça Upload de uma image pela galeria ou use a câmera para tirar uma foto.",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
          Image.asset("assets/images/take_picture_upload_photo.jpg")
        ],
      ),
      Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Recorte a image de forma que foque no texto que deseja traduzir.",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
          Image.asset("assets/images/crop_image.jpeg"),
        ],
      ),
      Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Resultado da tradução em Braille e opção de Download e ouvir texto.",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
          Image.asset(
            "assets/images/braille.gif",
             height: Styles.deviceHeight(context) *.35, 
            fit: BoxFit.cover,
          ),
          TextButton(
            style: ButtonStyle(
              alignment: Alignment.center,
            ),
            onPressed: () => Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => Home()),
            ),
            child: Container(
              width: 100,
              height: 30,
              decoration: BoxDecoration(
                  color: Colors.blue, borderRadius: BorderRadius.circular(5)),
              child: Center(
                child: Text(
                  "COMEÇAR",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    ];

    return SizedBox(
      width: Styles.deviceWidth(context),
      height: Styles.deviceHeight(context),
      child: CarouselSlider(
        options: CarouselOptions(
          height: Styles.deviceHeight(context),
          viewportFraction: 1.0,
          enlargeCenterPage: false,
          enableInfiniteScroll: false,
        ),
        items: pages.map((page) {
          return Builder(
            builder: (BuildContext context) {
              return Container(
                width: Styles.deviceWidth(context),
                height: Styles.deviceHeight(context),
                padding: EdgeInsets.symmetric(horizontal: Styles.padding),
                // decoration: BoxDecoration(
                //     image: DecorationImage(
                //   fit: BoxFit.cover,
                //   image: AssetImage("assets/images/background.png"),
                // )),
                child: page,
              );
            },
          );
        }).toList(),
      ),
    );
  }
}
