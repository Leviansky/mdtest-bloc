// To parse this JSON data, do
//
//     final requestAuth = requestAuthFromJson(jsonString);

import 'dart:convert';

RequestAuth requestAuthFromJson(String str) =>
    RequestAuth.fromJson(json.decode(str));

String requestAuthToJson(RequestAuth data) => json.encode(data.toJson());

class RequestAuth {
  RequestAuth({this.username, this.email, this.password});

  String? username;
  String? email;
  String? password;

  factory RequestAuth.fromJson(Map<String, dynamic> json) => RequestAuth(
    username: json["username"],
    email: json["email"],
    password: json["password"],
  );

  Map<String, dynamic> toJson() => {"username": username, "password": password};

  Map<String, dynamic> toEmailJson() => {"email": email, "password": password};
}
