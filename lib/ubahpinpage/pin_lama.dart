import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:Myfin/ubahpinpage/pertanyaan1.dart';
import 'package:Myfin/ubahpinpage/pin_baru.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class PinLamascreen extends StatefulWidget {
  const PinLamascreen({Key? key}) : super(key: key);

  @override
  State<PinLamascreen> createState() => _PinLamascreenState();

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const PinLamascreen());
  }
}

Future<bool?> updatePinNasabah(String email, String pin) async {
  SharedPreferences server = await SharedPreferences.getInstance();
  String? baseUrl = server.getString('server');
  final msg = jsonEncode({"email": email, "pin": pin});

  var response = await http.post(Uri.https(baseUrl!, '/api/login'),
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

  if (response.statusCode == 200) {
    return true;
  } else
    return false;
}

class _PinLamascreenState extends State<PinLamascreen> {
  List<String> currentPin = ["", "", "", "", "", ""];
  TextEditingController firstPinController = TextEditingController();
  TextEditingController secondPinController = TextEditingController();
  TextEditingController thirdPinController = TextEditingController();
  TextEditingController fourthPinController = TextEditingController();
  TextEditingController fifthPinController = TextEditingController();
  TextEditingController sixthPinController = TextEditingController();

  var outlineInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(40),
    borderSide: const BorderSide(color: Colors.transparent),
    gapPadding: 40.0,
  );

  int pinIndex = 0;

  pinIndexSetup(String text) {
    if (pinIndex == 0) {
      pinIndex = 1;
    } else if (pinIndex < 6) {
      pinIndex++;
    }
    setPin(pinIndex, text);
    currentPin[pinIndex - 1] = text;
    if (pinIndex == 6) {
      validatePin();
    }
  }

  setPin(int n, String text) {
    switch (n) {
      case 1:
        firstPinController.text = text;
        break;
      case 2:
        secondPinController.text = text;
        break;
      case 3:
        thirdPinController.text = text;
        break;
      case 4:
        fourthPinController.text = text;
        break;
      case 5:
        fifthPinController.text = text;
        break;
      case 6:
        sixthPinController.text = text;
        break;
    }
  }

  clearPin() {
    if (pinIndex == 0) {
      pinIndex = 0;
    } else if (pinIndex == 6) {
      setPin(pinIndex, '');
      currentPin[pinIndex - 1] = '';
      pinIndex--;
    } else {
      setPin(pinIndex, '');
      currentPin[pinIndex - 1] = '';
      pinIndex--;
    }
  }

  clearAllPin() {
    pinIndex = 0;
    firstPinController.text = '';
    secondPinController.text = '';
    thirdPinController.text = '';
    fourthPinController.text = '';
    fifthPinController.text = '';
    sixthPinController.text = '';
    currentPin = ["", "", "", "", "", ""];
  }

  validatePin() async {
    String pin = currentPin.join();
    if (pin.length == 6) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? emailid = prefs.getString('emailNasabah');
      bool? data = await updatePinNasabah(emailid!, pin);
      if(data == true){
        Navigator.push(context, PinBaruscreen.route());
      }else{
        showDialog(context: context, builder: (context) => const AlertDialog(title: const Text("Pin Salah"),));
      }

    }
    clearAllPin();
  }

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
        title: const Text('Masukan PIN',
            style: TextStyle(
                color: Color.fromRGBO(53, 80, 112, 1),
                fontSize: 20,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w700)),
        centerTitle: true,
      ),
      body: Center(
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: Container(
                  alignment: const Alignment(0, 0.5),
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      const SizedBox(height: 40),
                      buildSecurityText(),
                      const SizedBox(height: 40),
                      buildPinRow(),
                      const SizedBox(height: 40),
                      buildForgotPin(),                 
                    ],
                  ),
                ),
              ),
              buildNumberPad(),
            ],
          ),
        ),
      ),
    );
  }

  buildSecurityText() {
    return const Text(
      "Masukan PIN Kamu Saat Ini ?",
      style: TextStyle(
        fontFamily: 'Poppins',
        color: Color.fromRGBO(53, 80, 112, 1),
        fontSize: 15,
        fontWeight: FontWeight.normal,
      ),
    );
  }

  buildPinRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        PinNumber(
          outlineInputBorder: outlineInputBorder,
          textEditingController: firstPinController,
        ),
        PinNumber(
          outlineInputBorder: outlineInputBorder,
          textEditingController: secondPinController,
        ),
        PinNumber(
          outlineInputBorder: outlineInputBorder,
          textEditingController: thirdPinController,
        ),
        PinNumber(
          outlineInputBorder: outlineInputBorder,
          textEditingController: fourthPinController,
        ),
        PinNumber(
          outlineInputBorder: outlineInputBorder,
          textEditingController: fifthPinController,
        ),
        PinNumber(
          outlineInputBorder: outlineInputBorder,
          textEditingController: sixthPinController,
        ),
      ],
    );
  }

  buildForgotPin() {
    return TextButton(
      style: TextButton.styleFrom(
        primary: const Color.fromRGBO(53, 80, 112, 1),
        textStyle: const TextStyle(
          fontSize: 16,
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w700,
        ),
      ),
      onPressed: () {
        Navigator.push(context, Pertanyaan.route());
      },
      child: const Text('Lupa PIN ?'),
    );
  }

  buildNumberPad() {
    return Expanded(
      child: Container(
        alignment: Alignment.bottomCenter,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  KeyboardNumber(
                    n: 1,
                    onPressed: () {
                      pinIndexSetup('1');
                    },
                  ),
                  KeyboardNumber(
                    n: 2,
                    onPressed: () {
                      pinIndexSetup('2');
                    },
                  ),
                  KeyboardNumber(
                    n: 3,
                    onPressed: () {
                      pinIndexSetup('3');
                    },
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  KeyboardNumber(
                    n: 4,
                    onPressed: () {
                      pinIndexSetup('4');
                    },
                  ),
                  KeyboardNumber(
                    n: 5,
                    onPressed: () {
                      pinIndexSetup('5');
                    },
                  ),
                  KeyboardNumber(
                    n: 6,
                    onPressed: () {
                      pinIndexSetup('6');
                    },
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  KeyboardNumber(
                    n: 7,
                    onPressed: () {
                      pinIndexSetup('7');
                    },
                  ),
                  KeyboardNumber(
                    n: 8,
                    onPressed: () {
                      pinIndexSetup('8');
                    },
                  ),
                  KeyboardNumber(
                    n: 9,
                    onPressed: () {
                      pinIndexSetup('9');
                    },
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const SizedBox(width: 60),
                  KeyboardNumber(
                    n: 0,
                    onPressed: () {
                      pinIndexSetup('0');
                    },
                  ),
                  SizedBox(
                    width: 60,
                    child: IconButton(
                      onPressed: () {
                        clearPin();
                      },
                      icon: const Icon(
                        Icons.backspace_outlined,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PinNumber extends StatelessWidget {
  final TextEditingController textEditingController;
  final OutlineInputBorder outlineInputBorder;

  const PinNumber({
    Key? key,
    required this.textEditingController,
    required this.outlineInputBorder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 40,
      height: 40,
      child: TextField(
        controller: textEditingController,
        enabled: false,
        obscureText: true,
        textAlign: TextAlign.center,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(13),
          border: outlineInputBorder,
          filled: true,
          fillColor: Colors.white30,
        ),
        style: const TextStyle(
          fontSize: 19,
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class KeyboardNumber extends StatelessWidget {
  final int n;
  final Function() onPressed;

  const KeyboardNumber({
    Key? key,
    required this.n,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60,
      height: 60,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.transparent,
      ),
      alignment: Alignment.center,
      child: MaterialButton(
        padding: const EdgeInsets.all(8),
        onPressed: onPressed,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(60),
        ),
        height: 90,
        child: Text(
          n.toString(),
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 24 * MediaQuery.of(context).textScaleFactor,
            fontFamily: 'poppins',
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
