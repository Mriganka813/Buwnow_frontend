import 'dart:convert';

class User {
  String? id;
  String? name;
  String? email;
  String? phoneNo;
  String? password;
  String? address;
  String? role;
  String? token;

  User({
    this.id,
    this.name,
    this.email,
    this.phoneNo,
    this.password,
    this.address,
    this.role,
    this.token,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phoneNumber': phoneNo,
      'password': password,
      'address': address,
      'role': role,
      'token': token,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['_id'] ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      phoneNo: map['phoneNumber'] ?? '',
      password: map['password'] ?? '',
      address: map['address'] ?? '',
      role: map['role'] ?? '',
      token: map['token'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));

  User copyWith({
    String? id,
    String? name,
    String? email,
    String? phoneNo,
    String? password,
    String? address,
    String? role,
    String? token,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      phoneNo: phoneNo ?? this.phoneNo,
      password: password ?? this.password,
      address: address ?? this.address,
      role: role ?? this.role,
      token: token ?? this.token,
    );
  }
}
