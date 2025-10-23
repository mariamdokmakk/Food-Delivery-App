import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:food_delivery/data/models/menu_item.dart';
import 'package:food_delivery/data/services/user_services.dart';

class ItemDetailsServices {
  static final FirebaseFirestore _db = FirebaseFirestore.instance;
  static const String userCollection = "Users";
  static const String cartCollection = "Cart";

  Future<void> addToCart(MenuItem menuItem, int quantity, String note) async {
    final cartItem = _db
        .collection(userCollection)
        .doc(UserServices.getCurrentUser())
        .collection(cartCollection)
        .doc(menuItem.id);

    final existingDoc = await cartItem.get();
    if (existingDoc.exists) {
      final currentQuantity = existingDoc['quantity'] ?? 0;
      await cartItem.update({
        'quantity': currentQuantity + quantity,
        'price': menuItem.price * (currentQuantity + quantity),
      });
    } else {
      await cartItem.set({
        'id': menuItem.id,
        'name': menuItem.name,
        'quantity': quantity,
        'price': menuItem.price * quantity,
        'imageUrl': menuItem.image_url,
        'note': note,
      });
    }
  }

  //in UI I will handle the price on btn ,note,and quantity
}
