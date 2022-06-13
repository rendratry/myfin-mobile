// To parse this JSON data, do
//
//     final dataNasabahModel = dataNasabahModelFromJson(jsonString);

import 'dart:convert';

DataNasabahModel dataNasabahModelFromJson(String str) => DataNasabahModel.fromJson(json.decode(str));

String dataNasabahModelToJson(DataNasabahModel data) => json.encode(data.toJson());

class DataNasabahModel {
  DataNasabahModel({
    required this.code,
    required this.status,
    required this.data,
  });

  int code;
  String status;
  Data data;

  factory DataNasabahModel.fromJson(Map<String, dynamic> json) => DataNasabahModel(
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
    required this.pertanyaan,
    required this.jawaban,
    required this.nik,
    required this.nama,
    required this.alamat,
    required this.noHp,
    required this.lahir,
    required this.kota,
    required this.ktp,
    required this.swa,
  });

  int id;
  String email;
  String pertanyaan;
  String jawaban;
  String nik;
  String nama;
  String alamat;
  String noHp;
  String lahir;
  String kota;
  String ktp;
  String swa;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    email: json["email"],
    pertanyaan: json["pertanyaan"],
    jawaban: json["jawaban"],
    nik: json["nik"],
    nama: json["nama"],
    alamat: json["alamat"],
    noHp: json["no_hp"],
    lahir: json["lahir"],
    kota: json["kota"],
    ktp: json["ktp"],
    swa: json["swa"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "email": email,
    "pertanyaan": pertanyaan,
    "jawaban": jawaban,
    "nik": nik,
    "nama": nama,
    "alamat": alamat,
    "no_hp": noHp,
    "lahir": lahir,
    "kota": kota,
    "ktp": ktp,
    "swa": swa,
  };
}
