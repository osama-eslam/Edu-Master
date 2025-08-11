import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';

class WaveHeader extends StatelessWidget {
  const WaveHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 300,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFB3E5FC), Color(0xFFE1F5FE)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
        ClipPath(
          clipper: WaveClipperOne(),
          child: Container(
            height: 300,
            color: Colors.lightBlueAccent.withOpacity(0.5),
          ),
        ),
      ],
    );
  }
}
