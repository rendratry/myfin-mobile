// To parse this JSON data, do
//
//     final nikModel = nikModelFromJson(jsonString);

import 'dart:convert';

NikModel nikModelFromJson(String str) => NikModel.fromJson(json.decode(str));

String nikModelToJson(NikModel data) => json.encode(data.toJson());

class NikModel {
  NikModel({
    required this.code,
    required this.status,
    required this.data,
  });

  int code;
  String status;
  Data data;

  factory NikModel.fromJson(Map<String, dynamic> json) => NikModel(
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
    required this.nik,
    required this.nama,
    required this.alamat,
    required this.tglLahir,
    required this.kota,
  });

  int nik;
  String nama;
  String alamat;
  String tglLahir;
  String kota;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    nik: json["nik"],
    nama: json["nama"],
    alamat: json["alamat"],
    tglLahir: json["tgl_lahir"],
    kota: json["kota"],
  );

  Map<String, dynamic> toJson() => {
    "nik": nik,
    "nama": nama,
    "alamat": alamat,
    "tgl_lahir": tglLahir,
    "kota": kota,
  };
}
