import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AccountSettingsController {
  final user = FirebaseAuth.instance.currentUser;

  Future<Map<String, dynamic>?> loadUserData() async {
    final doc =
        await FirebaseFirestore.instance
            .collection("users")
            .doc(user!.uid)
            .get();
    return doc.data();
  }

  void deleteAccount(BuildContext context) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.warning,
      title: "حذف الحساب",
      desc: "هل أنت متأكد أنك تريد حذف الحساب نهائيًا؟",
      btnCancelText: "إلغاء",
      btnOkText: "حذف",
      btnCancelOnPress: () {},
      btnOkOnPress: () async {
        try {
          final uid = user!.uid;

          await FirebaseFirestore.instance
              .collection("users")
              .doc(uid)
              .delete();

          final lessons =
              await FirebaseFirestore.instance
                  .collection("lessons")
                  .where("teacherId", isEqualTo: uid)
                  .get();
          for (var doc in lessons.docs) {
            await doc.reference.delete();
          }

          final posts =
              await FirebaseFirestore.instance
                  .collection("posts")
                  .where("userId", isEqualTo: uid)
                  .get();
          for (var doc in posts.docs) {
            await doc.reference.delete();
          }

          await user!.delete();

          Navigator.of(context).pushReplacementNamed("login");
        } catch (e) {
          AwesomeDialog(
            context: context,
            dialogType: DialogType.error,
            title: "خطأ",
            desc: "حدث خطأ أثناء حذف الحساب: $e",
            btnOkOnPress: () {},
          ).show();
        }
      },
    ).show();
  }

  void logout(BuildContext context) {
    FirebaseAuth.instance.signOut();
    Navigator.pushReplacementNamed(context, "login");
  }
}
