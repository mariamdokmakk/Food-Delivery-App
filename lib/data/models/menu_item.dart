
class MenuItem {
  String description;
  String category;
  String id;
  String image_url;
  String name ;
  bool isFav;
  num price;
  num? newPrice;
  bool hasOffer=false;
  num total_order_count;
   // num? quantity;
   
  MenuItem({
    required this.description,
    required this.category,
    required this.id,
    required this.image_url,
    required this.name,
    required this.isFav,
    required this.price,
    this.newPrice,
    required this.hasOffer,
    required this.total_order_count,
  });
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'description': description,
      'category': category,
      'id': id,
      'image_url': image_url,
      'name': name,
      'isFav': isFav,
      'price': price,
      'newPrice': newPrice,
      'hasOffer=false': hasOffer=false,
      'total_order_count': total_order_count,
    };
  }

  factory MenuItem.fromMap(Map<String, dynamic> map) {
    return MenuItem(
      description: map['description'] as String,
      category: map['category'] as String,
      id: map['id'] as String,
      image_url: map['image_url'] as String,
      name: map ['name'] ,
      isFav: map['isFav'] as bool,
      price: map['price'] as num,
      newPrice: map['newPrice'] != null ? map['newPrice'] as num : null,
      hasOffer: map['hasOffer'] as bool,
      total_order_count: map['total_order_count'] as num,
    );
  }

}
