import 'package:flutter/material.dart';

class LessonDetailCard extends StatelessWidget {
  final Map<String, dynamic> lesson;
  final double Function(double) baseFontSize;
  final bool isOwner;
  final Widget? topAction;

  const LessonDetailCard({
    super.key,
    required this.lesson,
    required this.baseFontSize,
    this.isOwner = false,
    this.topAction,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (topAction != null) ...[
            Align(alignment: Alignment.topRight, child: topAction!),
            const SizedBox(height: 8),
          ],
          Text(
            lesson['title'] ?? '',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: baseFontSize(22),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            lesson['shortDesc'] ?? '',
            style: TextStyle(color: Colors.grey, fontSize: baseFontSize(15)),
          ),
          const Divider(height: 30),
          Text(
            lesson['longDesc'] ?? '',
            style: TextStyle(fontSize: baseFontSize(16)),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              const Icon(Icons.attach_money, color: Colors.teal),
              const SizedBox(width: 6),
              Text(
                "السعر: ${lesson['price']} جنيه",
                style: TextStyle(fontSize: baseFontSize(15)),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              const Icon(Icons.person, color: Colors.teal),
              const SizedBox(width: 6),
              Text(
                "المدرس: ${lesson['teacherName']}",
                style: TextStyle(fontSize: baseFontSize(15)),
              ),
            ],
          ),
          if (isOwner) ...[
            const SizedBox(height: 10),
            Row(
              children: [
                const Icon(Icons.email, color: Colors.teal),
                const SizedBox(width: 6),
                Text(
                  lesson['teacherEmail'] ?? '',
                  style: TextStyle(fontSize: baseFontSize(15)),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}
