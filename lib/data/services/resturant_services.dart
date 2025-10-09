import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:food_delivery/data/models/menu_item.dart';

class ResturantServices {
  static String restaurantsCollection = "Restaurants";
  static final FirebaseFirestore _db = FirebaseFirestore.instance;

  //load all menu items in resturant
  static Stream<List<MenuItem>> getMenuItems(String resturantId) {
    final queryStream = _db
        .collection(restaurantsCollection)
        .doc(resturantId)
        .collection('menu')
        .snapshots();
    return queryStream.map(
      (snapshot) =>
          snapshot.docs.map((doc) => MenuItem.fromMap(doc.data())).toList(),
    );
  }

  //load best seller in resturant
  static Stream<List<MenuItem>> getBestSellerInResturant(String restaurantId) {
    final queryStream = FirebaseFirestore.instance
        .collection('Restaurants')
        .doc(restaurantId)
        .collection('menu')
        .orderBy('totalOrderCount', descending: true)
        .limit(10)
        .snapshots();

    return queryStream.map(
      (snapshot) =>
          snapshot.docs.map((doc) => MenuItem.fromMap(doc.data())).toList(),
    );
  }
}
