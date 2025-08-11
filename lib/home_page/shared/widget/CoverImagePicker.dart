import 'dart:io';

import 'package:flutter/material.dart';

class CoverImagePicker extends StatelessWidget {
  final File? image;
  final VoidCallback onPick;
  final VoidCallback? onRemove;

  const CoverImagePicker({
    required this.image,
    required this.onPick,
    this.onRemove,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final mediaHeight = MediaQuery.of(context).size.height;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "صورة الغلاف",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.white,
            boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
          ),
          child: Stack(
            children: [
              SizedBox(
                width: double.infinity,
                height: mediaHeight * 0.25,
                child:
                    image != null
                        ? ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.file(image!, fit: BoxFit.cover),
                        )
                        : TextButton.icon(
                          onPressed: onPick,
                          icon: const Icon(Icons.image),
                          label: const Text("اختر صورة الغلاف"),
                        ),
              ),
              if (image != null && onRemove != null)
                Positioned(
                  top: 8,
                  right: 8,
                  child: IconButton(
                    icon: const Icon(Icons.close, color: Colors.red),
                    onPressed: onRemove,
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
