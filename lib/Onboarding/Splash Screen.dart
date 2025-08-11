import 'dart:async';
import 'package:edu_master/Onboarding/choose_user_type_page.dart';
import 'package:edu_master/Onboarding/onboarding_page.dart';
import 'package:edu_master/auth/pages/Login_page.dart';
import 'package:edu_master/home_page/teacher/widget/convex_bottom_bar_Mr.dart';
import 'package:edu_master/ui/widget/convex_bottom_bar_sud.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _logoController;
  late Animation<double> _logoScale;

  late AnimationController _textController;
  late Animation<double> _textFade;

  @override
  @override
  void initState() {
    super.initState();

    _logoController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    _logoScale = Tween<double>(begin: 0.95, end: 1.05).animate(
      CurvedAnimation(parent: _logoController, curve: Curves.easeInOut),
    );

    _textController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _textFade = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(parent: _textController, curve: Curves.easeIn));

    _textController.forward();

    Timer(const Duration(seconds: 4), _navigateUser);
  }

  @override
  void dispose() {
    _logoController.dispose();
    _textController.dispose();
    super.dispose();
  }

  Future<void> _navigateUser() async {
    final prefs = await SharedPreferences.getInstance();
    final seenOnboarding = prefs.getBool('seenOnboarding') ?? false;
    final user = FirebaseAuth.instance.currentUser;

    if (!seenOnboarding) {
      await prefs.remove('seenOnboarding');

      Navigator.pushReplacement(
        context,
        PageTransition(
          type: PageTransitionType.rightToLeftWithFade,
          duration: Duration(milliseconds: 600),
          child: const Onboarding(),
        ),
      );
    } else if (user == null) {
      Navigator.pushReplacement(
        context,
        PageTransition(
          type: PageTransitionType.rightToLeftWithFade,
          duration: Duration(milliseconds: 600),
          child: const LoginPage(),
        ),
      );
    } else {
      final uid = user.uid;
      final ref = FirebaseDatabase.instance.ref("users/$uid/userType");
      final snapshot = await ref.get();

      if (snapshot.exists) {
        final userType = snapshot.value.toString();
        Widget nextPage;

        if (userType == "طالب") {
          nextPage = const Navigationstudent();
        } else if (userType == "معلم") {
          nextPage = const NavigationTeacher();
        } else {
          nextPage = const ChooseUserTypePage();
        }

        Navigator.pushReplacement(
          context,
          PageTransition(
            type: PageTransitionType.rightToLeftWithFade,
            duration: Duration(milliseconds: 600),
            child: nextPage,
          ),
        );
      } else {
        Navigator.pushReplacement(
          context,
          PageTransition(
            type: PageTransitionType.rightToLeftWithFade,
            duration: Duration(milliseconds: 600),
            child: const ChooseUserTypePage(),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF141e30), Color(0xFF243b55)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ScaleTransition(
              scale: _logoScale,
              child: Container(
                width: 140,
                height: 140,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.blueAccent.withOpacity(0.2),
                  border: Border.all(color: Colors.white24, width: 1),
                ),
                child: Center(
                  child: Image.asset(
                    "assets/image/logo.png",
                    width: 80,
                    height: 80,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),
            FadeTransition(
              opacity: _textFade,
              child: Column(
                children: const [
                  Text(
                    "EduMaster",
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 1.2,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "ابدأ رحلتك التعليمية الآن",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white70,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
