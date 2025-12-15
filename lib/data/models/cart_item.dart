
class CartItem {
  String id;
  String name;
  int quantity;
  double price;
  double newPrice;
  String? note;
  String imageUrl;
  String? category;

  CartItem({
    required this.id,
    required this.name,
    required this.quantity,
    required this.price,
    this.newPrice=0,
    this.note,
    required this.imageUrl,
    this.category,
  });


  double get finalPrice =>
      newPrice > 0 ? newPrice : price;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'quantity': quantity,
      'price': price,
      'newPrice': newPrice,
      'note': note,
      'imageUrl': imageUrl,
      'category': category,
    };
  }

  factory CartItem.fromMap(Map<String, dynamic> map) {
    return CartItem(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      quantity: (map['quantity'] as num).toInt(),
      price: (map['price'] as num).toDouble(),
      // newPrice: (map['newPrice'] ).toDouble(),
      note: map['note'],
      imageUrl: map['imageUrl'] ?? '',
      category: map['category'],
    );
  }
}
