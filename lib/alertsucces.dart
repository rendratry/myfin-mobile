import 'dart:convert';
import 'package:Myfin/ubahpinpage/pertanyaan1.dart';
import 'package:Myfin/registerpage/emailcheck_model.dart';
import 'package:Myfin/ubahpinpage/pin_lama.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'datadiripage/data_diri.dart';
import 'homepage/navbar.dart';
import 'loginpage/login_screen.dart';

Future showprogess(context) async {
   return  showDialog(
                    context: context,
                    builder: (context) =>AlertDialog(
                            title: Stack(
                            clipBehavior: Clip.none, alignment: Alignment.center,
                            children: <Widget>[
                              Column(
                                children: [
                                  Container(
                                    width: 196,
                                    height: 220,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    padding: const EdgeInsets.fromLTRB(20, 160, 20, 10),
                                    child:  const Text("Berhasil",
                                    style: TextStyle(
                                      fontSize: 25,
                                      fontFamily: 'Poppins',
                                      color: Color.fromRGBO(53, 80, 112, 1)),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  Row(children: [
                                    Expanded(
                                      child: ElevatedButton(
                                        onPressed: () {
                                          if (kDebugMode) {
                                            print('yes selected');
                                          }
                                          Navigator.pushReplacement(context, Navbar.route());
                                        },
                                        child: const Text("OK"),
                                        style: ElevatedButton.styleFrom(
                                            primary: Colors.blue.shade800),
                                      ),
                                    ),]
                                    ),
                                ],
                              ),
                              Positioned(
                                top: -10,
                                child: Lottie.network('https://assets9.lottiefiles.com/packages/lf20_tnlxlkom.json',
                                width: 180,
                                height: 170
                                ),
                              ),
                            ],
                          ),
                        )
                   
   );
}

Future mustIsiData(context) async {
  return  showDialog(
      context: context,
      builder: (context) =>AlertDialog(
        title: Stack(
          clipBehavior: Clip.none, alignment: Alignment.center,
          children: <Widget>[
            Column(
              children: [
                Container(
                  width: 220,
                  height: 215,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.fromLTRB(20, 140, 20, 10),
                  child:  const Text("Lengkapi Data Terlebih Dahulu",
                    style: TextStyle(
                        fontSize: 18,
                        fontFamily: 'Poppins',
                        color: Color.fromRGBO(53, 80, 112, 1)),
                    textAlign: TextAlign.center,
                  ),
                ),
                Row(children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        if (kDebugMode) {
                          print('yes selected');
                        }
                        Navigator.pushReplacement(context, Navbar.route());
                      },
                      child: const Text("OK"),
                      style: ElevatedButton.styleFrom(
                          primary: Colors.blue.shade800),
                    ),
                  ),]
                ),
              ],
            ),
            Positioned(
              top: -40,
              child: Lottie.network('https://assets4.lottiefiles.com/packages/lf20_qszkkg7n.json',
                  width: 210,
                  height: 207
              ),
            ),
          ],
        ),
      )

  );
}

Future successIsiData(context) async {
  return  showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) =>AlertDialog(
        title: Stack(
          clipBehavior: Clip.none, alignment: Alignment.center,
          children: <Widget>[
            Column(
              children: [
                Container(
                  width: 220,
                  height: 215,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.fromLTRB(20, 150, 20, 10),
                  child:  const Text("Berhasil Verifikasi Data",
                    style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'Poppins',
                        color: Color.fromRGBO(53, 80, 112, 1)),
                    textAlign: TextAlign.center,
                  ),
                ),
                Row(children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        if (kDebugMode) {
                          print('yes selected');
                        }
                        Navigator.pushReplacement(context, Navbar.route());
                      },
                      child: const Text("OK"),
                      style: ElevatedButton.styleFrom(
                          primary: Colors.blue.shade800),
                    ),
                  ),]
                ),
              ],
            ),
            Positioned(
              top: -40,
              child: Lottie.network('https://assets7.lottiefiles.com/packages/lf20_9s417nlp.json',
                  width: 250,
                  height: 247
              ),
            ),
          ],
        ),
      )

  );
}

Future Logout(context) async {
  return  showDialog(
      context: context,
      builder: (context) =>AlertDialog(
        title: Stack(
          clipBehavior: Clip.none, alignment: Alignment.center,
          children: <Widget>[
            Column(
              children: [
                Container(
                  width: 220,
                  height: 215,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.fromLTRB(20, 175, 20, 10),
                  child:  const Text("Yakin akan keluar?",
                    style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'Poppins',
                        color: Color.fromRGBO(53, 80, 112, 1)),
                    textAlign: TextAlign.center,
                  ),
                ),
                Row(children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () async {
                        if (kDebugMode) {
                          print('yes selected');
                        }
                        // SharedPreferences preferences = await SharedPreferences.getInstance();
                        // await preferences.clear();
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => LoginDemo()),
                        );
                      },
                      child: const Text("OK"),
                      style: ElevatedButton.styleFrom(
                          primary: Colors.red),
                    ),
                  ),]
                ),
              ],
            ),
            Positioned(
              top: -10,
              child: Lottie.network('https://assets8.lottiefiles.com/packages/lf20_vvx2gjpt.json',
                  width: 190,
                  height: 187
              ),
            ),
          ],
        ),
      )

  );
}

Future ktpIsiData(context) async {
  return  showDialog(
      context: context,
      builder: (context) =>AlertDialog(
        title: Stack(
          clipBehavior: Clip.none, alignment: Alignment.center,
          children: <Widget>[
            Column(
              children: [
                Container(
                  width: 300,
                  height: 290,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.fromLTRB(20, 250, 20, 10),
                  child:  const Text("Siapkan KTP Kamu",
                    style: TextStyle(
                        fontSize: 18,
                        fontFamily: 'Poppins',
                        color: Color.fromRGBO(53, 80, 112, 1)),
                    textAlign: TextAlign.center,
                  ),
                ),
                Row(children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        if (kDebugMode) {
                          print('yes selected');
                        }
                        Navigator.pop(context);
                        swaIsiData(context);
                      },
                      child: const Text("Lanjutkan"),
                      style: ElevatedButton.styleFrom(
                          primary: Colors.blue.shade800),
                    ),
                  ),]
                ),
              ],
            ),
            Positioned(
              top: -5,
              child: Lottie.network('https://assets3.lottiefiles.com/packages/lf20_4tiy5nnf.json',
                  width: 230,
                  height: 227
              ),
            ),
          ],
        ),
      )

  );
}

Future swaIsiData(context) async {
  return  showDialog(
      context: context,
      builder: (context) =>AlertDialog(
        title: Stack(
          clipBehavior: Clip.none, alignment: Alignment.center,
          children: <Widget>[
            Column(
              children: [
                Container(
                  width: 300,
                  height: 290,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.fromLTRB(20, 250, 20, 10),
                  child:  const Text("Bersiap Untuk Swa Dengan KTP",
                    style: TextStyle(
                        fontSize: 18,
                        fontFamily: 'Poppins',
                        color: Color.fromRGBO(53, 80, 112, 1)),
                    textAlign: TextAlign.center,
                  ),
                ),
                Row(children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        if (kDebugMode) {
                          print('yes selected');
                        }
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const Datadiri()),
                        );
                        // Navigator.pushReplacement(context, Navbar.route());
                      },
                      child: const Text("Mulai Isi Data"),
                      style: ElevatedButton.styleFrom(
                          primary: Colors.blue.shade800),
                    ),
                  ),]
                ),
              ],
            ),
            Positioned(
              top: -5,
              child: Lottie.network('https://assets3.lottiefiles.com/packages/lf20_4gebyeyd.json',
                  width: 250,
                  height: 247
              ),
            ),
          ],
        ),
      )

  );
}

Future registerLoading(context) async {
  return  showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) =>AlertDialog(
        title: Stack(
          clipBehavior: Clip.none, alignment: Alignment.center,
          children: <Widget>[
            Column(
              children: [
                Container(
                  width: 300,
                  height: 300,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.fromLTRB(20, 200, 20, 10),
                  child:  const Text("Sedang Menyiapkan Akunmu",
                    style: TextStyle(
                        fontSize: 18,
                        fontFamily: 'Poppins',
                        color: Color.fromRGBO(53, 80, 210, 1)),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
            Positioned(
              top: -40,
              child: Lottie.network('https://assets9.lottiefiles.com/packages/lf20_x62chJ.json',
                  width: 300,
                  height: 300
              ),
            ),
          ],
        ),
      )

  );
}

Future pinSucceess(context) async {
  return  showDialog(
      context: context,
      barrierDismissible: false,
  builder: (context) =>AlertDialog(
        title: Stack(
          clipBehavior: Clip.none, alignment: Alignment.center,
          children: <Widget>[
            Column(
              children: [
                Container(
                  width: 280,
                  height: 300,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.fromLTRB(20, 200, 20, 10),
                  child:  const Text("Buat Pin Berhasil",
                    style: TextStyle(
                        fontSize: 18,
                        fontFamily: 'Poppins',
                        color: Color.fromRGBO(53, 80, 210, 1)),
                    textAlign: TextAlign.center,
                  ),
                ),

                Row(children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        if (kDebugMode) {
                          print('yes selected');
                        }
                        Navigator.pushReplacement(context, Navbar.route());
                      },
                      child: const Text("OK"),
                      style: ElevatedButton.styleFrom(
                          primary: Colors.blue.shade800),
                    ),
                  ),]
                ),
              ],
            ),
            Positioned(
              top: -40,
              child: Lottie.network('https://assets3.lottiefiles.com/packages/lf20_rdkzbvu0.json',
                  width: 300,
                  height: 300
              ),
            ),
          ],
        ),
      )

  );
}

Future emailTerdaftar(context) async {
  return  showDialog(
      context: context,
      builder: (context) =>AlertDialog(
        title: Stack(
          clipBehavior: Clip.none, alignment: Alignment.center,
          children: <Widget>[
            Column(
              children: [
                Container(
                  width: 260,
                  height: 270,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.fromLTRB(20, 180, 20, 10),
                  child:  const Text("Email Kamu Sudah Terdaftar, Gunakan Email Lain",
                    style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'Poppins',
                        color: Color.fromRGBO(53, 80, 210, 1)),
                    textAlign: TextAlign.center,
                  ),
                ),

                Row(children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        if (kDebugMode) {
                          print('yes selected');
                        }
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => LoginDemo()));
                      },
                      child: const Text("Login?"),
                      style: ElevatedButton.styleFrom(
                          primary: Colors.blue.shade800),
                    ),
                  ),]
                ),
              ],
            ),
            Positioned(
              top: 0,
              child: Lottie.network('https://assets2.lottiefiles.com/packages/lf20_pqpmxbxp.json',
                  width: 200,
                  height: 180
              ),
            ),
          ],
        ),
      )

  );
}

Future havePendingAjuan(context) async {
  return  showDialog(
      context: context,
      builder: (context) =>AlertDialog(
        title: Stack(
          clipBehavior: Clip.none, alignment: Alignment.center,
          children: <Widget>[
            Column(
              children: [
                Container(
                  width: 260,
                  height: 270,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.fromLTRB(20, 180, 20, 10),
                  child:  const Text("Status Ajuan Kamu Masih Pending",
                    style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'Poppins',
                        color: Color.fromRGBO(53, 80, 210, 1)),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
            Positioned(
              top: 0,
              child: Lottie.network('https://assets8.lottiefiles.com/packages/lf20_dnp2c83r.json',
                  width: 200,
                  height: 180
              ),
            ),
          ],
        ),
      )

  );
}

Future noHaveSaldo(context) async {
  return  showDialog(
      context: context,
      builder: (context) =>AlertDialog(
        title: Stack(
          clipBehavior: Clip.none, alignment: Alignment.center,
          children: <Widget>[
            Column(
              children: [
                Container(
                  width: 260,
                  height: 270,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.fromLTRB(20, 180, 20, 10),
                  child:  const Text("Oops.. Kamu Belum Punya Saldo",
                    style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'Poppins',
                        color: Color.fromRGBO(53, 80, 210, 1)),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
            Positioned(
              top: -50,
              child: Lottie.network('https://assets3.lottiefiles.com/private_files/lf30_oqpbtola.json',
                  width: 250,
                  height: 250
              ),
            ),
          ],
        ),
      )

  );
}

Future setupServer(context) async {
  TextEditingController servercontroller = TextEditingController();
  return  showDialog(
      context: context,
      builder: (context) =>AlertDialog(
        title: Stack(
          clipBehavior: Clip.none, alignment: Alignment.center,
          children: <Widget>[
            Column(
              children: [
                Container(
                  width: 260,
                  height: 270,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.fromLTRB(20, 180, 20, 10),
                  child:  TextFormField(
                    controller: servercontroller,
                    showCursor: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                      hintText: 'Server',
                    ),
                  ),
                ),

                Row(children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () async {
                        if (kDebugMode) {
                          print('yes selected');
                        }
                        String serverhttp = servercontroller.text;
                        SharedPreferences server = await SharedPreferences.getInstance();
                        await server.setString('server', serverhttp);
                        Navigator.pop(context);
                      },
                      child: const Text("OK"),
                      style: ElevatedButton.styleFrom(
                          primary: Colors.blue.shade800),
                    ),
                  ),]
                ),
              ],
            ),
            Positioned(
              top: 0,
              child: Lottie.network('https://assets9.lottiefiles.com/packages/lf20_giodppcr.json',
                  width: 200,
                  height: 180
              ),
            ),
          ],
        ),
      )

  );
}

Future alreadyVerified(context) async {
  return  showDialog(
      context: context,
      builder: (context) =>AlertDialog(
        title: Stack(
          clipBehavior: Clip.none, alignment: Alignment.center,
          children: <Widget>[
            Column(
              children: [
                Container(
                  width: 240,
                  height: 240,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.fromLTRB(20, 170, 20, 10),
                  child:  const Text("Akun Sudah Terverifikasi",
                    style: TextStyle(
                        fontSize: 18,
                        fontFamily: 'Poppins',
                        color: Color.fromRGBO(53, 80, 210, 1)),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
            Positioned(
              top: -10,
              child: Lottie.network('https://assets3.lottiefiles.com/packages/lf20_4jrhf7cm.json',
                  width: 150,
                  height: 160
              ),
            ),
          ],
        ),
      )

  );
}

Future nikTerdaftar(context) async {
  return  showDialog(
      context: context,
      builder: (context) =>AlertDialog(
        title: Stack(
          clipBehavior: Clip.none, alignment: Alignment.center,
          children: <Widget>[
            Column(
              children: [
                Container(
                  width: 240,
                  height: 240,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.fromLTRB(20, 170, 20, 10),
                  child:  const Text("Nik Sudah Terdaftar",
                    style: TextStyle(
                        fontSize: 18,
                        fontFamily: 'Poppins',
                        color: Color.fromRGBO(53, 80, 210, 1)),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
            Positioned(
              top: -10,
              child: Lottie.network('https://assets2.lottiefiles.com/packages/lf20_pqpmxbxp.json',
                  width: 150,
                  height: 160
              ),
            ),
          ],
        ),
      )
  );
}

Future playstoreAamiin(context) async {
  return  showDialog(
      context: context,
      builder: (context) =>AlertDialog(
        title: Stack(
          clipBehavior: Clip.none, alignment: Alignment.center,
          children: <Widget>[
            Column(
              children: [
                Container(
                  width: 300,
                  height: 300,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.fromLTRB(20, 200, 20, 10),
                  child:  const Text("Doakan Masuk Playstore Yaa...",
                    style: TextStyle(
                        fontSize: 18,
                        fontFamily: 'Poppins',
                        color: Color.fromRGBO(53, 80, 210, 1)),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
            Positioned(
              top: -40,
              child: Lottie.network('https://assets10.lottiefiles.com/packages/lf20_vsbadcxj.json',
                  width: 250,
                  height: 260
              ),
            ),
          ],
        ),
      )

  );
}

Future keamananSalah(context) async {
  return  showDialog(
      context: context,
      builder: (context) =>AlertDialog(
        title: Stack(
          clipBehavior: Clip.none, alignment: Alignment.center,
          children: <Widget>[
            Column(
              children: [
                Container(
                  width: 240,
                  height: 240,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.fromLTRB(20, 150, 20, 10),
                  child:  const Text("Keamanan Tidak Cocok",
                    style: TextStyle(
                        fontSize: 18,
                        fontFamily: 'Poppins',
                        color: Color.fromRGBO(53, 80, 210, 1)),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
            Positioned(
              top: -5,
              child: Lottie.network('https://assets2.lottiefiles.com/packages/lf20_pqpmxbxp.json',
                  width: 150,
                  height: 160
              ),
            ),
          ],
        ),
      )

  );
}

Future keamananSucceess(context) async {
  return  showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) =>AlertDialog(
        title: Stack(
          clipBehavior: Clip.none, alignment: Alignment.center,
          children: <Widget>[
            Column(
              children: [
                Container(
                  width: 280,
                  height: 300,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.fromLTRB(20, 200, 20, 10),
                  child:  const Text("Set Keamanan Berhasil",
                    style: TextStyle(
                        fontSize: 18,
                        fontFamily: 'Poppins',
                        color: Color.fromRGBO(53, 80, 210, 1)),
                    textAlign: TextAlign.center,
                  ),
                ),

                Row(children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        if (kDebugMode) {
                          print('yes selected');
                        }
                        Navigator.pushReplacement(context, Navbar.route());
                      },
                      child: const Text("OK"),
                      style: ElevatedButton.styleFrom(
                          primary: Colors.blue.shade800),
                    ),
                  ),]
                ),
              ],
            ),
            Positioned(
              top: -40,
              child: Lottie.network('https://assets3.lottiefiles.com/packages/lf20_rdkzbvu0.json',
                  width: 300,
                  height: 300
              ),
            ),
          ],
        ),
      )

  );
}

Future successPengajuanKredit(context) async {
  return  showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) =>AlertDialog(
        title: Stack(
          clipBehavior: Clip.none, alignment: Alignment.center,
          children: <Widget>[
            Column(
              children: [
                Container(
                  width: 300,
                  height: 300,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.fromLTRB(20, 200, 20, 10),
                  child:  const Text("Sukses Mengajukan Kredit, Tunggu Staff Memverifikasinya",
                    style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'Poppins',
                        color: Color.fromRGBO(53, 80, 112, 1)),
                    textAlign: TextAlign.center,
                  ),
                ),
                Row(children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        if (kDebugMode) {
                          print('yes selected');
                        }
                        Navigator.pushReplacement(context, Navbar.route());
                      },
                      child: const Text("OK"),
                      style: ElevatedButton.styleFrom(
                          primary: Colors.blue.shade800),
                    ),
                  ),]
                ),
              ],
            ),
            Positioned(
              top: -10,
              child: Lottie.network('https://assets5.lottiefiles.com/packages/lf20_vgiwpy5t.json',
                  width: 250,
                  height: 220
              ),
            ),
          ],
        ),
      )

  );
}

Future<bool?> emailCheck(String email) async{
  SharedPreferences server = await SharedPreferences.getInstance();
  String? baseUrl = server.getString('server');
  final msg = jsonEncode({"email": email});
  var response = await http.post(Uri.https(baseUrl!,'api/emailcheck'),
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
    var decodeId = EmailCheckModel.fromJson(jsonDecode(response.body));
    int idNasabah = decodeId.data.id;
    print(idNasabah);
    SharedPreferences prefsId =
    await SharedPreferences.getInstance();
    await prefsId.setInt('idNasabah', idNasabah);
    return true;
  } else
    return false;
}

validateEmail(String? value) {
  String pattern =
      r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
      r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
      r"{0,253}[a-zA-Z0-9])?)*$";
  RegExp regex = RegExp(pattern);
  if (value == null || value.isEmpty || !regex.hasMatch(value)) {
    return 'Masukkan Email Dengan Benar';
  } else {
    return null;
  }
}

Future lupaPin(context) async {
  TextEditingController idnasabahcontroller = TextEditingController();
  return  showDialog(
      context: context,
      builder: (context) =>AlertDialog(
        title: Stack(
          clipBehavior: Clip.none, alignment: Alignment.center,
          children: <Widget>[
            Column(
              children: [
                Container(
                  width: 300,
                  height: 270,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.fromLTRB(10, 180, 10, 10),
                  child:  TextFormField(
                    autovalidateMode: AutovalidateMode.always,
                    controller: idnasabahcontroller,
                    validator: (value) => validateEmail(value),
                    showCursor: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                      hintText: 'Masukkan Email Kamu',
                    ),
                  ),
                ),

                Row(children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () async {
                        if (kDebugMode) {
                          print('yes selected');
                        }
                        String emailNasabah = idnasabahcontroller.text;
                        bool? emailcheck = await emailCheck(emailNasabah);
                        if(emailcheck==true){
                          Navigator.push(context, Pertanyaan.route());
                        }else{
                          showDialog(context: context, builder: (context) => const AlertDialog(title: const Text("Email Belum Terdaftar"),));
                        }
                      },
                      child: const Text("OK"),
                      style: ElevatedButton.styleFrom(
                          primary: Colors.blue.shade800),
                    ),
                  ),]
                ),
              ],
            ),
            Positioned(
              top: 0,
              child: Lottie.network('https://assets6.lottiefiles.com/packages/lf20_sat0coot.json',
                  width: 150,
                  height: 150
              ),
            ),
          ],
        ),
      )

  );
}

Future successPenarikanSaldo(context) async {
  return  showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) =>AlertDialog(
        title: Stack(
          clipBehavior: Clip.none, alignment: Alignment.center,
          children: <Widget>[
            Column(
              children: [
                Container(
                  width: 300,
                  height: 300,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.fromLTRB(20, 200, 20, 10),
                  child:  const Text("Sukses Mengajukan Penarikan, Tunggu Staff Memverifikasinya",
                    style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'Poppins',
                        color: Color.fromRGBO(53, 80, 112, 1)),
                    textAlign: TextAlign.center,
                  ),
                ),
                Row(children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        if (kDebugMode) {
                          print('yes selected');
                        }
                        Navigator.pushReplacement(context, Navbar.route());
                      },
                      child: const Text("OK"),
                      style: ElevatedButton.styleFrom(
                          primary: Colors.blue.shade800),
                    ),
                  ),]
                ),
              ],
            ),
            Positioned(
              top: -40,
              child: Lottie.network('https://assets8.lottiefiles.com/packages/lf20_q8mar8hq.json',
                  width: 300,
                  height: 300
              ),
            ),
          ],
        ),
      )

  );
}