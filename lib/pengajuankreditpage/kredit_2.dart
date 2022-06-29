import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:select_form_field/select_form_field.dart';
import './kredit_3.dart';
import 'kredit_1.dart';

class Kredit2 extends StatefulWidget {
  final String valuePenggunaanKredit;
  final String valueBesarPengajuan;
  final String valueTenor;

  Kredit2(
      {Key? key,
      required this.valuePenggunaanKredit,
      required this.valueBesarPengajuan,
      required this.valueTenor})
      : super(key: key);

  final nominal = NumberFormat("#,##0.00", "en_US");

  @override
  State<Kredit2> createState() => _Kredit1State();
}

class CustomWidgets {
  static Widget textField(String title,
      {bool isNumber = false,
      int? length,
      TextEditingController? textController,
      int lines = 1,
      var cornerRadius = 0.0}) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: const TextStyle(
                fontWeight: FontWeight.normal,
                fontFamily: 'Oppen-sans',
                color: Color(0xff355070),
                fontSize: 18),
          ),
          const SizedBox(
            height: 10,
          ),
          TextFormField(
            maxLines: lines,
            controller: textController,
            maxLength: length,
            inputFormatters: [
              LengthLimitingTextInputFormatter(length),
            ],
            keyboardType: isNumber ? TextInputType.number : TextInputType.text,
            textCapitalization: TextCapitalization.words,
            decoration: InputDecoration(
              counterText: '',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(cornerRadius),
              ),
              fillColor: Colors.transparent,
            ),
          )
        ],
      ),
    );
  }
}

class _Kredit1State extends State<Kredit2> {
  late TextEditingController _pekerjaanController = TextEditingController();
  late TextEditingController _lamaBekerjaController = TextEditingController();
  late TextEditingController _usahaController = TextEditingController();
  late TextEditingController _bisnisController = TextEditingController();
  late TextEditingController _jumlahKaryawanController =
      TextEditingController();
  late TextEditingController _pendapatanController = TextEditingController();
  late TextEditingController _pendapatanTambahanController =
      TextEditingController();
  late TextEditingController _pendapatanPasanganController =
      TextEditingController();
  late TextEditingController _tanggunganController = TextEditingController();
  late TextEditingController _tempatTinggalController = TextEditingController();
  late TextEditingController _melunasiCicilanController =
      TextEditingController();
  late TextEditingController _kondisiBisnisController = TextEditingController();
  bool isButtonActive = false;

  @override
  void initState() {
    super.initState();
    _pekerjaanController = TextEditingController();
    _lamaBekerjaController = TextEditingController();
    _usahaController = TextEditingController();
    _bisnisController = TextEditingController();
    _jumlahKaryawanController = TextEditingController();
    _pendapatanController = TextEditingController();
    _pendapatanTambahanController = TextEditingController();
    _pendapatanPasanganController = TextEditingController();
    _tanggunganController = TextEditingController();
    _tempatTinggalController = TextEditingController();
    _melunasiCicilanController = TextEditingController();
    _kondisiBisnisController = TextEditingController();

    _pekerjaanController.addListener(() {
      final isButtonActive = _pekerjaanController.text.isNotEmpty &&
          _lamaBekerjaController.text.isNotEmpty &&
          _usahaController.text.isNotEmpty &&
          _bisnisController.text.isNotEmpty &&
          _jumlahKaryawanController.text.isNotEmpty &&
          _pendapatanController.text.isNotEmpty &&
          _pendapatanTambahanController.text.isNotEmpty &&
          _pendapatanPasanganController.text.isNotEmpty &&
          _tanggunganController.text.isNotEmpty &&
          _tempatTinggalController.text.isNotEmpty &&
          _melunasiCicilanController.text.isNotEmpty &&
          _kondisiBisnisController.text.isNotEmpty;
      setState(() => this.isButtonActive = isButtonActive);
    });

    _lamaBekerjaController.addListener(() {
      final isButtonActive = _pekerjaanController.text.isNotEmpty &&
          _lamaBekerjaController.text.isNotEmpty &&
          _usahaController.text.isNotEmpty &&
          _bisnisController.text.isNotEmpty &&
          _jumlahKaryawanController.text.isNotEmpty &&
          _pendapatanController.text.isNotEmpty &&
          _pendapatanTambahanController.text.isNotEmpty &&
          _pendapatanPasanganController.text.isNotEmpty &&
          _tanggunganController.text.isNotEmpty &&
          _tempatTinggalController.text.isNotEmpty &&
          _melunasiCicilanController.text.isNotEmpty &&
          _kondisiBisnisController.text.isNotEmpty;
      setState(() => this.isButtonActive = isButtonActive);
    });

    _usahaController.addListener(() {
      final isButtonActive = _pekerjaanController.text.isNotEmpty &&
          _lamaBekerjaController.text.isNotEmpty &&
          _usahaController.text.isNotEmpty &&
          _bisnisController.text.isNotEmpty &&
          _jumlahKaryawanController.text.isNotEmpty &&
          _pendapatanController.text.isNotEmpty &&
          _pendapatanTambahanController.text.isNotEmpty &&
          _pendapatanPasanganController.text.isNotEmpty &&
          _tanggunganController.text.isNotEmpty &&
          _tempatTinggalController.text.isNotEmpty &&
          _melunasiCicilanController.text.isNotEmpty &&
          _kondisiBisnisController.text.isNotEmpty;
      setState(() => this.isButtonActive = isButtonActive);
    });

    _bisnisController.addListener(() {
      final isButtonActive = _pekerjaanController.text.isNotEmpty &&
          _lamaBekerjaController.text.isNotEmpty &&
          _usahaController.text.isNotEmpty &&
          _bisnisController.text.isNotEmpty &&
          _jumlahKaryawanController.text.isNotEmpty &&
          _pendapatanController.text.isNotEmpty &&
          _pendapatanTambahanController.text.isNotEmpty &&
          _pendapatanPasanganController.text.isNotEmpty &&
          _tanggunganController.text.isNotEmpty &&
          _tempatTinggalController.text.isNotEmpty &&
          _melunasiCicilanController.text.isNotEmpty &&
          _kondisiBisnisController.text.isNotEmpty;
      setState(() => this.isButtonActive = isButtonActive);
    });

    _jumlahKaryawanController.addListener(() {
      final isButtonActive = _pekerjaanController.text.isNotEmpty &&
          _lamaBekerjaController.text.isNotEmpty &&
          _usahaController.text.isNotEmpty &&
          _bisnisController.text.isNotEmpty &&
          _jumlahKaryawanController.text.isNotEmpty &&
          _pendapatanController.text.isNotEmpty &&
          _pendapatanTambahanController.text.isNotEmpty &&
          _pendapatanPasanganController.text.isNotEmpty &&
          _tanggunganController.text.isNotEmpty &&
          _tempatTinggalController.text.isNotEmpty &&
          _melunasiCicilanController.text.isNotEmpty &&
          _kondisiBisnisController.text.isNotEmpty;
      setState(() => this.isButtonActive = isButtonActive);
    });

    _pendapatanController.addListener(() {
      final isButtonActive = _pekerjaanController.text.isNotEmpty &&
          _lamaBekerjaController.text.isNotEmpty &&
          _usahaController.text.isNotEmpty &&
          _bisnisController.text.isNotEmpty &&
          _jumlahKaryawanController.text.isNotEmpty &&
          _pendapatanController.text.isNotEmpty &&
          _pendapatanTambahanController.text.isNotEmpty &&
          _pendapatanPasanganController.text.isNotEmpty &&
          _tanggunganController.text.isNotEmpty &&
          _tempatTinggalController.text.isNotEmpty &&
          _melunasiCicilanController.text.isNotEmpty &&
          _kondisiBisnisController.text.isNotEmpty;
      setState(() => this.isButtonActive = isButtonActive);
    });

    _pendapatanTambahanController.addListener(() {
      final isButtonActive = _pekerjaanController.text.isNotEmpty &&
          _lamaBekerjaController.text.isNotEmpty &&
          _usahaController.text.isNotEmpty &&
          _bisnisController.text.isNotEmpty &&
          _jumlahKaryawanController.text.isNotEmpty &&
          _pendapatanController.text.isNotEmpty &&
          _pendapatanTambahanController.text.isNotEmpty &&
          _pendapatanPasanganController.text.isNotEmpty &&
          _tanggunganController.text.isNotEmpty &&
          _tempatTinggalController.text.isNotEmpty &&
          _melunasiCicilanController.text.isNotEmpty &&
          _kondisiBisnisController.text.isNotEmpty;
      setState(() => this.isButtonActive = isButtonActive);
    });

    _pendapatanPasanganController.addListener(() {
      final isButtonActive = _pekerjaanController.text.isNotEmpty &&
          _lamaBekerjaController.text.isNotEmpty &&
          _usahaController.text.isNotEmpty &&
          _bisnisController.text.isNotEmpty &&
          _jumlahKaryawanController.text.isNotEmpty &&
          _pendapatanController.text.isNotEmpty &&
          _pendapatanTambahanController.text.isNotEmpty &&
          _pendapatanPasanganController.text.isNotEmpty &&
          _tanggunganController.text.isNotEmpty &&
          _tempatTinggalController.text.isNotEmpty &&
          _melunasiCicilanController.text.isNotEmpty &&
          _kondisiBisnisController.text.isNotEmpty;
      setState(() => this.isButtonActive = isButtonActive);
    });

    _tanggunganController.addListener(() {
      final isButtonActive = _pekerjaanController.text.isNotEmpty &&
          _lamaBekerjaController.text.isNotEmpty &&
          _usahaController.text.isNotEmpty &&
          _bisnisController.text.isNotEmpty &&
          _jumlahKaryawanController.text.isNotEmpty &&
          _pendapatanController.text.isNotEmpty &&
          _pendapatanTambahanController.text.isNotEmpty &&
          _pendapatanPasanganController.text.isNotEmpty &&
          _tanggunganController.text.isNotEmpty &&
          _tempatTinggalController.text.isNotEmpty &&
          _melunasiCicilanController.text.isNotEmpty &&
          _kondisiBisnisController.text.isNotEmpty;
      setState(() => this.isButtonActive = isButtonActive);
    });

    _tempatTinggalController.addListener(() {
      final isButtonActive = _pekerjaanController.text.isNotEmpty &&
          _lamaBekerjaController.text.isNotEmpty &&
          _usahaController.text.isNotEmpty &&
          _bisnisController.text.isNotEmpty &&
          _jumlahKaryawanController.text.isNotEmpty &&
          _pendapatanController.text.isNotEmpty &&
          _pendapatanTambahanController.text.isNotEmpty &&
          _pendapatanPasanganController.text.isNotEmpty &&
          _tanggunganController.text.isNotEmpty &&
          _tempatTinggalController.text.isNotEmpty &&
          _melunasiCicilanController.text.isNotEmpty &&
          _kondisiBisnisController.text.isNotEmpty;
      setState(() => this.isButtonActive = isButtonActive);
    });

    _melunasiCicilanController.addListener(() {
      final isButtonActive = _pekerjaanController.text.isNotEmpty &&
          _lamaBekerjaController.text.isNotEmpty &&
          _usahaController.text.isNotEmpty &&
          _bisnisController.text.isNotEmpty &&
          _jumlahKaryawanController.text.isNotEmpty &&
          _pendapatanController.text.isNotEmpty &&
          _pendapatanTambahanController.text.isNotEmpty &&
          _pendapatanPasanganController.text.isNotEmpty &&
          _tanggunganController.text.isNotEmpty &&
          _tempatTinggalController.text.isNotEmpty &&
          _melunasiCicilanController.text.isNotEmpty &&
          _kondisiBisnisController.text.isNotEmpty;
      setState(() => this.isButtonActive = isButtonActive);
    });

    _kondisiBisnisController.addListener(() {
      final isButtonActive = _pekerjaanController.text.isNotEmpty &&
          _lamaBekerjaController.text.isNotEmpty &&
          _usahaController.text.isNotEmpty &&
          _bisnisController.text.isNotEmpty &&
          _jumlahKaryawanController.text.isNotEmpty &&
          _pendapatanController.text.isNotEmpty &&
          _pendapatanTambahanController.text.isNotEmpty &&
          _pendapatanPasanganController.text.isNotEmpty &&
          _tanggunganController.text.isNotEmpty &&
          _tempatTinggalController.text.isNotEmpty &&
          _melunasiCicilanController.text.isNotEmpty &&
          _kondisiBisnisController.text.isNotEmpty;
      setState(() => this.isButtonActive = isButtonActive);
    });
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    _pekerjaanController.dispose();
    _lamaBekerjaController.dispose();
    _usahaController.dispose();
    _bisnisController.dispose();
    _jumlahKaryawanController.dispose();
    _pendapatanController.dispose();
    _pendapatanTambahanController.dispose();
    _pendapatanPasanganController.dispose();
    _tanggunganController.dispose();
    _tempatTinggalController.dispose();
    _melunasiCicilanController.dispose();
    _kondisiBisnisController.dispose();
    super.dispose();
  }

  
  late String sampingan = '';
  late String karyawan = '';
  late String pasanganBekerja = '';
  late String asset = '';
  late String cicilan = '';
  final List<Map<String, dynamic>> listBisnis = [
    {
      'value': 1,
      'label': 'Penjual Barang',
    },
    {
      'value': 2,
      'label': 'Penjual Jasa',
    },
  ];
  final List<Map<String, dynamic>> listPendapatan = [
    {
      'value': 1,
      'label': '< Rp. 1.000.000',
    },
    {
      'value': 2,
      'label': '> Rp. 1.000.000 s/d Rp. 3.000.000',
    },
    {
      'value': 3,
      'label': '> Rp. 3.000.000 s/d Rp. 7.000.000',
    },
    {
      'value': 4,
      'label': '> Rp. 7.000.000 s/d Rp. 10.000.000',
    },
    {
      'value': 5,
      'label': '> Rp. 10.000.000',
    }
  ];
  final List<Map<String, dynamic>> listPendapatanPasangan = [
    {
      'value': 1,
      'label': '< Rp. 1.000.000',
    },
    {
      'value': 2,
      'label': '> Rp. 1.000.000 s/d Rp. 3.000.000',
    },
    {
      'value': 3,
      'label': '> Rp. 3.000.000 s/d Rp. 7.000.000',
    },
    {
      'value': 4,
      'label': '> Rp. 7.000.000 s/d Rp. 10.000.000',
    },
    {
      'value': 5,
      'label': '> Rp. 10.000.000',
    }
  ];
  final List<Map<String, dynamic>> listTempatTinggal = [
    {
      'value': 3,
      'label': 'Milik Sendiri',
    },
    {
      'value': 2,
      'label': 'Orang Tua',
    },
    {
      'value': 1,
      'label': 'Sewa',
    }
  ];
  final List<Map<String, dynamic>> listMelunasiCicilan = [
    {
      'value': 2,
      'label': 'Mengandalkan Usaha Utama',
    },
    {
      'value': 1,
      'label': 'Mengandalkan Usaha Sampingan',
    },
    {'value': 3, 'label': 'Dua duanya'}
  ];
  final List<Map<String, dynamic>> listKondisiBisnis = [
    {
      'value': 2,
      'label': 'Omzet menurun dalam 2 bulan terakhir',
    },
    {
      'value': 3,
      'label': 'Flat seperti biasanya',
    },
    {
      'value': 4,
      'label': 'Ada peningkatan Omzet dalam 2 bulan terakhir',
    },
    {'value': 1, 'label': 'Sedang tidak baik – baik saja'}
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
              const Text(
                "Kondisi",
                style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 20,
                    fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                height: 20,
              ),
              CustomWidgets.textField('Apa pekerjaan anda?',
                  textController: _pekerjaanController,
                  lines: 1,
                  cornerRadius: 10.0),
              const SizedBox(
                height: 20,
              ),
              CustomWidgets.textField(
                  'Sudah berapa lama anda bekerja? (untuk posisi ini, cth: 1 bulan atau 1 Tahun)',
                  textController: _lamaBekerjaController,
                  lines: 1,
                  cornerRadius: 10.0),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Apakah anda memiliki usaha atau bisnis sampingan?",
                style: TextStyle(
                  fontSize: 18,
                  color: Color(0xff355070),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              ListTile(
                title: const Text(
                  "Ya",
                  style: TextStyle(color: Color(0xff355070)),
                ),
                leading: Radio(
                    value: "1",
                    groupValue: sampingan,
                    onChanged: (value) {
                      setState(() {
                        sampingan = value.toString();
                      });
                    }),
              ),
              ListTile(
                title: const Text(
                  "Tidak",
                  style: TextStyle(color: Color(0xff355070)),
                ),
                leading: Radio(
                    value: "0",
                    groupValue: sampingan,
                    onChanged: (value) {
                      setState(() {
                        sampingan = value.toString();
                      });
                    }),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Untuk pekerjaan anda sekarang, status anda adalah karyawan tetap?",
                style: TextStyle(
                  fontSize: 18,
                  color: Color(0xff355070),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              ListTile(
                title: const Text(
                  "Karyawan Tetap",
                  style: TextStyle(color: Color(0xff355070)),
                ),
                leading: Radio(
                    value: "2",
                    groupValue: karyawan,
                    onChanged: (value) {
                      setState(() {
                        karyawan = value.toString();
                      });
                    }),
              ),
              ListTile(
                title: const Text(
                  "Karyawan Kontrak",
                  style: TextStyle(color: Color(0xff355070)),
                ),
                leading: Radio(
                    value: "1",
                    groupValue: karyawan,
                    onChanged: (value) {
                      setState(() {
                        karyawan = value.toString();
                      });
                    }),
              ),
              const SizedBox(
                height: 20,
              ),
              CustomWidgets.textField('Apa nama usaha yang dijalankan?',
                  textController: _usahaController,
                  lines: 1,
                  cornerRadius: 10.0),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Usaha anda bergerak di bidang apa (untuk anda yang memiliki bisnis sendiri)?",
                style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontFamily: 'Oppen-sans',
                    color: Color(0xff355070),
                    fontSize: 18),
              ),
              const SizedBox(
                height: 10,
              ),
              SelectFormField(
                decoration: InputDecoration(
                    suffixIcon: Icon(Icons.expand_more),
                    hintText: 'Pilih Bidang Bisnis Anda',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10))),
                type: SelectFormFieldType.dropdown,
                items: listBisnis,
                controller: _bisnisController,
              ),
              const SizedBox(
                height: 20,
              ),
              CustomWidgets.textField(
                'Berapa jumlah karyawan atau tenaga kerja yang membantu anda (untuk yang memiliki usaha sendiri)?',
                textController: _jumlahKaryawanController,
                lines: 1,
                cornerRadius: 10.0,
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Berapa pendapatan anda dalam satu bulan?",
                style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontFamily: 'Oppen-sans',
                    color: Color(0xff355070),
                    fontSize: 18),
              ),
              const SizedBox(
                height: 10,
              ),
              SelectFormField(
                decoration: InputDecoration(
                    suffixIcon: Icon(Icons.expand_more),
                    hintText: 'Pilih Pendapatan Anda dalam 1 Bulan',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10))),
                type: SelectFormFieldType.dropdown,
                items: listPendapatan,
                controller: _pendapatanController,
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                "Berapa penghasilan tambahan anda dari usaha sampingan ? (jika ada)",
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
                controller: _pendapatanTambahanController,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  CurrencyPtBrInputFormatter()
                ],
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    hintText: "Tuliskan penghasilan tambahan Anda"),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Apakah pasangan anda juga bekerja (memiliki penghasilan tetap)?",
                style: TextStyle(
                  fontSize: 18,
                  color: Color(0xff355070),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              ListTile(
                title: const Text(
                  "Ya",
                  style: TextStyle(color: Color(0xff355070)),
                ),
                leading: Radio(
                    value: "1",
                    groupValue: pasanganBekerja,
                    onChanged: (value) {
                      setState(() {
                        pasanganBekerja = value.toString();
                      });
                    }),
              ),
              ListTile(
                title: const Text(
                  "Tidak",
                  style: TextStyle(color: Color(0xff355070)),
                ),
                leading: Radio(
                    value: "0",
                    groupValue: pasanganBekerja,
                    onChanged: (value) {
                      setState(() {
                        pasanganBekerja = value.toString();
                      });
                    }),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Berapa pendapatan pasangan anda (jika pasangan anda memiliki penghasilan tetap)?",
                style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontFamily: 'Oppen-sans',
                    color: Color(0xff355070),
                    fontSize: 18),
              ),
              const SizedBox(
                height: 10,
              ),
              SelectFormField(
                decoration: InputDecoration(
                    suffixIcon: Icon(Icons.expand_more),
                    hintText: 'Pilih Pendapatan Pasangan Anda dalam 1 Bulan',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10))),
                type: SelectFormFieldType.dropdown,
                items: listPendapatanPasangan,
                controller: _pendapatanPasanganController,
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Apakah memiliki aset lain seperti warisan, tanah, simpanan berjangka, dan lain-lain?",
                style: TextStyle(
                  fontSize: 18,
                  color: Color(0xff355070),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              ListTile(
                title: const Text(
                  "Ya",
                  style: TextStyle(color: Color(0xff355070)),
                ),
                leading: Radio(
                    value: "1",
                    groupValue: asset,
                    onChanged: (value) {
                      setState(() {
                        asset = value.toString();
                      });
                    }),
              ),
              ListTile(
                title: const Text(
                  "Tidak",
                  style: TextStyle(color: Color(0xff355070)),
                ),
                leading: Radio(
                    value: "0",
                    groupValue: asset,
                    onChanged: (value) {
                      setState(() {
                        asset = value.toString();
                      });
                    }),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Apakah anda mempunyai cicilan di lain tempat? (KPR, Bank dll.)",
                style: TextStyle(
                  fontSize: 18,
                  color: Color(0xff355070),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              ListTile(
                title: const Text(
                  "Ya",
                  style: TextStyle(color: Color(0xff355070)),
                ),
                leading: Radio(
                    value: "0",
                    groupValue: cicilan,
                    onChanged: (value) {
                      setState(() {
                        cicilan = value.toString();
                      });
                    }),
              ),
              ListTile(
                title: const Text(
                  "Tidak",
                  style: TextStyle(color: Color(0xff355070)),
                ),
                leading: Radio(
                    value: "1",
                    groupValue: cicilan,
                    onChanged: (value) {
                      setState(() {
                        cicilan = value.toString();
                      });
                    }),
              ),
              const SizedBox(
                height: 20,
              ),
              CustomWidgets.textField(
                'Berapa Jumlah Tanggungan anda?',
                textController: _tanggunganController,
                lines: 1,
                isNumber: true,
                cornerRadius: 10.0,
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Keadaan tempat tinggal sekarang",
                style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontFamily: 'Oppen-sans',
                    color: Color(0xff355070),
                    fontSize: 18),
              ),
              const SizedBox(
                height: 10,
              ),
              SelectFormField(
                decoration: InputDecoration(
                    suffixIcon: Icon(Icons.expand_more),
                    hintText: 'Pilih Keadaan Tempat Tinggal',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10))),
                type: SelectFormFieldType.dropdown,
                items: listTempatTinggal,
                controller: _tempatTinggalController,
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Bagaimana Rencana Anda untuk Melunasi Cicilan?",
                style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontFamily: 'Oppen-sans',
                    color: Color(0xff355070),
                    fontSize: 18),
              ),
              const SizedBox(
                height: 10,
              ),
              SelectFormField(
                decoration: InputDecoration(
                    suffixIcon: Icon(Icons.expand_more),
                    hintText: 'Pilih Rencana Anda untuk Melunasi Cicilan',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10))),
                type: SelectFormFieldType.dropdown,
                items: listMelunasiCicilan,
                controller: _melunasiCicilanController,
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Jika Anda Mempunyai bisnis Bagaimana Kondisi Bisnis Anda Sekarang?",
                style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontFamily: 'Oppen-sans',
                    color: Color(0xff355070),
                    fontSize: 18),
              ),
              const SizedBox(
                height: 10,
              ),
              SelectFormField(
                decoration: InputDecoration(
                    suffixIcon: Icon(Icons.expand_more),
                    hintText: 'Pilih Kondisi Bisnis Anda',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10))),
                type: SelectFormFieldType.dropdown,
                items: listKondisiBisnis,
                controller: _kondisiBisnisController,
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
            ? () {
                setState(() {
                  isButtonActive = true;
                });
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Kredit3(
                            valuePenggunaanKredit: widget.valuePenggunaanKredit,
                            valueBesarPengajuan: widget.valueBesarPengajuan,
                            valueTenor: widget.valueTenor,
                            valuePekerjaan: _pekerjaanController.text,
                            valueLamaBekerja: _lamaBekerjaController.text,
                            valueUsaha: _usahaController.text,
                            valueBisnis: _bisnisController.text,
                            valueJumlahKaryawan: _jumlahKaryawanController.text,
                            valuePendapatan: _pendapatanController.text,
                            valuePendapatanTambahan:
                                _pendapatanTambahanController.text,
                            valuePendapatanPasangan:
                                _pendapatanPasanganController.text,
                            valueTanggungan: _tanggunganController.text,
                            valueTempatTinggal: _tempatTinggalController.text,
                            valueMelunasiCicilan:
                                _melunasiCicilanController.text,
                            valueKondisiBisnis: _kondisiBisnisController.text,
                            valueSampingan: sampingan,
                            valueKaryawan: karyawan,
                            valuePasanganBekerja: pasanganBekerja,
                            valueAsset: asset,
                            valueCicilan: cicilan,
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
