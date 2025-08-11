import 'package:edu_master/Onboarding/model/Wave%20Header.dart';
import 'package:edu_master/auth/controller/register_controller.dart';
import 'package:edu_master/shared/Appfonts/Appfonts.dart';
import 'package:edu_master/auth/widget/CustomTextAuth.dart';
import 'package:flutter/material.dart';
import 'package:edu_master/shared/colors/App%20colore.dart';
import 'package:edu_master/auth/widget/MaterialButton.dart';
import 'package:get/get.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController password2 = TextEditingController();

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
                  SizedBox(height: height * 0.1),

                  Center(
                    child: Column(
                      children: [
                        Text(
                          "أنشئ حسابك وابدأ رحلتك التعليمية معنا!",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            fontFamily: AppFonts.headlineFont,
                            color: AppColors.black,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "قم بإنشاء حسابك الآن",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 16, color: AppColors.grey),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 30),

                  Text(
                    "الاسم الكامل",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 8),
                  CustomTextField(hintText: "ادخل اسمك", mycontroller: name),

                  const SizedBox(height: 20),

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

                  const SizedBox(height: 20),

                  Text(
                    "تأكيد كلمة السر",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 8),
                  CustomTextField(
                    hintText: "أعد كتابة كلمة السر",
                    mycontroller: password2,
                  ),

                  const SizedBox(height: 30),
                  Button(
                    text: "انشاء حساب",
                    onPressed: () async {
                      await AuthServiceregister.register(
                        name: name.text,
                        email: email.text,
                        password: password.text,
                        confirmPassword: password2.text,
                        context: context,
                      );
                    },
                  ),

                  const SizedBox(height: 20),

                  InkWell(
                    onTap: () {
                      Get.offNamed('/login');
                    },
                    child: const Center(
                      child: Text(
                        "لديك حساب بالفعل؟ سجّل الدخول",
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
