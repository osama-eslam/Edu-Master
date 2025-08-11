import 'package:edu_master/home_page/shared/utils/lesson_details_screen.dart';
import 'package:edu_master/home_page/shared/widget/search_field.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class TeacherLessonsPage extends StatefulWidget {
  final String teacherId;
  final String teacherName;

  const TeacherLessonsPage({
    super.key,
    required this.teacherId,
    required this.teacherName,
  });

  @override
  State<TeacherLessonsPage> createState() => _TeacherLessonsPageState();
}

class _TeacherLessonsPageState extends State<TeacherLessonsPage> {
  final lessonsRef = FirebaseDatabase.instance.ref('lessons');

  List<Map<String, dynamic>> _allLessons = [];
  List<Map<String, dynamic>> _filteredLessons = [];
  bool _loading = true;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchLessons();
    _searchController.addListener(_filterLessons);
  }

  Future<void> fetchLessons() async {
    final snapshot = await lessonsRef.once();
    final Map<dynamic, dynamic>? lessonsMap = snapshot.snapshot.value as Map?;

    if (lessonsMap != null) {
      _allLessons =
          lessonsMap.values
              .map((e) => Map<String, dynamic>.from(e))
              .where((lesson) => lesson['teacherId'] == widget.teacherId)
              .toList()
              .reversed
              .toList();
      _filteredLessons = List.from(_allLessons);
    }

    if (!mounted) return;

    setState(() {
      _loading = false;
    });
  }

  void _filterLessons() {
    String query = _searchController.text.trim().toLowerCase();

    if (query.isEmpty) {
      _filteredLessons = List.from(_allLessons);
    } else {
      _filteredLessons =
          _allLessons.where((lesson) {
            final title = (lesson['title'] ?? '').toLowerCase();
            final desc = (lesson['shortDesc'] ?? '').toLowerCase();
            return title.contains(query) || desc.contains(query);
          }).toList();
    }

    setState(() {});
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("حصص ${widget.teacherName}"),
        backgroundColor: const Color(0xFF1565C0),
        centerTitle: true,
      ),
      body:
          _loading
              ? const Center(child: CircularProgressIndicator())
              : Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: CustomSearchField(
                      controller: _searchController,
                      hint: "ابحث عن الحصة...",
                    ),
                  ),
                  Expanded(
                    child:
                        _filteredLessons.isEmpty
                            ? const Center(child: Text("لا توجد حصص مطابقة"))
                            : ListView.builder(
                              itemCount: _filteredLessons.length,
                              itemBuilder: (context, index) {
                                final lesson = _filteredLessons[index];
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder:
                                            (_) => LessonDetailPage(
                                              lesson: lesson,
                                            ),
                                      ),
                                    );
                                  },
                                  child: Card(
                                    margin: const EdgeInsets.symmetric(
                                      horizontal: 16,
                                      vertical: 8,
                                    ),
                                    child: ListTile(
                                      leading: Image.network(
                                        lesson['imageUrl'] ?? '',
                                        width: 60,
                                        height: 60,
                                        fit: BoxFit.cover,
                                      ),
                                      title: Text(lesson['title'] ?? ''),
                                      subtitle: Text(
                                        lesson['shortDesc'] ?? '',
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      trailing: const Icon(Icons.play_arrow),
                                    ),
                                  ),
                                );
                              },
                            ),
                  ),
                ],
              ),
    );
  }
}
