import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:food_delivery_app/data/models/user.dart';

class UserServicesTest {
  final FirebaseFirestore db;
  final FirebaseAuth auth;
  final FirebaseStorage storage;

  UserServicesTest({
    required this.db,
    required this.auth,
    required this.storage,
  });

  Future<void> createUser(AppUser user) async {
    final uid = auth.currentUser!.uid;
    user.id = uid;
    await db.collection("users").doc(uid).set(user.toMap(), SetOptions(merge: true));
  }

  String getCurrentUser() {
    return auth.currentUser!.uid;
  }

  Future<String?> getUserName() async {
    final uid = auth.currentUser?.uid;
    if (uid == null) return null;
    final doc = await db.collection("users").doc(uid).get();
    return doc.data()?["name"];
  }

  Future<String?> uploadProfileImage(File file) async {
    final uid = auth.currentUser!.uid;

    final ref = storage
        .ref()
        .child("users")
        .child(uid)
        .child("profile.jpg");

    await ref.putFile(file);
    return await ref.getDownloadURL();
  }
}