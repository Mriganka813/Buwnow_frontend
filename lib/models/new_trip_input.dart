class NewTripInput {
  NewTripInput({
    this.price,
    this.vehicleId,
    this.serviceAreaId,
    this.pickuplocation,
    this.droplocatioon,
    this.upi,
    this.businessName,
    this.orderId,
    this.amount,
    this.isPaid = true,
    this.sellerNum,
  });

  double? price;
  String? serviceAreaId;
  String? vehicleId;
  var pickuplocation;
  var droplocatioon;
  String? upi;
  String? businessName;
  String? orderId;
  int? amount;
  bool isPaid;
  String? sellerNum;

  Map<String, dynamic> toMap() => {
        "pickup": {
          "lat": decodelocation(pickuplocation, 0).toString(),
          "long": decodelocation(pickuplocation, 1).toString()
        },
        "drop": {
          "lat": decodelocation(droplocatioon, 0).toString(),
          "long": decodelocation(droplocatioon, 1).toString()
        },
        "serviceAreaId": serviceAreaId,
        "vehicleId": vehicleId,
        "price": price,
        "upi": upi,
        "businessName": businessName,
        "orderId": orderId,
        "amount": amount,
        "isPaid": isPaid,
        "sellerNum": sellerNum
      };

  // index 0 = lat, index 1 = long
  decodelocation(location, int index) {
    Map<String, dynamic> loc = location;
    return loc.values.elementAt(index);
  }
}
