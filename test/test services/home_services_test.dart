import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:food_delivery_app/data/models/menu_item.dart';
import 'package:food_delivery_app/data/models/offers_item.dart';

class HomeServicesTest {
  final FirebaseFirestore db;

  HomeServicesTest({required this.db});

  static const String restaurantsCollection = "Restaurant";
  static const String offersCollection = "Offers";
  static const String restaurantId = "UFrCk69XBDrXFMOCuMvB";

  Stream<List<OffersItem>> getOffers() {
    return db.collection(offersCollection).snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return OffersItem.fromMap(doc.data());
      }).toList();
    });
  }

  Stream<List<MenuItem>> getBestSellers() {
    return db
        .collection(restaurantsCollection)
        .doc(restaurantId)
        .collection('menu')
        .orderBy('totalOrderCount', descending: true)
        .limit(10)
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => MenuItem.fromMap(doc.data())).toList());
  }

  Stream<List<MenuItem>> getMenuItems() {
    return db
        .collection(restaurantsCollection)
        .doc(restaurantId)
        .collection('menu')
        .snapshots()
        .map((s) =>
            s.docs.map((d) => MenuItem.fromMap(d.data())).toList());
  }

  Stream<List<MenuItem>> getMenuItemsByCategory(String category) {
    return db
        .collection(restaurantsCollection)
        .doc(restaurantId)
        .collection('menu')
        .where('category', isEqualTo: category)
        .snapshots()
        .map((s) =>
            s.docs.map((d) => MenuItem.fromMap(d.data())).toList());
  }
}
