class RequestForgotPassword {
  RequestForgotPassword({this.username, this.email, this.phone});

  String? username;
  String? email;
  String? phone;

  factory RequestForgotPassword.fromJson(Map<String, dynamic> json) =>
      RequestForgotPassword(
        username: json["username"],
        email: json["email"],
        phone: json["phone"],
      );

  Map<String, dynamic> toJson() => username != null
      ? {"username": username}
      : email != null
      ? {"email": email}
      : phone != null
      ? {"phone": phone}
      : {};
}
