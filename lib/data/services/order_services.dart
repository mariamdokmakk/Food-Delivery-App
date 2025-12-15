import 'package:cloud_firestore/cloud_firestore.dart';
import '/data/models/menu_item.dart';
import '/data/models/order.dart';
import '/data/services/user_services.dart';

enum OrderProgress { pending, preparing, onTheWay, completed, canceled }

class OrderServices {
  static final FirebaseFirestore _db = FirebaseFirestore.instance;
  static const String orderCollection = "Orders";
  static const String userCollection = "users";

  /// Cancel an order
  static Future<void> cancelOrder(OrderItem order) async {
    order.orderState = OrderProgress.canceled.name;
    await _db
        .collection(userCollection)
        .doc(UserServices.getCurrentUser())
        .collection(orderCollection)
        .doc(order.id)
        .update({"orderState": OrderProgress.canceled.name});
  }

  /// Active orders = pending, preparing, onTheWay
  static Stream<List<OrderItem>> getActiveOrders() {
    return _db
        .collection(userCollection)
        .doc(UserServices.getCurrentUser())
        .collection(orderCollection)
        .where(
          "orderState",
          whereIn: [
            OrderProgress.pending.name,
            OrderProgress.preparing.name,
            OrderProgress.onTheWay.name,
          ],
        )
        .snapshots()
        .map(
          (snapshot) => snapshot.docs.map((doc) {
            return OrderItem.fromMap({...doc.data(), 'id': doc.id});
          }).toList(),
        );
  }

  /// Completed orders
  static Stream<List<OrderItem>> getCompletedOrders() {
    return _db
        .collection(userCollection)
        .doc(UserServices.getCurrentUser())
        .collection(orderCollection)
        .where("orderState", isEqualTo: OrderProgress.completed.name)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs.map((doc) {
            return OrderItem.fromMap({...doc.data(), 'id': doc.id});
          }).toList(),
        );
  }

  /// Cancelled orders
  static Stream<List<OrderItem>> getCancelledOrders() {
    return _db
        .collection(userCollection)
        .doc(UserServices.getCurrentUser())
        .collection(orderCollection)
        .where("orderState", isEqualTo: OrderProgress.canceled.name)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs.map((doc) {
            return OrderItem.fromMap({...doc.data(), 'id': doc.id});
          }).toList(),
        );
  }

  /// Calculate total price of an order
  static Future<double> calcTotalPrice(OrderItem order) async {
    double totalPrice = 0;
    final allOrderItems = await _db
        .collection(userCollection)
        .doc(UserServices.getCurrentUser())
        .collection(orderCollection)
        .doc(order.id)
        .collection("items")
        .get();

    for (var item in allOrderItems.docs) {
      totalPrice += MenuItem.fromMap(item.data()).price;
    }

    await _db
        .collection(userCollection)
        .doc(UserServices.getCurrentUser())
        .collection(orderCollection)
        .doc(order.id)
        .update({"totalPrice": totalPrice});

    return totalPrice;
  }
}
