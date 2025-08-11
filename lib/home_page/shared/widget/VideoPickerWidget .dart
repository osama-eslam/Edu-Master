import 'dart:io';

import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPickerWidget extends StatelessWidget {
  final File? video;
  final VideoPlayerController? videoController;
  final ChewieController? chewieController;
  final VoidCallback onPick;
  final VoidCallback? onRemove;

  const VideoPickerWidget({
    required this.video,
    required this.videoController,
    required this.chewieController,
    required this.onPick,
    this.onRemove,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final mediaHeight = MediaQuery.of(context).size.height;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "فيديو الحصة",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.white,
            boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
          ),
          child: Stack(
            children: [
              SizedBox(
                width: double.infinity,
                height: mediaHeight * 0.25,
                child:
                    chewieController != null &&
                            videoController!.value.isInitialized
                        ? ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Chewie(controller: chewieController!),
                        )
                        : TextButton.icon(
                          onPressed: onPick,
                          icon: const Icon(Icons.video_file),
                          label: const Text("اختر فيديو الحصة"),
                        ),
              ),
              if (video != null && onRemove != null)
                Positioned(
                  top: 8,
                  right: 8,
                  child: IconButton(
                    icon: const Icon(Icons.close, color: Colors.red),
                    onPressed: onRemove,
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
