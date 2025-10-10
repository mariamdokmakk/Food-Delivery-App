import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:food_delivery/data/models/menu_item.dart';

class OffersItem {
  String id;
  num discount_percent;
  bool is_active;
  String restaurant_id;
  DateTime valid_from;
  DateTime valid_to;
  MenuItem menu_item;

  OffersItem({
    required this.id,
    required this.discount_percent,
    required this.is_active,
    required this.restaurant_id,
    required this.valid_from,
    required this.valid_to,
    required this.menu_item,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'discount_percent': discount_percent,
      'is_active': is_active,
      'restaurant_id': restaurant_id,
      'valid_from': Timestamp.fromDate(valid_from),
      'valid_to': Timestamp.fromDate(valid_to),
      'menu_item': menu_item.toMap(),
    };
  }

  factory OffersItem.fromMap(Map<String, dynamic> map) {
    return OffersItem(
      id: map['id'] as String,
      discount_percent: map['discount_percent'] as num,
      is_active: map['is_active'] as bool,
      restaurant_id: map['restaurant_id'] as String,
      valid_from: (map['valid_from'] as Timestamp).toDate(),
      valid_to: (map['valid_to'] as Timestamp).toDate(),
      menu_item: MenuItem.fromMap(map['menu_item'] as Map<String, dynamic>),
    );
  }
}
