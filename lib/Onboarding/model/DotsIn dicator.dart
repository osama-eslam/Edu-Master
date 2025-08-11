import 'package:edu_master/shared/colors/App%20colore.dart';
import 'package:flutter/material.dart';

class DotsIndicator extends StatelessWidget {
  final int currentIndex;
  final int itemCount;

  const DotsIndicator({
    Key? key,
    required this.currentIndex,
    required this.itemCount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        itemCount,
        (index) => AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: const EdgeInsets.symmetric(horizontal: 4.0),
          width: currentIndex == index ? 10.0 : 6.0,
          height: currentIndex == index ? 10.0 : 6.0,
          decoration: BoxDecoration(
            color: currentIndex == index ? AppColors.blue : AppColors.grey,
            shape: BoxShape.circle,
          ),
        ),
      ),
    );
  }
}
