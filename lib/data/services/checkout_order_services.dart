import 'package:cloud_firestore/cloud_firestore.dart';
import '/data/models/cart_item.dart';
import '/data/services/user_services.dart';
import 'package:geocoding/geocoding.dart';


class CheckoutOrderServices {
  static final FirebaseFirestore _db = FirebaseFirestore.instance;
  static const String userCollection = "users";
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
  static Future<num> getTotalPrice(num fee) async {
    num totalPrice = 0;

    final List<CartItem> cartList = await getAllCartItems();

    for (final cartItem in cartList) {
      totalPrice += cartItem.finalPrice * cartItem.quantity;
    }

    return totalPrice + fee;
  }


  static Future<void> placeOrder(num fee) async {
    final userId = UserServices.getCurrentUser();

    // 1️⃣ Fetch all cart items (await)
    final List<CartItem> items = await getAllCartItems();

    // Convert items to Firestore-friendly map list
    final List<Map<String, dynamic>> itemsMap =
    items.map((e) => e.toMap()).toList();

    // 2️⃣ Calculate total price
    final num totalPrice = await getTotalPrice(fee);

    // 3️⃣ Create order document reference
    final orderRef = _db
        .collection(userCollection) // make sure this matches your rules
        .doc(userId)
        .collection(ordersCollection)
        .doc();

    // 4️⃣ Store the order (await or it will fail silently)
    await orderRef.set({
      'id': orderRef.id,
      'items': itemsMap,            // NOT future
      'totalPrice': totalPrice,     // NOT future
      'orderState': "active",
      'orderProgress': "preparing",
      'createdAt': Timestamp.now(),
    });
  }



  static Future<String> getAddressFromCoordinates(double lat, double lng) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(lat, lng);
      if (placemarks.isEmpty) return "Unknown location";
      final place = placemarks.first;
      return "${place.street}, ${place.locality}, ${place.country}";
    } catch (e) {
      return "Failed to get address";
    }
  }



}
