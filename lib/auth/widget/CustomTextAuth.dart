import 'package:edu_master/shared/Appfonts/Appfonts.dart';
import 'package:flutter/material.dart';
import 'package:edu_master/shared/colors/App%20colore.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final TextEditingController mycontroller;

  const CustomTextField({
    super.key,
    required this.hintText,
    required this.mycontroller,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: mycontroller,
      style: TextStyle(
        fontFamily: AppFonts.headlineFont,
        fontSize: 16,
        color: AppColors.black,
      ),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(
          fontFamily: AppFonts.headlineFont,
          fontSize: 14,
          color: AppColors.black,
        ),
        filled: true,
        fillColor: AppColors.grey.withOpacity(0.1),
        contentPadding: const EdgeInsets.symmetric(
          vertical: 18,
          horizontal: 25,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(40),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(40),
          borderSide: BorderSide(color: AppColors.purpleLight, width: 2),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(40),
          borderSide: BorderSide(color: AppColors.grey, width: 1),
        ),
      ),
    );
  }
}
