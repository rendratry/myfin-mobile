import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:myfin_app/alertsucces.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;


class Kredit5 extends StatefulWidget {
  final String valuePenggunaanKredit;
  final String valueBesarPengajuan;
  final String valueTenor;
  final String valuePekerjaan;
  final String valueLamaBekerja;
  final String valueUsaha;
  final String valueBisnis;
  final String valueJumlahKaryawan;
  final String valuePendapatan;
  final String valuePendapatanTambahan;
  final String valuePendapatanPasangan;
  final String valueTanggungan;
  final String valueTempatTinggal;
  final String valueMelunasiCicilan;
  final String valueKondisiBisnis;
  final String valueHubunganKeluarga;
  final String valueHubunganSosial;
  final String valueMemilihAplikasi;
  final String valueSampingan;
  final String valueKaryawan;
  final String valuePasanganBekerja;
  final String valueAsset;
  final String valueCicilan;
  final String valuePernahHutang;
  final String valueKesulitanHutang;
  final String valueTerlambatMembayar;
  final String valueHutangBank;
  final String valueHutangPlatformLain;
  final String valueMelibatkanOrangLain;

  Kredit5({
    Key? key,
    required this.valuePenggunaanKredit,
    required this.valueBesarPengajuan,
    required this.valueTenor,
    required this.valuePekerjaan,
    required this.valueLamaBekerja,
    required this.valueUsaha,
    required this.valueBisnis,
    required this.valueJumlahKaryawan,
    required this.valuePendapatan,
    required this.valuePendapatanTambahan,
    required this.valuePendapatanPasangan,
    required this.valueTanggungan,
    required this.valueTempatTinggal,
    required this.valueMelunasiCicilan,
    required this.valueKondisiBisnis,
    required this.valueHubunganKeluarga,
    required this.valueHubunganSosial,
    required this.valueMemilihAplikasi,
    required this.valueSampingan,
    required this.valueKaryawan,
    required this.valuePasanganBekerja,
    required this.valueAsset,
    required this.valueCicilan,
    required this.valuePernahHutang,
    required this.valueKesulitanHutang,
    required this.valueTerlambatMembayar,
    required this.valueHutangBank,
    required this.valueHutangPlatformLain,
    required this.valueMelibatkanOrangLain,
  }) : super(key: key);

  @override
  State<Kredit5> createState() => _Kredit5State();
}


Future<bool?> pengajuanKredit(int id, String penggunaan,int besarPengajuan, String tenor, int score) async{
  SharedPreferences server = await SharedPreferences.getInstance();
  String? baseUrl = server.getString('server');

  final msg = jsonEncode({"id": id, "penggunaan":penggunaan, "besar_pengajuan":besarPengajuan, "tenor":tenor, "score":score});
  var response = await http.post(Uri.http(baseUrl!,'api/pengajuankredit'),
      headers: {
        'X-API-Key': "myfin",
        'Accept': "application/json",
      },
      body:
      msg
  );
  var data = response.body;
  print(data);
  print(response.statusCode);

  if(response.statusCode == 200){
    return true;
  } else
    return false;
}

class _Kredit5State extends State<Kredit5> {
  bool _value = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
            size: 20,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Pengajuan Kredit',
          style: TextStyle(
            color: Color.fromRGBO(53, 80, 112, 1),
            fontSize: 25,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Apakah Saya Bertanggng Jawab Penuh Atas Semua Informasi Dan Dokumen Yang Saya Berikan?",
                style: const TextStyle(
                    fontWeight: FontWeight.normal,
                    fontFamily: 'Oppen-sans',
                    color: Color(0xff355070),
                    fontSize: 18),
              ),
              SizedBox(
                height: 10,
              ),
              CheckboxListTile(
                controlAffinity: ListTileControlAffinity.leading,
                title: Text(
                  "Saya benar-benar bertanggung jawab atas isian data saat ini, dan saya akan menerima sanksi jika ada ketidak sesuaian data",
                  style: const TextStyle(
                      fontWeight: FontWeight.normal,
                      fontFamily: 'Oppen-sans',
                      fontSize: 18),
                ),
                value: _value,
                onChanged: (value) {
                  setState(() {
                    _value = value!;
                  });
                },
              ),
              const SizedBox(height: 40),
              Center(
                child: buildButton(),
              )
            ],
          ),
        ),
      ),
    );
  }

  buildButton() {
    return ConstrainedBox(
      constraints: BoxConstraints.tightFor(width: 128, height: 49),
      child: ElevatedButton(
        onPressed: _value == true
            ? () async{
                int a = int.parse(widget.valuePenggunaanKredit);
                int b = int.parse(widget.valueTenor);
                int c = int.parse(widget.valueSampingan);
                int d = int.parse(widget.valueKaryawan);
                int e = int.parse(widget.valueBisnis);
                int f = int.parse(widget.valuePendapatan);
                int g = int.parse(widget.valuePasanganBekerja);
                int h = int.parse(widget.valuePendapatanPasangan);
                int i = int.parse(widget.valueAsset);
                int j = int.parse(widget.valueCicilan);
                int k = int.parse(widget.valueTempatTinggal);
                int l = int.parse(widget.valueMelunasiCicilan);
                int m = int.parse(widget.valueKondisiBisnis);
                int n = int.parse(widget.valueHubunganKeluarga);
                int o = int.parse(widget.valueHubunganSosial);
                int p = int.parse(widget.valueMemilihAplikasi);
                int q = int.parse(widget.valuePernahHutang);
                int r = int.parse(widget.valueKesulitanHutang);
                int s = int.parse(widget.valueTerlambatMembayar);
                int t = int.parse(widget.valueHutangBank);
                int u = int.parse(widget.valueHutangPlatformLain);
                int v = int.parse(widget.valueMelibatkanOrangLain);
                var z = (a +
                    b +
                    c +
                    d +
                    e +
                    f +
                    g +
                    h +
                    i +
                    j +
                    k +
                    l +
                    m +
                    n +
                    o +
                    p +
                    q +
                    r +
                    s +
                    t +
                    u +
                    v);

                SharedPreferences idNasabah = await SharedPreferences.getInstance();
                int? id = idNasabah.getInt('idNasabah');
                SharedPreferences prefspenggunaan = await SharedPreferences.getInstance();
                String? penggunaan = prefspenggunaan.getString('penggunaan');
                SharedPreferences prefspenganjuan = await SharedPreferences.getInstance();
                String? besarPengajuan = prefspenganjuan.getString('pengajuan');
                SharedPreferences prefstenor = await SharedPreferences.getInstance();
                String? tenor= prefstenor.getString('tenor');
                int score = z;
                var pengajuanint = int.parse(besarPengajuan!);

                bool? pengajuan = await pengajuanKredit(id!, penggunaan!, pengajuanint!, tenor!, score);
                if(pengajuan == true){
                  showprogess(context);
                  //showDialog(context: context, builder: (context) => const AlertDialog(title: const Text("Berhasil Mengajukan"),));
                }else{
                  showDialog(context: context, builder: (context) => const AlertDialog(title: const Text("Pengajuan Gagal"),));
                }
                print(z);
                print("Besar Pengajuan = " + widget.valueBesarPengajuan);
                print("Pekerjaan = " + widget.valuePekerjaan);
                print("Lama Bekerja = " + widget.valueLamaBekerja);
                print("Nama Usaha yang Dijalankan = " + widget.valueUsaha);
                print("Jumlah Karyawan = " + widget.valueJumlahKaryawan);
                print("Jumlah Pendapatan Tambahan = " +
                    widget.valuePendapatanTambahan);
                print("Jumlah Tanggungan = " + widget.valueTanggungan);
              }
            : null,
        child: Text(
          "Lanjutkan",
          style: TextStyle(
              color: Colors.white,
              fontFamily: 'Poppins',
              fontSize: 15,
              fontWeight: FontWeight.w500),
        ),
        style: ButtonStyle(
          // backgroundColor:
          //     MaterialStateProperty.all(Color.fromRGBO(53, 80, 112, 1)),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ),
    );
  }
}
