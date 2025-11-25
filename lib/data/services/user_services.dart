import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '/data/models/user.dart';


class UserServices {
//create user
//update user

static final FirebaseFirestore _db = FirebaseFirestore.instance;
static final FirebaseAuth _auth = FirebaseAuth.instance;

//creat user and update and save this in firestore

   static Future<void> createUser(AppUser user) async {
    final userDoc = _db.collection("users").doc(_auth.currentUser!.uid);
    user.id = userDoc.id;
    //updates exist doc or create new if not found
    await userDoc.set(user.toMap(),SetOptions(merge: true));
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

  static Future<String?> uploadProfileImage(File imageFile) async {
    String uid = FirebaseAuth.instance.currentUser!.uid;

    final ref = FirebaseStorage.instance
        .ref()
        .child("users")
        .child(uid)
        .child("profile.jpg");

    await ref.putFile(imageFile);
    return await ref.getDownloadURL();
  }


}