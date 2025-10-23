import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:food_delivery/data/models/menu_item.dart';
import 'package:food_delivery/data/models/order.dart';
import 'package:food_delivery/data/services/user_services.dart';

//will edit all

enum OrderProgress { pending, preparing, delivered }

enum OrderState { active, completed, cancelled }

class OrderServices {
  static final FirebaseFirestore _db = FirebaseFirestore.instance;
  static const String orderCollection = "Orders";
  static const String userCollection = "Users";

  static Future<void> cancelOrder(OrderItem order) async {
    order.orderState = OrderState.cancelled.name;
    await _db
        .collection(userCollection)
        .doc(UserServices.getCurrentUser())
        .collection(orderCollection)
        .doc(order.id)
        .update({"orderState": OrderState.cancelled.name});
  }

  static Stream<List<OrderItem>> getActiveOrders() {
    final allOrders = _db
        .collection(userCollection)
        .doc(UserServices.getCurrentUser())
        .collection(orderCollection)
        .where("orderState", isEqualTo: OrderState.active.name)
        .snapshots();

    return allOrders.map(
      (snapshot) => snapshot.docs
          .map((order) => OrderItem.fromMap(order.data()))
          .toList(),
    );
  }

  static Stream<List<OrderItem>> getCancelledOrders() {
    final allOrders = _db
        .collection(userCollection)
        .doc(UserServices.getCurrentUser())
        .collection(orderCollection)
        .where("orderState", isEqualTo: OrderState.cancelled.name)
        .snapshots();

    return allOrders.map(
      (snapshot) => snapshot.docs
          .map((order) => OrderItem.fromMap(order.data()))
          .toList(),
    );
  }

  static Stream<List<OrderItem>> getCompletedOrders() {
    final allOrders = _db
        .collection(userCollection)
        .doc(UserServices.getCurrentUser())
        .collection(orderCollection)
        .where("orderState", isEqualTo: OrderState.completed.name)
        .snapshots();

    return allOrders.map(
      (snapshot) => snapshot.docs
          .map((order) => OrderItem.fromMap(order.data()))
          .toList(),
    );
  }

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
