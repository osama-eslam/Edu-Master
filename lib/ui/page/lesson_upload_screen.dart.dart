import 'dart:io';
import 'package:edu_master/home_page/controller/lesson_upload_controller.dart';
import 'package:edu_master/home_page/shared/widget/CoverImagePicker.dart';
import 'package:edu_master/home_page/shared/widget/TextFormField.dart';
import 'package:edu_master/home_page/shared/widget/VideoPickerWidget%20.dart';
import 'package:edu_master/home_page/teacher/widget/SubjectDropdown.dart';
import 'package:edu_master/home_page/teacher/widget/list_Sections.dart';
import 'package:edu_master/shared/colors/App%20colore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';

class UploadLessonPage extends StatefulWidget {
  const UploadLessonPage({super.key});

  @override
  State<UploadLessonPage> createState() => _UploadLessonPageState();
}

class _UploadLessonPageState extends State<UploadLessonPage> {
  File? _selectedImage;
  File? _selectedVideo;

  VideoPlayerController? _videoController;
  ChewieController? _chewieController;

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _shortDescController = TextEditingController();
  final TextEditingController _longDescController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String? _selectedSubject;

  Future<void> _pickImage() async {
    final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() {
        _selectedImage = File(picked.path);
      });
    }
  }

  Future<void> _pickVideo() async {
    final picked = await FilePicker.platform.pickFiles(type: FileType.video);
    if (picked != null) {
      _selectedVideo = File(picked.files.single.path!);
      _videoController = VideoPlayerController.file(_selectedVideo!);
      await _videoController!.initialize();
      _chewieController = ChewieController(
        videoPlayerController: _videoController!,
        autoPlay: false,
        looping: false,
      );
      setState(() {});
    }
  }

  Future<void> _submitLesson() async {
    if (!_formKey.currentState!.validate()) return;

    if (_selectedImage == null ||
        _selectedVideo == null ||
        _selectedSubject == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('يرجى اختيار صورة، فيديو، ومادة')),
      );
      return;
    }

    final uploader = LessonUploadController();

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const Center(child: CircularProgressIndicator()),
    );

    try {
      await uploader.uploadLesson(
        imageFile: _selectedImage!,
        videoFile: _selectedVideo!,
        subject: _selectedSubject!,
        title: _titleController.text.trim(),
        shortDesc: _shortDescController.text.trim(),
        longDesc: _longDescController.text.trim(),
        price: _priceController.text.trim(),
      );

      Navigator.of(context).pop();

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('تم رفع الحصة بنجاح')));

      _formKey.currentState!.reset();
      setState(() {
        _selectedImage = null;
        _selectedVideo = null;
        _selectedSubject = null;
        _videoController?.dispose();
        _chewieController?.dispose();
        _videoController = null;
        _chewieController = null;
      });
    } catch (e) {
      Navigator.of(context).pop();
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  @override
  void dispose() {
    _videoController?.dispose();
    _chewieController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _ = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      appBar: AppBar(
        title: const Text(
          "رفع الحصة",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: AppColors.blue,
        centerTitle: true,
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CoverImagePicker(
                      image: _selectedImage,
                      onPick: _pickImage,
                      onRemove: () => setState(() => _selectedImage = null),
                    ),

                    const SizedBox(height: 20),

                    VideoPickerWidget(
                      video: _selectedVideo,
                      videoController: _videoController,
                      chewieController: _chewieController,
                      onPick: _pickVideo,
                      onRemove: () {
                        setState(() {
                          _selectedVideo = null;
                          _videoController?.dispose();
                          _chewieController?.dispose();
                          _videoController = null;
                          _chewieController = null;
                        });
                      },
                    ),

                    const SizedBox(height: 24),

                    SubjectDropdown(
                      selectedSubject: _selectedSubject,
                      subjects: subjects,
                      onChanged:
                          (value) => setState(() => _selectedSubject = value),
                    ),

                    const SizedBox(height: 16),

                    CustomTextField(
                      controller: _titleController,
                      label: 'عنوان الحصة',
                      validator:
                          (value) => value!.isEmpty ? 'العنوان مطلوب' : null,
                    ),

                    const SizedBox(height: 16),

                    CustomTextField(
                      controller: _shortDescController,
                      label: 'وصف خفيف (≤ 100 حرف)',
                      maxLength: 100,
                      validator:
                          (value) =>
                              value!.length > 100
                                  ? 'الوصف لا يتجاوز 100 حرف'
                                  : null,
                    ),

                    const SizedBox(height: 16),

                    CustomTextField(
                      controller: _longDescController,
                      label: 'الوصف الكامل (اختياري)',
                      maxLines: 5,
                    ),

                    const SizedBox(height: 16),

                    CustomTextField(
                      controller: _priceController,
                      label: 'سعر الحصة بالجنيه المصري',
                      keyboardType: TextInputType.number,
                      validator:
                          (value) =>
                              value!.isEmpty ? 'برجاء إدخال السعر' : null,
                    ),

                    const SizedBox(height: 32),

                    Center(
                      child: ElevatedButton.icon(
                        onPressed: _submitLesson,
                        icon: const Icon(Icons.upload),
                        label: const Text('رفع الحصة'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.teal,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 40,
                            vertical: 16,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 32),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
