// 📁 controller/student_lessons_controller.dart
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class StudentLessonsController extends ChangeNotifier {
  final DatabaseReference _lessonsRef = FirebaseDatabase.instance.ref(
    "lessons",
  );
  List<Map<String, dynamic>> lessons = [];
  bool isLoading = true;

  Future<void> fetchLessons() async {
    final snapshot = await _lessonsRef.get();

    if (snapshot.exists) {
      final data = snapshot.value as Map<dynamic, dynamic>;
      final temp =
          data.values
              .map((e) => Map<String, dynamic>.from(e))
              .where(
                (lesson) =>
                    lesson['imageUrl'] != null &&
                    lesson['title'] != null &&
                    lesson['teacherName'] != null,
              )
              .toList();

      lessons = temp.reversed.toList();
    }

    isLoading = false;
    if (hasListeners) {
      notifyListeners();
    }
  }
}
