class CartItem {
  String id;
  String name;
  int quantity;
  double price;
  String? note;
  String imageUrl;
  CartItem({
    required this.id,
    required this.name,
    required this.quantity,
    required this.price,
    this.note,
    required this.imageUrl,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'quantity': quantity,
      'price': price,
      'note': note,
      'imageUrl': imageUrl,
    };
  }

  factory CartItem.fromMap(Map<String, dynamic> map) {
    return CartItem(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      quantity: (map['quantity'] as num).toInt(),
      price: (map['price'] as num).toDouble(),
      note: map['note'],
      imageUrl: map['imageUrl'] ?? '',
    );
  }
}
