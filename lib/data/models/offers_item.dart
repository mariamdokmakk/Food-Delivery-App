// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import '/data/models/menu_item.dart';


class OffersItem {
  String id;
  num discount_percent;
  bool is_active;
  DateTime valid_from;
  DateTime valid_to;
  MenuItem menu_item;

  OffersItem({
    required this.id,
    required this.discount_percent,
    required this.is_active,
    required this.valid_from,
    required this.valid_to,
    required this.menu_item,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'discount_percent': discount_percent,
      'is_active': is_active,
      'valid_from': Timestamp.fromDate(valid_from),
      'valid_to': Timestamp.fromDate(valid_to),
    };
  }

  // factory OffersItem.fromMap(Map<String, dynamic> map) {
  //   return OffersItem(
  //     id: map['id'] as String,
  //     discount_percent: map['discount_percent'] as num,
  //     is_active: map['is_active'] as bool,
  //     valid_from:(map['valid_from']as Timestamp).toDate(),
  //     valid_to: (map['valid_to']as Timestamp).toDate(),
  //     menu_item: MenuItem.fromMap(map['menu_item'] as Map<String, dynamic>),
  //   );
  // }
  factory OffersItem.fromMap(Map<String, dynamic> map) {
    return OffersItem(
      id: map['id'] ?? '',
      discount_percent: map['discount_percent'] ?? 0,
      is_active: map['is_active'] ?? false,
      valid_from: (map['valid_from'] is Timestamp)
          ? (map['valid_from'] as Timestamp).toDate()
          : DateTime.now(),
      valid_to: (map['valid_to'] is Timestamp)
          ? (map['valid_to'] as Timestamp).toDate()
          : DateTime.now(),
      menu_item:
          map['menu_item'] != null && map['menu_item'] is Map<String, dynamic>
          ? MenuItem.fromMap(map['menu_item'] as Map<String, dynamic>)
          : MenuItem(
              id: '',
              name: '',
              description: '',
              category: '',
              imageUrl: '',
              price: 0,
              newPrice: 0,
              totalOrderCount: 0,
            ),
    );
  }
}
