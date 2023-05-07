import 'dart:io';

bool isImage(File file) {
  bool response = file.path.split(".").last == "png" || file.path.split(".").last == "jpg" || file.path.split(".").last == "jpeg";
  return response;
}