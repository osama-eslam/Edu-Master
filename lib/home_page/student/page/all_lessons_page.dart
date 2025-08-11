// 📁 widget/all_lessons_widget.dart
import 'package:edu_master/home_page/controller/all_lessons_controller.dart';
import 'package:edu_master/home_page/shared/utils/lesson_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AllLessonspage extends StatelessWidget {
  const AllLessonspage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => StudentLessonsController()..fetchLessons(),
      child: Consumer<StudentLessonsController>(
        builder: (context, controller, _) {
          if (controller.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (controller.lessons.isEmpty) {
            return const Center(child: Text("لا توجد حصص حالياً"));
          }

          return Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  child: Text(
                    "📚 أحدث الحصص",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1565C0),
                    ),
                  ),
                ),
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 0.75,
                  ),
                  itemCount: controller.lessons.length,
                  itemBuilder: (context, index) {
                    final lesson = controller.lessons[index];

                    return InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => LessonDetailPage(lesson: lesson),
                          ),
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.15),
                              blurRadius: 8,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: const BorderRadius.vertical(
                                top: Radius.circular(16),
                              ),
                              child: Image.network(
                                lesson['imageUrl'] ??
                                    'https://via.placeholder.com/300',
                                height: 120,
                                width: double.infinity,
                                fit: BoxFit.contain,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    lesson['title'] ?? 'بدون عنوان',
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF0D47A1),
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 6),
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.person,
                                        size: 16,
                                        color: Colors.grey,
                                      ),
                                      const SizedBox(width: 4),
                                      Expanded(
                                        child: Text(
                                          lesson['teacherName'] ??
                                              'معلم غير معروف',
                                          style: const TextStyle(
                                            fontSize: 13,
                                            color: Colors.grey,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
