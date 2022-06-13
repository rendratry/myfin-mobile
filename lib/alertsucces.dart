import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
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
                      onPressed: () {
                        if (kDebugMode) {
                          print('yes selected');
                        }
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