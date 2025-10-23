import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:food_delivery/data/models/user.dart';

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


}