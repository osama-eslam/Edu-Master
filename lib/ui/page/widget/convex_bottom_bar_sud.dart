import 'package:edu_master/home_page/student/page/Student_page_home.dart';
import 'package:edu_master/home_page/student/page/search_teacher_page.dart';
import 'package:edu_master/home_page/shared/utils/account_profile_screen.dart.dart';
import 'package:edu_master/shared/colors/App%20colore.dart';
import 'package:flutter/material.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';

class Navigationstudent extends StatefulWidget {
  const Navigationstudent({super.key});

  @override
  State<Navigationstudent> createState() => _NavigationstudentState();
}

class _NavigationstudentState extends State<Navigationstudent> {
  int _selectedIndex = 0;

  final List<Widget> pages = [
    HomePage(),
    SearchByTeacherPage(),
    AccountSettingsPage(),
  ];

  final List<TabItem> tabItems = const [
    TabItem(icon: Icons.home, title: 'الصفحه الرئيسية '),
    TabItem(icon: Icons.search, title: 'بحث'),
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
