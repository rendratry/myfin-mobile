import 'package:flutter/material.dart';
import 'package:Myfin/pengajuankreditpage/kredit_2.dart';
import 'package:flutter/services.dart';
import 'package:select_form_field/select_form_field.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

class Kredit1 extends StatefulWidget {
  const Kredit1({Key? key}) : super(key: key);

  @override
  State<Kredit1> createState() => _Kredit1State();
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

class _Kredit1State extends State<Kredit1> {
  late TextEditingController _penggunaanKreditController =
      TextEditingController();
  late TextEditingController _besarPengajuanController =
      TextEditingController();
  late TextEditingController _tenorController = TextEditingController();
  bool isButtonActive = false;

  @override
  void initState() {
    super.initState();
    _penggunaanKreditController = TextEditingController();
    _besarPengajuanController = TextEditingController();
    _tenorController = TextEditingController();

    _penggunaanKreditController.addListener(() {
      final isButtonActive = _besarPengajuanController.text.isNotEmpty &&
          _penggunaanKreditController.text.isNotEmpty;
      setState(() => this.isButtonActive = isButtonActive);
    });

    _besarPengajuanController.addListener(() {
      final isButtonActive = _besarPengajuanController.text.isNotEmpty &&
          _penggunaanKreditController.text.isNotEmpty &&
          _tenorController.text.isNotEmpty;
      setState(() => this.isButtonActive = isButtonActive);
    });
    _tenorController.addListener(() {
      final isButtonActive = _besarPengajuanController.text.isNotEmpty &&
          _penggunaanKreditController.text.isNotEmpty &&
          _tenorController.text.isNotEmpty;
      setState(() => this.isButtonActive = isButtonActive);
    });
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    _penggunaanKreditController.dispose();
    _besarPengajuanController.dispose();
    _tenorController.dispose();
    super.dispose();
  }

  final List<Map<String, dynamic>> listPenggunaanKredit = [
    {'value': 5, 'label': 'Buka Usaha'},
    {'value': 2, 'label': 'Membeli barang elektronik(HP, Laptop, TV, dll)'},
    {
      'value': 1,
      'label': 'Membeli kendaraan (Mobil, Motor, Sepeda, dll)',
    },
    {
      'value': 4,
      'label': 'Untuk kebutuhan sehari–hari',
    },
    {
      'value': 3,
      'label': 'Membayar sewa tempat',
    },
  ];

  final List<Map<String, dynamic>> listTenor = [
    {
      'value': 3,
      'label': '3 Bulan',
    },
    {
      'value': 2,
      'label': '6 Bulan',
    },
    {
      'value': 1,
      'label': '12 Bulan',
    }
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
          'Pengajuan Kredit',
          style: TextStyle(
            color: Color.fromRGBO(53, 80, 112, 1),
            fontSize: 25,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Kapasitas",
                style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 20,
                    fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Tujuan Penggunaan Kredit",
                style: const TextStyle(
                    fontWeight: FontWeight.normal,
                    fontFamily: 'Oppen-sans',
                    color: Color(0xff355070),
                    fontSize: 18),
              ),
              SizedBox(
                height: 10,
              ),
              SelectFormField(
                decoration: InputDecoration(
                    suffixIcon: Icon(Icons.expand_more),
                    hintText: 'Pilih Tujuan Anda Kredit',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10))),
                type: SelectFormFieldType.dropdown,
                items: listPenggunaanKredit,
                controller: _penggunaanKreditController,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Besar Pengajuan",
                style: const TextStyle(
                    fontWeight: FontWeight.normal,
                    fontFamily: 'Oppen-sans',
                    color: Color(0xff355070),
                    fontSize: 18),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: _besarPengajuanController,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  CurrencyPtBrInputFormatter()
                ],
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    hintText: "Masukkan Besar Pengajuan Anda"),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Tenor",
                style: const TextStyle(
                    fontWeight: FontWeight.normal,
                    fontFamily: 'Oppen-sans',
                    color: Color(0xff355070),
                    fontSize: 18),
              ),
              SizedBox(
                height: 10,
              ),
              SelectFormField(
                decoration: InputDecoration(
                    suffixIcon: Icon(Icons.expand_more),
                    hintText: 'Pilih Tenor Anda',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10))),
                type: SelectFormFieldType.dropdown,
                items: listTenor,
                controller: _tenorController,
              ),
              const SizedBox(height: 40),
              Center(
                child: buildButton(),
              )
            ],
          ),
        ),
      ),
    );
  }

  buildButton() {
    return ConstrainedBox(
      constraints: BoxConstraints.tightFor(width: 128, height: 49),
      child: ElevatedButton(
        onPressed: isButtonActive
            ? () async {

          var tenorKredit;
          if(_tenorController.text == "3"){
            tenorKredit= "3 bulan";
          }
          if(_tenorController.text == "2"){
            tenorKredit= "6 bulan";
          }
          if(_tenorController.text == "1"){
            tenorKredit= "12 bulan";
          }
          var penggunaanKredit;
          if(_penggunaanKreditController.text == "5"){
            penggunaanKredit= "Buka Usaha";
          }
          if(_penggunaanKreditController.text == "2"){
            penggunaanKredit= "Membeli Barang Elektronik(Hp/Laptop/TV dll.)";
          }
          if(_penggunaanKreditController.text == "1"){
            penggunaanKredit= "Membeli Kendaraan(Motor/Mobil/Sepeda dll.)";
          }
          if(_penggunaanKreditController.text == "4"){
            penggunaanKredit= "Untuk Kebutuhan Sehari - hari";
          }
          if(_penggunaanKreditController.text == "3"){
            penggunaanKredit= "Membayar Sewa Tempat";
          }


          SharedPreferences prefstenor =
          await SharedPreferences.getInstance();
          await prefstenor.setString('tenor', tenorKredit.toString());
          SharedPreferences prefsbesarpengajuan =
          await SharedPreferences.getInstance();
          await prefsbesarpengajuan.setString('pengajuan', _besarPengajuanController.text);
          SharedPreferences prefspenggunaan =
          await SharedPreferences.getInstance();
          await prefspenggunaan.setString('penggunaan', penggunaanKredit);

          print(tenorKredit);
          print(penggunaanKredit);

                setState(() {
                  isButtonActive = true;
                });
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Kredit2(
                            valuePenggunaanKredit:
                                _penggunaanKreditController.text,
                            valueBesarPengajuan: _besarPengajuanController.text,
                            valueTenor: _tenorController.text,
                          )),
                );
              }
            : null,
        child: Text(
          "Lanjutkan",
          style: TextStyle(
              color: Colors.white,
              fontFamily: 'Poppins',
              fontSize: 15,
              fontWeight: FontWeight.w500),
        ),
        style: ButtonStyle(
          // backgroundColor:
          //     MaterialStateProperty.all(Color.fromRGBO(53, 80, 112, 1)),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ),
    );
  }
}
