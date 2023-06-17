import 'dart:convert';

class Product {
  final String name;
  final String description;
  final int quantity;
  final String image;
  final int price;
  final String sellerid;
  final String? id;

  Product({
    required this.name,
    required this.description,
    required this.quantity,
    required this.image,
    required this.price,
    required this.sellerid,
    this.id,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
      'qty': quantity,
      'image': image,
      'price': price,
      'sellerId': sellerid,
      'id': id,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      quantity: map['qty'] ?? 0,
      image: map['image'],
      price: map['price'] ?? 0,
      sellerid: map['sellerId'] ?? '',
      id: map['_id'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Product.fromJson(String source) =>
      Product.fromMap(jsonDecode(source));
}
