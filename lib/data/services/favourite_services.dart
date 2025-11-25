import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import '../models/menu_item.dart';


class FavoriteServices {


  static ValueNotifier<List<String>> favoriteIds = ValueNotifier([]);

  static Future<void> loadFavorites() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    final doc = await FirebaseFirestore.instance
        .collection("users")
        .doc(user.uid)
        .get();

    favoriteIds.value =
    List<String>.from(doc.data()?["favoriteMenuItems"] ?? []);
  }

  static Future<bool> isFavorite(String itemId) async {
    if (favoriteIds.value.isEmpty) await loadFavorites();
    return favoriteIds.value.contains(itemId);
  }

  static Future<void> toggleFavorite(MenuItem item) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    final ref =
    FirebaseFirestore.instance.collection("users").doc(user.uid);

    if (favoriteIds.value.contains(item.id)) {
      await ref.update({
        "favoriteMenuItems": FieldValue.arrayRemove([item.id])
      });
      favoriteIds.value.remove(item.id);
    } else {
      await ref.update({
        "favoriteMenuItems": FieldValue.arrayUnion([item.id])
      });
      favoriteIds.value.add(item.id);
    }

    // notify listeners
    favoriteIds.notifyListeners();
  }




  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final String userCollection = "users";
  final String restaurantId= 'UFrCk69XBDrXFMOCuMvB';



  // static Future<bool> isFavorite(String itemId) async {
  //   final user = FirebaseAuth.instance.currentUser;
  //   if (user == null) return false;
  //
  //   final doc = await FirebaseFirestore.instance
  //       .collection("users")
  //       .doc(user.uid)
  //       .get();
  //
  //   List<String> favs = List<String>.from(doc.data()?["favoriteMenuItems"] ?? []);
  //   return favs.contains(itemId);
  // }

  // static Future<void> toggleFavorite(MenuItem item) async {
  //   final user = FirebaseAuth.instance.currentUser;
  //   if (user == null) return;
  //
  //   final ref = FirebaseFirestore.instance.collection("users").doc(user.uid);
  //
  //   final doc = await ref.get();
  //   List<String> favs = List<String>.from(doc.data()?["favoriteMenuItems"] ?? []);
  //
  //   if (favs.contains(item.id)) {
  //     await ref.update({
  //       "favoriteMenuItems": FieldValue.arrayRemove([item.id])
  //     });
  //   } else {
  //     await ref.update({
  //       "favoriteMenuItems": FieldValue.arrayUnion([item.id])
  //     });
  //   }
  // }



  Future<List<MenuItem>> getFavoriteMenuItems(
      String userId) async {
    final favIds = await getUserFavorites(userId);
    if (favIds.isEmpty) return [];

    List<MenuItem> results = [];
    for (int i = 0; i < favIds.length; i += 10) {
      final chunk = favIds.sublist(i, i + 10 > favIds.length ? favIds.length : i + 10);
      final snapshot = await _db
          .collection('Restaurant')
          .doc(restaurantId)
          .collection('menu')
          .where(FieldPath.documentId, whereIn: chunk)
          .get();
      results.addAll(snapshot.docs.map((doc) => MenuItem.fromFirestore(doc)));
    }
    return results;
  }


  /// GET ALL FAVORITE ITEM IDS
  Future<List<String>> getUserFavorites(String userId) async {
    final doc = await _db.collection(userCollection).doc(userId).get();

    if (!doc.exists) return [];

    return List<String>.from(doc.data()?["favoriteMenuItems"] ?? []);
  }

  /// CHECK IF ITEM IS FAVORITE
  Future<bool> checkIfFavorite(String userId, String itemId) async {
    List<String> favs = await getUserFavorites(userId);
    return favs.contains(itemId);
  }

  // Future<List<MenuItem>> getFavoriteMenuItems(String userId) async {
  //   final favIds = await getUserFavorites(userId);
  //   if (favIds.isEmpty) return [];
  //
  //   List<MenuItem> results = [];
  //
  //   // Firestore 'whereIn' supports max 10 IDs per query
  //   for (int i = 0; i < favIds.length; i += 10) {
  //     final chunk = favIds.sublist(
  //       i,
  //       i + 10 > favIds.length ? favIds.length : i + 10,
  //     );
  //
  //     final snapshot = await _db
  //     .collection('Restaurant').doc('UFrCk69XBDrXFMOCuMvB')
  //         .collection('menu')
  //         .where(FieldPath.documentId, whereIn: chunk)
  //         .get();
  //
  //     results.addAll(snapshot.docs.map((doc) => MenuItem.fromFirestore(doc)));
  //   }
  //
  //   return results;
  // }


  Stream<List<MenuItem>> favoritesMenuItemsStream(String userId) {
    return _db.collection("users").doc(userId).snapshots().asyncMap((doc) async {
      try {
        final ids = doc.data()?["favoriteMenuItems"];
        final favIds = ids != null ? List<String>.from(ids) : <String>[];
        if (favIds.isEmpty) return [];
        return await getFavoriteMenuItems(userId);
      } catch (e, s) {
        return [];
      }
    });
  }



}

