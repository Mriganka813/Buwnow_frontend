class TripModel {
  Pickup? pickup;
  Pickup? drop;
  String? sId;
  String? businessName;
  int? amount;
  bool? isPaid;
  String? orderId;
  String? upi;
  List<String>? silent;
  String? customerId;
  String? status;
  double? price;
  String? serviceAreaId;
  String? vehicleId;
  String? createdAt;
  List<SubTrips>? subTrips;
  String? customerSocket;
  String? driverSocketID;
  int? driverNumber;
  String? otp;
  String? driverId;
  int? iV;

  TripModel(
      {this.pickup,
      this.drop,
      this.sId,
      this.businessName,
      this.amount,
      this.isPaid,
      this.orderId,
      this.upi,
      this.silent,
      this.customerId,
      this.status,
      this.price,
      this.serviceAreaId,
      this.vehicleId,
      this.createdAt,
      this.subTrips,
      this.customerSocket,
      this.driverSocketID,
      this.driverNumber,
      this.otp,
      this.driverId,
      this.iV});

  TripModel.fromJson(Map<String, dynamic> json) {
    pickup =
        json['pickup'] != null ? new Pickup.fromJson(json['pickup']) : null;
    drop = json['drop'] != null ? new Pickup.fromJson(json['drop']) : null;
    sId = json['_id'];
    businessName = json['businessName'];
    amount = json['amount'];
    isPaid = json['isPaid'];
    orderId = json['orderId'];
    upi = json['upi'];
    silent = json['silent'].cast<String>();
    customerId = json['customerId'];
    status = json['status'];
    price = double.parse(json['price'].toString());
    serviceAreaId = json['serviceAreaId'];
    vehicleId = json['vehicleId'];
    createdAt = json['createdAt'];
    if (json['subTrips'] != null) {
      subTrips = <SubTrips>[];
      json['subTrips'].forEach((v) {
        subTrips!.add(new SubTrips.fromJson(v));
      });
    }
    driverSocketID = json["driverSocket"];
    customerSocket = json['customerSocket'];
    driverNumber = json['driverNumber'];
    otp = json['otp'];
    driverId = json['driverId'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.pickup != null) {
      data['pickup'] = this.pickup!.toJson();
    }
    if (this.drop != null) {
      data['drop'] = this.drop!.toJson();
    }
    data['_id'] = this.sId;
    data['businessName'] = this.businessName;
    data['amount'] = this.amount;
    data['isPaid'] = this.isPaid;
    data['orderId'] = this.orderId;
    data['upi'] = this.upi;
    data['silent'] = this.silent;
    data['customerId'] = this.customerId;
    data['status'] = this.status;
    data['price'] = this.price;
    data['serviceAreaId'] = this.serviceAreaId;
    data['vehicleId'] = this.vehicleId;
    data['createdAt'] = this.createdAt;
    if (this.subTrips != null) {
      data['subTrips'] = this.subTrips!.map((v) => v.toJson()).toList();
    }
    data['customerSocket'] = this.customerSocket;
    data['driverSocket'] = this.driverSocketID;
    data['driverNumber'] = this.driverNumber;
    data['otp'] = this.otp;
    data['driverId'] = this.driverId;
    data['__v'] = this.iV;
    return data;
  }
}

class Pickup {
  String? lat;
  String? long;

  Pickup({this.lat, this.long});

  Pickup.fromJson(Map<String, dynamic> json) {
    lat = json['lat'];
    long = json['long'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lat'] = this.lat;
    data['long'] = this.long;
    return data;
  }
}

class SubTrips {
  Pickup? start;
  Pickup? end;
  String? status;
  String? sId;

  SubTrips({this.start, this.end, this.status, this.sId});

  SubTrips.fromJson(Map<String, dynamic> json) {
    start = json['start'] != null ? new Pickup.fromJson(json['start']) : null;
    end = json['end'] != null ? new Pickup.fromJson(json['end']) : null;
    status = json['status'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.start != null) {
      data['start'] = this.start!.toJson();
    }
    if (this.end != null) {
      data['end'] = this.end!.toJson();
    }
    data['status'] = this.status;
    data['_id'] = this.sId;
    return data;
  }
}
