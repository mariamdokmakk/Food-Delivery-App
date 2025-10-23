import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:food_delivery/data/models/menu_item.dart';
import 'package:food_delivery/data/services/user_services.dart';

class FavouriteServices {
  static final FirebaseFirestore _db = FirebaseFirestore.instance;
  static const String userCollection = "Users";
  static const String favCollection = "Favourites";

  Stream<List<MenuItem>> getFavourites() {
    final favColRef = _db
        .collection(userCollection)
        .doc(UserServices.getCurrentUser())
        .collection(favCollection)
        .snapshots();
    return favColRef.map(
      (favCol) => favCol.docs
          .map((favItem) => MenuItem.fromMap(favItem.data()))
          .toList(),
    );
  }
}