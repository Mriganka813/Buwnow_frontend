import 'dart:convert';

class SellerAddress {
  String? locality;
  String? city;
  String? state;
  String? country;

  SellerAddress({this.locality, this.city, this.state, this.country});

  SellerAddress.fromJson(Map<String, dynamic> json) {
    locality = json['locality'];
    city = json['city'];
    state = json['state'];
    country = json['country'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['locality'] = this.locality;
    data['city'] = this.city;
    data['state'] = this.state;
    data['country'] = this.country;
    return data;
  }
}
