import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:edu_master/shared/Appfonts/Appfonts.dart';
import 'package:flutter/material.dart';
import 'package:edu_master/shared/colors/App%20colore.dart';

class GoogleButton extends StatelessWidget {
  const GoogleButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 55,
      child: ElevatedButton.icon(
        onPressed: () {
          AwesomeDialog(
            context: context,
            dialogType: DialogType.info,
            title: 'خطاء',
            desc: 'هذه الخدمه غير متاحه الان ',
            btnOkOnPress: () {},
          ).show();
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.blue,
          foregroundColor: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40),
            side: const BorderSide(color: Colors.grey),
          ),
          elevation: 4,
          shadowColor: AppColors.grey.withOpacity(0.4),
        ),
        icon: Image.asset('assets/image/googel.png', height: 30, width: 30),
        label: Text(
          "التسجيل عبر جوجل",
          style: TextStyle(
            color: AppColors.white,
            fontFamily: AppFonts.iconFont,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
