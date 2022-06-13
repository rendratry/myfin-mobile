// To parse this JSON data, do
//
//     final penarikanSaldoModel = penarikanSaldoModelFromJson(jsonString);

import 'dart:convert';

PenarikanSaldoModel penarikanSaldoModelFromJson(String str) => PenarikanSaldoModel.fromJson(json.decode(str));

String penarikanSaldoModelToJson(PenarikanSaldoModel data) => json.encode(data.toJson());

class PenarikanSaldoModel {
  PenarikanSaldoModel({
    required this.code,
    required this.status,
    required this.data,
  });

  int code;
  String status;
  Data data;

  factory PenarikanSaldoModel.fromJson(Map<String, dynamic> json) => PenarikanSaldoModel(
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
    required this.jmlPenarikan,
    required this.bank,
    required this.norek,
    required this.namaPemilik,
    required this.status,
  });

  int id;
  int jmlPenarikan;
  String bank;
  String norek;
  String namaPemilik;
  String status;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    jmlPenarikan: json["jml_penarikan"],
    bank: json["bank"],
    norek: json["norek"],
    namaPemilik: json["nama_pemilik"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "jml_penarikan": jmlPenarikan,
    "bank": bank,
    "norek": norek,
    "nama_pemilik": namaPemilik,
    "status": status,
  };
}
