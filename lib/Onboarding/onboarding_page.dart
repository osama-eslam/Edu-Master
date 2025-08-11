import 'dart:ui' show TextAlign;

import 'package:edu_master/auth/pages/Login_page.dart';
import 'package:edu_master/shared/Appfonts/Appfonts.dart';
import 'package:edu_master/data/static_onboarding.dart';
import 'package:edu_master/Onboarding/model/DotsIn%20dicator.dart';
import 'package:edu_master/shared/colors/App%20colore.dart';
import 'package:edu_master/Onboarding/model/Wave%20Header.dart';
import 'package:flutter/material.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({super.key});

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  final PageController _controller = PageController();
  int _currentIndex = 0;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          const WaveHeader(),
          SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: PageView.builder(
                    controller: _controller,
                    itemCount: Onboarddinlist.length,
                    onPageChanged: (index) {
                      setState(() {
                        _currentIndex = index;
                      });
                    },
                    itemBuilder: (context, index) {
                      return AnimatedBuilder(
                        animation: _controller,
                        builder: (context, child) {
                          double value = 1.0;
                          if (_controller.position.haveDimensions) {
                            value = _controller.page! - index;
                            value = (1 - (value.abs() * 0.3)).clamp(0.0, 1.0);
                          }

                          return Opacity(
                            opacity: value,
                            child: Transform.translate(
                              offset: Offset(40 * (1 - value), 0),
                              child: Transform.scale(
                                scale: value,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0,
                                  ),
                                  child: Column(
                                    children: [
                                      SizedBox(height: size.height * 0.03),
                                      Text(
                                        Onboarddinlist[index].title!,
                                        textAlign: TextAlign.center,
                                        style: AppFonts.headlineStyle.copyWith(
                                          color: AppColors.blackDark,
                                          fontSize: size.width * 0.06,
                                        ),
                                      ),
                                      SizedBox(height: size.height * 0.05),
                                      SizedBox(
                                        height: size.height * 0.3,
                                        child: Image.asset(
                                          Onboarddinlist[index].image!,
                                          alignment: Alignment.center,
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                      SizedBox(height: size.height * 0.05),
                                      Expanded(
                                        child: Center(
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 12,
                                            ),
                                            child: Text(
                                              Onboarddinlist[index].body!,
                                              style: AppFonts.bodyStyle
                                                  .copyWith(
                                                    color: AppColors.blackDark,
                                                    fontSize:
                                                        size.width * 0.045,
                                                  ),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: DotsIndicator(
                    currentIndex: _currentIndex,
                    itemCount: Onboarddinlist.length,
                  ),
                ),
                SizedBox(height: 80),
                Padding(
                  padding: const EdgeInsets.only(bottom: 30),
                  child: ElevatedButton(
                    onPressed: () {
                      if (_currentIndex < Onboarddinlist.length - 1) {
                        _controller.nextPage(
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeInOut,
                        );
                      } else {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginPage(),
                          ),
                        );
                      }
                    },

                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.blue,
                      padding: EdgeInsets.symmetric(
                        horizontal: size.width * 0.2,
                        vertical: size.height * 0.015,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: Text(
                      _currentIndex == Onboarddinlist.length - 1
                          ? 'ابدأ'
                          : 'التالي',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: size.width * 0.045,
                        fontWeight: FontWeight.bold,
                        fontFamily: AppFonts.iconFont,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
