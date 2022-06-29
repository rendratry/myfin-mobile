import 'dart:convert';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:Myfin/alertsucces.dart';
import 'package:Myfin/penarikansaldopage/penarikan_saldo_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../homepage/navbar.dart';

class TransferBank extends StatefulWidget {
  const TransferBank({ Key? key }) : super(key: key);

  @override
  State<TransferBank> createState() => _TransferBankState();
}



Future<bool?> penguranganSaldo(int id, int saldo) async {
  SharedPreferences server = await SharedPreferences.getInstance();
  String? baseUrl = server.getString('server');
  final msg = jsonEncode({"saldo":saldo});
  var response = await http.put(Uri.https(baseUrl!,'api/minsaldo/'+id.toString()),
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

Future<bool?> penarikanSaldo(int id, int jumlahPenarikan,String bank, String norek, String namaPemilik) async{
  SharedPreferences server = await SharedPreferences.getInstance();
  String? baseUrl = server.getString('server');

  final msg = jsonEncode({"id": id, "jml_penarikan":jumlahPenarikan, "bank":bank, "norek":norek, "nama_pemilik":namaPemilik});
  var response = await http.post(Uri.https(baseUrl!,'api/penarikansaldo'),
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



class _TransferBankState extends State<TransferBank> {
  late PenarikanSaldoModel _penarikansaldoNasabah;

  String? _valBank;
  List listBank = ['BRI', 'BNI', 'BCA', 'Mandiri'];
  TextEditingController nominalController = TextEditingController();
  TextEditingController bankController = TextEditingController();
  TextEditingController norekController = TextEditingController();
  TextEditingController namapemilikController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
                  color: Colors.white,
                  child: Center(
                    child: ListView(
                      children: [
                        Container(
                          child: Image.asset(
                            'assets/png/atm.png',
                            height: 222,
                            width: 222,
                          ),
                        ),
                        SizedBox(height: 26),
                        Container(
                            child: Column(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 30),
                              child: Column(
                                children: [
                                  TextFormField(
                                    controller: nominalController,
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        hintText: "Masukkan Nominal"),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "Tersedia : ",
                                        style: TextStyle(
                                            fontFamily: 'OpenSans',
                                            fontSize: 10,
                                            color: Color(0xffA8A8A8)),
                                      ),
                                      Text(
                                        "Rp " + "300.000",
                                        style: TextStyle(
                                            fontFamily: 'Roboto',
                                            fontSize: 13,
                                            fontWeight: FontWeight.w700),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 25,
                                  ),
                                  DropdownButtonHideUnderline(
                                    child: DropdownButton2(
                                      isExpanded: true,
                                      hint: Row(
                                        children: const [
                                          Expanded(
                                            child: Text(
                                              'Pilih Bank',
                                            ),
                                          ),
                                        ],
                                      ),
                                      icon: SvgPicture.asset(
                                          'assets/svg/arrow_down.svg'),
                                      buttonPadding:
                                          const EdgeInsets.symmetric(horizontal: 10),
                                      items: listBank
                                          .map((item) =>
                                              DropdownMenuItem<String>(
                                                value: item,
                                                child: Text(item),
                                              ))
                                          .toList(),
                                      value: _valBank,
                                      onChanged: (value) {
                                        setState(() {
                                          _valBank = value as String;
                                        });
                                      },
                                      buttonDecoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                            color: Color(0xffA8A8A8)),
                                      ),
                                      dropdownDecoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                            color: Color(0xffA8A8A8)),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 24,
                                  ),
                                  TextFormField(
                                    controller: norekController,
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        hintText: "Nomor Rekening"),
                                  ),
                                  SizedBox(
                                    height: 24,
                                  ),
                                  TextFormField(
                                    controller: namapemilikController,
                                    decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        hintText: "Nama Pemilik"),
                                  ),
                                  SizedBox(
                                    height: 34,
                                  )
                                ],
                              ),
                            ),
                            ConstrainedBox(
                              constraints: BoxConstraints.tightFor(
                                  width: 128, height: 50),
                              child: ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      Color(0xff355070)),
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                ),
                                child: Text(
                                  "Ajukan",
                                  style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500),
                                ),
                                onPressed: () async{
                                  String nominalSaldo = nominalController.text;
                                  String jumlahPenarikan = nominalController.text;
                                  String? bank = _valBank;
                                  String namaPemilik = namapemilikController.text;
                                  String norek = norekController.text;

                                  SharedPreferences idNasabah = await SharedPreferences.getInstance();
                                  int? id = idNasabah.getInt('idNasabah');

                                  var datapenarikan = await penarikanSaldo(id!, int.parse(jumlahPenarikan), bank!, norek, namaPemilik);

                                  if(datapenarikan == true){
                                    var datapengurangan = await penguranganSaldo(id!, int.parse(nominalSaldo));
                                    showprogess(context);
                                    // showDialog(context: context, builder: (context) => const AlertDialog(title: const Text("Penarikan Dalam Proses"),));
                                    // await Navigator.push(context, new MaterialPageRoute(
                                    //     builder: (context)=> Navbar()));
                                  }

                                  setState(() {
                                    _penarikansaldoNasabah = datapenarikan as PenarikanSaldoModel;
                                  });
                                },
                              ),
                            ),
                            SizedBox(
                              height: 34,
                            ),
                          ],
                        ))
                      ],
                    ),
                  ),
                );
  }
}
