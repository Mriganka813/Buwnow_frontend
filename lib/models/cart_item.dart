class CartItem {
  String? productId;
  String? sellerName;
  String? sellerId;
  int? originalPrice;
  int? discountedPrice;
  int? qty;
  String? name;
  String? image;

  CartItem({
    this.productId,
    this.sellerName,
    this.sellerId,
    this.originalPrice,
    this.qty,
    this.name,
    this.image,
  });

  CartItem.fromJson(Map<String, dynamic> json) {
    productId = json['productId'];
    sellerName = json['sellerName'];
    sellerId = json['sellerId'];
    originalPrice = json['originalPrice'];
    discountedPrice = json['discountedPrice'];
    qty = json['qty'];
    name = json['name'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['productId'] = this.productId;
    data['sellerName'] = this.sellerName;
    data['sellerId'] = this.sellerId;
    data['originalPrice'] = this.originalPrice;
    data['discountedPrice'] = this.discountedPrice;
    data['qty'] = this.qty;
    data['name'] = this.name;
    data['image'] = this.image;
    return data;
  }
}
