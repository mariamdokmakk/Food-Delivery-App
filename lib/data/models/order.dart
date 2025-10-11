import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:food_delivery/data/models/menu_item.dart';

class OrderItem {
  final String id;
  final String userId;
  final String restaurantId;
  final List<MenuItem> items;
  double totalPrice;
  String orderState; // pending, preparing, delivered
  String orderProgress; // active, completed, cancelled
  final DateTime createdAt;

  OrderItem({
    required this.id,
    required this.userId,
    required this.restaurantId,
    required this.items,
    required this.totalPrice,
    required this.orderState,
    required this.orderProgress,
    required this.createdAt,
  });

  factory OrderItem.fromMap(Map<String, dynamic> data) {
    return OrderItem(
      id: data['id'] ?? '',
      userId: data['userId'] ?? '',
      restaurantId: data['restaurantId'] ?? '',
      items: (data['items'] as List)
          .map((item) => MenuItem.fromMap(item))
          .toList(),
      totalPrice: (data['totalPrice'] ?? 0).toDouble(),
      orderState: data['orderState'] ?? 'pending',
      orderProgress: data['orderProgress'] ?? 'active',
      createdAt: (data['createdAt'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'restaurantId': restaurantId,
      'items': items.map((e) => e.toMap()).toList(),
      'totalPrice': totalPrice,
      'orderState': orderState,
      'orderProgress': orderProgress,
      'createdAt': Timestamp.fromDate(createdAt),
    };
  }
}
