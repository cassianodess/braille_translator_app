import 'dart:convert';
import 'dart:io';

import 'package:braille_translator/usecases/models/response.dart';
import 'package:either_dart/either.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

Future<Either<dynamic, Response>> translate(File image) async {
  String baseURL = "${dotenv.env["BASE_URL"]}/translate";

  var request = http.MultipartRequest("POST", Uri.parse(baseURL));

  Map<String, String> headers = {
    "Authorization": "Bearer ${dotenv.env["SECRET"]}",
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
  var responseString = String.fromCharCodes(responseBytes);
  var response = Response.fromJson(responseString);

  if (streamedResponse.statusCode == 200) {
    return Right(response);
  }

  return Left(response.message);
}
