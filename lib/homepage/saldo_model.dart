// To parse this JSON data, do
//
//     final saldoModel = saldoModelFromJson(jsonString);

import 'dart:convert';

SaldoModel saldoModelFromJson(String str) => SaldoModel.fromJson(json.decode(str));

String saldoModelToJson(SaldoModel data) => json.encode(data.toJson());

class SaldoModel {
  SaldoModel({
    required this.code,
    required this.status,
    required this.data,
  });

  int code;
  String status;
  Data data;

  factory SaldoModel.fromJson(Map<String, dynamic> json) => SaldoModel(
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
    required this.saldo,
  });

  int id;
  int saldo;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    saldo: json["saldo"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "saldo": saldo,
  };
}
