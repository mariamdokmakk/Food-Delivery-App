import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/data/services/user_services.dart';
import '../models/cart_item.dart';
import 'offers_services.dart';

class CartServices {
  final OfferService _offerService = OfferService();

  static final FirebaseFirestore _db = FirebaseFirestore.instance;
  static const String userCollection = "users";
  static const String cartCollection = "Cart";

  /// Call this on app start to initialize cart count
  static Future<void> initCartCount() async {
    await getAllCartItemsOnce(); // fetch current cart and update notifier
  }

  /// ValueNotifier for cart count
  static final ValueNotifier<int> cartCountNotifier = ValueNotifier<int>(0);

  /// Stream all cart items for current user
  static Stream<List<CartItem>> getAllCartItems() {
    final userId = UserServices.getCurrentUser();
    final stream = _db
        .collection(userCollection)
        .doc(userId)
        .collection(cartCollection)
        .snapshots()
        .map((snapshot) =>
        snapshot.docs.map((doc) => CartItem.fromMap(doc.data())).toList());

    // Count items
    stream.listen((items) {
      cartCountNotifier.value = items.length;
    });

    return stream;
  }

  /// Get cart items once (useful for updating count manually)
  static Future<List<CartItem>> getAllCartItemsOnce() async {
    final userId = UserServices.getCurrentUser();
    final snapshot = await _db
        .collection(userCollection)
        .doc(userId)
        .collection(cartCollection)
        .get();

    final items =
    snapshot.docs.map((doc) => CartItem.fromMap(doc.data())).toList();

    // Update cart count
    cartCountNotifier.value = items.fold(0, (sum, item) => sum + item.quantity);

    return items;
  }

  /// Add a new item to cart
  static Future<void> addCartItem(CartItem item) async {
    final userId = UserServices.getCurrentUser();
    await _db
        .collection(userCollection)
        .doc(userId)
        .collection(cartCollection)
        .doc(item.id)
        .set(item.toMap());

    // Update cart count
    await getAllCartItemsOnce();
  }

  /// Delete one cart item
  static Future<void> deleteCartItem(String id) async {
    final userId = UserServices.getCurrentUser();
    await _db
        .collection(userCollection)
        .doc(userId)
        .collection(cartCollection)
        .doc(id)
        .delete();

    // Update cart count
    await getAllCartItemsOnce();
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

    // Update cart count
    cartCountNotifier.value = 0;
  }
}
