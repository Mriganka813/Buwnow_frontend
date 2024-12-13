class Vehicle {
  double? price;
  String? name;
  String? id;
  int? pricePerKm;
  String? serviceAreaId;

  Vehicle(
      {this.price, this.name, this.id, this.pricePerKm, this.serviceAreaId});

  Vehicle.fromJson(Map<String, dynamic> json) {
    price = double.parse(json['price'].toString());
    name = json['name'];
    id = json['id'];
    pricePerKm = json['pricePerKm'];
    serviceAreaId = json['ServiceAreaId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['price'] = this.price;
    data['name'] = this.name;
    data['id'] = this.id;
    data['pricePerKm'] = this.pricePerKm;
    data['ServiceAreaId'] = this.serviceAreaId;
    return data;
  }
}
