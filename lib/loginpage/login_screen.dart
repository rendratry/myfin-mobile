import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:myfin_app/loginpage/pin_screen.dart';
import 'package:myfin_app/registerpage/register_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../exitalert.dart';

// ignore: use_key_in_widget_constructors
class LoginDemo extends StatefulWidget {
  @override
  _LoginDemoState createState() => _LoginDemoState();
}

class _LoginDemoState extends State<LoginDemo> {
  TextEditingController emailcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return  WillPopScope(
      onWillPop: () => showExitPopup(context),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Padding(padding: EdgeInsets.only(top: 68.0),
                child: Text(
                  'Login Akun',
                  style: TextStyle(fontFamily: 'Poppins',color: Color.fromRGBO(53, 80, 112, 1),
                    fontSize: 30,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const SizedBox(height: 68),
              Lottie.network('https://assets5.lottiefiles.com/packages/lf20_mjlh3hcy.json',
                width: 280,
                height: 250,),
              // Image.asset(
              //   "assets/png/login.png",
              //   width: 280,
              //   height: 250,
              // ),
              Padding(
                //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
                  padding: const EdgeInsets.only(left:32.0, right: 32.0, top: 60.0),
                  child: Form(
                    autovalidateMode: AutovalidateMode.always,
                    child: TextFormField(
                      controller: emailcontroller,
                      validator: (value) => validateEmail(value),
                      showCursor: true,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                        hintText: 'Email',
                      ),
                    ),
                  )
              ),
              const SizedBox(
                height: 50,
              ),

              Theme(
                data: Theme.of(context).copyWith(canvasColor: Colors.transparent),
                child: RawMaterialButton(
                  onPressed: () async{
                    String email = emailcontroller.text;
                    SharedPreferences prefsEmail =
                    await SharedPreferences.getInstance();
                    await prefsEmail.setString('emailNasabah', email);

                    showModalBottomSheet(
                        context: context,
                        useRootNavigator:true,
                        isScrollControlled: true,
                        builder: (BuildContext context){
                          print(email);
                          return MyBottomSheet();
                        });
                  },
                  fillColor: const Color.fromRGBO(53, 80, 112, 1),
                  constraints: const BoxConstraints(minHeight: 49, minWidth: 128),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  textStyle:
                  const TextStyle(
                    color: Colors.white,
                    fontFamily: 'Poppins',
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                  child: const Text(
                      'Masuk'),
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Belum Punya Akun?'),
                  TextButton(
                    style: TextButton.styleFrom(
                      primary: const Color.fromRGBO(2, 62, 138, 1),
                      textStyle: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    child: const Text("Daftar"),
                    onPressed: (){Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Register()),
                    );}, ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  validateEmail(String? value) {
    String pattern =
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?)*$";
    RegExp regex = RegExp(pattern);
    if (value == null || value.isEmpty || !regex.hasMatch(value)) {
      return 'Enter a valid email address';
    } else {
      return null;
    }
  }
}
class MyBottomSheet extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: Container(
          height: 310,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: InputPin(),
        )
    );
  }
}