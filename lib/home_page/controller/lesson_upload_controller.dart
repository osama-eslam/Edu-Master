import 'dart:io';
import 'dart:convert';
import 'package:edu_master/data/teacher/string_htt.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;
import 'package:uuid/uuid.dart';

class LessonUploadController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseDatabase _database = FirebaseDatabase.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> uploadToCloudinary(File file, String fileType) async {
    final uri = Uri.parse(
      "${CloudinaryConfig.url}${CloudinaryConfig.cloudName}/${fileType == 'video' ? 'video' : 'image'}/upload",
    );

    final request =
        http.MultipartRequest('POST', uri)
          ..fields['upload_preset'] = CloudinaryConfig.uploadPreset
          ..files.add(await http.MultipartFile.fromPath('file', file.path))
          ..headers['Authorization'] =
              'Basic ${base64Encode(utf8.encode('${CloudinaryConfig.apiKey}:${CloudinaryConfig.apiSecret}'))}';

    final response = await request.send();

    if (response.statusCode == 200) {
      final resStr = await response.stream.bytesToString();
      final resJson = json.decode(resStr);
      return resJson['secure_url'];
    } else {
      throw Exception('فشل رفع الملف إلى Cloudinary: ${response.statusCode}');
    }
  }

  Future<void> uploadLesson({
    required File imageFile,
    required File videoFile,
    required String subject,
    required String title,
    required String shortDesc,
    required String longDesc,
    required String price,
  }) async {
    try {
      final user = _auth.currentUser;
      if (user == null) throw Exception("لم يتم تسجيل الدخول");
      final uid = user.uid;
      final email = user.email ?? '';

      final nameSnapshot = await _firestore.collection('users').doc(uid).get();
      final teacherName = nameSnapshot.data()?['name'] ?? 'مدرس غير معروف';

      final lessonId = const Uuid().v4();

      if (!imageFile.existsSync()) throw Exception("ملف الصورة غير موجود");
      if (!videoFile.existsSync()) throw Exception("ملف الفيديو غير موجود");

      final imageUrl = await uploadToCloudinary(imageFile, 'image');

      final videoUrl = await uploadToCloudinary(videoFile, 'video');

      final data = {
        'id': lessonId,
        'teacherId': uid,
        'subject': subject,
        'title': title,
        'shortDesc': shortDesc,
        'longDesc': longDesc,
        'price': price,
        'imageUrl': imageUrl,
        'videoUrl': videoUrl,
        'uploadedBy': uid,
        'teacherEmail': email,
        'teacherName': teacherName,
        'timestamp': DateTime.now().toIso8601String(),
      };

      await _database.ref('${FirebasePaths.lessons}/$lessonId').set(data);
    } catch (e) {
      throw Exception('فشل في رفع الحصة: ${e.toString()}');
    }
  }
}
