import 'dart:convert';
import 'dart:io';

import 'package:braille_translator/usecases/models/response.dart';
import 'package:either_dart/either.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

Future<Either<dynamic, Response>> translate(File file, String name) async {
  String baseURL = "${dotenv.env["BASE_URL"]}/translate";

  var request = http.MultipartRequest("POST", Uri.parse(baseURL));

  Map<String, String> headers = {
    "Authorization": "Bearer ${dotenv.env["SECRET"]}",
    "Content-Type": "multipart/form-data"
  };

  request.headers.addAll(headers);

  http.MultipartFile multipartFile = http.MultipartFile(
    name.split(".")[1],
    file.readAsBytes().asStream(),
    file.lengthSync(),
    filename: name,
  );

  request.files.add(multipartFile);

  var streamedResponse = await request.send();
  var responseBytes = await streamedResponse.stream.toBytes();
  var responseString = String.fromCharCodes(responseBytes);
  var response = jsonDecode(responseString);

  if (response["status"] == 400) {
    return Left(response["message"]);
  }

  return Right(Response.fromJson(responseString));
}
