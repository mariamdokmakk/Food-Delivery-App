import 'package:cloud_firestore/cloud_firestore.dart';
import '/data/models/menu_item.dart';
import '/data/models/offers_item.dart';
import '/data/services/user_services.dart';


class HomeServices {
  static String restaurantsCollection = "Restaurant";
  static const String offersCollection = "Offers";
  static const String restaurantId = "UFrCk69XBDrXFMOCuMvB";
  static const String userCollection = "users";
  // static const String favCollection = "Favourites";
  static final FirebaseFirestore _db = FirebaseFirestore.instance;

  //create fuction to load all offers

  // static Stream<List<MenuItem>> getOffers() {
  //   final queryStream = _db.collection(offersCollection).snapshots();
  //   return queryStream.map((snapshot) {
  //     return snapshot.docs.map((doc) => MenuItem.fromMap(doc.data())).toList();
  //   });
  // }
  static Stream<List<OffersItem>> getOffers() {
    return _db.collection(offersCollection).snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        final data = doc.data();
        return OffersItem.fromMap(data);
      }).toList();
    });
  }

  //load bestsellers

  static Stream<List<MenuItem>> getBestSellers() {
    final queryStream = _db
        .collection(restaurantsCollection)
        .doc(restaurantId)
        .collection('menu')
        .orderBy('totalOrderCount', descending: true)
        .limit(10)
        .snapshots();

    return queryStream.map((snapshot) {
      return snapshot.docs.map((doc) {
        return MenuItem.fromMap(doc.data());
      }).toList();
    });
  }

  //get menu items
  static Stream<List<MenuItem>> getMenuItems() {
    final queryStream = _db
        .collection(restaurantsCollection)
        .doc(restaurantId)
        .collection('menu')
        .snapshots();

    return queryStream.map(
      (snapshot) =>
          snapshot.docs.map((doc) => MenuItem.fromMap(doc.data())).toList(),
    );
  }

  //get item by its category
  static Stream<List<MenuItem>> getMenuItemsByCategory(String category) {
    final queryStream = _db
        .collection(restaurantsCollection)
        .doc(restaurantId)
        .collection('menu')
        .where('category', isEqualTo: category)
        .snapshots();

    return queryStream.map(
      (snapshot) =>
          snapshot.docs.map((doc) => MenuItem.fromMap(doc.data())).toList(),
    );
  }

  //favoutrite handling
  // Future<void> handleFav(MenuItem menuItem) async {
  //   final favItem = _db
  //       .collection(userCollection)
  //       .doc(UserServices.getCurrentUser())
  //       .collection(favCollection)
  //       .doc(menuItem.id);
  //
  //   final existingDoc = await favItem.get();
  //   if (existingDoc.exists) {
  //     favItem.delete();
  //   } else {
  //     await favItem.set(menuItem.toMap());
  //   }
  // }
}
