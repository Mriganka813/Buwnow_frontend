import 'dart:convert';

import 'package:gofoods/models/seller_address.dart';

class Seller {
  SellerAddress? address;
  String? sId;
  String? email;
  String? role;
  String? businessName;
  String? businessType;
  int? phoneNumber;
  int? clicks;
  String? referredBy;
  String? taxFile;
  String? upiId;
  String? createdAt;
  String? updatedAt;
  int? iV;

  Seller(
      {this.address,
      this.sId,
      this.email,
      this.role,
      this.businessName,
      this.businessType,
      this.phoneNumber,
      this.clicks,
      this.referredBy,
      this.taxFile,
      this.upiId,
      this.createdAt,
      this.updatedAt,
      this.iV});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'address': address?.toJson(),
      'sId': sId,
      'email': email,
      'role': role,
      'businessName': businessName,
      'businessType': businessType,
      'phoneNumber': phoneNumber,
      'clicks': clicks,
      'referredBy': referredBy,
      'taxFile': taxFile,
      'upiId': upiId,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'iV': iV,
    };
  }

  factory Seller.fromMap(Map<String, dynamic> map) {
    return Seller(
      address: map['address'] != null
          ? SellerAddress.fromJson(map['address'] as Map<String, dynamic>)
          : null,
      sId: map['sId'] != null ? map['sId'] as String : null,
      email: map['email'] != null ? map['email'] as String : null,
      role: map['role'] != null ? map['role'] as String : null,
      businessName:
          map['businessName'] != null ? map['businessName'] as String : null,
      businessType:
          map['businessType'] != null ? map['businessType'] as String : null,
      phoneNumber:
          map['phoneNumber'] != null ? map['phoneNumber'] as int : null,
      clicks: map['clicks'] != null ? map['clicks'] as int : null,
      referredBy:
          map['referredBy'] != null ? map['referredBy'] as String : null,
      taxFile: map['taxFile'] != null ? map['taxFile'] as String : null,
      upiId: map['upiId'] != null ? map['upiId'] as String : null,
      createdAt: map['createdAt'] != null ? map['createdAt'] as String : null,
      updatedAt: map['updatedAt'] != null ? map['updatedAt'] as String : null,
      iV: map['iV'] != null ? map['iV'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Seller.fromJson(String source) =>
      Seller.fromMap(json.decode(source) as Map<String, dynamic>);
}
