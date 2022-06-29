import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:screenshot/screenshot.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../currency.dart';
import '../refresh_widget.dart';

class DetailTransaksi extends StatefulWidget {
  const DetailTransaksi({Key? key}) : super(key: key);

  @override
  State<DetailTransaksi> createState() => _DetailTransaksiState();
}

class _DetailTransaksiState extends State<DetailTransaksi> {

  final keyRefresh = GlobalKey<RefreshIndicatorState>();

  String? idTransaksi;
  String? Nominal;
  String? Tanggal;
  String? Status;
  int? transaksi;
  String? Catatan;
  Color? StatusColor;

  String get displayIdTransaksi => idTransaksi.toString();

  String get displayNominal => Nominal.toString();

  String get displayStatus => Status.toString();

  String get displayTanggal => Tanggal.toString();


  @override
  void initState() {
    super.initState();

    loadList();
  }

  Future loadList() async {
    keyRefresh.currentState?.show();
    await Future.delayed(const Duration(milliseconds: 50));

    SharedPreferences idNasabah = await SharedPreferences.getInstance();
    String? idTransaksi = idNasabah.getString('idTransaksi');
    SharedPreferences TanggalTransaksi = await SharedPreferences.getInstance();
    String? Tanggal = TanggalTransaksi.getString('TanggalTransaksi');
    SharedPreferences NominalTransaksi = await SharedPreferences.getInstance();
    String? Nominal = NominalTransaksi.getString('Nominal');
    SharedPreferences StatusTransaksi = await SharedPreferences.getInstance();
    String? Status = StatusTransaksi.getString('statusTransaksi');
    SharedPreferences CatatanTransaksi = await SharedPreferences.getInstance();
    String? Catatan = CatatanTransaksi.getString('Catatan');

    setState(() => this.idTransaksi = idTransaksi);
    setState(() => this.Nominal = Nominal);
    setState(() => this.Tanggal = Tanggal);
    setState(() => this.Status = Status);
    setState(() => this.Catatan = Catatan);
  }
  final controller = ScreenshotController();
  Future<String> saveImage(Uint8List bytes) async {
    await [Permission.storage].request();

    final time = DateTime.now()
        .toIso8601String()
        .replaceAll('.', '_')
        .replaceAll(':', '_');
    final name = 'hasil_$time';
    final result = await ImageGallerySaver.saveImage(bytes, name: name);
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('Berhasil Menyimpan Ke Galeri'),
    ));
    if (kDebugMode) {
      print("Berhasil Menyimpan Ke Galeri");
    }
    return result['filePath'];
  }

  @override
  Widget build(BuildContext context) {
    var displayStatusColor;
    if(Status.toString()=="ditolak"){
      displayStatusColor = Color(0xffff0033);
    }else{
      displayStatusColor = Color(0xff01D47C);
    }
    setState(() => this.StatusColor = displayStatusColor);
    var displayIdTransaksi = idTransaksi.toString();
    var displayNominal = Nominal.toString();
    var displayTanggal = Tanggal.toString();
    var displayStatus = Status.toString();
    var displayCatatan = Catatan.toString();
    return idTransaksi == null?  Center(
      child: Lottie.network('https://assets4.lottiefiles.com/packages/lf20_b88nh30c.json',
        width: 150,
        height: 150,
      ),): RefreshWidget(
      keyRefresh: keyRefresh,
      onRefresh: loadList,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: SvgPicture.asset(
                'assets/svg/arrow_left.svg',
                color: const Color(0xff355070),
                height: 30,
                width: 30,
              )),
          title: const Text(
            "Detail Transaksi",
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: Color(0xff355070),
            ),
          ),
          centerTitle: true,
        ),
        body: Container(
          color: const Color.fromRGBO(227, 227, 254, 0.39),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Container(
                      color: Colors.transparent,
                      height: 215,
                      child: Image.asset(
                        'assets/png/detailtransaksi.png',
                        fit: BoxFit.none,
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20))),
                  child: ListView(children: [
                    Container(
                      padding: const EdgeInsets.only(top: 45, left: 39, right: 39),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Jenis Transaksi",
                              style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 11,
                                  color: Color(0xff757575)),
                            ),
                            Text(
                              "Pengajuan Kredit",
                              style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600),
                            ),
                            SizedBox(height: 10),
                            Text("ID Transaksi",
                                style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 11,
                                    color: Color(0xff757575))),
                            Text(displayIdTransaksi,
                                style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600)),
                            SizedBox(height: 10),
                            Text("Nominal",
                                style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 11,
                                    color: Color(0xff757575))),
                            Text(displayNominal,
                                style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600)),
                            SizedBox(height: 10),
                            Text("Status",
                                style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 11,
                                    color: Color(0xff757575))),
                            Text(displayStatus,
                                style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: displayStatusColor)),
                            SizedBox(height: 10),
                            Text("Tanggal",
                                style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 11,
                                    color: Color(0xff757575))),
                            Text(displayTanggal,
                                style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600)),
                            SizedBox(height: 10),
                            Text("Catatan",
                                style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 11,
                                    color: Color(0xff757575))),
                            Text(displayCatatan,
                                style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600)),
                            SizedBox(
                              height: 31,
                            ),
                          ]),
                    ),
                    Center(
                      child: ConstrainedBox(
                        constraints:
                        const BoxConstraints.tightFor(height: 49, width: 279),
                        child: ElevatedButton(
                          onPressed: () async {
                            final image = await controller.captureFromWidget(
                                buildImage(),
                                delay: const Duration(milliseconds: 10));

                            await saveImage(image);
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(
                                Icons.print,
                                color: Color(0xff4E6682),
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              Text(
                                "Download Bukti",
                                style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xff4E6682)),
                              ),
                            ],
                          ),
                          style: ButtonStyle(
                            backgroundColor:
                            MaterialStateProperty.all(Colors.white),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                side: const BorderSide(
                                    color: Color(0xff4E6682), width: 2),
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  ]),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  static const colorF = Colors.black;

  Widget buildImage() => Container(
    color: const Color(0xFFE3E3FE),
    child: Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Container(
                color: Colors.transparent,
                height: 215,
                child: Image.asset(
                  'assets/png/detailtransaksi.png',
                  fit: BoxFit.none,
                ),
              ),
            ),
          ],
        ),
        Expanded(
          child: Container(
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20))),
            child: ListView(children: [
              Container(
                padding: const EdgeInsets.only(top: 45, left: 39, right: 39),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Jenis Transaksi",
                            style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 11,
                                color: Color(0xff757575)),
                          ),
                          Image.asset(
                            'assets/png/logobaru.png',
                            height: 40,
                            width: 100,
                            //fit: BoxFit.none,
                          )
                        ],
                      ),
                      const Text(
                        "Pengajuan Kredit",
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            color: colorF,
                            fontSize: 14,
                            fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 10),
                      const Text("ID Transaksi",
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 11,
                              color: Color(0xff757575))),
                      Text(displayIdTransaksi,
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              color: colorF,
                              fontSize: 14,
                              fontWeight: FontWeight.w600)),
                      const SizedBox(height: 10),
                      const Text("Nominal",
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 11,
                              color: Color(0xff757575))),
                      Text(displayNominal,
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              color: colorF,
                              fontSize: 14,
                              fontWeight: FontWeight.w600)),
                      const SizedBox(height: 10),
                      const Text("Status",
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 11,
                              color: Color(0xff757575))),
                      Text(displayStatus,
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: StatusColor)),
                      const SizedBox(height: 10),
                      const Text("Tanggal",
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 11,
                              color: Color(0xff757575))),
                      Text(displayTanggal,
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              color: colorF,
                              fontSize: 14,
                              fontWeight: FontWeight.w600)),
                      const SizedBox(height: 10),
                      const Text("Catatan",
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 11,
                              color: Color(0xff757575))),
                      Text(Catatan.toString(),
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              color: colorF,
                              fontSize: 14,
                              fontWeight: FontWeight.w600)),
                      const SizedBox(
                        height: 31,
                      ),
                    ]),
              ),
            ]),
          ),
        )
      ],
    ),
  );
}
