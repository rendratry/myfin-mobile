import 'dart:convert';
import 'dart:ffi';

import 'package:Myfin/transaksipage/transaksi_model.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../currency.dart';
import '../refresh_widget.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

class DalamProses extends StatefulWidget {
  const DalamProses({Key? key}) : super(key: key);

  @override
  State<DalamProses> createState() => _DalamProsesState();
}



class _DalamProsesState extends State<DalamProses> {

  int? idTransaksi;
  String? Nominal;
  String? Tanggal;
  String? Status;
  int? transaksi;


  Future<bool?> gettransaksiPending(int id) async {
    SharedPreferences server = await SharedPreferences.getInstance();
    String? baseUrl = server.getString('server');

    var stringId = id.toString();

    var response = await http.get(
      Uri.https(baseUrl!, 'api/transaksi/$stringId/pending'),
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
      String Nominal = decodeId.data.nominal;
      String Tanggal = decodeId.data.tanggal;
      String Status = decodeId.data.status;


      setState(() => this.idTransaksi = idTransaksi);
      setState(() => this.Nominal = Nominal);
      setState(() => this.Tanggal = Tanggal);
      setState(() => this.Status = Status);
      return true;
    }else{
      return null;
    }
  }



  final List _post = [
    'Pengajuan Kredit',
  ];
  final List  _id = [
    '12345135',
  ];

  final String _date = DateFormat("yMMMd").format(DateTime.now());

  final keyRefresh = GlobalKey<RefreshIndicatorState>();
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
    bool? transaksi = await gettransaksiPending(id!);

    var transaksistatus;
    if(transaksi==true){
      transaksistatus = 1;
      setState(() => this.transaksi = transaksistatus);
    }else{
      transaksistatus = 0;
      setState(() => this.transaksi = transaksistatus);
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
    var nomSaldo = CurrencyFormat.convertToIdr(int.parse(Nominal!), 0);
    var displayNominal = nomSaldo.toString();
    var displayTanggal = Tanggal.toString();
    var displayStatus = Status.toString();
    var displayTransaksiStatus = transaksi;
    return  displayTransaksiStatus == 0?  Center(
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
      child: ListView.builder(
        itemCount: displayTransaksiStatus,
        itemBuilder: (_, index) {
          return Container(
            height: 95,
            margin: const EdgeInsets.only(left: 19, right: 19, bottom: 25),
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
                    children:  [
                      Text(
                        "Pengajuan Kredit",
                        style: const TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 12,
                            fontWeight: FontWeight.w600),
                      ),
                      Text(
                        "ID : " + displayIdTransaksi,
                        style: const TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 9,
                            color: Color(0xff757575)),
                      ),
                      const Spacer(),
                      Text(
                        displayTanggal,
                        style: const TextStyle(fontFamily: 'Poppins', fontSize: 9),
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
                          color: Color(0xffEAAD53)),
                    )
                  ],
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
