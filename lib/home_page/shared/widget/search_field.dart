import 'package:flutter/material.dart';

class CustomSearchField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;

  const CustomSearchField({
    super.key,
    required this.controller,
    this.hint = "ابحث...",
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: hint,
          prefixIcon: const Icon(Icons.search),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),
    );
  }
}
