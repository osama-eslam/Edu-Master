import 'package:edu_master/home_page/student/page/all_lessons_page.dart';
import 'package:edu_master/shared/colors/App%20colore.dart';
import 'package:flutter/material.dart';
import 'package:edu_master/ui/page/widget/teachers_slider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 4,
        backgroundColor: AppColors.blue,
        leading: const Padding(
          padding: EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundImage: AssetImage("assets/image/logo.png"),
            backgroundColor: Colors.white,
          ),
        ),
        title: const Text(
          "EduMaster",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22,
            letterSpacing: 1,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            TeachersSliderWidget(),
            SizedBox(height: 16),
            AllLessonspage(),
          ],
        ),
      ),
    );
  }
}
