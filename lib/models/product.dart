// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Product {
  String? sId;
  String? name;
  int? sellingPrice;
  int? returnPeriod;
  int? quantity;
  int? clicks;
  String? user;
  String? sellerName;
  String? createdAt;
  String? updatedAt;
  int? iV;

  Product(
      {this.sId,
      this.name,
      this.sellingPrice,
      this.returnPeriod,
      this.quantity,
      this.clicks,
      this.user,
      this.sellerName,
      this.createdAt,
      this.updatedAt,
      this.iV});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'sId': sId,
      'name': name,
      'sellingPrice': sellingPrice,
      'returnPeriod': returnPeriod,
      'quantity': quantity,
      'clicks': clicks,
      'user': user,
      'sellerName': sellerName,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'iV': iV,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      sId: map['sId'] != null ? map['sId'] as String : null,
      name: map['name'] != null ? map['name'] as String : null,
      sellingPrice:
          map['sellingPrice'] != null ? map['sellingPrice'] as int : null,
      returnPeriod:
          map['returnPeriod'] != null ? map['returnPeriod'] as int : null,
      quantity: map['quantity'] != null ? map['quantity'] as int : null,
      clicks: map['clicks'] != null ? map['clicks'] as int : null,
      user: map['user'] != null ? map['user'] as String : null,
      sellerName:
          map['sellerName'] != null ? map['sellerName'] as String : null,
      createdAt: map['createdAt'] != null ? map['createdAt'] as String : null,
      updatedAt: map['updatedAt'] != null ? map['updatedAt'] as String : null,
      iV: map['iV'] != null ? map['iV'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Product.fromJson(String source) =>
      Product.fromMap(json.decode(source) as Map<String, dynamic>);
}
