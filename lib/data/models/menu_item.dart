class MenuItem {
  String description;
  String category;
  String id;
  String image_url;
  String name ;
  num price;
  num total_order_count;
  num user_order_count;
  num? quantity;
  MenuItem({
    required this.description,
    required this.category,
    required this.id,
    required this.image_url,
    required this.name,
    required this.price,
    required this.total_order_count,
    required this.user_order_count,
    this.quantity
  });
  


  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'description': description,
      'category': category,
      'id': id,
      'image_url': image_url,
      'name': name,
      'price': price,
      'total_order_count': total_order_count,
      'user_order_count': user_order_count,
      'quantity':quantity
    };
  }

  factory MenuItem.fromMap(Map<String, dynamic> map) {
    return MenuItem(
      description: map['description'] as String,
      category: map['category'] as String,
      id: map['id'] as String,
      image_url: map['image_url'] as String,
      name:map['name'] as String,
      price: map['price'] as num,
      total_order_count: map['total_order_count'] as num,
      user_order_count: map['user_order_count'] as num,
      quantity:map['quantity'] as num
    );
  }
}
