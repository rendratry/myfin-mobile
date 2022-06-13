// To parse this JSON data, do
//
//     final profileModel = profileModelFromJson(jsonString);

import 'dart:convert';

ProfileModel profileModelFromJson(String str) => ProfileModel.fromJson(json.decode(str));

String profileModelToJson(ProfileModel data) => json.encode(data.toJson());

class ProfileModel {
  ProfileModel({
    required this.code,
    required this.status,
    required this.data,
  });

  int code;
  String status;
  Data data;

  factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
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
    required this.nama,
    required this.email,
    required this.ava,
    required this.noHp,
    required this.nik,
    required this.alamat,
  });

  String nama;
  String email;
  String ava;
  String noHp;
  String nik;
  String alamat;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    nama: json["nama"],
    email: json["email"],
    ava: json["ava"],
    noHp: json["no_hp"],
    nik: json["nik"],
    alamat: json["alamat"],
  );

  Map<String, dynamic> toJson() => {
    "nama": nama,
    "email": email,
    "ava": ava,
    "no_hp": noHp,
    "nik": nik,
    "alamat": alamat,
  };
}
