import 'package:buynow/models/seller_address.dart';

class NearbyRestorentModel {
  SellerAddress? address;
  int? discount;
  bool? shopOpen;
  String? sId;
  String? email;
  String? role;
  String? businessName;
  String? businessType;
  int? phoneNumber;
  String? image;
  int? clicks;
  String? referredBy;
  String? taxFile;
  String? upiId;
  String? openingTime;
  String? closingTime;
  String? createdAt;
  String? updatedAt;
  int? iV;

  NearbyRestorentModel(
      {this.address,
      this.discount,
      this.shopOpen,
      this.sId,
      this.email,
      this.role,
      this.businessName,
      this.businessType,
      this.phoneNumber,
      this.image,
      this.clicks,
      this.referredBy,
      this.taxFile,
      this.upiId,
      this.openingTime,
      this.closingTime,
      this.createdAt,
      this.updatedAt,
      this.iV});

  NearbyRestorentModel.fromJson(Map<String, dynamic> json) {
    address = json['address'] != null
        ? new SellerAddress.fromJson(json['address'])
        : null;
    discount = json['discount'];
    shopOpen = json['shopOpen'];
    sId = json['_id'];
    email = json['email'];
    role = json['role'];
    businessName = json['businessName'];
    businessType = json['businessType'];
    phoneNumber = json['phoneNumber'];
    image = json['image'];
    clicks = json['clicks'];
    referredBy = json['referredBy'];
    taxFile = json['taxFile'];
    upiId = json['upi_id'];
    openingTime = json['openingTime'];
    closingTime = json['closingTime'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.address != null) {
      data['address'] = this.address!.toJson();
    }
    data['discount'] = this.discount;
    data['shopOpen'] = this.shopOpen;
    data['_id'] = this.sId;
    data['email'] = this.email;
    data['role'] = this.role;
    data['businessName'] = this.businessName;
    data['businessType'] = this.businessType;
    data['phoneNumber'] = this.phoneNumber;
    data['image'] = this.image;
    data['clicks'] = this.clicks;
    data['referredBy'] = this.referredBy;
    data['taxFile'] = this.taxFile;
    data['upi_id'] = this.upiId;
    data['openingTime'] = this.openingTime;
    data['closingTime'] = this.closingTime;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}
