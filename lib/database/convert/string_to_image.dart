import 'dart:io';
import 'dart:typed_data';
import 'dart:convert';
import 'package:path_provider/path_provider.dart';

class ConvertImageToString {
  static Future<File> stringToImg(String enncodeString) async {
    Uint8List bytes = base64.decode(enncodeString);
    String dir = (await getApplicationDocumentsDirectory()).path;
    File file = File(
        "$dir/" + DateTime.now().millisecondsSinceEpoch.toString() + ".jpg");
    return await file.writeAsBytes(bytes);
  }

  static Future<String> imgToString(File file) async {
    Uint8List bytes = await file.readAsBytes();
    return base64Encode(bytes);
  }
}
