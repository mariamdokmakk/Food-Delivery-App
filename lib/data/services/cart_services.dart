import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:food_delivery/data/models/cart_item.dart';
import 'package:food_delivery/data/services/user_services.dart';

class CartServices {
  static final FirebaseFirestore _db = FirebaseFirestore.instance;
  static const String userCollection = "Users";
  static const String cartCollection = "Cart";

  Stream<List<CartItem>> getAllCartItems() {
    final cartColRef = _db
        .collection(userCollection)
        .doc(UserServices.getCurrentUser())
        .collection(cartCollection)
        .snapshots();
    return cartColRef.map(
      (cartCol) => cartCol.docs
          .map((cartItem) => CartItem.fromMap(cartItem.data()))
          .toList(),
    );
  }

  Future<void> deleteCartItem(String id) async {
    _db
        .collection(userCollection)
        .doc(UserServices.getCurrentUser())
        .collection(cartCollection)
        .doc(id)
        .delete();
  }

  //add a checkout order button forwards me to checkout screen
}