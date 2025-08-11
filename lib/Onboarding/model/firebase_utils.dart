import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<String?> getUserTypeFromFirebase() async {
  final uid = FirebaseAuth.instance.currentUser?.uid;
  if (uid == null) return null;

  final ref = FirebaseDatabase.instance.ref("users/$uid/userType");
  final snapshot = await ref.get();

  if (snapshot.exists) {
    return snapshot.value.toString();
  } else {
    return null;
  }
}
