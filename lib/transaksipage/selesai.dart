import 'dart:convert';

import 'package:Myfin/transaksipage/transaksi_model.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../currency.dart';
import '../detailtransaksipage/detail_transaksi_page.dart';
import '../refresh_widget.dart';

class Selesai extends StatefulWidget {
  const Selesai({Key? key}) : super(key: key);

  @override
  State<Selesai> createState() => _SelesaiState();
}

class _SelesaiState extends State<Selesai> {
  final keyRefresh = GlobalKey<RefreshIndicatorState>();

  int? idTransaksi;
  String? Nominal;
  String? Tanggal;
  String? Status;
  int? transaksi;
  String? catatan;
  Color? statuscolorTrue;
  int? statuscolorFalse;


  Future<bool?> gettransaksiDitolak(int id) async {
    SharedPreferences server = await SharedPreferences.getInstance();
    String? baseUrl = server.getString('server');

    var stringId = id.toString();

    var response = await http.get(
      Uri.https(baseUrl!, 'api/transaksi/$stringId/ditolak'),
      headers: {
        'X-API-Key': "myfin",
        'Accept': "application/json",
      },
    );
    var data = response.body;
    print(data);
    print(response.statusCode)
    ;

    if (response.statusCode == 200) {
      var decodeId = TransaksiModel.fromJson(jsonDecode(response.body));
      int idTransaksi = decodeId.data.idTransaksi;
      String Nominal = decodeId.data.nominalDiterima;
      String Tanggal = decodeId.data.tanggal;
      String Status = decodeId.data.status;
      String Catatan = decodeId.data.catatan;

      setState(() => this.catatan = Catatan);
      setState(() => this.idTransaksi = idTransaksi);
      setState(() => this.Nominal = Nominal);
      setState(() => this.Tanggal = Tanggal);
      setState(() => this.Status = Status);
      return true;
    }else{
      return null;
    }
  }


  Future<bool?> gettransaksiCatatan(int id) async {
    SharedPreferences server = await SharedPreferences.getInstance();
    String? baseUrl = server.getString('server');

    var stringId = id.toString();

    var response = await http.get(
      Uri.https(baseUrl!, 'api/transaksi/$stringId/catatan'),
      headers: {
        'X-API-Key': "myfin",
        'Accept': "application/json",
      },
    );
    var data = response.body;
    print(data);
    print(response.statusCode)
    ;

    if (response.statusCode == 200) {
      var decodeId = TransaksiModel.fromJson(jsonDecode(response.body));
      int idTransaksi = decodeId.data.idTransaksi;
      String Nominal = decodeId.data.nominalDiterima;
      String Tanggal = decodeId.data.tanggal;
      String Status = decodeId.data.status;
      String Catatan = decodeId.data.catatan;

      setState(() => this.catatan = Catatan);
      setState(() => this.idTransaksi = idTransaksi);
      setState(() => this.Nominal = Nominal);
      setState(() => this.Tanggal = Tanggal);
      setState(() => this.Status = Status);
      return true;
    }else{
      return null;
    }
  }

  Future<bool?> gettransaksiDiterima(int id) async {
    SharedPreferences server = await SharedPreferences.getInstance();
    String? baseUrl = server.getString('server');

    var stringId = id.toString();

    var response = await http.get(
      Uri.https(baseUrl!, 'api/transaksi/$stringId/diterima'),
      headers: {
        'X-API-Key': "myfin",
        'Accept': "application/json",
      },
    );
    var data = response.body;
    print(data);
    print(response.statusCode)
    ;

    if (response.statusCode == 200) {
      var decodeId = TransaksiModel.fromJson(jsonDecode(response.body));
      int idTransaksi = decodeId.data.idTransaksi;
      String Nominal = decodeId.data.nominalDiterima;
      String Tanggal = decodeId.data.tanggal;
      String Status = decodeId.data.status;
      String Catatan = decodeId.data.catatan;

      setState(() => this.catatan = Catatan);
      setState(() => this.idTransaksi = idTransaksi);
      setState(() => this.Nominal = Nominal);
      setState(() => this.Tanggal = Tanggal);
      setState(() => this.Status = Status);
      return true;
    }else{
      return null;
    }
  }



  @override
  void initState() {
    super.initState();

    loadList();
  }

  Future loadList() async {
    keyRefresh.currentState?.show();
    await Future.delayed(const Duration(milliseconds: 500));
    SharedPreferences idNasabah = await SharedPreferences.getInstance();
    int? id = idNasabah.getInt('idNasabah');

    bool? transaksi = await gettransaksiDiterima(id!);

    var transaksistatus;
    if(transaksi==true){
      transaksistatus = 1;
      setState(() => this.statuscolorTrue = Color(0xff01D47C));
      setState(() => this.transaksi = transaksistatus);
    }else{
      bool? transaksiCatatan = await gettransaksiCatatan(id);
      if (transaksiCatatan==true){
        transaksistatus = 1;
        setState(() => this.statuscolorTrue = Color(0xff01D47C));
        setState(() => this.transaksi = transaksistatus);
      }else{
        bool? transaksiDitolak = await gettransaksiDitolak(id);
        if(transaksiDitolak==true){
          setState(() => this.statuscolorTrue = Color(0xffff0033));
          transaksistatus = 1;
          setState(() => this.transaksi = transaksistatus);
        }else{
          transaksistatus = 0;
          setState(() => this.transaksi = transaksistatus);
        }
      }

    }

  }

  @override
  Widget build(BuildContext context) {
    var displayIdTransaksi = idTransaksi.toString();
    if (Nominal==null){
      Nominal ="0";
    }else{
      Nominal=Nominal;
    }
    var dispalyStatusColor = statuscolorTrue;
    var nomSaldo = CurrencyFormat.convertToIdr(int.parse(Nominal!), 0);
    var displayNominal = nomSaldo.toString();
    var displayTanggal = Tanggal.toString();
    var displayStatus = Status.toString();
    var displayTransaksiStatus = transaksi;

    return displayTransaksiStatus == 0?  Center(
      child: Lottie.network('https://assets4.lottiefiles.com/packages/lf20_mk6o3c37.json',
          width: 200,
          height: 200
      ),):
    idTransaksi == null?  Center(
      child: Lottie.network('https://assets2.lottiefiles.com/datafiles/AX0rqrGV5ahKpWr/data.json',
          width: 400,
          height: 400
      ),):RefreshWidget(
      keyRefresh: keyRefresh,
      onRefresh: loadList,
      child: InkWell(
        onTap: (() async {
          SharedPreferences prefsId =
          await SharedPreferences.getInstance();
          await prefsId.setString('idTransaksi', displayIdTransaksi);
          await SharedPreferences.getInstance();
          await prefsId.setString('Nominal', displayNominal);
          await SharedPreferences.getInstance();
          await prefsId.setString('statusTransaksi', displayStatus);
          await SharedPreferences.getInstance();
          await prefsId.setString('TanggalTransaksi', displayTanggal);
          await SharedPreferences.getInstance();
          await prefsId.setString('Catatan', catatan.toString());
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const DetailTransaksi()),
          );
        }),
        child: ListView.builder(
          itemCount: displayTransaksiStatus,
          itemBuilder: (_, index) {
            return Container(
              height: 95,
              margin: const EdgeInsets.only(left: 19, right: 19,bottom: 25),
              padding: const EdgeInsets.all(17),
              decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 1,
                      blurRadius: 10,
                    )
                  ],
                  borderRadius: BorderRadius.circular(10)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Pengajuan Kredit",
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 12,
                              fontWeight: FontWeight.w600),
                        ),
                        Text(
                          "ID : "+displayIdTransaksi,
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 9,
                              color: Color(0xff757575)),
                        ),
                        Spacer(),
                        Text(
                          displayTanggal,
                          style:
                          TextStyle(fontFamily: 'Poppins', fontSize: 9),
                        )
                      ]),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        displayNominal,
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 12,
                            fontWeight: FontWeight.w600),
                      ),
                      Text(
                        displayStatus,
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: dispalyStatusColor),
                      )
                    ],
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
