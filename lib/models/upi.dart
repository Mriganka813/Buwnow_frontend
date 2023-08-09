class UPIModel {
  bool? success;
  String? businessName;
  String? upi;

  UPIModel({this.success, this.businessName, this.upi});

  UPIModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    businessName = json['businessName'];
    upi = json['upi'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['businessName'] = this.businessName;
    data['upi'] = this.upi;
    return data;
  }
}
