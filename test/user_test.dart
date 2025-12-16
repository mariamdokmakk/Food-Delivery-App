import 'dart:io';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:firebase_storage_mocks/firebase_storage_mocks.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:food_delivery_app/data/models/user.dart';
import 'test services/user_services_test.dart';

void main() {
  group("UserServices Tests", () {
    late FakeFirebaseFirestore fakeDb;
    late MockFirebaseAuth mockAuth;
    late MockFirebaseStorage mockStorage;
    late UserServicesTest userServices;

    setUp(() async {
      fakeDb = FakeFirebaseFirestore();
      mockAuth = MockFirebaseAuth(
        mockUser: MockUser(uid: "testUser123", email: "test@example.com"),
      );
      mockStorage = MockFirebaseStorage();

      await mockAuth.signInWithEmailAndPassword(
        email: "test@example.com",
        password: "123456",
      );

      userServices = UserServicesTest(
        db: fakeDb,
        auth: mockAuth,
        storage: mockStorage,
      );
    });

    test("createUser() should create/update user in Firestore", () async {
      final user = AppUser(
        id: "",
        name: "Nada",
        email: "nada@example.com",
        phone: '',
        profileImage: '',
      );

      await userServices.createUser(user);

      final doc = await fakeDb.collection("users").doc("testUser123").get();

      expect(doc.exists, true);
      expect(doc["name"], "Nada");
      expect(doc["email"], "nada@example.com");
    });

    test("getCurrentUser() returns the correct UID", () {
      final uid = userServices.getCurrentUser();
      expect(uid, "testUser123");
    });

    test("getUserName() returns saved username", () async {
      await fakeDb.collection("users").doc("testUser123").set({
        "name": "Nada Saber",
      });

      final name = await userServices.getUserName();
      expect(name, "Nada Saber");
    });

    test("uploadProfileImage() uploads and returns URL", () async {
      final file = File("test/test_image.jpg");
      await file.writeAsString("fake image content");

      final url = await userServices.uploadProfileImage(file);

      expect(url, isNotNull);
      expect(url!.contains("profile.jpg"), true);
    });
  });
}
