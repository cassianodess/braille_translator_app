import 'dart:io';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

Future<void> translate(File image) async {
  try {
    String baseURL = "${dotenv.env["BASE_URL"]}/translator";

    var request = http.MultipartRequest("POST", Uri.parse(baseURL));

    Map<String, String> headers = {
      "Authorization": "",
      "Content-Type": "multipart/form-data"
    };

    request.headers.addAll(headers);

    http.MultipartFile multipartFile = http.MultipartFile(
      "image",
      image.readAsBytes().asStream(),
      image.lengthSync(),
      filename: "image.jpeg",
    );

    request.files.add(multipartFile);

    var streamedResponse = await request.send();
    var responseBytes = await streamedResponse.stream.toBytes();
    var response = String.fromCharCodes(responseBytes);
    print(response);
  } on Exception catch (e) {
    print("DEU RUIM");
    print(e);
  }
}
