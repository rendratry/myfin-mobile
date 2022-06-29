import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:Myfin/homepage/saldo_model.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:Myfin/alertsucces.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../currency.dart';
import '../homepage/navbar.dart';
import 'package:Myfin/penarikansaldopage/penarikan_saldo_model.dart';

class PenarikanSaldo extends StatefulWidget {
  const PenarikanSaldo({Key? key}) : super(key: key);

  @override
  State<PenarikanSaldo> createState() => _PenarikanSaldoState();
}

class MapUtils {
  MapUtils._();

  static Future<void> openMap(double derajat, double desimal) async {
    String googleUrl =
        'https://www.google.com/maps/search/?api=1&query=$derajat,$desimal';
    if (await canLaunchUrlString(googleUrl)) {
      await launchUrlString(googleUrl);
    } else {
      throw 'Tidak Bisa Membuka Map';
    }
  }
}

class CurrencyPtBrInputFormatter extends TextInputFormatter {
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }

    int value = int.parse(newValue.text);
    final formatter = new NumberFormat.currency(
        locale: 'id', decimalDigits: 0, symbol: 'Rp ');
    String newText = formatter.format(value);

    return newValue.copyWith(
        text: newText,
        selection: new TextSelection.collapsed(offset: newText.length));
  }
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

Future<bool?> getsaldoData(int id) async {
  SharedPreferences server = await SharedPreferences.getInstance();
  String? baseUrl = server.getString('server');

  var stringId = id.toString();

  var response = await http.get(
    Uri.https(baseUrl!, 'api/getsaldo/'+stringId),
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
    var decodeId = SaldoModel.fromJson(jsonDecode(response.body));
    int saldoNasabah = decodeId.data.saldo;
    SharedPreferences prefsId =
    await SharedPreferences.getInstance();
    await prefsId.setInt('saldoNasabah2', saldoNasabah);
    return true;
  }else{
    return null;
  }
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

class _PenarikanSaldoState extends State<PenarikanSaldo> {
  late PenarikanSaldoModel _penarikansaldoNasabah;

  String? _valBank;
  List listBank = ['BRI', 'BNI', 'BCA', 'Mandiri'];
  TextEditingController nominalController = TextEditingController();
  TextEditingController bankController = TextEditingController();
  TextEditingController norekController = TextEditingController();
  TextEditingController namapemilikController = TextEditingController();

  final keyRefresh = GlobalKey<RefreshIndicatorState>();
  int? saldo;

  @override
  void initState() {
    super.initState();

    loadList();
  }

  Future loadList() async {
    keyRefresh.currentState?.show();
    await Future.delayed(Duration(milliseconds: 500));

    SharedPreferences idNasabah = await SharedPreferences.getInstance();
    int? id = idNasabah.getInt('idNasabah');

    bool? saldo = await getsaldoData(id!);

    if (saldo==true){

      SharedPreferences saldoNasabah = await SharedPreferences.getInstance();
      int? saldo = saldoNasabah.getInt('saldoNasabah');
      print(saldo);


      setState(() => this.saldo = saldo);
    }
  }


  @override
  Widget build(BuildContext context) {
    if (saldo==null){
      saldo =0;
    }else{
      saldo=saldo;
    }
    var nomSaldo = CurrencyFormat.convertToIdr(saldo, 0);
    var saldoDisplay = nomSaldo.toString();
    return Scaffold(
        body: DefaultTabController(
            length: 2,
            child: Scaffold(
              //Judul Halaman
              appBar: AppBar(
                backgroundColor: Colors.white,
                elevation: 0,
                leading: IconButton(
                  icon: SvgPicture.asset(
                    'assets/svg/arrow_left.svg',
                    color: Color(0xff355070),
                    height: 30,
                    width: 30,
                  ),
                  onPressed: ()  {
                    Navigator.pop(context);
                  },
                ),
                title: Text(
                  "Penarikan Saldo",
                  style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: Color(0xff355070)),
                ),
                centerTitle: true,
                bottom: TabBar(
                  labelColor: Color(0xffE56B6F),
                  unselectedLabelColor: Color(0xff355070),
                  indicatorColor: Color(0xffE56B6F),
                  tabs: [
                    Tab(
                        child: Text("Ambil Offline",
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                            ))),
                    Tab(
                        child: Text("Transfer Bank",
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                            )))
                  ],
                ),
              ),
              body: TabBarView(children: [
                //Tab Bar Ambil Offline
                Container(
                  color: Colors.white,
                  child: Column(children: [
                    Container(
                      padding: EdgeInsets.only(top: 70),
                      child: Text(
                        "Untuk mengambil uang bisa langsung datangi\ncustomer service Myfin dan sebutkan nama kamu",
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 12,
                            fontWeight: FontWeight.w600),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    InkWell(
                      onTap: () {
                        MapUtils.openMap(-7.556480, 111.659966);
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 22),
                        padding: EdgeInsets.only(left: 15),
                        height: 95,
                        child: Row(
                          children: [
                            SvgPicture.asset('assets/svg/google_maps.svg'),
                            SizedBox(
                              width: 23,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Myfin Office",
                                  style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600),
                                ),
                                Text(
                                  "Desa Pandean Kec. Mejayan Kab. Madiun",
                                  style: TextStyle(
                                      fontFamily: 'Poppins', fontSize: 12),
                                )
                              ],
                            )
                          ],
                        ),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.1),
                                spreadRadius: 1,
                                blurRadius: 10,
                              )
                            ],
                            borderRadius: BorderRadius.circular(10)),
                      ),
                    )
                  ]),
                ),

                //Tab Bar Transfer Bank
                Container(
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
                                        inputFormatters: [
                                          FilteringTextInputFormatter.digitsOnly,
                                          CurrencyPtBrInputFormatter()
                                        ],
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
                                            saldoDisplay,
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
                                      String resultjumlahPenarikan = jumlahPenarikan.replaceAll(RegExp('[^0-9]'), '');
                                      var jumlahPenarikanint = int.parse(resultjumlahPenarikan);
                                      String? bank = _valBank;
                                      String namaPemilik = namapemilikController.text;
                                      String norek = norekController.text;
                                      var jumlahPenarikanbool;
                                      if(jumlahPenarikanint!=null){
                                        jumlahPenarikanbool = true;
                                      }else{
                                        jumlahPenarikanbool = false;
                                      }
                                      var bankbool;
                                      if(bank!=null){
                                        bankbool = true;
                                      }else{
                                        bankbool = false;
                                      }
                                      var namaPemilikbool;
                                      if(namaPemilik!=null){
                                        namaPemilikbool = true;
                                      }else{
                                        namaPemilikbool = false;
                                      }
                                      var norekbool;
                                      if(norek!=null){
                                        norekbool = true;
                                      }else{
                                        norekbool = false;
                                      }

                                      SharedPreferences idNasabah = await SharedPreferences.getInstance();
                                      int? id = idNasabah.getInt('idNasabah');

                                      // if(jumlahPenarikanint > saldo!){
                                      //   showDialog(context: context, builder: (context) => const AlertDialog(title: const Text("Saldo Tidak Cukup"),));
                                      // }
                                      // if(jumlahPenarikanint < 10000){
                                      //   showDialog(context: context, builder: (context) => const AlertDialog(title: const Text("Minimal Penarikan\nRp 10.000"),));
                                      // }
                                      if(jumlahPenarikanbool&&bankbool&&namaPemilikbool&&norekbool == true){
                                        if(jumlahPenarikanint > saldo!){
                                          showDialog(context: context, builder: (context) => const AlertDialog(title: const Text("Saldo Tidak Cukup"),));
                                        }
                                        else if(jumlahPenarikanint < 10000){
                                          showDialog(context: context, builder: (context) => const AlertDialog(title: const Text("Minimal Penarikan\nRp 10.000"),));
                                        } else{
                                          var datapenarikan = await penarikanSaldo(id!, jumlahPenarikanint, bank!, norek, namaPemilik);
                                          print(jumlahPenarikanint);

                                          if(datapenarikan == true){
                                            var datapengurangan = await penguranganSaldo(id!, jumlahPenarikanint);
                                            if(datapengurangan==true){
                                              successPenarikanSaldo(context);
                                            }
                                            // showDialog(context: context, builder: (context) => const AlertDialog(title: const Text("Penarikan Dalam Proses"),));
                                            // await Navigator.push(context, new MaterialPageRoute(
                                            //     builder: (context)=> Navbar()));
                                          }
                                        }

                                      }else{
                                        showDialog(context: context, builder: (context) => const AlertDialog(title: const Text("Pastikan Semua Terisi Benar"),));
                                      }
                                      ;
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
                )
              ]),
            )));
  }
}
