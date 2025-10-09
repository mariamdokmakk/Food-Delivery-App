
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:food_delivery/data/models/menu_item.dart';
import 'package:food_delivery/data/models/resturant.dart';

class HomeServices {
  static  String restaurantsCollection = "Restaurants";
   static const String offersCollection = "Offers";

  static final FirebaseFirestore _db = FirebaseFirestore.instance;

//creat a function to load all resturants
  static Stream<List<Resturant>> getResturants() {
    final queryStream = _db.collection(restaurantsCollection).snapshots();
    return queryStream.map((snapshot) {
      return snapshot.docs
          .map((doc) => Resturant.fromMap(doc.data()))
          .toList();
    });
  }
  
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
        .collectionGroup('menu') // gets ALL documents in all menu subcollections
        .orderBy('totalOrderCount', descending: true)
        .limit(10)
        .snapshots();

    return queryStream.map((snapshot) =>
        snapshot.docs.map((doc) => MenuItem.fromMap(doc.data())).toList());
  }



    
  }

   




