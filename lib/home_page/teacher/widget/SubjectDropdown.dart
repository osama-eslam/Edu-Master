import 'package:flutter/material.dart';

class SubjectDropdown extends StatelessWidget {
  final String? selectedSubject;
  final List<String> subjects;
  final Function(String?) onChanged;

  const SubjectDropdown({
    required this.selectedSubject,
    required this.subjects,
    required this.onChanged,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: selectedSubject,
      items:
          subjects
              .map(
                (subject) =>
                    DropdownMenuItem(value: subject, child: Text(subject)),
              )
              .toList(),
      onChanged: onChanged,
      decoration: const InputDecoration(
        labelText: 'اختر المادة',
        border: OutlineInputBorder(),
      ),
      validator: (value) => value == null ? 'يجب اختيار المادة' : null,
    );
  }
}
