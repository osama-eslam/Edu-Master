import 'package:edu_master/ui/widget/lesson_detail_card.dart';
import 'package:edu_master/ui/widget/lesson_video_player.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:edu_master/home_page/controller/lesson_detail_controller_Mr.dart';
import 'package:edu_master/shared/colors/App colore.dart';

class LessonDetailPage extends StatefulWidget {
  final Map<String, dynamic> lesson;

  const LessonDetailPage({super.key, required this.lesson});

  @override
  State<LessonDetailPage> createState() => _LessonDetailPageState();
}

class _LessonDetailPageState extends State<LessonDetailPage> {
  final LessonDetailController controller = LessonDetailController();
  String? currentUserId;

  @override
  void initState() {
    super.initState();

    currentUserId = FirebaseAuth.instance.currentUser?.uid;

    controller.initializeVideo(widget.lesson['videoUrl']).then((_) {
      if (mounted) setState(() {});
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Future<void> _deleteLesson() async {
    final confirm = await showDialog<bool>(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('تأكيد الحذف'),
            content: const Text('هل أنت متأكد أنك تريد حذف هذه الحصة؟'),
            actions: [
              TextButton(
                child: const Text('إلغاء'),
                onPressed: () => Navigator.of(context).pop(false),
              ),
              TextButton(
                child: const Text('حذف', style: TextStyle(color: Colors.red)),
                onPressed: () => Navigator.of(context).pop(true),
              ),
            ],
          ),
    );

    if (confirm == true) {
      await controller.deleteLesson(context: context, lesson: widget.lesson);
    }
  }

  @override
  Widget build(BuildContext context) {
    final lesson = widget.lesson;
    final screenWidth = MediaQuery.of(context).size.width;
    double baseFontSize(double size) => screenWidth > 600 ? size * 1.2 : size;

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text(lesson['title'] ?? ''),
        backgroundColor: AppColors.blue,
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 700),
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              LessonVideoPlayer(
                chewieController: controller.chewieController,
                videoController: controller.videoController,
              ),
              const SizedBox(height: 20),
              LessonDetailCard(
                lesson: lesson,
                baseFontSize: baseFontSize,
                isOwner: lesson['teacherId'] == currentUserId,
                topAction:
                    lesson['teacherId'] == currentUserId
                        ? IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: _deleteLesson,
                        )
                        : null,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
