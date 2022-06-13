import 'dart:convert';
import 'dart:io';
import 'dart:io' as io;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:myfin_app/alertsucces.dart';
import 'package:myfin_app/datadiripage/nik_model.dart';
import 'package:path/path.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class Datadiri extends StatefulWidget {
  const Datadiri({ Key? key }) : super(key: key);

  @override
  State<Datadiri> createState() => _DatadiriState();

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const Datadiri(),
    );
  }
}

Future<bool?> cekNik(int nik) async {
  SharedPreferences server = await SharedPreferences.getInstance();
  String? baseUrl = server.getString('server');
  final msg = jsonEncode({"nik":nik});
  var response = await http.post(Uri.http(baseUrl!,'api/getnik/'),
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
    var decodeResponse = NikModel.fromJson(jsonDecode(response.body));
    int nik = decodeResponse.data.nik;
    String nama = decodeResponse.data.nama;
    String alamat = decodeResponse.data.alamat;
    String tglLahir = decodeResponse.data.tglLahir;
    String kota = decodeResponse.data.kota;

    SharedPreferences prefsnik =
    await SharedPreferences.getInstance();
    await prefsnik.setInt('nik', nik);
    SharedPreferences prefsnama =
    await SharedPreferences.getInstance();
    await prefsnama.setString('nama', nama);
    SharedPreferences prefsalamat =
    await SharedPreferences.getInstance();
    await prefsalamat.setString('alamat', alamat);
    SharedPreferences prefstglLahir =
    await SharedPreferences.getInstance();
    await prefstglLahir.setString('tgl_lahir', tglLahir);
    SharedPreferences prefskota =
    await SharedPreferences.getInstance();
    await prefskota.setString('kota', kota);

    return true;
  } else
    return false;
}

Future<bool?> updateDataDiri(int id, String nik,String nama, String alamat, String noHp, String lahir, String kota, String ktp, String swa) async{
  SharedPreferences server = await SharedPreferences.getInstance();
  String? baseUrl = server.getString('server');

  final msg = jsonEncode({"id": id, "nik":nik, "nama":nama, "alamat":alamat, "no_hp":noHp, "lahir":lahir, "kota":kota, "ktp":ktp, "swa":swa});
  var response = await http.put(Uri.http(baseUrl!,'api/datanasabah/'+id.toString()),
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

class CustomWidgets {
  static Widget textField(String title,
      {
        bool isNumber = false,
        int? length,
        TextEditingController? textController,
        int lines = 1,
        var cornerRadius = 0.0}) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const SizedBox(
            height: 10,
          ),
          Text(
            title,
            style: const TextStyle(
                fontWeight: FontWeight.normal,
                fontFamily: 'Oppen-sans',
                color: Color(0xff355070),
                fontSize: 15),
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
            textInputAction: TextInputAction.done,
            decoration: InputDecoration(
              counterText: '',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(cornerRadius),
                borderSide: const BorderSide(color: Colors.grey),
              ),
              fillColor: Colors.transparent,
            ),
          )
        ],
      ),
    );
  }
}

class Customboxname {
  static Widget box(String title,)
  {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 2),
      child:Container(
        height: 66,
        padding: const EdgeInsets.all(23),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Text(
                  title,
                  style: const TextStyle(
                      fontFamily: 'Roboto',
                      color: Color(0xff355070),
                      fontSize: 15,
                      fontWeight: FontWeight.normal),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _DatadiriState extends State<Datadiri> {
  TextEditingController nikController = TextEditingController();
  final TextEditingController controller = TextEditingController();
  File? _image;
  File? _foto;
  final picker = ImagePicker();

  Future uploadImageToFirebase1(BuildContext context) async {
    String fileName = basename(_image!.path);
    firebase_storage.Reference ref =
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('KTP')
        .child('/$fileName');

    final metadata = firebase_storage.SettableMetadata(
        contentType: 'image/jpeg',
        customMetadata: {'picked-file-path': fileName});
    firebase_storage.UploadTask uploadTask;
    //late StorageUploadTask uploadTask = firebaseStorageRef.putFile(_imageFile);
    uploadTask = ref.putFile(io.File(_image!.path), metadata);
    firebase_storage.UploadTask task= await Future.value(uploadTask);
    Future.value(uploadTask).then((value) => {
      print("Upload file path ${value.ref.fullPath}")
    }).onError((error, stackTrace) => {
      print("Upload file path error ${error.toString()} ")
    });
    String urlktp;
    await uploadTask.whenComplete(() async {
      urlktp = await uploadTask.snapshot.ref.getDownloadURL();
      SharedPreferences prefsurlktp =
      await SharedPreferences.getInstance();
      await prefsurlktp.setString('url_ktp', urlktp);
      print('Iki Link E Foto KTP  $urlktp');
    });

  }

  Future getImageFromGallery1() async {
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
      maxHeight: 400,
      maxWidth: 800,
      imageQuality: 100,
    );

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      }
    });
  }

  Future getImageFromCamera1() async {
    final pickedFile = await picker.pickImage(
      source: ImageSource.camera,
      maxHeight: 400,
      maxWidth: 800,
      imageQuality: 100,);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
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
                      getImageFromGallery1();
                      Navigator.of(context).pop();
                    }),
                ListTile(
                  leading: const Icon(Icons.photo_camera),
                  title: const Text('Camera'),
                  onTap: () {
                    getImageFromCamera1();
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          );
        });
  }

  String? nama;
  String? alamat;
  String? kota;
  String? lahir;

  @override
  Widget build(BuildContext context) {
    var displayNama;
    if(nama==null){
      displayNama = " ";
    }else {
      displayNama  = nama.toString();
    }
    var displayAlamat;
    if(alamat==null){
      displayAlamat = " ";
    }else {
      displayAlamat  = alamat.toString();
    }
    var displayKota;
    if(kota==null){
      displayKota = " ";
    }else {
      displayKota  = kota.toString();
    }
    var displayLahir;
    if(lahir==null){
      displayLahir = " ";
    }else {
      displayLahir  = lahir.toString();
    }
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
          title: const Text('Isi Data Pribadi',
            style: TextStyle(
              color: Color.fromRGBO(53, 80, 112, 1),
              fontSize: 20,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w700,
            ),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
            child: Column(
              children: [
                CustomWidgets.textField(
                    'NIK',isNumber: true, textController: nikController, length: 16, cornerRadius: 10.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: () async {
                        String nik = nikController.text;
                        bool? datadiri = await cekNik(int.parse(nik));
                        if (datadiri == true){
                          SharedPreferences prefsnama = await SharedPreferences.getInstance();
                          String? namaNasabah = prefsnama.getString('nama');

                          SharedPreferences prefsalamat = await SharedPreferences.getInstance();
                          String? alamat = prefsalamat.getString('alamat');

                          SharedPreferences prefslahir = await SharedPreferences.getInstance();
                          String? lahir = prefslahir.getString('tgl_lahir');

                          SharedPreferences prefskota = await SharedPreferences.getInstance();
                          String? kota = prefskota.getString('kota');

                          setState(() => this.nama = namaNasabah);
                          setState(() => this.alamat = alamat);
                          setState(() => this.lahir = lahir);
                          setState(() => this.kota = kota);
                          showDialog(context: context, builder: (context) => const AlertDialog(title: const Text("Berhasil Mengambil Data"),));
                        }else{
                          setState(() => this.nama = null);
                          setState(() => this.alamat = null);
                          setState(() => this.lahir = null);
                          setState(() => this.kota = null);
                          showDialog(context: context, builder: (context) => const AlertDialog(title: const Text("Nik Tidak Terdaftar"),));
                        }
                      },
                      child: const Text("Check NIK"),
                      style: ElevatedButton.styleFrom(
                          primary: Colors.purple,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50))
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20,),
                Customboxname.box("Nama              : "+displayNama),
                const SizedBox(height: 20,),
                Customboxname.box("Alamat            : "+displayAlamat),
                const SizedBox(height: 20,),
                Customboxname.box("Tanggal lahir  : "+displayLahir),
                const SizedBox(height: 20,),
                Customboxname.box("Kota lahir        : "+displayKota),
                const SizedBox(height: 20,),
                Row(
                  children: const [
                    Text(
                      "No Hp",
                      style: TextStyle(
                          fontFamily: 'Roboto',
                          color: Color(0xff355070),
                          fontSize: 15,
                          fontWeight: FontWeight.normal),
                    ),
                  ],
                ),
                const SizedBox(height: 10,),
                Container(
                  height: 66,
                  padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 5),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: const [
                      BoxShadow(
                          color: Color(0xffeeeeee),
                          blurRadius: 10,
                          offset: Offset(0, 4)
                      )
                    ],
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.grey),
                  ),
                  child: Stack(
                    children: [
                      InternationalPhoneNumberInput(
                        onInputChanged: (PhoneNumber number){
                          print(number.phoneNumber);
                        },
                        onInputValidated: (bool value){
                          print(value);
                        },
                        selectorConfig: const SelectorConfig(
                          selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                        ),
                        ignoreBlank: false,
                        selectorTextStyle: const TextStyle(color: Colors.black),
                        textFieldController: controller,
                        formatInput: false,
                        maxLength: 12,
                        keyboardType: TextInputType.number,
                        cursorColor: Colors.black,
                        inputDecoration: const InputDecoration(
                            contentPadding: EdgeInsets.only(bottom: 15, left: 0),
                            border: InputBorder.none,
                            hintText: 'Nomor Hp'
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: const [
                    Text("Uplod Ktp",
                      style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontFamily: 'Oppen-sans',
                          color: Color(0xff355070),
                          fontSize: 15),
                    ),
                  ],
                ),
                const SizedBox(height: 10,),
                InkWell(
                  onTap: () {
                    _showPicker(context);
                  },
                  child: _image == null ? Container(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                        border: Border.all(
                          color: Colors.grey,
                        )),
                    width: 400,
                    height: 200,
                    child: const Icon(
                      CupertinoIcons.camera,
                      color: Colors.grey,
                    ),
                  )
                      : Container(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                        border: Border.all(
                          color: Colors.grey,
                        )),
                    width: 400,
                    height: 200,
                    child: Image.file(
                      _image!,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: const [
                    Text("Uplod Swafoto Dengan Ktp",
                      style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontFamily: 'Oppen-sans',
                          color: Color(0xff355070),
                          fontSize: 15),
                    ),
                  ],
                ),
                const SizedBox(height: 10,),
                InkWell(
                  onTap: () {
                    _showPicker2(context);
                  },
                  child: _foto == null ? Container(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                        border: Border.all(
                          color: Colors.grey,
                        )),
                    width: 400,
                    height: 200,
                    child: const Icon(
                      CupertinoIcons.camera,
                      color: Colors.grey,
                    ),
                  )
                      : Container(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                        border: Border.all(
                          color: Colors.grey,
                        )),
                    width: 400,
                    height: 200,
                    child: Image.file(
                      _foto!,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                buildButton(context),
                const SizedBox(height: 20,)
              ],
            ),
          ),
        )
    );
  }
  Widget buildButton(BuildContext context){
    return RawMaterialButton(
      onPressed: () async {
        uploadImageToFirebase1(context);
        uploadImageToFirebase2(context);
        String noHp = "+62"+controller.text;
        SharedPreferences prefsId =
        await SharedPreferences.getInstance();
        await prefsId.setString('no_hp', noHp);
        SharedPreferences idNasabah = await SharedPreferences.getInstance();
        int? id = idNasabah.getInt('idNasabah');
        SharedPreferences prefsnik = await SharedPreferences.getInstance();
        int? nik = prefsnik.getInt('nik');
        SharedPreferences prefsnama = await SharedPreferences.getInstance();
        String? nama = prefsnama.getString('nama');
        SharedPreferences prefsalamat = await SharedPreferences.getInstance();
        String? alamat = prefsalamat.getString('alamat');
        SharedPreferences prefslahir = await SharedPreferences.getInstance();
        String? lahir = prefslahir.getString('tgl_lahir');
        SharedPreferences prefskota = await SharedPreferences.getInstance();
        String? kota = prefskota.getString('kota');
        SharedPreferences prefsktp = await SharedPreferences.getInstance();
        String? ktp = prefsktp.getString('url_ktp');
        SharedPreferences prefsswa = await SharedPreferences.getInstance();
        String? swa = prefsswa.getString('url_swa');
        bool? uploaddata = await updateDataDiri(id!, nik!.toString(), nama!, alamat!, noHp, lahir!, kota!, ktp!, swa!);
        if(uploaddata == true){
          successIsiData(context);
          //showDialog(context: context, builder: (context) => const AlertDialog(title: const Text("Berhasil Update Data"),));
        }else{
          showDialog(context: context, builder: (context) => const AlertDialog(title: const Text("Upload Gagal"),));
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
          'Simpan'),
    );
  }
  Future uploadImageToFirebase2(BuildContext context) async {
    String fileName = basename(_foto!.path);
    firebase_storage.Reference ref =
    firebase_storage.FirebaseStorage.instance
        .ref().child('SwafotoKTP').child('/$fileName');

    final metadata = firebase_storage.SettableMetadata(
        contentType: 'image/jpeg',
        customMetadata: {'picked-file-path': fileName});
    firebase_storage.UploadTask uploadTask;
    //late StorageUploadTask uploadTask = firebaseStorageRef.putFile(_imageFile);
    uploadTask = ref.putFile(io.File(_foto!.path), metadata);
    firebase_storage.UploadTask task= await Future.value(uploadTask);
    Future.value(uploadTask).then((value) => {
      print("Upload file path ${value.ref.fullPath}")
    }).onError((error, stackTrace) => {
      print("Upload file path error ${error.toString()} ")
    });
    String urlswa;
    await uploadTask.whenComplete(() async {
      urlswa = await uploadTask.snapshot.ref.getDownloadURL();
      SharedPreferences prefsurlswa =
      await SharedPreferences.getInstance();
      await prefsurlswa.setString('url_swa', urlswa);
      print('Iki Link E Swafoto KTP $urlswa');
    });
  }
  //Image Picker function to get image from gallery
  Future getImageFromGallery2() async {
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
      maxHeight: 400,
      maxWidth: 800,
      imageQuality: 100,
    );

    setState(() {
      if (pickedFile != null) {
        _foto = File(pickedFile.path);
      }
    });
  }

  Future getImageFromCamera2() async {
    final pickedFile = await picker.pickImage(
      source: ImageSource.camera,
      maxHeight: 400,
      maxWidth: 800,
      imageQuality: 100,);

    setState(() {
      if (pickedFile != null) {
        _foto = File(pickedFile.path);
      }
    });
  }

  void _showPicker2(context) {
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
                      getImageFromGallery2();
                      Navigator.of(context).pop();
                    }),
                ListTile(
                  leading: const Icon(Icons.photo_camera),
                  title: const Text('Camera'),
                  onTap: () {
                    getImageFromCamera2();
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          );
        });
  }
}