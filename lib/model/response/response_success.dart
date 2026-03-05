import 'dart:convert';

ResponseSuccess responseSuccessFromJson(String str) =>
    ResponseSuccess.fromJson(json.decode(str));

String responseSuccessToJson(ResponseSuccess data) =>
    json.encode(data.toJson());

class ResponseSuccess {
  ResponseSuccess({
    this.message,
    this.statusCode,
    this.status,
    this.elapsedTime,
    this.uid,
  });

  String? message;
  int? statusCode;
  bool? status;
  double? elapsedTime;
  String? uid;

  factory ResponseSuccess.fromJson(Map<String, dynamic> json) {
    String? uid;

    if (json["data"] != null && json["data"] is Map) {
      uid = json["data"]["uid"];
    } else if (json["result"] != null && json["result"] is Map) {
      uid = json["result"]["uid"];
    }

    return ResponseSuccess(
      message: json["message"],
      statusCode: json["status_code"],
      status: json["status"],
      elapsedTime: (json["elapsed_time"] as num?)?.toDouble(),
      uid: uid,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "message": message,
      "status_code": statusCode,
      "status": status,
      "elapsed_time": elapsedTime,
    };
  }
}
