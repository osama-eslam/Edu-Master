import 'package:edu_master/home_page/controller/account_settings_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

class AccountSettingsPage extends StatefulWidget {
  const AccountSettingsPage({super.key});

  @override
  State<AccountSettingsPage> createState() => _AccountSettingsPageState();
}

class _AccountSettingsPageState extends State<AccountSettingsPage> {
  final controller = AccountSettingsController();
  String? name;
  String? email;
  bool loading = true;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    if (controller.user == null) return;
    final data = await controller.loadUserData();
    if (!mounted) return;
    setState(() {
      name = data?['name'];
      email = data?['email'];
      loading = false;
    });
  }

  Future<void> deleteAccount(BuildContext context) async {
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
          final user = FirebaseAuth.instance.currentUser;
          final uid = user?.uid;
          if (uid == null) return;

          await FirebaseFirestore.instance
              .collection("users")
              .doc(uid)
              .delete();

          await user!.delete();

          await FirebaseAuth.instance.signOut();

          if (context.mounted) {
            Navigator.of(
              context,
            ).pushNamedAndRemoveUntil("signup", (route) => false);
          }
        } catch (e) {
          AwesomeDialog(
            context: context,
            dialogType: DialogType.error,
            title: "خطأ",
            desc: "حدث خطأ أثناء حذف الحساب",
            btnOkOnPress: () {},
          ).show();
        }
      },
    ).show();
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("إعدادات الحساب"),
        backgroundColor: Colors.teal,
        centerTitle: true,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => controller.logout(context),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 30),
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.teal, Colors.tealAccent],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(30),
                  ),
                ),
                child: Column(
                  children: [
                    const CircleAvatar(
                      radius: 60,
                      backgroundImage: AssetImage(
                        'assets/image/default_avatar.png',
                      ),
                      backgroundColor: Colors.white,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      name ?? '',
                      style: const TextStyle(
                        fontSize: 22,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      email ?? '',
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.delete_forever, color: Colors.white),
                  label: const Text(
                    "حذف الحساب",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    minimumSize: const Size.fromHeight(55),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    elevation: 5,
                  ),
                  onPressed: () => deleteAccount(context),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
