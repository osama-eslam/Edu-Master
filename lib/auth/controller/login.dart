import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

class AuthService {
  static Future<void> login({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      // ignore: unused_local_variable
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );

      if (!context.mounted) return;

      Navigator.of(context).pushReplacementNamed('/landingpage');
    } on FirebaseAuthException catch (e) {
      if (!context.mounted) return;

      if (e.code == 'user-not-found') {}

      AwesomeDialog(
        context: context,
        dialogType: DialogType.info,
        animType: AnimType.rightSlide,
        title: 'خطاء',
        desc: 'البيانات غير صحيحة، يُرجى التأكد من البيانات وإعادة المحاولة.',
        btnOkOnPress: () {},
      ).show();
    }
  }
}
