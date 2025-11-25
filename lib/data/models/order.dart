// import 'package:cloud_firestore/cloud_firestore.dart';
// import '/data/models/menu_item.dart';
//
//
// class OrderItem {
//   final String id;
//   final List<MenuItem> items;
//   double totalPrice;
//   String orderState; // pending, preparing, delivered
//   String orderProgress; // active, completed, cancelled
//   final DateTime createdAt;
//
//   OrderItem({
//     required this.id,
//     required this.items,
//     required this.totalPrice,
//     required this.orderState,
//     required this.orderProgress,
//     required this.createdAt,
//   });
//
//   factory OrderItem.fromMap(Map<String, dynamic> data, {required String id}) {
//     return OrderItem(
//       id: id,
//       orderState: data["orderState"],
//       orderProgress: data["orderProgress"],
//       totalPrice: (data["totalPrice"] ?? 0).toDouble(),
//
//       // FIX: Convert List<dynamic> → List<MenuItem>
//       items: (data["items"] as List<dynamic>?)
//           ?.map((e) => MenuItem.fromMap(e))
//           .toList()
//           ?? [],
//
//       // FIX: Convert Timestamp → DateTime
//       createdAt: (data["createdAt"] as Timestamp).toDate(),
//     );
//   }
//
//
//   Map<String, dynamic> toMap() {
//     return {
//       'id': id,
//       'items': items.map((e) => e.toMap()).toList(),
//       'totalPrice': totalPrice,
//       'orderState': orderState,
//       'orderProgress': orderProgress,
//       'createdAt': Timestamp.fromDate(createdAt),
//     };
//   }
// }

// import 'package:cloud_firestore/cloud_firestore.dart';
//
// import '/data/models/menu_item.dart';
//
//
// class OrderItem {
//   final String userId;
//   final String id;
//   final num orderId;
//   final List<MenuItem> items;
//   double totalPrice;
//   String orderState; // pending, preparing, onTheWay,completed, cancelled
//   final DateTime createdAt;
//
//   OrderItem({
//     required this.userId,
//     required this.id,
//     required this.orderId,
//     required this.items,
//     required this.totalPrice,
//     required this.orderState,
//     required this.createdAt,
//   });
//
//   factory OrderItem.fromMap(Map<String, dynamic> data) {
//     return OrderItem(
//       userId: (data['userId']).toString(),
//       id: (data['id'] ?? '').toString(),
//       orderId: (data['orderId']),
//       totalPrice: (data['totalPrice'] ?? 0).toDouble(),
//       orderState: (data['orderState'] ?? 'pending').toString(),
//       createdAt: data['createdAt'] != null
//           ? (data['createdAt'] as Timestamp).toDate()
//           : DateTime.now(),
//       // FIX: Convert List<dynamic> → List<MenuItem>
//       items:
//       (data["items"] as List<dynamic>?)
//           ?.map((e) => MenuItem.fromMap(e))
//           .toList() ??
//           [],
//     );
//   }
//
//   Map<String, dynamic> toMap() {
//     return {
//       'id': id,
//       'userId': userId,
//       'orderId': orderId,
//       'items': items.map((e) => e.toMap()).toList(),
//       'totalPrice': totalPrice,
//       'orderState': orderState,
//       'createdAt': Timestamp.fromDate(createdAt),
//     };
//   }
// }

import 'package:cloud_firestore/cloud_firestore.dart';
import '/data/models/menu_item.dart';

class OrderItem {
  final String userId;
  final String id;
  final num orderId;
  final List<MenuItem> items;
  String address;
  double totalPrice;
  String orderState; // pending, preparing, onTheWay, completed, cancelled
  final DateTime createdAt;

  OrderItem({
    required this.userId,
    required this.id,
    required this.orderId,
    required this.items,
    required this.totalPrice,
    required this.orderState,
    required this.address,
    required this.createdAt,
  });

  factory OrderItem.fromMap(Map<String, dynamic> data) {
    return OrderItem(
      userId: (data['userId']).toString(),
      id: (data['id'] ?? '').toString(),
      orderId: (data['orderId']),
      totalPrice: (data['totalPrice'] ?? 0).toDouble(),
      orderState: (data['orderState'] ?? 'pending').toString(),
      address: (data['address'] ?? '').toString(),
      createdAt: data['createdAt'] != null
          ? (data['createdAt'] as Timestamp).toDate()
          : DateTime.now(),

      items: (data["items"] as List<dynamic>?)
          ?.map((e) => MenuItem.fromMap(e))
          .toList() ??
          [],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'orderId': orderId,
      'items': items.map((e) => e.toMap()).toList(),
      'totalPrice': totalPrice,
      'orderState': orderState,
      'address': address,
      'createdAt': Timestamp.fromDate(createdAt),
    };
  }
}

