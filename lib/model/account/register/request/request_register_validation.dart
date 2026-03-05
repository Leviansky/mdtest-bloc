// To parse this JSON data, do
//
//     final requestRegisterValidate = requestRegisterValidateFromJson(jsonString);

import 'dart:convert';

RequestRegisterValidate requestRegisterValidateFromJson(String str) =>
    RequestRegisterValidate.fromJson(json.decode(str));

String requestRegisterValidateToJson(RequestRegisterValidate data) =>
    json.encode(data.toJson());

class RequestRegisterValidate {
  RequestRegisterValidate({this.name, this.email, this.phone, this.password});

  String? name;
  String? email;
  String? phone;
  String? password;

  factory RequestRegisterValidate.fromJson(Map<String, dynamic> json) =>
      RequestRegisterValidate(
        name: json["name"],
        email: json["email"],
        phone: json["phone"],
        password: json["password"],
      );

  Map<String, dynamic> toJson() => {
    "name": name,
    "email": email,
    "phone": phone,
    "password": password,
  };
}
