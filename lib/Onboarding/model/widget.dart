import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

Future<void> saveUserType(String userType) async {
  final uid = FirebaseAuth.instance.currentUser?.uid;
  if (uid == null) return;

  final ref = FirebaseDatabase.instance.ref("users/$uid");
  await ref.update({"userType": userType});
}
