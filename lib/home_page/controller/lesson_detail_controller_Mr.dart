import 'package:chewie/chewie.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class LessonDetailController {
  late VideoPlayerController videoController;
  ChewieController? chewieController;

  Future<void> initializeVideo(String videoUrl) async {
    videoController = VideoPlayerController.network(videoUrl);
    await videoController.initialize();
    chewieController = ChewieController(
      videoPlayerController: videoController,
      autoPlay: false,
      looping: false,
      allowFullScreen: true,
    );
  }

  void dispose() {
    videoController.dispose();
    chewieController?.dispose();
  }

  Future<void> deleteLesson({
    required BuildContext context,
    required Map<String, dynamic> lesson,
  }) async {
    try {
      if (lesson['id'] != null && lesson['teacherId'] != null) {
        final dbRef1 = FirebaseDatabase.instance
            .ref()
            .child('lessons')
            .child(lesson['id']);

        await dbRef1.remove();

        if (context.mounted) {
          Navigator.of(context).pop();
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text('تم حذف الحصة بنجاح')));
        }
      } else {
        throw Exception("المعرفات مفقودة");
      }
    } catch (e) {
      print("❌ فشل في حذف الحصة: $e");
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('حدث خطأ أثناء حذف الحصة')),
        );
      }
    }
  }
}
