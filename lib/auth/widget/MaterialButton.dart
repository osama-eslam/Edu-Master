import 'package:edu_master/shared/Appfonts/Appfonts.dart';
import 'package:flutter/material.dart';
import 'package:edu_master/shared/colors/App%20colore.dart';

class Button extends StatelessWidget {
  final void Function()? onPressed;
  final String text;
  final Color? backgroundColor;
  final Color? textColor;

  const Button({
    super.key,
    required this.text,
    this.onPressed,
    this.backgroundColor,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 55,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor ?? AppColors.blue,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40),
          ),
          elevation: 4,
          shadowColor: AppColors.grey.withOpacity(0.4),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontFamily: AppFonts.iconFont,
            fontSize: 18,
            color: textColor ?? AppColors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
