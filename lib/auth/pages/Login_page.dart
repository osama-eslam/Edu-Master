import 'package:edu_master/Onboarding/model/Wave%20Header.dart';
import 'package:edu_master/auth/controller/login.dart';
import 'package:edu_master/shared/Appfonts/Appfonts.dart';
import 'package:edu_master/auth/widget/CustomTextAuth.dart';
import 'package:edu_master/auth/widget/google%20Login%20Button.dart';
import 'package:flutter/material.dart';
import 'package:edu_master/shared/colors/App%20colore.dart';
import 'package:edu_master/auth/widget/MaterialButton.dart';
import 'package:get/get.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: AppColors.white,
      body: Stack(
        children: [
          const WaveHeader(),

          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: ListView(
                children: [
                  SizedBox(height: height * 0.12),

                  Center(
                    child: Container(
                      width: 100,
                      height: 100,
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: AppColors.blue.withOpacity(0.3),
                        shape: BoxShape.circle,
                      ),
                      child: Image.asset(
                        "assets/image/logo.png",
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),

                  const SizedBox(height: 30),

                  Center(
                    child: Column(
                      children: [
                        Text(
                          "مرحبًا بعودتك",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                            fontFamily: AppFonts.headlineFont,
                            color: AppColors.black,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "سجّل دخولك إلى حسابك",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 16, color: AppColors.grey),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 30),

                  Text(
                    "البريد الإلكتروني",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 8),
                  CustomTextField(
                    hintText: "ادخل البريد الإلكتروني",
                    mycontroller: email,
                  ),

                  const SizedBox(height: 20),

                  Text(
                    "كلمة السر",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 8),
                  CustomTextField(
                    hintText: "ادخل كلمة السر",
                    mycontroller: password,
                  ),

                  const SizedBox(height: 40),

                  Button(
                    text: "تسجيل الدخول",
                    onPressed: () {
                      AuthService.login(
                        email: email.text,
                        password: password.text,
                        context: context,
                      );
                    },
                  ),

                  const SizedBox(height: 20),

                  const GoogleButton(),

                  const SizedBox(height: 20),

                  InkWell(
                    onTap: () {
                      Get.offNamed('/register');
                    },
                    child: const Center(
                      child: Text(
                        "ليس لديك حساب؟ أنشئ حسابك الآن",
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: height * 0.05),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
