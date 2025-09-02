import 'dart:io';
import 'package:video_player/video_player.dart';
import 'package:path_provider/path_provider.dart';

Future<VideoPlayerController> createVideoController(String videoPath) async {
  final filename = videoPath.split('/').last;
  final dir = await getApplicationDocumentsDirectory();
  final path = '${dir.path}/$filename';

  if (File(path).existsSync()) {
    return VideoPlayerController.file(File(path));
  } else {
    return VideoPlayerController.network(videoPath);
  }
}

String formatDuration(Duration duration) {
  String twoDigits(int n) => n.toString().padLeft(2, '0');
  final minutes = twoDigits(duration.inMinutes.remainder(60));
  final seconds = twoDigits(duration.inSeconds.remainder(60));
  return '$minutes:$seconds';
}
