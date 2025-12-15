import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '/data/models/user.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class UserServices {
  static final FirebaseFirestore _db = FirebaseFirestore.instance;
  static final FirebaseAuth _auth = FirebaseAuth.instance;

  // 🔹 Cloudinary config
  static const String _cloudName = "dwhyg24zo";
  static const String _uploadPreset = "ml_default";

  /// Create or update user in Firestore
  static Future<void> createUser(AppUser user) async {
    final userDoc = _db.collection("users").doc(_auth.currentUser!.uid);
    user.id = userDoc.id;

    await userDoc.set(user.toMap(), SetOptions(merge: true));
  }

  static String getCurrentUser() {
    return FirebaseAuth.instance.currentUser!.uid;
  }

  static Future<String?> getUserName() async {
    final uid = _auth.currentUser?.uid;
    if (uid == null) return null;

    final doc = await _db.collection("users").doc(uid).get();
    if (doc.exists) {
      return doc.data()?["name"] as String?;
    }
    return null;
  }

  /// 🔹 Save profile image URL to Firestore
  static Future<void> updateProfileImage(String imageUrl) async {
    final uid = _auth.currentUser!.uid;
    await _db.collection("users").doc(uid).update({"image": imageUrl});
  }

  /// 🔹 Upload profile image to Cloudinary
  /// Upload profile image to Cloudinary
  static Future<String?> uploadProfileImage(File imageFile) async {
    try {
      final uri = Uri.parse(
        "https://api.cloudinary.com/v1_1/$_cloudName/image/upload",
      );
      final request = http.MultipartRequest("POST", uri)
        ..fields["upload_preset"] = _uploadPreset
        ..fields["folder"] = "users/${_auth.currentUser!.uid}"
        ..files.add(await http.MultipartFile.fromPath("file", imageFile.path));

      final response = await request.send();
      final responseBody = await response.stream.bytesToString();
      final data = json.decode(responseBody);

      if (response.statusCode == 200) return data["secure_url"];
      return null;
    } catch (e) {
      print("Cloudinary upload error: $e");
      return null;
    }
  }
}
