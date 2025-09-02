import 'dart:io';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';

Future<String?> downloadVideo() async {
  final url = 'https://ahmadshamma.pythonanywhere.com';
  final filename = url.split('/').last;

  final dir = await getApplicationDocumentsDirectory();
  final filePath = '${dir.path}/$filename';

  final file = File(filePath);
  if (await file.exists()) {
    // Already downloaded
    return filePath;
  }

  try {
    await Dio().download(url, filePath);
    return filePath;
  } catch (e) {
    print('Download failed: $e');
    return null;
  }
}
