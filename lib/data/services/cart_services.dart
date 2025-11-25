import 'package:cloud_firestore/cloud_firestore.dart';
import '/data/models/cart_item.dart';
import '/data/services/user_services.dart';


class CartServices {
  static final FirebaseFirestore _db = FirebaseFirestore.instance;
  static const String userCollection = "users";
  static const String cartCollection = "Cart";

  /// Stream all cart items for current user
  static Stream<List<CartItem>> getAllCartItems() {
    return _db
        .collection(userCollection)
        .doc(UserServices.getCurrentUser())
        .collection(cartCollection)
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => CartItem.fromMap(doc.data())).toList());
  }

  /// Delete one cart item
  static Future<void> deleteCartItem(String id) async {
    await _db
        .collection(userCollection)
        .doc(UserServices.getCurrentUser())
        .collection(cartCollection)
        .doc(id)
        .delete();
  }

  /// Add a new item to cart
  static Future<void> addCartItem(CartItem item) async {
    await _db
        .collection(userCollection)
        .doc(UserServices.getCurrentUser())
        .collection(cartCollection)
        .doc(item.id)
        .set(item.toMap());
  }

  /// Clear the entire cart
  static Future<void> clearCart() async {
    final userId = UserServices.getCurrentUser();
    final batch = _db.batch();
    final cartRef =
        _db.collection(userCollection).doc(userId).collection(cartCollection);

    final snapshot = await cartRef.get();
    for (final doc in snapshot.docs) {
      batch.delete(doc.reference);
    }
    await batch.commit();
  }
}
