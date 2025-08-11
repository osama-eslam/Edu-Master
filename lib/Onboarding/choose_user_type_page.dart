import 'package:edu_master/shared/colors/App%20colore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:edu_master/shared/Appfonts/Appfonts.dart';
import 'package:edu_master/Onboarding/model/widget.dart';

class ChooseUserTypePage extends StatefulWidget {
  const ChooseUserTypePage({super.key});

  @override
  State<ChooseUserTypePage> createState() => _ChooseUserTypePageState();
}

class _ChooseUserTypePageState extends State<ChooseUserTypePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeIn;
  late Animation<Offset> _slideIn;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    _fadeIn = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));

    _slideIn = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.decelerate));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _buildOption({
    required String title,
    required String description,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return FadeTransition(
      opacity: _fadeIn,
      child: SlideTransition(
        position: _slideIn,
        child: GestureDetector(
          onTap: onTap,
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 14),
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [color.withOpacity(0.45), AppColors.white12],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(28),
              border: Border.all(
                color: AppColors.white.withOpacity(0.1),
                width: 1.5,
              ),
              boxShadow: [
                BoxShadow(
                  color: color.withOpacity(0.5),
                  blurRadius: 18,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 34,
                  backgroundColor: AppColors.white,
                  child: Icon(icon, size: 36, color: color),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: AppFonts.headlineStyle.copyWith(
                          fontFamily: AppFonts.iconFont,
                          fontSize: 26,
                          color: AppColors.white,
                          shadows: const [
                            Shadow(
                              color: Colors.black54,
                              blurRadius: 4,
                              offset: Offset(1, 2),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        description,
                        style: AppFonts.bodyStyle.copyWith(
                          fontSize: 15,
                          color: AppColors.white70,
                        ),
                      ),
                    ],
                  ),
                ),
                const Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: AppColors.white54,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryBlue,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppColors.darkBlue,
              AppColors.primaryBlue,
              AppColors.lightBlue,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 40),
                FadeTransition(
                  opacity: _fadeIn,
                  child: Text(
                    "🎓 اختر نوع حسابك",
                    style: AppFonts.headlineStyle.copyWith(
                      fontFamily: AppFonts.iconFont,
                      fontSize: 32,
                      color: AppColors.white,
                      letterSpacing: 1,
                      shadows: const [
                        Shadow(
                          color: Colors.black54,
                          blurRadius: 12,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 14),
                FadeTransition(
                  opacity: _fadeIn,
                  child: Text(
                    "لنمنحك تجربة تناسبك تمامًا",
                    style: AppFonts.bodyStyle.copyWith(
                      fontSize: 17,
                      fontWeight: FontWeight.normal,
                      color: AppColors.white70,
                    ),
                  ),
                ),
                const SizedBox(height: 50),
                _buildOption(
                  title: "طالب",
                  description: "ادخل لتشاهد جدولك، المواد الدراسية، والمدرسين",
                  icon: Icons.school_rounded,
                  color: AppColors.studentColor,
                  onTap: () async {
                    await saveUserType("طالب");
                    Get.offAllNamed("/navigationstudent");
                  },
                ),
                _buildOption(
                  title: "معلم",
                  description: "ادخل لإضافة حصصك، الملفات، والتفاعل مع الطلاب",
                  icon: Icons.person_pin_rounded,
                  color: AppColors.teacherColor,
                  onTap: () async {
                    await saveUserType("معلم");
                    Get.offAllNamed("/navigationteacher");
                  },
                ),
                const SizedBox(height: 40),
                Container(
                  height: 2,
                  width: 120,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    gradient: const LinearGradient(
                      colors: [AppColors.white38, AppColors.white12],
                    ),
                  ),
                ),
                const SizedBox(height: 18),
                FadeTransition(
                  opacity: _fadeIn,
                  child: Text(
                    "EduMaster © 2025",
                    style: AppFonts.bodyStyle.copyWith(
                      fontSize: 13,
                      color: AppColors.white38,
                      letterSpacing: 0.8,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
