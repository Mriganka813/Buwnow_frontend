import 'order.dart';

class OrderHistory {
  Order? recentOrders;
  int? sellerNumber;
  String? sellerUpi;

  OrderHistory({this.recentOrders, this.sellerNumber, this.sellerUpi});

  OrderHistory.fromJson(Map<String, dynamic> json) {
    recentOrders = json['recentOrders'] != null
        ? new Order.fromJson(json['recentOrders'])
        : null;
    sellerNumber = json['sellerNumber'];
    sellerUpi = json['sellerUpi'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.recentOrders != null) {
      data['recentOrders'] = this.recentOrders!.toJson();
    }
    data['sellerNumber'] = this.sellerNumber;
    data['sellerUpi'] = this.sellerUpi;
    return data;
  }
}
