class Product {
  String? sId;
  String? name;
  String? image;
  int? purchasePrice;
  int? sellingPrice;
  int? returnPeriod;
  int? quantity;
  List? rating;
  int? clicks;
  String? user;
  int? discount;
  String? sellerName;
  String? expiryDate;
  String? createdAt;
  String? updatedAt;
  bool? available;

  int? iV;

  Product(
      {this.sId,
      this.name,
      this.image,
      this.purchasePrice,
      this.sellingPrice,
      this.returnPeriod,
      this.quantity,
      this.rating,
      this.clicks,
      this.user,
      this.discount,
      this.sellerName,
      this.expiryDate,
      this.createdAt,
      this.updatedAt,
      this.available = true,
      this.iV});

  Product.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    image = json['image'];
    purchasePrice = json['purchasePrice'];
    sellingPrice = json['sellingPrice'].toInt();
    returnPeriod = json['returnPeriod'];
    quantity = json['quantity'];
    rating = json['rating'];
    clicks = json['clicks'];
    user = json['user'];
    discount = json['discount'];
    sellerName = json['sellerName'];
    expiryDate = json['expiryDate'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    available = json['available'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['image'] = this.image;
    data['purchasePrice'] = this.purchasePrice;
    data['sellingPrice'] = this.sellingPrice;
    data['returnPeriod'] = this.returnPeriod;
    data['quantity'] = this.quantity;
    data['rating'] = this.rating;
    data['clicks'] = this.clicks;
    data['user'] = this.user;
    data['discount'] = this.discount;
    data['sellerName'] = this.sellerName;
    data['expiryDate'] = this.expiryDate;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['available'] = this.available;
    data['__v'] = this.iV;
    return data;
  }
}
