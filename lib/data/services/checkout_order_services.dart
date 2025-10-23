import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:food_delivery/data/models/cart_item.dart';
import 'package:food_delivery/data/services/user_services.dart';

class CheckoutOrderServices {
  static final FirebaseFirestore _db = FirebaseFirestore.instance;
  static const String userCollection = "Users";
  static const String cartCollection = "Cart";
  static const String ordersCollection = "Orders";

  static Future<List<CartItem>> getAllCartItems() async {
    final cartColRef = await _db
        .collection(userCollection)
        .doc(UserServices.getCurrentUser())
        .collection(cartCollection)
        .get();

    return cartColRef.docs
        .map((cartItem) => CartItem.fromMap(cartItem.data()))
        .toList();
  }

  //need to handle fee
  static Future<void> placeOrder(num fee) async {
    final order = _db
        .collection(userCollection)
        .doc(UserServices.getCurrentUser())
        .collection(ordersCollection)
        .doc();

    _db
        .collection(userCollection)
        .doc(UserServices.getCurrentUser())
        .collection(ordersCollection)
        .doc()
        .set({
          'id': order.id,
          'items': CheckoutOrderServices.getAllCartItems(),
          'totalPrice': CheckoutOrderServices.getTotalPrice(fee),
          'orderState': "active",
          'orderProgress': "preparing",
          'createdAt': Timestamp.now(),
        });
  }

  static Future<num> getTotalPrice(num fee) async {
    num totalPrice = 0;

    final List<CartItem> cartList =
        await CheckoutOrderServices.getAllCartItems();
    cartList.map((cartItem) => totalPrice += cartItem.price);

    return totalPrice + fee;
  }
}
