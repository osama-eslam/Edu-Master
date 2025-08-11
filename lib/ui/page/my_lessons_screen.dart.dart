import 'package:edu_master/home_page/shared/utils/lesson_details_screen.dart';
import 'package:edu_master/home_page/shared/widget/search_field.dart';
import 'package:edu_master/shared/colors/App colore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class MyLessonsPage extends StatefulWidget {
  const MyLessonsPage({super.key});

  @override
  State<MyLessonsPage> createState() => _MyLessonsPageState();
}

class _MyLessonsPageState extends State<MyLessonsPage> {
  final user = FirebaseAuth.instance.currentUser;
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
    if (user == null) return;

    final snapshot = await lessonsRef.once();
    final Map<dynamic, dynamic>? lessonsMap = snapshot.snapshot.value as Map?;

    if (lessonsMap != null) {
      _allLessons =
          lessonsMap.values
              .map((e) => Map<String, dynamic>.from(e))
              .where((lesson) => lesson['teacherId'] == user!.uid)
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
    final screenWidth = MediaQuery.of(context).size.width;

    double fontScale(double size) => screenWidth > 600 ? size * 1.2 : size;

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text("حصصي"),
        centerTitle: true,
        backgroundColor: AppColors.blue,
      ),
      body:
          _loading
              ? const Center(child: CircularProgressIndicator())
              : Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 700),
                  child: Column(
                    children: [
                      const SizedBox(height: 12),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: CustomSearchField(
                          controller: _searchController,
                          hint: "ابحث عن اسم الحصة",
                        ),
                      ),
                      const SizedBox(height: 10),
                      Expanded(
                        child:
                            _filteredLessons.isEmpty
                                ? const Center(
                                  child: Text("لا توجد حصص مطابقة"),
                                )
                                : ListView.builder(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                  ),
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
                                      child: Container(
                                        margin: const EdgeInsets.only(
                                          bottom: 16,
                                        ),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(
                                            16,
                                          ),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.black.withOpacity(
                                                0.05,
                                              ),
                                              blurRadius: 8,
                                              offset: const Offset(0, 3),
                                            ),
                                          ],
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Stack(
                                              children: [
                                                ClipRRect(
                                                  borderRadius:
                                                      const BorderRadius.vertical(
                                                        top: Radius.circular(
                                                          16,
                                                        ),
                                                      ),
                                                  child: Image.network(
                                                    lesson['imageUrl'] ?? '',
                                                    height:
                                                        screenWidth > 600
                                                            ? 240
                                                            : 180,
                                                    width: double.infinity,
                                                    fit: BoxFit.contain,
                                                    errorBuilder:
                                                        (
                                                          _,
                                                          __,
                                                          ___,
                                                        ) => SizedBox(
                                                          height:
                                                              screenWidth > 600
                                                                  ? 240
                                                                  : 180,
                                                          child: const Center(
                                                            child: Icon(
                                                              Icons
                                                                  .broken_image,
                                                              size: 40,
                                                            ),
                                                          ),
                                                        ),
                                                  ),
                                                ),
                                                const Positioned(
                                                  right: 12,
                                                  bottom: 12,
                                                  child: CircleAvatar(
                                                    backgroundColor:
                                                        Colors.black54,
                                                    radius: 18,
                                                    child: Icon(
                                                      Icons.play_arrow,
                                                      color: Colors.white,
                                                      size: 28,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(12),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    lesson['title'] ?? '',
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: fontScale(18),
                                                    ),
                                                  ),
                                                  const SizedBox(height: 6),
                                                  Text(
                                                    lesson['shortDesc'] ?? '',
                                                    maxLines: 2,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: fontScale(14),
                                                    ),
                                                  ),
                                                ],
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
                ),
              ),
    );
  }
}
