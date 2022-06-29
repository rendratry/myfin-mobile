import 'dart:convert';

import 'package:Myfin/alertsucces.dart';
import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class Pertanyaan extends StatefulWidget {
  const Pertanyaan({Key? key}) : super(key: key);

  @override
  State<Pertanyaan> createState() => _PertanyaanState();
}

Future<bool?> pertanyaanKeamanan(int id,String pertanyaan, String jawaban) async {
  SharedPreferences server = await SharedPreferences.getInstance();
  String? baseUrl = server.getString('server');
  final msg = jsonEncode({"pertanyaan":pertanyaan, "jawaban":jawaban});
  var response = await http.put(Uri.https(baseUrl!,'api/keamanannasabah/'+id.toString()),
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
  TextEditingController jawabanController = TextEditingController();
  // PertanyaanModel _pertanyaanModel;
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
          title: const Text(
            'Pertanyaan Keamanan',
            style: TextStyle(
              color: Color.fromRGBO(53, 80, 112, 1),
              fontSize: 20,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w700,
            ),
          ),
          centerTitle: true),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(30),
        child: Column(
          children: [
            DropdownButtonHideUnderline(
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
            ),
            const SizedBox(
              height: 24,
            ),
            TextFormField(
              keyboardType: TextInputType.text,
              controller: jawabanController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                  hintText: "Jawab"),
            ),
            const SizedBox(
              height: 100,
            ),
            buildButton()
          ],
        ),
      ),
    );
  }

  buildButton() {
    return RawMaterialButton(
      onPressed: () async {
        String? pertanyaankeamanan = _pertanyaan;
        String jawaban = jawabanController.text;

        SharedPreferences idNasabah = await SharedPreferences.getInstance();
        int? id = idNasabah.getInt('idNasabah');

        bool? data = await pertanyaanKeamanan(id!, pertanyaankeamanan!, jawaban);

        if(data == true){
          keamananSucceess(context);
        }else{
          showDialog(context: context, builder: (context) => const AlertDialog(title: const Text("Gagal Set Keamanan"),));
        }

        //Navigator.push(context,PinBaruscreen.route());
      },
      fillColor: const Color.fromRGBO(53, 80, 112, 1),
      constraints: const BoxConstraints(minHeight: 49, minWidth: 128),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      textStyle: const TextStyle(
        color: Colors.white,
        fontFamily: 'Poppins',
        fontSize: 15,
        fontWeight: FontWeight.w500,
      ),
      child: const Text('Simpan'),
    );
  }
}