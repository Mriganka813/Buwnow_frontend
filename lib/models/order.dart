import 'package:buynow/models/consumer_adrress.dart';

class Order {
  ConsumerAddress? addresses;
  String? sId;
  List<Items>? items;
  bool? isPaid;
  String? consumerId;
  String? consumerName;
  String? sellerNum;
  String? sellerUpi;
  String? createdAt;
  int? iV;

  Order(
      {this.addresses,
      this.sId,
      this.items,
      this.isPaid,
      this.consumerId,
      this.consumerName,
      this.sellerNum,
      this.sellerUpi,
      this.createdAt,
      this.iV});

  Order.fromJson(Map<String, dynamic> json) {
    addresses = json['addresses'] != null
        ? new ConsumerAddress.fromJson(json['addresses'])
        : null;
    sId = json['_id'];
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(new Items.fromJson(v));
      });
    }
    isPaid = json['isPaid'];
    consumerId = json['consumerId'];
    consumerName = json['consumerName'];
    sellerNum = json['sellerNum'];
    sellerUpi = json['sellerUpi'];
    createdAt = json['createdAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.addresses != null) {
      data['addresses'] = this.addresses!.toJson();
    }
    data['_id'] = this.sId;
    if (this.items != null) {
      data['items'] = this.items!.map((v) => v.toJson()).toList();
    }
    data['isPaid'] = this.isPaid;
    data['consumerId'] = this.consumerId;
    data['consumerName'] = this.consumerName;
    data['sellerNum'] = this.sellerNum;
    data['sellerUpi'] = this.sellerUpi;
    data['createdAt'] = this.createdAt;
    data['__v'] = this.iV;
    return data;
  }
}

class Items {
  String? productId;
  String? productName;
  int? productPrice;
  String? productImage;
  int? quantity;
  String? status;
  String? sellerId;
  String? sellerName;
  String? sId;

  Items(
      {this.productId,
      this.productName,
      this.productPrice,
      this.productImage,
      this.quantity,
      this.status,
      this.sellerId,
      this.sellerName,
      this.sId});

  Items.fromJson(Map<String, dynamic> json) {
    productId = json['productId'];
    productName = json['productName'];
    productPrice = json['productPrice'];
    productImage = json['productImage'] ?? '';
    quantity = json['quantity'];
    status = json['status'];
    sellerId = json['sellerId'];
    sellerName = json['sellerName'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['productId'] = this.productId;
    data['productName'] = this.productName;
    data['productPrice'] = this.productPrice;
    data['productImage'] = this.productImage;
    data['quantity'] = this.quantity;
    data['status'] = this.status;
    data['sellerId'] = this.sellerId;
    data['sellerName'] = this.sellerName;
    data['_id'] = this.sId;
    return data;
  }
}
