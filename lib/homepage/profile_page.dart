import 'dart:convert';
import 'dart:io';
import 'dart:io' as io;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:Myfin/datadiripage/data_diri.dart';
import 'package:Myfin/homepage/profile_model.dart';
import 'package:Myfin/loginpage/login_screen.dart';
import 'package:Myfin/pertanyaankeamananpage/pertanyaan.dart';
import 'package:Myfin/ubahpinpage/pin_lama.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../alertsucces.dart';
import '../loading.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:path/path.dart';
import '../refresh_widget.dart';
import 'package:http/http.dart' as http;

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  final keyRefresh = GlobalKey<RefreshIndicatorState>();

  String? email;
  String? nama;
  String? ava;
  String? nohp;
  String? alamat;
  String? nik;
  String? verifstatus;
  int? statuscolorTrue;
  int? statuscolorFalse;

  @override
  void initState() {
    super.initState();

    loadList();
  }


  Future<bool?> getProfile(int id) async {
    SharedPreferences server = await SharedPreferences.getInstance();
    String? baseUrl = server.getString('server');

    var stringId = id.toString();

    var response = await http.get(
      Uri.https(baseUrl!, 'api/profile/'+stringId),
      headers: {
        'X-API-Key': "myfin",
        'Accept': "application/json",
      },
    );
    var data = response.body;
    print(data);
    print(response.statusCode)
    ;

    if (response.statusCode == 200) {
      var decodeId = ProfileModel.fromJson(jsonDecode(response.body));
      String profilNama = decodeId.data.nama;
      String profilEmail = decodeId.data.email;
      String profilNohp = decodeId.data.noHp;
      String profilNik = decodeId.data.nik;
      String profilAlamat = decodeId.data.alamat;

      SharedPreferences prefsId =
      await SharedPreferences.getInstance();
      await prefsId.setString('profilNama', profilNama);
      await SharedPreferences.getInstance();
      await prefsId.setString('profilEmail', profilEmail);
      await SharedPreferences.getInstance();
      await prefsId.setString('profilNohp', profilNohp);
      await SharedPreferences.getInstance();
      await prefsId.setString('profilNik', profilNik);
      await SharedPreferences.getInstance();
      await prefsId.setString('profilNohp', profilNohp);
      await SharedPreferences.getInstance();
      await prefsId.setString('profilAlamat', profilAlamat);

      return true;
    }else{
      return false;
    }
  }
  Future<bool?> getAva(int id, String ava) async {
    SharedPreferences server = await SharedPreferences.getInstance();
    String? baseUrl = server.getString('server');

    var msg = jsonEncode({"ava":ava});
    var response = await http.put(
        Uri.https(baseUrl!, 'api/ava/'+id.toString()),
        headers: {
          'X-API-Key': "myfin",
          'Accept': "application/json",
        },
        body: msg
    );
    var data = response.body;
    print(data);
    print(response.statusCode)
    ;

    if (response.statusCode == 200) {
      return true;
    }else{
      return false;
    }
  }


  Future loadList() async {
    keyRefresh.currentState?.show();
    await Future.delayed(Duration(milliseconds: 500));

    SharedPreferences idNasabah = await SharedPreferences.getInstance();
    int? id = idNasabah.getInt('idNasabah');

    bool? profile = await getProfile(id!);
    if(profile==true){
      SharedPreferences prefsnama = await SharedPreferences.getInstance();
      String? nama = prefsnama.getString('profilNama');

      SharedPreferences prefsemail = await SharedPreferences.getInstance();
      String? emailid = prefsemail.getString('profilEmail');

      SharedPreferences prefsalamat = await SharedPreferences.getInstance();
      String? alamat = prefsalamat.getString('profilAlamat');

      SharedPreferences prefsnik = await SharedPreferences.getInstance();
      String? nik = prefsnik.getString('profilNik');

      SharedPreferences prefsava = await SharedPreferences.getInstance();
      String? ava = prefsava.getString('ava');

      SharedPreferences prefsnohp = await SharedPreferences.getInstance();
      String? nohp = prefsnohp.getString('profilNohp');
      print(emailid);

      setState(() => this.ava = ava);
      setState(() => this.nama = nama);
      setState(() => this.email = emailid);
      setState(() => this.nohp = nohp);
      setState(() => this.alamat = alamat);
      setState(() => this.nik = nik);
      setState(() => this.statuscolorFalse = 0xffEAAD53);
      setState(() => this.statuscolorTrue = 0xff01D47C);
    }

  }

  File? _profile;
  final picker = ImagePicker();
  Future uploadImageToFirebase() async {
    String fileName = basename(_profile!.path);
    firebase_storage.Reference ref =
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('Avatar')
        .child('/$fileName');

    final metadata = firebase_storage.SettableMetadata(
        contentType: 'image/jpeg',
        customMetadata: {'picked-file-path': fileName});
    firebase_storage.UploadTask uploadTask;
    //late StorageUploadTask uploadTask = firebaseStorageRef.putFile(_imageFile);
    uploadTask = ref.putFile(io.File(_profile!.path), metadata);
    firebase_storage.UploadTask task= await Future.value(uploadTask);
    Future.value(uploadTask).then((value) => {
      print("Upload file path ${value.ref.fullPath}")
    }).onError((error, stackTrace) => {
      print("Upload file path error ${error.toString()} ")
    });

    await uploadTask.whenComplete(() async {
      SharedPreferences idNasabah = await SharedPreferences.getInstance();
      int? id = idNasabah.getInt('idNasabah');
      var urlprofile = await uploadTask.snapshot.ref.getDownloadURL();
      var urlp = urlprofile.toString();
      print('Iki Link E Foto Avatar  $urlp');
      bool? ava = await getAva(id!, urlp);
      if(ava==true){
        print("sukes ganti ava");
      }else{
        print("gagal ganti ava");
      }
      return urlp;
    });

  }

  Future getImage(ImageSource source) async {
    final pickedFile = await picker.pickImage(
      source: source,
      imageQuality: 100,);

    setState(() {
      if (pickedFile != null) {
        _profile = File(pickedFile.path);
        uploadImageToFirebase();
      }
    });
  }

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Wrap(
              children: <Widget>[
                ListTile(
                    leading: const Icon(Icons.photo_library),
                    title: const Text('Gallery'),
                    onTap: () {
                      getImage(ImageSource.gallery);
                      Navigator.of(context).pop();
                    }),
                ListTile(
                  leading: const Icon(Icons.photo_camera),
                  title: const Text('Camera'),
                  onTap: () {
                    getImage(ImageSource.camera);
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    var avaToDisplay;
    if(ava==null){
      ava = "0";
    }if(ava=="0"){
      avaToDisplay = 'https://firebasestorage.googleapis.com/v0/b/myfin-ktp.appspot.com/o/KTP%2Fscaled_image_picker7138079792496807795.jpg?alt=media&token=8de953e4-3a8f-4cb5-bb9a-8dcbdb56ecd0';
    }else{
      avaToDisplay = ava.toString();
    }

    var emailToDisplay;
    if(email==null){
      email = "";
      emailToDisplay = " ";
    }else{
      emailToDisplay = email.toString();
    }

    var colorVerif;
    var verifikasiStatus;
    if(nik=="0"){
      colorVerif = Color(0xffEAAD53);
      verifikasiStatus = "Belum Verifikasi";
    }else{
      colorVerif = Color(0xff01D47C);
      verifikasiStatus = "Verified";
    }

    var namaToDisplay;
    if(nama=="0"){
      nama = "";
      namaToDisplay = email.toString();
    }else {
      namaToDisplay = nama.toString();
    }
    //no hp
    var nohpToDisplay;
    if(nohp=="0"){
      nohp = "";
      nohpToDisplay = "Lengkapi Data Kamu";
    }else {
      nohpToDisplay = nohp.toString();
    }

    var nikToDisplay;
    if(nik=="0"){
      nik = " ";
      nikToDisplay = "-";
    }else {
      nikToDisplay = nik.toString();
    }

    var alamatToDisplay;
    if(alamat=="0"){
      alamat = " ";
      alamatToDisplay = "-";
    }else {
      alamatToDisplay = alamat.toString();
    }
    ;
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(top: 17, left: 27, right: 27),
        color: Colors.white,
        child:
        nik == null?  Center(
          child: Lottie.network('https://assets4.lottiefiles.com/packages/lf20_b88nh30c.json',
              width: 150,
              height: 150
          ),)
            :RefreshWidget(
          keyRefresh: keyRefresh,
          onRefresh: loadList,
          child: ListView(
            children: [
              //Judul halaman
              Text(
                "Profile",
                style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Color(0xff355070)),
              ),
              SizedBox(
                height: 27,
              ),

              //Box data user
              Container(
                padding: EdgeInsets.only(top: 10, bottom: 10, left: 25),
                height: 95,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Color(0x26000000)),
                ),
                child: Row(
                  children: [
                    InkWell(
                      onTap: (){
                        _showPicker(context);
                      },
                      child:
                      //_profile == null ?
                      // const ClipOval(
                      //   clipBehavior: Clip.antiAliasWithSaveLayer,
                      //   child: Icon(
                      //     CupertinoIcons.camera,
                      //     color: Colors.grey,
                      //   ),
                      // )
                      CircleAvatar(
                        radius: 30,
                        backgroundImage: NetworkImage(
                            avaToDisplay),
                      ),
                    ),
                    SizedBox(
                      width: 25,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            namaToDisplay,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: TextStyle(
                                fontFamily: 'Roboto',
                                fontSize: 19,
                                fontWeight: FontWeight.w600),
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          Text(
                            //emailToDisplay!
                            emailToDisplay,
                            style: TextStyle(
                                fontFamily: 'Roboto',
                                fontSize: 14,
                                color: Color(0xff757575)),
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          Text(
                            nohpToDisplay,
                            style: TextStyle(
                                fontFamily: 'Roboto',
                                fontSize: 14,
                                color: Color(0xff757575)),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 40,
              ),

              //Form Data Pribadi
              Container(
                child: Row(
                  children: [
                    Text(
                      "Data Pribadi",
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 16,
                          fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      width: 12,
                    ),
                    Container(
                      height: 17,
                      width: 100,
                      alignment: Alignment.center,
                      child: Text(
                        verifikasiStatus,
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 10,
                            color: Color(0xffFFFFFF)),
                      ),
                      decoration: BoxDecoration(
                        color: colorVerif,
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    Spacer(),
                    Container(
                      height: 17,
                      width: 100,
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            'assets/svg/document2.svg',
                            color: Color(0xffFFFFFF),
                            height: 15,
                            width: 15,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            "Isi Data",
                            style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 10,
                                color: Color(0xffFFFFFF)),
                          ),
                        ],
                      ),
                      decoration: BoxDecoration(
                        color: Color(0xffFFFFFF),
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 25,
              ),
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "NIK",
                      style: TextStyle(
                          fontFamily: 'OpenSans',
                          fontSize: 15,
                          color: Color(0xff355070)),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      height: 46,
                      padding: EdgeInsets.all(5),
                      alignment: Alignment.centerLeft,
                      decoration: BoxDecoration(
                          border: Border.all(color: Color(0x24000000)),
                          borderRadius: BorderRadius.circular(10)),
                      child: Text(
                        //nikToDisplay
                        nikToDisplay,
                        style: TextStyle(
                          fontFamily: 'OpenSans',
                          fontSize: 14,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "Alamat",
                      style: TextStyle(
                          fontFamily: 'OpenSans',
                          fontSize: 15,
                          color: Color(0xff355070)),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      height: 46,
                      padding: EdgeInsets.all(5),
                      alignment: Alignment.centerLeft,
                      decoration: BoxDecoration(
                          border: Border.all(color: Color(0x24000000)),
                          borderRadius: BorderRadius.circular(10)),
                      child: Text(
                        alamatToDisplay,
                        style: TextStyle(fontFamily: 'OpenSans', fontSize: 14),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    SizedBox(
                      height: 28,
                    ),
                  ],
                ),
              ),

              //Akun & Keamanan
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Akun & Keamanan",
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 16,
                        fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  InkWell(
                    onTap: () {
                      if(nikToDisplay!="-"){
                        alreadyVerified(context);
                      }else{
                        ktpIsiData(context);
                      }
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(builder: (context) => const Datadiri()),
                      // );
                    },
                    child: Column(
                      children: [
                        Row(
                          children: [
                            SvgPicture.asset('assets/svg/document2.svg',
                                height: 26, width: 26),
                            SizedBox(
                              width: 21,
                            ),
                            Text(
                              "Isi Data Pribadi",
                              style: TextStyle(
                                  fontFamily: 'OpenSans', fontSize: 15),
                            ),
                            Spacer(),
                            SvgPicture.asset('assets/svg/arrow_right.svg'),
                          ],
                        ),
                        Divider(
                          color: Color(0xffE3E3FE),
                          height: 14,
                          thickness: 1,
                          indent: 44,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PinLamascreen()),
                      );
                    },
                    child: Column(
                      children: [
                        Row(
                          children: [
                            SvgPicture.asset('assets/svg/key.svg',
                                height: 26, width: 26),
                            SizedBox(
                              width: 21,
                            ),
                            Text(
                              "Ubah PIN",
                              style: TextStyle(
                                  fontFamily: 'OpenSans', fontSize: 15),
                            ),
                            Spacer(),
                            SvgPicture.asset('assets/svg/arrow_right.svg'),
                          ],
                        ),
                        Divider(
                          color: Color(0xffE3E3FE),
                          height: 14,
                          thickness: 1,
                          indent: 44,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Pertanyaan()
                        ),
                      );
                    },
                    child: Column(
                      children: [
                        Row(
                          children: [
                            SvgPicture.asset('assets/svg/lock.svg',
                                height: 26, width: 26),
                            SizedBox(
                              width: 21,
                            ),
                            Text(
                              "Pertanyaan Keamanan",
                              style:
                              TextStyle(fontFamily: 'OpenSans', fontSize: 15),
                            ),
                            Spacer(),
                            SvgPicture.asset('assets/svg/arrow_right.svg'),
                          ],
                        ),
                        Divider(
                          color: Color(0xffE3E3FE),
                          height: 14,
                          thickness: 1,
                          indent: 44,
                        ),
                      ],
                    ),
                  ),

                  SizedBox(
                    height: 15,
                  ),
                ],
              ),

              //Info Lainnya
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Info Lainnya",
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 16,
                          fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                InkWell(
                  onTap: () {
                    playstoreAamiin(context);
                  },
                    child : Column(
                      children: [
                        Row(
                          children: [
                            SvgPicture.asset('assets/svg/medal_star.svg',
                                height: 26, width: 26),
                            SizedBox(
                              width: 21,
                            ),
                            Text(
                              "Beri Rating",
                              style:
                              TextStyle(fontFamily: 'OpenSans', fontSize: 15),
                            ),
                            Spacer(),
                            SvgPicture.asset('assets/svg/arrow_right.svg'),
                          ],
                        ),
                        Divider(
                          color: Color(0xffE3E3FE),
                          height: 14,
                          thickness: 1,
                          indent: 44,
                        ),
                      ],
                    ),
                ),
                    SizedBox(
                      height: 4,
                    ),
                    Column(
                      children: [
                        Row(
                          children: [
                            SvgPicture.asset('assets/svg/document.svg',
                                height: 26, width: 26),
                            SizedBox(
                              width: 21,
                            ),
                            Text(
                              "Syarat dan Ketentuan",
                              style:
                              TextStyle(fontFamily: 'OpenSans', fontSize: 15),
                            ),
                            Spacer(),
                            SvgPicture.asset('assets/svg/arrow_right.svg'),
                          ],
                        ),
                        Divider(
                          color: Color(0xffE3E3FE),
                          height: 14,
                          thickness: 1,
                          indent: 44,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Column(
                      children: [
                        Row(
                          children: [
                            SvgPicture.asset('assets/svg/shield.svg',
                                height: 26, width: 26),
                            SizedBox(
                              width: 21,
                            ),
                            Text(
                              "Kebijakan Privasi",
                              style:
                              TextStyle(fontFamily: 'OpenSans', fontSize: 15),
                            ),
                            Spacer(),
                            SvgPicture.asset('assets/svg/arrow_right.svg'),
                          ],
                        ),
                        Divider(
                          color: Color(0xffE3E3FE),
                          height: 14,
                          thickness: 1,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    InkWell(
                      onTap: () {
                        Logout(context);
                      },
                      child: Column(
                        children: [
                          Row(
                            children: [
                              SvgPicture.asset(
                                'assets/svg/upload.svg',
                                height: 26,
                                width: 26,
                              ),
                              SizedBox(
                                width: 21,
                              ),
                              Text(
                                "Keluar",
                                style: TextStyle(
                                    fontFamily: 'OpenSans',
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xffE03A45)),
                              )
                            ],
                          ),
                          Divider(
                            color: Color(0xffE3E3FE),
                            height: 18,
                            thickness: 1,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
