import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

Future<void> downloadVideo(
  BuildContext context,
  String url,
  Function(double) onProgress,
) async {
  final filename = url.split('/').last;
  final dir = await getApplicationDocumentsDirectory();
  final path = '${dir.path}/$filename';

  if (File(path).existsSync()) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text("Video already downloaded.")));
    return;
  }

  try {
    await Dio().download(
      url,
      path,
      onReceiveProgress: (rec, total) {
        onProgress(rec / total);
      },
    );
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text("Download complete.")));
  } catch (e) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text("Download failed.")));
  }
}
