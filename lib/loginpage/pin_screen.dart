import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:Myfin/alertsucces.dart';
import 'package:Myfin/homepage/navbar.dart';
import 'package:Myfin/loginpage/login_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

// ignore: use_key_in_widget_constructors
class InputPin extends StatefulWidget {
  @override
  State<InputPin> createState() => _InputPinState();
}

Future<bool?> loginNasabah(String email, String pin) async{
  SharedPreferences server = await SharedPreferences.getInstance();
  String? baseUrl = server.getString('server');
  final msg = jsonEncode({"email": email, "pin":pin});

  var response = await http.post(Uri.https(baseUrl!,'/api/login'),
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
    var decodeId = LoginModel.fromJson(jsonDecode(response.body));
    int idNasabah = decodeId.data.id;
    //String emailNasabah = decodeId.data.email;
    print(idNasabah);
    SharedPreferences prefsId =
    await SharedPreferences.getInstance();
    await prefsId.setInt('idNasabah', idNasabah);
    return true;
  } else
    return false;
}

class _InputPinState extends State<InputPin> {

  late LoginModel _loginNasabah;
  List<String> currentPin = ["", "", "", "", "", ""];
  TextEditingController pinOneController = TextEditingController();
  TextEditingController pinTwoController = TextEditingController();
  TextEditingController pinThreeController = TextEditingController();
  TextEditingController pinFourController = TextEditingController();
  TextEditingController pinFiveController = TextEditingController();
  TextEditingController pinSixController = TextEditingController();

  var outlineInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(10.0),
    borderSide: const BorderSide(color: Colors.blue),
  );

  int pinIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const Padding(padding: EdgeInsets.only(top: 69.0)),
        Expanded(
          child: Container(
            alignment: const Alignment(0, 0.5),
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                buildSecurityText(),
                const SizedBox(height: 40.0),
                buildPinRow(),
                const SizedBox(height: 40.0),
                buildButton(),
              ],
            ),
          ),
        )
      ],
    );
  }

  buildSecurityText() {
    return const Text("Masukan PIN Kamu",
        style: TextStyle(
          color: Colors.black,
          fontSize: 19.0,
          fontWeight: FontWeight.bold,
        ));
  }

  buildPinRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        PINNumber(
          outlineInputBorder: outlineInputBorder,
          textEditingController: pinOneController,
        ),
        PINNumber(
          outlineInputBorder: outlineInputBorder,
          textEditingController: pinTwoController,
        ),
        PINNumber(
          outlineInputBorder: outlineInputBorder,
          textEditingController: pinThreeController,
        ),
        PINNumber(
          outlineInputBorder: outlineInputBorder,
          textEditingController: pinFourController,
        ),
        PINNumber(
          outlineInputBorder: outlineInputBorder,
          textEditingController: pinFiveController,
        ),
        PINNumber(
          outlineInputBorder: outlineInputBorder,
          textEditingController: pinSixController,
        ),
      ],
    );
  }

  buildButton() {
    var pin1 = pinOneController.text;
    var pin2 = pinTwoController.text;
    var pin3 = pinThreeController.text;
    var pin4 = pinFourController.text;
    var pin5 = pinFiveController.text;
    var pin6 = pinSixController.text;
    var pinString = pin1.toString()+pin2.toString()+pin3.toString()+pin4.toString()+pin5.toString()+pin6.toString();
    return RawMaterialButton(
      onPressed: () async {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        String? emailid = prefs.getString('emailNasabah');

        SharedPreferences prefsEmail = await SharedPreferences.getInstance();
        String? emailid2 = prefsEmail.getString('emailNasabah2');

        bool? data = (await loginNasabah(emailid!,pinString));
        print(emailid);
        print(pinString);

        if(data != true){
          showDialog(context: context, builder: (context) => const AlertDialog(title: const Text("Email Atau Pin Salah"),));
        }else{
          showprogess(context);
          var navigationResult = await Navigator.push(context, new MaterialPageRoute(
             builder: (context)=> Navbar()));
        }
        setState(() {
          _loginNasabah = data! as LoginModel;
        });
      },
      fillColor: const Color.fromRGBO(53, 80, 112, 1),
      constraints: const BoxConstraints(minHeight: 49, minWidth: 128),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      textStyle: const TextStyle(
        color: Colors.white,
        fontFamily: 'Poppins',
        fontSize: 20,
        fontWeight: FontWeight.w500,
      ),
      child: const Text('Masuk'),
    );
  }
}

class PINNumber extends StatelessWidget {
  final TextEditingController textEditingController;
  final OutlineInputBorder outlineInputBorder;

  // ignore: use_key_in_widget_constructors
  const PINNumber(
      {required this.textEditingController, required this.outlineInputBorder});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 50.0,
        child: AspectRatio(
          aspectRatio: 1.0,
          child: TextField(
            autofocus: true,
            keyboardType: TextInputType.number,
            controller: textEditingController,
            obscureText: true,
            textAlign: TextAlign.center,
            showCursor: false,
            maxLength: 1,
            decoration: InputDecoration(
              counter: const Offstage(),
              contentPadding: const EdgeInsets.all(16.0),
              border: outlineInputBorder,
              focusedBorder: outlineInputBorder,
              filled: true,
              fillColor: Colors.white30,
            ),
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 21.0,
              color: Colors.black,
            ),
            onChanged: (value) {
              if (value.length == 1) {
                FocusScope.of(context).nextFocus();
                debugPrint(value);
              }
              if (value.isEmpty) {
                FocusScope.of(context).previousFocus();
              }
            },
          ),
        ));
  }
}
