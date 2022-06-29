// To parse this JSON data, do
//
//     final emailCheckModel = emailCheckModelFromJson(jsonString);

import 'dart:convert';

EmailCheckModel emailCheckModelFromJson(String str) => EmailCheckModel.fromJson(json.decode(str));

String emailCheckModelToJson(EmailCheckModel data) => json.encode(data.toJson());

class EmailCheckModel {
  EmailCheckModel({
    required this.code,
    required this.status,
    required this.data,
  });

  int code;
  String status;
  Data data;

  factory EmailCheckModel.fromJson(Map<String, dynamic> json) => EmailCheckModel(
    code: json["code"],
    status: json["status"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "status": status,
    "data": data.toJson(),
  };
}

class Data {
  Data({
    required this.id,
    required this.email,
    required this.status,
  });

  int id;
  String email;
  String status;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    email: json["email"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "email": email,
    "status": status,
  };
}
