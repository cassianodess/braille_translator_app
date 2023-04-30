import 'package:braille_translator/shared/custom-appbar.dart';
import 'package:braille_translator/styles/styles.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        context,
        200,
        Text("SOBRE NÓS"),
        isCentered: true,
        canPop: true,
      ),
      body: aboutBody(),
    );
  }

  Widget aboutBody() {

    Future<void> _makePhoneCall(String phoneNumber) async {
      final Uri launchUri = Uri(
        scheme: 'tel',
        path: phoneNumber,
      );
      if(await canLaunchUrl(launchUri)) {
        await launchUrl(launchUri);
      } else {
        throw 'Could not launch $phoneNumber';

      }
    }

    Future<void> _launchURL(String url) async {
      if(await canLaunchUrl(Uri.parse(url))) {
        await launchUrl(Uri.parse(url));
      } else {
        throw 'Could not launch $url';
      }
    }


    
    return Container(
      width: Styles.deviceWidth(context),
      height: Styles.deviceHeight(context),
      padding: EdgeInsets.all(Styles.padding),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Styles.Title("Objetivo"),
            Styles.SubTitle('Desenvolver uma aplicação (APP – abreviatura em inglês para Application) que permita oferecer maior autonomia aos deficientes visuais através de tecnologias ubíquas e pervasivas. Para alcançar este objetivo a aplicação permite traduzir um texto em uma página web para o alfabeto Braille e salvar em um formato imagem para posterior impressão. A vantagem deste tipo de aplicação é que caso do usuário não possua uma impressora Braille, devido ao seu alto custo, é possível utilizar a estratégia de imprimir que qualquer impressora e posteriormente marcar os pontos com tinta (ou cola) alto relevo ou mesmo pode fazer pequenos furos (do verso) e guardar o documento para leitura. Sabe-se que existem várias tecnologias que auxiliam os cegos a ler documentos (textos na web). Leitores de tela são programas que, interagindo com o Sistema Operacional do computador, capturam toda e qualquer informação apresentada na forma de texto e a transforma em uma resposta falada através de um sintetizador de voz. O leitor de tela “varre” os programas em busca de informações que podem ser lidas para o usuário, possibilitando a navegação por menus, janelas e textos presentes em praticamente qualquer aplicativo. A navegação é feita através de um teclado comum, dispensando o uso do mouse na maior parte do tempo. Nenhuma adaptação especial é necessária para que o programa funcione. Entretanto, essas tecnologias não permitem salvar os documentos lido no alfabeto Braille para que possam ser armazenados tanto em formato digital como em formato em papel.'),
            Styles.Title("Desenvolvedores"),
            Styles.DevelopersContainer(
              "Cassiano de Souza Santos", [
              GestureDetector(
                child: Image.asset(
                  "assets/images/phone-call.png",
                  height: 20,
                ),
                onTap: () => _makePhoneCall("5521973373791"),
              ),
              GestureDetector(
                child: Image.asset(
                  "assets/images/whatsapp-logo.png",
                  height: 20,
                ),
                onTap: () => _launchURL("whatsapp://send?phone=5521973373791"),
              ),
              GestureDetector(
                onTap: () => _launchURL("https://github.com/cassianodess"),
                child: Image.asset(
                "assets/images/github-logo.png",
                height: 20,
                ),
              ),
              GestureDetector(
                onTap: () => _launchURL("https://www.linkedin.com/in/cassianodess/"),
                child: Image.asset(
                  "assets/images/linkedin-logo.png",
                  height: 20,
                ),
              )]),

            Styles.DevelopersContainer(
              "Rafael Oliveira", [
                GestureDetector(
                child: Image.asset(
                  "assets/images/phone-call.png",
                  height: 20,
                ),
                onTap: () => _makePhoneCall("5521973688896"),
              ),
              GestureDetector(
                child: Image.asset(
                  "assets/images/whatsapp-logo.png",
                  height: 20,
                ),
                onTap: () => _launchURL("whatsapp://send?phone=5521973688896"),
              ),
              GestureDetector(
                onTap: () => _launchURL("https://github.com/Oliveira00"),
                child: Image.asset(
                "assets/images/github-logo.png",
                height: 20,
                ),
              ),
              GestureDetector(
                onTap: () => _launchURL("https://www.linkedin.com/in/rafael-0liveira/"),
                child: Image.asset(
                  "assets/images/linkedin-logo.png",
                  height: 20,
                ),
              )]),
            
            
          ],
        ),
      ),
    );
  }
}