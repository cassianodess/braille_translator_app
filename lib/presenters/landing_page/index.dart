import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import "package:braille_translator/styles/styles.dart";
import "../home/index.dart";
import 'package:dots_indicator/dots_indicator.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: landingPageBody(context),
    );
  }

  Widget landingPageBody(BuildContext context) {
    List<Widget> pages = [
      Stack(
        children: [
          Positioned(
            top: Styles.deviceHeight(context) * .1,
            left: 0,
            right: 0,
            child: Container(
              padding: EdgeInsets.all(Styles.padding),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.blue.shade700
              ),
              child: Text(
                "Faça Upload de uma image pela galeria ou use a câmera para tirar uma foto.",
                style: Styles.landingPageHeaderStyle(),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Positioned(
           top: 0,
            bottom: 0,
            left: 0,
            right: 0,
            child: Image.asset(
              "assets/images/take_picture_upload_photo.jpg",              
            ),
          ),

        ],
      ),
      Stack(
        children: [
          Positioned(
            top: Styles.deviceHeight(context) * .1,
            left: 0,
            right: 0,
            child: Container(
              padding: EdgeInsets.all(Styles.padding),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.blue.shade700
              ),
              child: Text(
                "Recorte a image de forma que foque no texto que deseja traduzir.",
                style: Styles.landingPageHeaderStyle(),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Positioned(
            child: Image.asset("assets/images/crop_image.jpeg"),
            top: 0,
            bottom: 0,
            left: 0,
            right: 0,
          ),
        ],
      ),
      Stack(
        children: [
          Positioned(
            top: Styles.deviceHeight(context) * .1,
            left: 0,
            right: 0,
            child: Container(
              padding: EdgeInsets.all(Styles.padding),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.blue.shade700
              ),
              child: Text(
                "Resultado da tradução em Braille e opção de Download e ouvir texto.",
                style: Styles.landingPageHeaderStyle(),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: Styles.deviceHeight(context)*.2,
            child: Image.asset(
              "assets/images/braille.gif",
               height: Styles.deviceHeight(context) *.5,
               fit: BoxFit.cover, 
            ),
          ),
          Positioned(
            right: 0,
            bottom: Styles.deviceHeight(context) * .03,
            child: TextButton(
              style: ButtonStyle(
                alignment: Alignment.center,
              ),
              onPressed: () => Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => Home()),
              ),
              child: Container(
                width: 100,
                height: 30,
                decoration: BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.circular(5)),
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
          ),
        ],
      ),
    ];

    return SizedBox(
      width: Styles.deviceWidth(context),
      height: Styles.deviceHeight(context),
      child: Stack(
        children: [
          CarouselSlider(
            options: CarouselOptions(
              height: Styles.deviceHeight(context) * 5,
              viewportFraction: 1,
              enlargeCenterPage: true,
              enableInfiniteScroll: false,
              onPageChanged: (index, reason) {
                setState(() {
                  this.currentIndex = index;
                });
              },
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
          Positioned(
            bottom: Styles.deviceHeight(context) * .05,
            left: 0,
            right: 0,
            child: DotsIndicator(
              dotsCount: pages.length,
              position: currentIndex.toDouble(),
              decorator: DotsDecorator(
                size: const Size.square(9.0),
                activeSize: const Size(18.0, 9.0),
                activeShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
              ),
            ),
          )
        ],
      ),
    );
  }
}
