

import 'package:cloud_firestore/cloud_firestore.dart';


class OffersItem {
  String id;
  num discount_percent;
  bool is_active;
  DateTime valid_from;
  DateTime valid_to;
  
  OffersItem({
    required this.id,
    required this.discount_percent,
    required this.is_active,
    required this.valid_from,
    required this.valid_to,
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

  factory OffersItem.fromMap(Map<String, dynamic> map) {
    return OffersItem(
      id: map['id'] as String,
      discount_percent: map['discount_percent'] as num,
      is_active: map['is_active'] as bool,
      valid_from:(map['valid_from']as Timestamp).toDate(),
      valid_to: (map['valid_to']as Timestamp).toDate(),
      
    );
  }

}
