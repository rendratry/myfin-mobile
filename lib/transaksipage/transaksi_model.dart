// To parse this JSON data, do
//
//     final transaksiModel = transaksiModelFromJson(jsonString);

import 'dart:convert';

TransaksiModel transaksiModelFromJson(String str) => TransaksiModel.fromJson(json.decode(str));

String transaksiModelToJson(TransaksiModel data) => json.encode(data.toJson());

class TransaksiModel {
    TransaksiModel({
        required this.code,
        required this.status,
        required this.data,
    });

    int code;
    String status;
    Data data;

    factory TransaksiModel.fromJson(Map<String, dynamic> json) => TransaksiModel(
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
        required this.idTransaksi,
        required this.tanggal,
        required this.nominal,
        required this.nominalDiterima,
        required this.status,
        required this.catatan,
    });

    int idTransaksi;
    String tanggal;
    String nominal;
    String nominalDiterima;
    String status;
    String catatan;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        idTransaksi: json["id_transaksi"],
        tanggal: json["tanggal"],
        nominal: json["nominal"],
        nominalDiterima: json["nominal_diterima"],
        status: json["status"],
        catatan: json["catatan"],
    );

    Map<String, dynamic> toJson() => {
        "id_transaksi": idTransaksi,
        "tanggal": tanggal,
        "nominal": nominal,
        "nominal_diterima": nominalDiterima,
        "status": status,
        "catatan": catatan,
    };
}
