// To parse this JSON data, do
//
//     final registerRequest = registerRequestFromJson(jsonString);

import 'dart:convert';

RegisterRequest registerRequestFromJson(String str) =>
    RegisterRequest.fromJson(json.decode(str));

String registerRequestToJson(RegisterRequest data) =>
    json.encode(data.toJson());

class RegisterRequest {
  String? name;
  String? email;
  String? password;
  String? avatar;

  RegisterRequest({
    this.name,
    this.email,
    this.password,
    this.avatar = 'https://api.lorem.space/image/face?w=640&h=480',
  });

  RegisterRequest copyWith({
    String? name,
    String? email,
    String? password,
    String? avatar,
  }) =>
      RegisterRequest(
        name: name ?? this.name,
        email: email ?? this.email,
        password: password ?? this.password,
        avatar: avatar ?? this.avatar,
      );

  factory RegisterRequest.fromJson(Map<String, dynamic> json) =>
      RegisterRequest(
        name: json["name"],
        email: json["email"],
        password: json["password"],
        avatar: json["avatar"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "email": email,
        "password": password,
        "avatar": avatar,
      };
}
