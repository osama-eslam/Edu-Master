import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class LessonVideoPlayer extends StatelessWidget {
  final ChewieController? chewieController;
  final VideoPlayerController videoController;

  const LessonVideoPlayer({
    super.key,
    required this.chewieController,
    required this.videoController,
  });

  @override
  Widget build(BuildContext context) {
    if (chewieController != null && videoController.value.isInitialized) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: AspectRatio(
          aspectRatio: videoController.value.aspectRatio,
          child: Chewie(controller: chewieController!),
        ),
      );
    } else {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: CircularProgressIndicator(),
        ),
      );
    }
  }
}
