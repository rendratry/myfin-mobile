import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:Myfin/alertsucces.dart';
import 'package:Myfin/currency.dart';
import 'package:Myfin/homepage/profile_model.dart';
import 'package:Myfin/homepage/saldo_model.dart';
import 'package:Myfin/penarikansaldopage/penarikan_saldo_page.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../pengajuankreditpage/kredit_1.dart';
import '../refresh_widget.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard>{

  String greetingMessage(){

    var timeNow = DateTime.now().hour;

    if (timeNow <= 12) {
      return 'Selamat Pagi';
    } else if ((timeNow > 12) && (timeNow <= 16)) {
      return 'Selamat Siang';
    } else if ((timeNow > 16) && (timeNow < 20)) {
      return 'Selamat Sore';
    } else {
      return 'Selamat Malam';
    }
  }

  final keyRefresh = GlobalKey<RefreshIndicatorState>();
  int? saldo;
  String? ava;
  String? nik;
  String? nama;

  @override
  void initState() {
    super.initState();

    loadList();
  }



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
      return true;
    }else{
      return null;
    }
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
      await prefsId.setInt('saldoNasabah', saldoNasabah);
      return true;
    }else{
      return null;
    }
  }

  Future<bool?> getProfile(int id) async {
    SharedPreferences server = await SharedPreferences.getInstance();
    String? baseUrl = server.getString('server');

    var stringId = id.toString();

    var response = await http.get(
      Uri.https(baseUrl!, 'api/profile/'+stringId),
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
      var decodeId = ProfileModel.fromJson(jsonDecode(response.body));
      String profilNik = decodeId.data.nik;
      String ava = decodeId.data.ava;
      String nama = decodeId.data.nama;

      SharedPreferences prefsId =
      await SharedPreferences.getInstance();
      await prefsId.setString('ava', ava);
      await SharedPreferences.getInstance();
      await prefsId.setString('namadepan', nama);
      await SharedPreferences.getInstance();
      await prefsId.setString('profileNik', profilNik);

      return true;
    }else{
      return false;
    }
  }

  Future loadList() async {
    keyRefresh.currentState?.show();
    await Future.delayed(Duration(milliseconds: 500));


    SharedPreferences idNasabah = await SharedPreferences.getInstance();
    int? id = idNasabah.getInt('idNasabah');

    bool? saldo = await getsaldoData(id!);
    bool? profile = await getProfile(id);

    if (profile==true){

      SharedPreferences saldoNasabah = await SharedPreferences.getInstance();
      String? nik = saldoNasabah.getString('profileNik');
      SharedPreferences ava = await SharedPreferences.getInstance();
      String? avaNasabah = ava.getString('ava');
      SharedPreferences nama = await SharedPreferences.getInstance();
      String? namaNasabah = ava.getString('namadepan');
      print(saldo);

      // final currencyFormatter = NumberFormat.currency(locale: 'ID');
      // var saldoCurrency = currencyFormatter.format(saldo.toString());

      setState(() => this.nik = nik);
      setState(() => this.nama = namaNasabah);
      setState(() => this.ava = avaNasabah);
    }


    if (saldo==true){

      SharedPreferences saldoNasabah = await SharedPreferences.getInstance();
      int? saldo = saldoNasabah.getInt('saldoNasabah');
      print(saldo);

      // final currencyFormatter = NumberFormat.currency(locale: 'ID');
      // var saldoCurrency = currencyFormatter.format(saldo.toString());

      setState(() => this.saldo = saldo);
    }
  }

  @override
  Widget build(BuildContext context) {
    var avaToDisplay;
    if(ava=="0"){
      avaToDisplay = 'https://firebasestorage.googleapis.com/v0/b/myfin-ktp.appspot.com/o/KTP%2Fscaled_image_picker7138079792496807795.jpg?alt=media&token=8de953e4-3a8f-4cb5-bb9a-8dcbdb56ecd0';
    }else{
      avaToDisplay = ava.toString();
    }
    if (saldo==null){
      saldo =0;
    }else if (saldo! < 0){
      saldo=0;
    }else{
    saldo=saldo;
    }
    var nomSaldo = CurrencyFormat.convertToIdr(saldo, 0);
    var textToDisplay = nomSaldo.toString();

    var namaToDisplay;
    if(nama=="0"){
      namaToDisplay = " ";
    }else{
      var namaDepan = nama?.split(" ");
      print(namaDepan);
      namaToDisplay = namaDepan?.first;
    }
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(top: 28, left: 27, right: 27),
        color: Colors.white,
        child:
        saldo == null?  Center(
          child: Lottie.network('https://assets4.lottiefiles.com/packages/lf20_b88nh30c.json',
              width: 150,
              height: 150
          ),):
        ava == null?  Center(
          child: Lottie.network('https://assets4.lottiefiles.com/packages/lf20_b88nh30c.json',
              width: 150,
              height: 150
          ),)
            : RefreshWidget(
          keyRefresh: keyRefresh,
          onRefresh: loadList,
          child: ListView(children: [
            //nama dan foto profil user
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Text(
                        "Halo, $namaToDisplay\n" + greetingMessage(),
                        style: const TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: 15,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  CircleAvatar(
                    radius: 17,
                    backgroundImage: NetworkImage(avaToDisplay),
                  ),
                ]),
            const SizedBox(
              height: 47,
            ),

            //Saldo user
            Container(
              height: 95,
              padding: const EdgeInsets.all(23),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: const Color(0x26000000))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text(
                      "Saldo Kamu",
                      style: TextStyle(fontFamily: 'Roboto', fontSize: 13),
                    ),
                    SizedBox(
                      height: 3,
                    ),
                    Text(
                      textToDisplay,
                      style: TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: 21,
                          fontWeight: FontWeight.w700),
                    )
                  ]),
                  IconButton(
                      icon: SvgPicture.asset('assets/svg/download.svg'),
                      onPressed: () {
                        if(saldo==0){
                          noHaveSaldo(context);
                        }else{
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const PenarikanSaldo()),
                          );
                        }
                      }),
                  // SvgPicture.asset('assets/svg/download.svg'),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),

            //Banner aplikasi
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 150,
                  width: 350,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/png/banner.png'),
                        fit: BoxFit.cover),
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 15,
            ),

            //Tombol pengajuan kredit
            Container(
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Ajukan Peminjaman Untuk\nMemperoleh Kredit",
                      style: TextStyle(fontFamily: 'Roboto', fontSize: 14),
                    ),
                    ConstrainedBox(
                      constraints:
                      const BoxConstraints.tightFor(width: 140, height: 35),
                      child: ElevatedButton(
                        onPressed: () async {
                          SharedPreferences idNasabah = await SharedPreferences.getInstance();
                          int? id = idNasabah.getInt('idNasabah');
                          bool? cekStatusAjuan = await gettransaksiPending(id!);
                          if (nik == "0"){
                            mustIsiData(context);
                          }else{
                            if(cekStatusAjuan==true){
                              havePendingAjuan(context);
                            }else{
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const Kredit1()),
                              );
                            }
                          }
                        },
                        child: const Text(
                          "Ajukan Sekarang",
                          style: TextStyle(
                              fontFamily: 'Roboto',
                              fontSize: 13,
                              fontWeight: FontWeight.w700),
                        ),
                        style: ButtonStyle(
                          backgroundColor:
                          MaterialStateProperty.all(const Color(0xff355070)),
                          shape:
                          MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ]),
            ),
            const SizedBox(
              height: 65,
            ),

            //Fitur pembelian
            Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Pembelian",
                    style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 15,
                        fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Container(
                            height: 45,
                            width: 50,
                            decoration: BoxDecoration(
                                image: const DecorationImage(
                                    image: AssetImage('assets/png/pulsa.png')),
                                borderRadius: BorderRadius.circular(10)),
                          ),
                          const SizedBox(height: 10,),
                          const Text("Pulsa",style: TextStyle(fontFamily: 'Roboto', fontSize: 14)),
                        ],
                      ),
                      Column(
                        children: [
                          Container(
                            height: 45,
                            width: 50,
                            decoration: BoxDecoration(
                                image: const DecorationImage(
                                    image: AssetImage('assets/png/paket data.png')),
                                borderRadius: BorderRadius.circular(10)),
                          ),
                          const SizedBox(height: 10,),
                          const Text("Data",style: TextStyle(fontFamily: 'Roboto', fontSize: 14)),
                        ],
                      ),
                      Column(
                        children: [
                          Container(
                            height: 45,
                            width: 50,
                            decoration: BoxDecoration(
                                image: const DecorationImage(
                                    image: AssetImage('assets/png/games.png')),
                                borderRadius: BorderRadius.circular(10)),
                          ),
                          const SizedBox(height: 10,),
                          const Text("Games",style: TextStyle(fontFamily: 'Roboto', fontSize: 14))
                        ],
                      ),
                      Column(
                        children: [
                          Container(
                            height: 45,
                            width: 50,
                            decoration: BoxDecoration(
                                image: const DecorationImage(
                                    image: AssetImage('assets/png/tiket nonton.png')),
                                borderRadius: BorderRadius.circular(10)),
                          ),
                          const SizedBox(height: 10,),
                          const Text("Tiket Movie",style: TextStyle(fontFamily: 'Roboto', fontSize: 14))
                        ],
                      ),
                    ],
                  ),
                ]),
            const SizedBox(
              height: 40,
            ),

            //Fitur Pembayaran
            Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Pembayaran",
                    style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 15,
                        fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Container(
                            height: 45,
                            width: 50,
                            decoration: BoxDecoration(
                                image: const DecorationImage(
                                    image: AssetImage('assets/png/bayar internet.png')),
                                borderRadius: BorderRadius.circular(10)),
                          ),
                          const SizedBox(height: 10,),
                          const Text("Internet",style: TextStyle(fontFamily: 'Roboto', fontSize: 14))
                        ],
                      ),
                      Column(
                        children: [
                          Container(
                            height: 45,
                            width: 50,
                            decoration: BoxDecoration(
                                image: const DecorationImage(
                                    image: AssetImage('assets/png/bayar PDAM.png')),
                                borderRadius: BorderRadius.circular(10)),
                          ),
                          const SizedBox(height: 10,),
                          const Text("Air",style: TextStyle(fontFamily: 'Roboto', fontSize: 14))
                        ],
                      ),
                      Column(
                        children: [
                          Container(
                            height: 45,
                            width: 50,
                            decoration: BoxDecoration(
                                image: const DecorationImage(
                                    image: AssetImage('assets/png/bayar pln.png')),
                                borderRadius: BorderRadius.circular(10)),
                          ),
                          const SizedBox(height: 10,),
                          const Text("Listrik",style: TextStyle(fontFamily: 'Roboto', fontSize: 14))
                        ],
                      ),
                      Column(
                        children: [
                          Container(
                            height: 45,
                            width: 50,
                            decoration: BoxDecoration(
                                image: const DecorationImage(
                                    image: AssetImage('assets/png/pembayan education.png')),
                                borderRadius: BorderRadius.circular(10)),
                          ),
                          const Text("Sekolah",style: TextStyle(fontFamily: 'Roboto', fontSize: 14))
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 20,)
                ]
            )
          ]
          ),
        ),
      ),
    );
  }
// Widget buildList() => data.isEmpty
//     ? Center(child: CircularProgressIndicator())
//     : RefreshWidget(
//         keyRefresh: keyRefresh,
//         onRefresh: loadList,
//         child: ListView.builder(
//           shrinkWrap: true,
//           primary: false,
//           padding: EdgeInsets.all(16),
//           itemCount: data.length,
//           itemBuilder: (context, index) {
//             final number = data[index];

//             return buildItem(number);
//           },
//         ),
//       );
}
