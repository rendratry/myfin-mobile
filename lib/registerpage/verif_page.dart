import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:myfin_app/createpinpage/onboarding_pin.dart';
import 'package:myfin_app/registerpage/register_model.dart';
import 'package:myfin_app/registerpage/register_page.dart';
import 'package:myfin_app/registerpage/verif_model.dart';
import 'package:http/http.dart' as http;
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Verifikasi extends StatefulWidget {
  @override
  _VerifikasiState createState() => _VerifikasiState();
}


//RegisterModel emailid = registerModelFromJson(json['data']);

Future<bool?> verifikasiData(String emailid, String otp) async {
  SharedPreferences server = await SharedPreferences.getInstance();
  String? baseUrl = server.getString('server');

  final msg = jsonEncode({"email": emailid, "otp": otp});
  var response = await http.post(
      Uri.http(baseUrl!, 'api/emailvalidation'),
      headers: {
        'X-API-Key': "myfin",
        'Accept': "application/json",
      },
      body:
      msg
  );
  var data = response.body;
  print(data);
  print(response.statusCode)
  ;

  if (response.statusCode == 200) {
    return true;
    String responseString = response.body;
    verifModelFromJson(responseString);
  }else{
    return null;
  }
}
class _VerifikasiState extends State<Verifikasi> {
  TextEditingController textEditingController = TextEditingController();
  String currentText = "";
  late VerifModel _verifData;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 52),
                child: Image.asset(
                  "assets/png/verif.png",
                  width: 293,
                  height: 293,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Text(
                  'Verifikasi Akun',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    color: Color.fromRGBO(53, 80, 112, 1),
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 0),
                child: Text(
                  'Cek email kamu untuk mendapatkan kode\nverifikasi dari akun',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    color: Color(0xffA8A8A8),
                    fontSize: 11,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 42, right: 42, top: 23),
                child: Center(
                  child: PinCodeTextField(
                    length: 4,
                    backgroundColor: Colors.white,
                    keyboardType: TextInputType.numberWithOptions(),
                    obscureText: false,
                    animationType: AnimationType.fade,
                    pinTheme: PinTheme(
                        shape: PinCodeFieldShape.box,
                        borderRadius: BorderRadius.circular(5),
                        fieldHeight: 54,
                        fieldWidth: 57,
                        activeFillColor: Colors.white,
                        inactiveFillColor: Colors.white,
                        inactiveColor: Color(0x26000000),
                        activeColor: Color(0x26000000)),
                    animationDuration: const Duration(milliseconds: 300),
                    enableActiveFill: true,
                    controller: textEditingController,
                    onCompleted: (v) {
                      debugPrint("Completed");
                    },
                    onChanged: (value) {
                      debugPrint(value);
                      setState(() {
                        currentText = value;
                      });
                    },
                    beforeTextPaste: (text) {
                      return true;
                    },
                    appContext: context,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 28),
                child: Text(
                  'Kirim ulang kode',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    color: Color(0xffA8A8A8),
                    fontSize: 11,
                  ),
                ),
              ),
              SizedBox(
                height: 32,
              ),
              RawMaterialButton(
                onPressed: () async {
                  // SharedPreferences prefsId = await SharedPreferences.getInstance();
                  // int? idNasabah = prefsId.getInt('idNasabah');
                  // print(idNasabah);

                  SharedPreferences prefs = await SharedPreferences.getInstance();
                  String? emailid = prefs.getString('emailNasabah');

                  String otp = textEditingController.text;
                  bool? data = await verifikasiData(emailid!,otp);
                  if (data==true){
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) {
                          return Onboarding();
                        }));
                  }else {
                    showDialog(context: context, builder: (context) => const AlertDialog(title: const Text("Kode OTP Salah"),));
                  }
                  setState(() {
                    _verifData = data! as VerifModel;
                  });
                },
                fillColor: Color.fromRGBO(53, 80, 112, 1),
                constraints: BoxConstraints(minHeight: 49, minWidth: 128),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                textStyle: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Poppins',
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
                child: Text('Verifikasi'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
