import 'package:edu_master/home_page/controller/TeacherLessonsPage.dart';
import 'package:edu_master/home_page/controller/all_lessons_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchByTeacherPage extends StatelessWidget {
  const SearchByTeacherPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => StudentLessonsController()..fetchLessons(),
      child: _SearchLessonContent(),
    );
  }
}

class _SearchLessonContent extends StatefulWidget {
  @override
  State<_SearchLessonContent> createState() => _SearchLessonContentState();
}

class _SearchLessonContentState extends State<_SearchLessonContent> {
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> _filteredLessons = [];

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_filterLessons);
  }

  void _filterLessons() {
    final controller = Provider.of<StudentLessonsController>(
      context,
      listen: false,
    );
    final query = _searchController.text.trim().toLowerCase();

    if (query.isEmpty) {
      _filteredLessons = [];
    } else {
      _filteredLessons =
          controller.lessons.where((lesson) {
            final teacherName = (lesson['teacherName'] ?? '').toLowerCase();
            return teacherName.contains(query);
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
    final controller = Provider.of<StudentLessonsController>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("البحث عن حصص المعلمين"),
        centerTitle: true,
        backgroundColor: const Color(0xFF1565C0),
      ),
      body:
          controller.isLoading
              ? const Center(child: CircularProgressIndicator())
              : Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: TextField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        hintText: "ابحث باسم المعلم...",
                        prefixIcon: const Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child:
                        _filteredLessons.isEmpty
                            ? const Center(child: Text("لا توجد حصص للعرض"))
                            : ListView.builder(
                              itemCount: _filteredLessons.length,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                              ),
                              itemBuilder: (context, index) {
                                final lesson = _filteredLessons[index];
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder:
                                            (_) => TeacherLessonsPage(
                                              teacherId: lesson['teacherId'],
                                              teacherName:
                                                  lesson['teacherName'] ??
                                                  'المعلم',
                                            ),
                                      ),
                                    );
                                  },

                                  child: Container(
                                    margin: const EdgeInsets.only(bottom: 12),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(12),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.1),
                                          blurRadius: 6,
                                          offset: const Offset(0, 2),
                                        ),
                                      ],
                                    ),
                                    child: Row(
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                              const BorderRadius.horizontal(
                                                left: Radius.circular(12),
                                              ),
                                          child: Image.network(
                                            lesson['imageUrl'] ?? '',
                                            width: 120,
                                            height: 100,
                                            fit: BoxFit.cover,
                                            errorBuilder:
                                                (_, __, ___) => Container(
                                                  width: 120,
                                                  height: 100,
                                                  color: Colors.grey[300],
                                                  child: const Icon(
                                                    Icons.broken_image,
                                                  ),
                                                ),
                                          ),
                                        ),
                                        const SizedBox(width: 12),
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  lesson['title'] ?? '',
                                                  style: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                                const SizedBox(height: 4),
                                                Text(
                                                  lesson['teacherName'] ?? '',
                                                  style: const TextStyle(
                                                    color: Colors.grey,
                                                    fontSize: 14,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
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
