// To parse this JSON data, do
//
//     final createPinModel = createPinModelFromJson(jsonString);

import 'dart:convert';

CreatePinModel createPinModelFromJson(String str) => CreatePinModel.fromJson(json.decode(str));

String createPinModelToJson(CreatePinModel data) => json.encode(data.toJson());

class CreatePinModel {
  CreatePinModel({
    required this.code,
    required this.status,
    required this.data,
  });

  int code;
  String status;
  Data data;

  factory CreatePinModel.fromJson(Map<String, dynamic> json) => CreatePinModel(
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
    required this.pin,
  });

  int id;
  String pin;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    pin: json["pin"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "pin": pin,
  };
}
