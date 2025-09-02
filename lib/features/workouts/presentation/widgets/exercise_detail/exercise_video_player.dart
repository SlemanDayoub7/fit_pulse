import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:gym_app/core/theme/app_text.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ExerciseVideoPlayer extends StatefulWidget {
  final String videoUrl;
  final String title;

  const ExerciseVideoPlayer({
    super.key,
    required this.videoUrl,
    required this.title,
  });

  @override
  State<ExerciseVideoPlayer> createState() => _ExerciseVideoPlayerState();
}

class _ExerciseVideoPlayerState extends State<ExerciseVideoPlayer> {
  late VideoPlayerController _controller;
  bool _isInitialized = false;
  bool _isMuted = false;
  bool _isDownloading = false;
  double _downloadProgress = 0;

  @override
  void initState() {
    super.initState();
    _initializeVideo();
  }

  Future<void> _initializeVideo() async {
    final url = 'https://ahmadshamma.pythonanywhere.com${widget.videoUrl}';
    final filename = url.split('/').last;
    final dir = await getApplicationDocumentsDirectory();
    final path = '${dir.path}/$filename';

    if (File(path).existsSync()) {
      _controller = VideoPlayerController.file(File(path));
    } else {
      _controller = VideoPlayerController.network(url);
    }

    await _controller.initialize();
    _controller.setLooping(true);
    setState(() => _isInitialized = true);
  }

  Future<void> _downloadVideo() async {
    setState(() {
      _isDownloading = true;
      _downloadProgress = 0;
    });

    final url = 'https://ahmadshamma.pythonanywhere.com${widget.videoUrl}';
    final filename = url.split('/').last;
    final dir = await getApplicationDocumentsDirectory();
    final path = '${dir.path}/$filename';

    if (File(path).existsSync()) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Video already downloaded.")));
      setState(() => _isDownloading = false);
      return;
    }

    try {
      await Dio().download(
        url,
        path,
        onReceiveProgress: (rec, total) {
          setState(() => _downloadProgress = rec / total);
        },
      );
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Download complete.")));
    } catch (_) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Download failed.")));
    } finally {
      setState(() => _isDownloading = false);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return '$minutes:$seconds';
  }

  @override
  Widget build(BuildContext context) {
    if (!_isInitialized) {
      return Container(
        height: 260.h,
        color: Colors.black12,
        child: const Center(child: CircularProgressIndicator()),
      );
    }

    return GestureDetector(
      onTap: () => setState(() {
        _controller.value.isPlaying ? _controller.pause() : _controller.play();
      }),
      child: Container(
        height: 260.h,
        width: double.infinity,
        color: Colors.black,
        child: Stack(
          alignment: Alignment.center,
          children: [
            AspectRatio(
              aspectRatio: _controller.value.aspectRatio,
              child: VideoPlayer(_controller),
            ),
            if (!_controller.value.isPlaying)
              Icon(Icons.play_circle_fill_rounded,
                  size: 72.sp, color: Colors.white.withOpacity(0.85)),
            _buildTopBar(),
            _buildBottomOverlay(),
          ],
        ),
      ),
    );
  }

  Widget _buildTopBar() {
    return Positioned(
      top: 20.h,
      left: 16.w,
      right: 16.w,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CircleAvatar(
            backgroundColor: Colors.black54,
            child: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.white, size: 20.sp),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          Row(
            children: [
              IconButton(
                icon: Icon(
                    _isMuted ? Icons.volume_off : Icons.volume_up_rounded,
                    color: Colors.white,
                    size: 24.sp),
                onPressed: () {
                  setState(() {
                    _isMuted = !_isMuted;
                    _controller.setVolume(_isMuted ? 0.0 : 1.0);
                  });
                },
              ),
              _isDownloading
                  ? SizedBox(
                      height: 24,
                      width: 24,
                      child: CircularProgressIndicator(
                          value: _downloadProgress,
                          color: Colors.white,
                          strokeWidth: 2),
                    )
                  : IconButton(
                      icon: Icon(Icons.download_rounded,
                          color: Colors.white, size: 24.sp),
                      onPressed: _downloadVideo,
                    ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBottomOverlay() {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.transparent, Colors.black.withOpacity(0.7)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppText.s24W600.copyWith(
                color: Colors.white,
                shadows: [
                  Shadow(
                      color: Colors.black54,
                      offset: Offset(0, 1),
                      blurRadius: 4)
                ],
              ),
            ),
            SizedBox(height: 6.h),
            Row(
              children: [
                Expanded(
                  child: VideoProgressIndicator(
                    _controller,
                    allowScrubbing: true,
                    colors: VideoProgressColors(
                      playedColor: Colors.redAccent,
                      backgroundColor: Colors.white24,
                      bufferedColor: Colors.white38,
                    ),
                    padding: EdgeInsets.zero,
                  ),
                ),
                SizedBox(width: 8.w),
                Text(
                  '${_formatDuration(_controller.value.position)} / ${_formatDuration(_controller.value.duration)}',
                  style: AppText.s12w600.copyWith(color: Colors.white70),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
