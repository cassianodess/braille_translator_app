import 'dart:io';

import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';

Future<void> saveAndLaunchFile(List<int> documentBytes, String fileName) async {
  String path = (await getExternalStorageDirectory())!.path;
  File file = File("$path/$fileName");
  await file.writeAsBytes(documentBytes, flush: true);
  OpenFile.open("$path/$fileName");
}
