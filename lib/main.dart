import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:Myfin/homepage/navbar.dart';
import 'package:Myfin/loginpage/login_screen.dart';
import 'package:firebase_core/firebase_core.dart' as firebase_core;
import 'package:page_transition/page_transition.dart';




Future<void> main() async {

  // SharedPreferences idNasabah = await SharedPreferences.getInstance();
  // int? id = idNasabah.getInt('idNasabah');
  //
  // setState(() => this.id = id);
  WidgetsFlutterBinding.ensureInitialized();
  //Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await firebase_core.Firebase.initializeApp(
    // options: DefaultFirebaseOptions.currentPlatform,
  );
  // SharedPreferences server = await SharedPreferences.getInstance();
  // await server.setString('server', "d9b2-120-188-86-240.ap.ngrok.io");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Myfin App",
      initialRoute: 'loginscreen',
      home: AnimatedSplashScreen(
        splash:
            Image.asset('assets/png/logobaru.png'),
        splashIconSize: 70.0,
        nextScreen: LoginDemo(),
        splashTransition: SplashTransition.scaleTransition,
        pageTransitionType: PageTransitionType.rightToLeft,
        duration: 2000,
        animationDuration: const Duration(seconds: 1),
        curve: Curves.decelerate,
      ),
    );
  }
}
