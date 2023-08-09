import 'package:buynow/models/seller_address.dart';

class CategoryItem {
  SellerAddress? address;
  String? sId;
  String? email;
  String? role;
  String? businessName;
  String? businessType;
  String? image;
  int? phoneNumber;
  int? clicks;
  String? referredBy;
  String? taxFile;
  String? upiId;
  String? createdAt;
  String? updatedAt;
  int? iV;

  CategoryItem(
      {this.address,
      this.sId,
      this.email,
      this.role,
      this.businessName,
      this.businessType,
      this.image,
      this.phoneNumber,
      this.clicks,
      this.referredBy,
      this.taxFile,
      this.upiId,
      this.createdAt,
      this.updatedAt,
      this.iV});

  CategoryItem.fromJson(Map<String, dynamic> json) {
    address = json['address'] != null
        ? new SellerAddress.fromJson(json['address'])
        : null;
    sId = json['_id'];
    email = json['email'];
    role = json['role'];
    businessName = json['businessName'];
    businessType = json['businessType'];
    image = json['image'];
    phoneNumber = json['phoneNumber'];
    clicks = json['clicks'];
    referredBy = json['referredBy'];
    taxFile = json['taxFile'];
    upiId = json['upi_id'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.address != null) {
      data['address'] = this.address!.toJson();
    }
    data['_id'] = this.sId;
    data['email'] = this.email;
    data['role'] = this.role;
    data['businessName'] = this.businessName;
    data['businessType'] = this.businessType;
    data['image'] = this.image;
    data['phoneNumber'] = this.phoneNumber;
    data['clicks'] = this.clicks;
    data['referredBy'] = this.referredBy;
    data['taxFile'] = this.taxFile;
    data['upi_id'] = this.upiId;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}
