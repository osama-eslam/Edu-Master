import 'package:edu_master/Onboarding/Splash%20Screen.dart';
import 'package:edu_master/Onboarding/choose_user_type_page.dart';
import 'package:edu_master/Onboarding/model/entry_point.dart';
import 'package:edu_master/Onboarding/onboarding_page.dart';
import 'package:edu_master/auth/pages/Login_page.dart';
import 'package:edu_master/auth/pages/register.dart';
import 'package:edu_master/home_page/teacher/widget/convex_bottom_bar_Mr.dart';
import 'package:edu_master/ui/widget/convex_bottom_bar_sud.dart';
import 'package:edu_master/home_page/shared/utils/account_profile_screen.dart.dart';
import 'package:edu_master/home_page/student/page/Student_page_home.dart';

import 'package:edu_master/ui/page/my_lessons_screen.dart.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
      getPages: [
        GetPage(name: '/login', page: () => LoginPage()),
        GetPage(name: '/register', page: () => Register()),
        GetPage(name: '/homepage', page: () => HomePage()),
        GetPage(name: '/profile', page: () => AccountSettingsPage()),
        GetPage(name: '/mylessonpage', page: () => MyLessonsPage()),
        GetPage(name: '/navigationstudent', page: () => Navigationstudent()),
        GetPage(name: '/navigationteacher', page: () => NavigationTeacher()),
        GetPage(name: '/chooseusertypepage', page: () => ChooseUserTypePage()),
        GetPage(name: '/landingpage', page: () => LandingPage()),
        GetPage(name: '/onboarding', page: () => Onboarding()),
      ],
    );
  }
}
