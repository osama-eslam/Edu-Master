import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

class AuthServiceregister {
  static Future<void> register({
    required String name,
    required String email,
    required String password,
    required String confirmPassword,
    required BuildContext context,
  }) async {
    if (password != confirmPassword) {
      AwesomeDialog(
        context: context,
        dialogType: DialogType.warning,
        animType: AnimType.rightSlide,
        title: 'تأكيد كلمة المرور',
        desc: 'كلمة المرور وتأكيدها غير متطابقين.',
        btnOkOnPress: () {},
      ).show();
      return;
    }

    try {
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
            email: email.trim(),
            password: password.trim(),
          );

      final uid = credential.user?.uid;
      if (uid != null) {
        await FirebaseFirestore.instance.collection("users").doc(uid).set({
          'name': name,
          'email': email.trim(),
        });
      }

      if (!context.mounted) return;

      Navigator.of(context).pushReplacementNamed('/landingpage');
    } on FirebaseAuthException catch (e) {
      String errorMessage = 'حدث خطأ أثناء إنشاء الحساب.';

      if (e.code == 'weak-password') {
        errorMessage = 'كلمة المرور ضعيفة. يُرجى اختيار كلمة مرور أقوى.';
      } else if (e.code == 'email-already-in-use') {
        errorMessage = 'هذا البريد الإلكتروني مستخدم بالفعل.';
      }

      AwesomeDialog(
        context: context,
        dialogType: DialogType.error,
        animType: AnimType.rightSlide,
        title: 'خطاء',
        desc: errorMessage,
        btnOkOnPress: () {},
      ).show();
    }
  }
}
