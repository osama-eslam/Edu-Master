import 'package:edu_master/Onboarding/choose_user_type_page.dart';
import 'package:edu_master/auth/pages/Login_page.dart';
import 'package:edu_master/home_page/teacher/widget/convex_bottom_bar_Mr.dart';
import 'package:edu_master/ui/widget/convex_bottom_bar_sud.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  Widget _currentPage = const Scaffold(
    body: Center(child: CircularProgressIndicator()),
  );

  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _checkUserState();
  }

  Future<String?> _getUserType() async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) return null;
    final ref = FirebaseDatabase.instance.ref("users/$uid/userType");
    final snapshot = await ref.get();
    if (snapshot.exists) {
      print('UserType from Firebase: ${snapshot.value}');
      return snapshot.value.toString();
    } else {
      print('UserType not found in Firebase');
      return null;
    }
  }

  Future<void> _checkUserState() async {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      setState(() {
        _currentPage = LoginPage();
        _isLoading = false;
      });
    } else {
      final userType = await _getUserType();

      setState(() {
        if (userType == null || userType.isEmpty) {
          _currentPage = const ChooseUserTypePage();
        } else if (userType == "طالب") {
          _currentPage = const Navigationstudent();
        } else if (userType == "معلم") {
          _currentPage = const NavigationTeacher();
        } else {
          _currentPage = const ChooseUserTypePage();
        }
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    return _currentPage;
  }
}
