
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:food_delivery/data/models/menu_item.dart';
class HomeServices {
  static  String restaurantsCollection = "Restaurants";
   static const String offersCollection = "Offers";
static const String restaurantId="UFrCk69XBDrXFMOCuMvB";
  static final FirebaseFirestore _db = FirebaseFirestore.instance;


//create fuction to load all offers
  static Stream<List<MenuItem>> getOffers() {
    final queryStream = _db.collection(offersCollection).snapshots();
    return queryStream.map((snapshot) {
      return snapshot.docs
          .map((doc) => MenuItem.fromMap(doc.data()))
          .toList();
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

    return queryStream.map((snapshot) =>
        snapshot.docs.map((doc) => MenuItem.fromMap(doc.data())).toList());
  }

//get menu items
  static Stream<List<MenuItem>> getMenuItems() {
    final queryStream = _db
        .collection(restaurantsCollection)
        .doc(restaurantId)
        .collection('menu')
        .snapshots();

    return queryStream.map((snapshot) =>
        snapshot.docs.map((doc) => MenuItem.fromMap(doc.data())).toList());

    
  }

  //get item by its category
  static Stream<List<MenuItem>> getMenuItemsByCategory(String category) {
    final queryStream = _db
        .collection(restaurantsCollection)
        .doc(restaurantId)
        .collection('menu')
        .where('category', isEqualTo: category)
        .snapshots();

    return queryStream.map((snapshot) =>
        snapshot.docs.map((doc) => MenuItem.fromMap(doc.data())).toList());
  }

   

}


