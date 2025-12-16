import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:food_delivery_app/data/models/menu_item.dart';

import 'package:food_delivery_app/data/models/order.dart';

enum OrderProgress { pending, preparing, onTheWay, completed, cancelled }

class OrderServicesTest {
  final FirebaseFirestore db;
  final String userId;

  OrderServicesTest({required this.db, required this.userId});

  CollectionReference get userOrders =>
      db.collection("users").doc(userId).collection("Orders");

  Future<void> cancelOrder(OrderItem order) async {
    await userOrders.doc(order.id).update({
      "orderState": OrderProgress.cancelled.name,
    });
  }

  Stream<List<OrderItem>> getActiveOrders() {
    return userOrders
        .where("orderState", whereIn: [
          OrderProgress.pending.name,
          OrderProgress.preparing.name,
          OrderProgress.onTheWay.name
        ])
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) {
              final data = Map<String, dynamic>.from(doc.data() as Map<String, dynamic>);
              data['id'] = doc.id;
              return OrderItem.fromMap(data);
            })
            .toList());
  }

  Stream<List<OrderItem>> getCompletedOrders() {
    return userOrders
        .where("orderState", isEqualTo: OrderProgress.completed.name)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) {
              final data = Map<String, dynamic>.from(doc.data() as Map<String, dynamic>);
              data['id'] = doc.id;
              return OrderItem.fromMap(data);
            })
            .toList());
  }

  Stream<List<OrderItem>> getCancelledOrders() {
    return userOrders
        .where("orderState", isEqualTo: OrderProgress.cancelled.name)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => OrderItem.fromMap({...doc.data() as Map<String, dynamic>, "id": doc.id}))
            .toList());
  }

  Future<double> calcTotalPrice(OrderItem order) async {
    double total = 0;

    final items = await userOrders.doc(order.id).collection("items").get();

    for (var doc in items.docs) {
      total += MenuItem.fromMap(doc.data()).price;
    }

    await userOrders.doc(order.id).update({"totalPrice": total});
    return total;
  }
}
