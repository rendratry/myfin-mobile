import 'dart:convert';
import 'package:Myfin/alertsucces.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'pin_baru.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter_svg/svg.dart';


class Pertanyaan extends StatefulWidget {
  const Pertanyaan({ Key? key }) : super(key: key);

  @override
  State<Pertanyaan> createState() => _PertanyaanState();

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const Pertanyaan(),
    );
  }
}

Future<bool?> checkKeamanan(int id, String pertanyaan, String jawaban) async{
  SharedPreferences server = await SharedPreferences.getInstance();
  String? baseUrl = server.getString('server');

  final msg = jsonEncode({"pertanyaan": pertanyaan, "jawaban":jawaban});
  var response = await http.post(Uri.https(baseUrl!,'api/keamanancheck/'+id.toString()),
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

class _PertanyaanState extends State<Pertanyaan> {
  TextEditingController jawabancontroller = TextEditingController();
  String? _pertanyaan;
  List listp = [
    'Siapa nama Ibumu?',
    'Siapa nama Gurumu waktu SD?',
    'Siapa nama hewan peliharaanmu?',
    'Apa tim olahraga favoritmu?'
  ];

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
          title: const Text('Masukan Keamanan',
            style: TextStyle(
              color: Color.fromRGBO(53, 80, 112, 1),
              fontSize: 25,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w700,
            ),
          ),
          centerTitle: true,
        ),
        body:
        Center(
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
                              buildInputText(),
                              const SizedBox(height: 80),
                              buildButoon(),
                            ]
                        ),
                      ),
                    ),
                  ]
              ),
            )
        )
    );
  }
  buildSecurityText() {
    return DropdownButtonHideUnderline(
      child: DropdownButton2(
        isExpanded: true,
        hint: Row(
          children: const [
            Expanded(
              child: Text(
                'Pilih Pertanyaan',
              ),
            ),
          ],
        ),
        icon: SvgPicture.asset(
            'assets/svg/arrow_down.svg'),
        buttonPadding: const EdgeInsets.symmetric(horizontal: 10),
        items: listp
            .map((item) => DropdownMenuItem<String>(
          value: item,
          child: Text(item),
        ))
            .toList(),
        value: _pertanyaan,
        onChanged: (value) {
          setState(() {
            _pertanyaan = value as String;
          });
        },
        buttonDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: const Color(0xffA8A8A8)),
        ),
        dropdownDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: const Color(0xffA8A8A8)),
        ),
      ),
    );
  }
  buildInputText(){
    return TextFormField(
      showCursor: true,
      keyboardType: TextInputType.text,
      controller: jawabancontroller,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        hintText: 'Jawab',
      ),
    );
  }
  buildButoon(){
    return RawMaterialButton(
      onPressed: () async {
        SharedPreferences idNasabah = await SharedPreferences.getInstance();
        int? id = idNasabah.getInt('idNasabah');

        String? pertanyaan = _pertanyaan;
        String? jawaban = jawabancontroller.text;

        bool? cekKeamanan = await checkKeamanan(id!, pertanyaan!, jawaban);

        if(cekKeamanan==true){
          Navigator.push(context,PinBaruscreen.route());
        }else{
          keamananSalah(context);
        }

      },
      fillColor: const Color.fromRGBO(53, 80, 112, 1),
      constraints: const BoxConstraints(minHeight: 49, minWidth: 128),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      textStyle:
      const TextStyle(
        color: Colors.white,
        fontFamily: 'Poppins',
        fontSize: 15,
        fontWeight: FontWeight.w500,
      ),
      child: const Text(
          'Lanjutkan'),
    );
  }
}