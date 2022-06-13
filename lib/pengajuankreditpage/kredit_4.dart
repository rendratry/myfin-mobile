import 'package:flutter/material.dart';
import './kredit_5.dart';

class Kredit4 extends StatefulWidget {
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
  final String valueHubunganKeluarga;
  final String valueHubunganSosial;
  final String valueMemilihAplikasi;
  final String valueSampingan;
  final String valueKaryawan;
  final String valuePasanganBekerja;
  final String valueAsset;
  final String valueCicilan;

  const Kredit4({
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
    required this.valueHubunganKeluarga,
    required this.valueHubunganSosial,
    required this.valueMemilihAplikasi,
    required this.valueSampingan,
    required this.valueKaryawan,
    required this.valuePasanganBekerja,
    required this.valueAsset,
    required this.valueCicilan,
  }) : super(key: key);

  @override
  State<Kredit4> createState() => _Kredit4State();
}

class _Kredit4State extends State<Kredit4> {
  late String pernahHutang = '';
  late String kesulitanHutang = '';
  late String melibatkanOrangLain = '';
  late String terlambatMembayar = '';
  late String hutangBank = '';
  late String hutangPlatformLain = '';

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
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Karakter",
                style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 20,
                    fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Apakah Anda Pernah Berhutang?",
                style: TextStyle(
                  fontSize: 18,
                  color: Color(0xff355070),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              ListTile(
                title: const Text("Sering",
                    style: TextStyle(color: Color(0xff355070))),
                leading: Radio(
                    value: "1",
                    groupValue: pernahHutang,
                    onChanged: (value) {
                      setState(() {
                        pernahHutang = value.toString();
                      });
                    }),
              ),
              ListTile(
                title: const Text("Kadang - Kadang",
                    style: TextStyle(color: Color(0xff355070))),
                leading: Radio(
                    value: "2",
                    groupValue: pernahHutang,
                    onChanged: (value) {
                      setState(() {
                        pernahHutang = value.toString();
                      });
                    }),
              ),
              ListTile(
                title: const Text("Tidak Pernah",
                    style: TextStyle(color: Color(0xff355070))),
                leading: Radio(
                    value: "3",
                    groupValue: pernahHutang,
                    onChanged: (value) {
                      setState(() {
                        pernahHutang = value.toString();
                      });
                    }),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Apakah anda pernah mengalami kesulitan dalam membayar hutang?",
                style: TextStyle(fontSize: 18, color: Color(0xff355070)),
              ),
              const SizedBox(
                height: 10,
              ),
              ListTile(
                title: const Text("Sering",
                    style: TextStyle(color: Color(0xff355070))),
                leading: Radio(
                    value: "1",
                    groupValue: kesulitanHutang,
                    onChanged: (value) {
                      setState(() {
                        kesulitanHutang = value.toString();
                      });
                    }),
              ),
              ListTile(
                title: const Text("Kadang - Kadang",
                    style: TextStyle(color: Color(0xff355070))),
                leading: Radio(
                    value: "2",
                    groupValue: kesulitanHutang,
                    onChanged: (value) {
                      setState(() {
                        kesulitanHutang = value.toString();
                      });
                    }),
              ),
              ListTile(
                title: const Text("Tidak Pernah",
                    style: TextStyle(color: Color(0xff355070))),
                leading: Radio(
                    value: "3",
                    groupValue: kesulitanHutang,
                    onChanged: (value) {
                      setState(() {
                        kesulitanHutang = value.toString();
                      });
                    }),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Apakah anda pernah melibatkan orang lain dalam membayar hutang?",
                style: TextStyle(
                  fontSize: 18,
                  color: Color(0xff355070),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              ListTile(
                title: const Text("Sering",
                    style: TextStyle(color: Color(0xff355070))),
                leading: Radio(
                    value: "1",
                    groupValue: melibatkanOrangLain,
                    onChanged: (value) {
                      setState(() {
                        melibatkanOrangLain = value.toString();
                      });
                    }),
              ),
              ListTile(
                title: const Text("Kadang - Kadang",
                    style: TextStyle(color: Color(0xff355070))),
                leading: Radio(
                    value: "2",
                    groupValue: melibatkanOrangLain,
                    onChanged: (value) {
                      setState(() {
                        melibatkanOrangLain = value.toString();
                      });
                    }),
              ),
              ListTile(
                title: const Text("Tidak Pernah",
                    style: TextStyle(color: Color(0xff355070))),
                leading: Radio(
                    value: "3",
                    groupValue: melibatkanOrangLain,
                    onChanged: (value) {
                      setState(() {
                        melibatkanOrangLain = value.toString();
                      });
                    }),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Apakah anda pernah terlambat dalam membayar hutang?",
                style: TextStyle(fontSize: 18, color: Color(0xff355070)),
              ),
              const SizedBox(
                height: 10,
              ),
              ListTile(
                title: const Text("Sering",
                    style: TextStyle(color: Color(0xff355070))),
                leading: Radio(
                    value: "1",
                    groupValue: terlambatMembayar,
                    onChanged: (value) {
                      setState(() {
                        terlambatMembayar = value.toString();
                      });
                    }),
              ),
              ListTile(
                title: const Text("Kadang - Kadang",
                    style: TextStyle(color: Color(0xff355070))),
                leading: Radio(
                    value: "2",
                    groupValue: terlambatMembayar,
                    onChanged: (value) {
                      setState(() {
                        terlambatMembayar = value.toString();
                      });
                    }),
              ),
              ListTile(
                title: const Text("Tidak Pernah",
                    style: TextStyle(color: Color(0xff355070))),
                leading: Radio(
                    value: "3",
                    groupValue: terlambatMembayar,
                    onChanged: (value) {
                      setState(() {
                        terlambatMembayar = value.toString();
                      });
                    }),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Apakah anda pernah berhutang di bank konvensional?",
                style: TextStyle(fontSize: 18, color: Color(0xff355070)),
              ),
              const SizedBox(
                height: 10,
              ),
              ListTile(
                title: const Text("Sering",
                    style: TextStyle(color: Color(0xff355070))),
                leading: Radio(
                    value: "1",
                    groupValue: hutangBank,
                    onChanged: (value) {
                      setState(() {
                        hutangBank = value.toString();
                      });
                    }),
              ),
              ListTile(
                title: const Text("Kadang - Kadang",
                    style: TextStyle(color: Color(0xff355070))),
                leading: Radio(
                    value: "2",
                    groupValue: hutangBank,
                    onChanged: (value) {
                      setState(() {
                        hutangBank = value.toString();
                      });
                    }),
              ),
              ListTile(
                title: const Text("Tidak Pernah",
                    style: TextStyle(color: Color(0xff355070))),
                leading: Radio(
                    value: "3",
                    groupValue: hutangBank,
                    onChanged: (value) {
                      setState(() {
                        hutangBank = value.toString();
                      });
                    }),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Apakah anda pernah berhutang di platform lain?",
                style: TextStyle(
                  fontSize: 18,
                  color: Color(0xff355070),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              ListTile(
                title: const Text("Sering",
                    style: TextStyle(color: Color(0xff355070))),
                leading: Radio(
                    value: "1",
                    groupValue: hutangPlatformLain,
                    onChanged: (value) {
                      setState(() {
                        hutangPlatformLain = value.toString();
                      });
                    }),
              ),
              ListTile(
                title: const Text("Kadang - Kadang",
                    style: TextStyle(color: Color(0xff355070))),
                leading: Radio(
                    value: "2",
                    groupValue: hutangPlatformLain,
                    onChanged: (value) {
                      setState(() {
                        hutangPlatformLain = value.toString();
                      });
                    }),
              ),
              ListTile(
                title: const Text("Tidak Pernah",
                    style: TextStyle(color: Color(0xff355070))),
                leading: Radio(
                    value: "3",
                    groupValue: hutangPlatformLain,
                    onChanged: (value) {
                      setState(() {
                        hutangPlatformLain = value.toString();
                      });
                    }),
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
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Kredit5(
                      valuePenggunaanKredit: widget.valuePenggunaanKredit,
                      valueBesarPengajuan: widget.valueBesarPengajuan,
                      valueTenor: widget.valueTenor,
                      valuePekerjaan: widget.valuePekerjaan,
                      valueLamaBekerja: widget.valueLamaBekerja,
                      valueUsaha: widget.valueUsaha,
                      valueBisnis: widget.valueBisnis,
                      valueJumlahKaryawan: widget.valueJumlahKaryawan,
                      valuePendapatan: widget.valuePendapatan,
                      valuePendapatanTambahan: widget.valuePendapatanTambahan,
                      valuePendapatanPasangan: widget.valuePendapatanPasangan,
                      valueTanggungan: widget.valueTanggungan,
                      valueTempatTinggal: widget.valueTempatTinggal,
                      valueMelunasiCicilan: widget.valueMelunasiCicilan,
                      valueKondisiBisnis: widget.valueKondisiBisnis,
                      valueHubunganKeluarga: widget.valueHubunganKeluarga,
                      valueHubunganSosial: widget.valueHubunganSosial,
                      valueMemilihAplikasi: widget.valueMemilihAplikasi,
                      valueSampingan: widget.valueSampingan,
                      valueKaryawan: widget.valueKaryawan,
                      valuePasanganBekerja: widget.valuePasanganBekerja,
                      valueAsset: widget.valueAsset,
                      valueCicilan: widget.valueCicilan,
                      valuePernahHutang: pernahHutang,
                      valueKesulitanHutang: kesulitanHutang,
                      valueMelibatkanOrangLain: melibatkanOrangLain,
                      valueTerlambatMembayar: terlambatMembayar,
                      valueHutangBank: hutangBank,
                      valueHutangPlatformLain: hutangPlatformLain,
                    )),
          );
        },
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
    // return RawMaterialButton(
    //   onPressed: () {
    //     Navigator.push(
    //       context,
    //       MaterialPageRoute(
    //           builder: (context) => Kredit5(
    //                 valuePenggunaanKredit: widget.valuePenggunaanKredit,
    //                 valueBesarPengajuan: widget.valueBesarPengajuan,
    //                 valueTenor: widget.valueTenor,
    //                 valuePekerjaan: widget.valuePekerjaan,
    //                 valueLamaBekerja: widget.valueLamaBekerja,
    //                 valueUsaha: widget.valueUsaha,
    //                 valueBisnis: widget.valueBisnis,
    //                 valueJumlahKaryawan: widget.valueJumlahKaryawan,
    //                 valuePendapatan: widget.valuePendapatan,
    //                 valuePendapatanTambahan: widget.valuePendapatanTambahan,
    //                 valuePendapatanPasangan: widget.valuePendapatanPasangan,
    //                 valueTanggungan: widget.valueTanggungan,
    //                 valueTempatTinggal: widget.valueTempatTinggal,
    //                 valueMelunasiCicilan: widget.valueMelunasiCicilan,
    //                 valueKondisiBisnis: widget.valueKondisiBisnis,
    //                 valueHubunganKeluarga: widget.valueHubunganKeluarga,
    //                 valueHubunganSosial: widget.valueHubunganSosial,
    //                 valueMemilihAplikasi: widget.valueMemilihAplikasi,
    //                 valueSampingan: widget.valueSampingan,
    //                 valueKaryawan: widget.valueKaryawan,
    //                 valuePasanganBekerja: widget.valuePasanganBekerja,
    //                 valueAsset: widget.valueAsset,
    //                 valueCicilan: widget.valueCicilan,
    //                 valuePernahHutang: pernahHutang,
    //                 valueKesulitanHutang: kesulitanHutang,
    //                 valueMelibatkanOrangLain: melibatkanOrangLain,
    //                 valueTerlambatMembayar: terlambatMembayar,
    //                 valueHutangBank: hutangBank,
    //                 valueHutangPlatformLain: hutangPlatformLain,
    //               )),
    //     );
    //   },
    //   fillColor: const Color.fromRGBO(53, 80, 112, 1),
    //   constraints: const BoxConstraints(minHeight: 49, minWidth: 128),
    //   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    //   textStyle: const TextStyle(
    //     color: Colors.white,
    //     fontFamily: 'Poppins',
    //     fontSize: 15,
    //     fontWeight: FontWeight.w500,
    //   ),
    //   child: const Text('Lanjutkan'),
    // );
  }
}
