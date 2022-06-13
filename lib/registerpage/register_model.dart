// To parse this JSON data, do
//
//     final registerModel = registerModelFromJson(jsonString);

import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

// RegisterModel registerModelFromJson(String str) => RegisterModel.fromJson(json.decode(str));
//
// String registerModelToJson(RegisterModel data) => json.encode(data.toJson());

class RegisterModel {
  RegisterModel({
    required this.code,
    required this.status,
    required this.data,
  });

  int code;
  String status;
  Data data;

  factory RegisterModel.fromJson(Map<String, dynamic> json) => RegisterModel(
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
  });

  int id;
  String email;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    email: json["email"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "email": email,
  };
}
