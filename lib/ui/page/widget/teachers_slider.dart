import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:edu_master/data/teacher/Teachers_image.dart';
import 'package:edu_master/data/teacher/teacher_backgrounds.dart';
import 'package:edu_master/shared/colors/App%20colore.dart';

// ignore: must_be_immutable
class TeachersSliderWidget extends StatelessWidget {
  TeachersSliderWidget({super.key});

  Color getBorderColor = AppColors.blue;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return CarouselSlider.builder(
      itemCount: teachersList.length,
      itemBuilder: (context, itemIndex, _) {
        final teacher = teachersList[itemIndex];
        final backgroundImage = teacherBackgroundsMap[teacher.subject] ?? '';
        final borderColor = getBorderColor;

        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          width: screenWidth * 0.9,
          height: screenHeight * 0.25,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(backgroundImage),
              fit: BoxFit.cover,
            ),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: borderColor, width: 3),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade400,
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(
                    teacher.image,
                    width: screenWidth * 0.3,
                    height: screenWidth * 0.7,
                    fit: BoxFit.contain,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        teacher.name,
                        style: TextStyle(
                          fontSize: screenWidth * 0.045,
                          fontWeight: FontWeight.bold,
                          color: AppColors.blackDark,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        teacher.subject,
                        style: TextStyle(
                          fontSize: screenWidth * 0.040,
                          fontWeight: FontWeight.w500,
                          color: AppColors.black,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        teacher.info,
                        style: TextStyle(
                          fontSize: screenWidth * 0.035,
                          color: AppColors.black,
                        ),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
      options: CarouselOptions(
        height: screenHeight * 0.27,
        autoPlay: true,
        enlargeCenterPage: true,
        autoPlayInterval: const Duration(seconds: 3),
        viewportFraction: 0.9,
      ),
    );
  }
}
