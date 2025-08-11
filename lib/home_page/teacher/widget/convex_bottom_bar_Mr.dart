import 'package:edu_master/home_page/shared/utils/account_profile_screen.dart.dart';
import 'package:edu_master/shared/colors/App%20colore.dart';
import 'package:edu_master/ui/page/lesson_upload_screen.dart.dart';
import 'package:edu_master/ui/page/my_lessons_screen.dart.dart';
import 'package:flutter/material.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';

class NavigationTeacher extends StatefulWidget {
  const NavigationTeacher({super.key});

  @override
  State<NavigationTeacher> createState() => _NavigationTeacherState();
}

class _NavigationTeacherState extends State<NavigationTeacher> {
  int _selectedIndex = 0;

  final List<Widget> pages = [
    MyLessonsPage(),
    UploadLessonPage(),
    AccountSettingsPage(),
  ];

  final List<TabItem> tabItems = const [
    TabItem(icon: Icons.list_alt, title: 'حصصي'),
    TabItem(icon: Icons.upload_file, title: 'رفع حصة'),
    TabItem(icon: Icons.settings, title: 'الإعدادات'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_selectedIndex],
      bottomNavigationBar: ConvexAppBar(
        backgroundColor: AppColors.blue,
        activeColor: AppColors.white,
        style: TabStyle.reactCircle,
        items: tabItems,
        initialActiveIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}
