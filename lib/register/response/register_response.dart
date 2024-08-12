// To parse this JSON data, do
//
//     final registerResponse = registerResponseFromJson(jsonString);

import 'dart:convert';

RegisterResponse registerResponseFromJson(String str) =>
    RegisterResponse.fromJson(json.decode(str));

String registerResponseToJson(RegisterResponse data) =>
    json.encode(data.toJson());

class RegisterResponse {
  String? email;
  String? password;
  String? name;
  String? avatar;
  String? role;
  int? id;
  DateTime? creationAt;
  DateTime? updatedAt;

  RegisterResponse({
    this.email,
    this.password,
    this.name,
    this.avatar,
    this.role,
    this.id,
    this.creationAt,
    this.updatedAt,
  });

  RegisterResponse copyWith({
    String? email,
    String? password,
    String? name,
    String? avatar,
    String? role,
    int? id,
    DateTime? creationAt,
    DateTime? updatedAt,
  }) =>
      RegisterResponse(
        email: email ?? this.email,
        password: password ?? this.password,
        name: name ?? this.name,
        avatar: avatar ?? this.avatar,
        role: role ?? this.role,
        id: id ?? this.id,
        creationAt: creationAt ?? this.creationAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory RegisterResponse.fromJson(Map<String, dynamic> json) =>
      RegisterResponse(
        email: json["email"],
        password: json["password"],
        name: json["name"],
        avatar: json["avatar"],
        role: json["role"],
        id: json["id"],
        creationAt: json["creationAt"] == null
            ? null
            : DateTime.parse(json["creationAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "password": password,
        "name": name,
        "avatar": avatar,
        "role": role,
        "id": id,
        "creationAt": creationAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
      };
}
