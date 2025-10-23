import 'package:firebase_auth/firebase_auth.dart';

class UserServices {
  static String getCurrentUser() {
    return FirebaseAuth.instance.currentUser!.uid;
  }
}