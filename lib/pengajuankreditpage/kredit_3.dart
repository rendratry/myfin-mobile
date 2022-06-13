import 'package:flutter/material.dart';
import 'package:select_form_field/select_form_field.dart';
import './kredit_4.dart';

class Kredit3 extends StatefulWidget {
  final String valuePenggunaanKredit;
  final String valueBesarPengajuan;
  final String valueTenor;
  final String valuePekerjaan;
  final String valueLamaBekerja;
  final String valueUsaha;
  final String valueBisnis;
  final String valueJumlahKaryawan;
  final String valuePendapatan;
  final String valuePendapatanTambahan;
  final String valuePendapatanPasangan;
  final String valueTanggungan;
  final String valueTempatTinggal;
  final String valueMelunasiCicilan;
  final String valueKondisiBisnis;
  final String valueSampingan;
  final String valueKaryawan;
  final String valuePasanganBekerja;
  final String valueAsset;
  final String valueCicilan;

  Kredit3({
    Key? key,
    required this.valuePenggunaanKredit,
    required this.valueBesarPengajuan,
    required this.valueTenor,
    required this.valuePekerjaan,
    required this.valueLamaBekerja,
    required this.valueUsaha,
    required this.valueBisnis,
    required this.valueJumlahKaryawan,
    required this.valuePendapatan,
    required this.valuePendapatanTambahan,
    required this.valuePendapatanPasangan,
    required this.valueTanggungan,
    required this.valueTempatTinggal,
    required this.valueMelunasiCicilan,
    required this.valueKondisiBisnis,
    required this.valueSampingan,
    required this.valueKaryawan,
    required this.valuePasanganBekerja,
    required this.valueAsset,
    required this.valueCicilan,
  }) : super(key: key);

  @override
  State<Kredit3> createState() => _Kredit3State();
}

class _Kredit3State extends State<Kredit3> {
  late TextEditingController _hubunganKeluargaController =
      TextEditingController();
  late TextEditingController _hubunganSosialController =
      TextEditingController();
  late TextEditingController _memilihAplikasiController =
      TextEditingController();
  bool isButtonActive = false;

  @override
  void initState() {
    super.initState();
    _hubunganKeluargaController = TextEditingController();
    _hubunganSosialController = TextEditingController();
    _memilihAplikasiController = TextEditingController();

    _hubunganKeluargaController.addListener(() {
      final isButtonActive = _hubunganKeluargaController.text.isNotEmpty &&
          _hubunganSosialController.text.isNotEmpty &&
          _memilihAplikasiController.text.isNotEmpty;
      setState(() => this.isButtonActive = isButtonActive);
    });

    _hubunganSosialController.addListener(() {
      final isButtonActive = _hubunganKeluargaController.text.isNotEmpty &&
          _hubunganSosialController.text.isNotEmpty &&
          _memilihAplikasiController.text.isNotEmpty;
      setState(() => this.isButtonActive = isButtonActive);
    });

    _memilihAplikasiController.addListener(() {
      final isButtonActive = _hubunganKeluargaController.text.isNotEmpty &&
          _hubunganSosialController.text.isNotEmpty &&
          _memilihAplikasiController.text.isNotEmpty;
      setState(() => this.isButtonActive = isButtonActive);
    });
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    _hubunganKeluargaController.dispose();
    _hubunganSosialController.dispose();
    _memilihAplikasiController.dispose();
    super.dispose();
  }

  final List<Map<String, dynamic>> listHubunganKeluarga = [
    {
      'value': 3,
      'label': 'Selalu Berkumpul Setiap Hari',
    },
    {
      'value': 2,
      'label': 'Bertemu Seminggu Sekali',
    },
    {'value': 1, 'label': 'Bertemu Beberapa Bulan/Tahun Sekali'}
  ];
  final List<Map<String, dynamic>> listHubunganSosial = [
    {
      'value': 2,
      'label': 'Saling Rukun',
    },
    {
      'value': 1,
      'label': 'Individualis',
    },
  ];
  final List<Map<String, dynamic>> listMemilihAplikasi = [
    {
      'value': 1,
      'label': 'Aman',
    },
    {
      'value': 1,
      'label': 'Bunga Ringan',
    },
    {
      'value': 2,
      'label': 'Sudah Pernah Meminjam Sebelumnya',
    },
    {
      'value': 1,
      'label': 'Lainnya',
    },
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
                "Hubungan",
                style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 20,
                    fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Gimana hubungan kamu dengan keluarga di rumah?",
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
                    hintText: 'Pilih Hubungan Keluarga Anda',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10))),
                type: SelectFormFieldType.dropdown,
                items: listHubunganKeluarga,
                controller: _hubunganKeluargaController,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Bagaimana anda menjalin hubungan dengan orang-orang disekitar anda?",
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
                    hintText: 'Pilih Hubungan Sosial Anda',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10))),
                type: SelectFormFieldType.dropdown,
                items: listHubunganSosial,
                controller: _hubunganSosialController,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Apa motivasi anda memilih aplikasi kami sebagai sarana pinjaman?",
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
                    hintText: 'Pilih Alasan Anda',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10))),
                type: SelectFormFieldType.dropdown,
                items: listMemilihAplikasi,
                controller: _memilihAplikasiController,
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
                      builder: (context) => Kredit4(
                            valuePenggunaanKredit: widget.valuePenggunaanKredit,
                            valueBesarPengajuan: widget.valueBesarPengajuan,
                            valueTenor: widget.valueTenor,
                            valuePekerjaan: widget.valuePekerjaan,
                            valueLamaBekerja: widget.valueLamaBekerja,
                            valueUsaha: widget.valueUsaha,
                            valueBisnis: widget.valueBisnis,
                            valueJumlahKaryawan: widget.valueJumlahKaryawan,
                            valuePendapatan: widget.valuePendapatan,
                            valuePendapatanTambahan:
                                widget.valuePendapatanTambahan,
                            valuePendapatanPasangan:
                                widget.valuePendapatanPasangan,
                            valueTanggungan: widget.valueTanggungan,
                            valueTempatTinggal: widget.valueTempatTinggal,
                            valueMelunasiCicilan: widget.valueMelunasiCicilan,
                            valueKondisiBisnis: widget.valueKondisiBisnis,
                            valueHubunganKeluarga:
                                _hubunganKeluargaController.text,
                            valueHubunganSosial: _hubunganSosialController.text,
                            valueMemilihAplikasi:
                                _memilihAplikasiController.text,
                            valueSampingan: widget.valueSampingan,
                            valueKaryawan: widget.valueKaryawan,
                            valuePasanganBekerja: widget.valuePasanganBekerja,
                            valueAsset: widget.valueAsset,
                            valueCicilan: widget.valueCicilan,
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
